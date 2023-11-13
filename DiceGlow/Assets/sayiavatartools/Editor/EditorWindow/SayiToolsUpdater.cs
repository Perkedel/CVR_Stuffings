using UnityEngine;
using UnityEditor;
using UnityEngine.Networking;
using System.IO.Compression;
using System.IO;
using System.Collections.Generic;

namespace SayiTools
{
    public class SayiToolsUpdater : EditorWindow
    {
        private enum WebRequestState
        {
            None,
            InProgress,
            Error,
            Success
        }

        private const string VERSION_URL = "https://gitlab.com/sayiarin/sayiavatartools/-/raw/main/version.txt";
        private const string CHANGELOG_URL = "https://gitlab.com/sayiarin/sayiavatartools/-/raw/main/changelog.txt";
        private const string ZIP_URL = "https://gitlab.com/sayiarin/sayiavatartools/-/archive/main/sayiavatartools-main.zip";
        private const string ZIP_ROOT_FOLDER = "sayiavatartools-main/";

        private static UnityWebRequest VersionRequest;
        private static UnityWebRequest ChangelogRequest;
        // we will handle the Changelog together with the Version Request
        private static WebRequestState UpdateDataRequestState = WebRequestState.None;

        private static UnityWebRequest UpdateDownloadRequest;
        private static WebRequestState UpdateDownloadRequestState = WebRequestState.None;

        private List<string> DownloadedFileList = new List<string>();

        private Vector2 ChangelogScrollPosition;

        // unity has an enum called Version that masks this one >.<
        private System.Version RemoteVersion;
        private System.Version LocalVersion;

        [MenuItem("Tools/Sayi/Update", priority = 100)]
        public static void Init()
        {
            GetWindow<SayiToolsUpdater>("SayiTools Updater").Show();
        }

        private void OnGUI()
        {
            EditorGUILayout.Space(EditorGUIUtility.singleLineHeight);
            EditorGUIHelper.HeaderLevel2("SayiTools Updater");

            // automatically check for an update the first time the window is opened
            if (RemoteVersion == null && UpdateDataRequestState == WebRequestState.None)
            {
                CheckForUpdate();
            }

            EditorGUI.BeginDisabledGroup(UpdateDataRequestState == WebRequestState.InProgress);
            if (GUILayout.Button("Check for Updates"))
            {
                CheckForUpdate();
            }
            EditorGUI.EndDisabledGroup();

            switch (UpdateDataRequestState)
            {
                case WebRequestState.None:
                    break;
                case WebRequestState.InProgress:
                    EditorGUILayout.LabelField("Fetching Version Data");
                    break;
                case WebRequestState.Error:
                    EditorGUILayout.HelpBox(string.Format("Encountered an error while fetching Version:\n{0}\n{1}", VersionRequest.error, ChangelogRequest.error), MessageType.Error);
                    break;
                case WebRequestState.Success:
                    ShowUpdateInfo();
                    break;
            }

            if (UpdateDataRequestState == WebRequestState.Success)
            {
                EditorGUILayout.Space(EditorGUIUtility.singleLineHeight);
                EditorGUILayout.LabelField("Changelog:");
                ChangelogScrollPosition = GUILayout.BeginScrollView(ChangelogScrollPosition);
                EditorGUI.BeginDisabledGroup(true);
                EditorStyles.textArea.wordWrap = true;
                EditorGUILayout.TextArea(ChangelogRequest.downloadHandler.text, EditorStyles.textArea);
                EditorGUI.EndDisabledGroup();
                GUILayout.EndScrollView();
            }
        }

        private void ShowUpdateInfo()
        {
            if (RemoteVersion == null)
            {
                RemoteVersion = new System.Version(VersionRequest.downloadHandler.text);
            }
            if (LocalVersion == null)
            {
                UpdateLocalVersion();
            }
            EditorGUILayout.Space(EditorGUIUtility.singleLineHeight);
            EditorGUIHelper.FlexSpaceText("Remote Version:", RemoteVersion.ToString());
            EditorGUIHelper.FlexSpaceText("Local Version:", LocalVersion.ToString());
            EditorGUILayout.Space(EditorGUIUtility.singleLineHeight);

            if (RemoteVersion > LocalVersion)
            {
                EditorGUILayout.HelpBox("An update is available.\nPlease note that the automatic updater will override all local changes within the Sayi Avatar Tools root folder!", MessageType.Warning);
                EditorGUI.BeginDisabledGroup(UpdateDownloadRequestState != WebRequestState.None);
                if (GUILayout.Button("Update"))
                {
                    UpdateDownloadRequest = UnityWebRequest.Get(ZIP_URL);
                    UpdateDownloadRequest.SendWebRequest();
                    UpdateDownloadRequestState = WebRequestState.InProgress;
                    EditorApplication.update += UpdateDownload;
                }
                EditorGUI.EndDisabledGroup();

                switch (UpdateDownloadRequestState)
                {
                    case WebRequestState.None:
                        break;
                    case WebRequestState.InProgress:
                        break;
                    case WebRequestState.Error:
                        EditorGUILayout.HelpBox(string.Format("Encountered an error while fetching Version:\n{0}", UpdateDownloadRequest.error), MessageType.Error);
                        break;
                    case WebRequestState.Success:
                        try
                        {
                            AssetDatabase.StartAssetEditing();
                            UpdateFiles();
                        }
                        finally
                        {
                            EditorUtility.DisplayProgressBar(EditorGUIHelper.GetProgressBarTitle("Updater"), "Updating Database ...", 0);
                            AssetDatabase.StopAssetEditing();
                            AssetDatabase.Refresh();
                            EditorUtility.ClearProgressBar();
                        }
                        break;
                }
            }
            else
            {
                EditorGUILayout.HelpBox("You are up to date!", MessageType.Info);
            }
        }

        private void UpdateLocalVersion()
        {
            TextAsset versionFile = AssetDatabase.LoadAssetAtPath<TextAsset>(EditorHelper.GetPathInSayiTools("version.txt"));
            LocalVersion = new System.Version(versionFile.text);
        }

        void Update()
        {
            // force window to update by repainting UI every frame if we fetch update version and changelog
            // otherwise the window does not consistently update even after all requests have finished
            if (UpdateDataRequestState == WebRequestState.InProgress)
            {
                Repaint();
            }
        }

        private void CheckForUpdate()
        {
            UpdateDataRequestState = WebRequestState.InProgress;
            VersionRequest = UnityWebRequest.Get(VERSION_URL);
            VersionRequest.SendWebRequest();
            ChangelogRequest = UnityWebRequest.Get(CHANGELOG_URL);
            ChangelogRequest.SendWebRequest();
            EditorApplication.update += VersionRequestUpdate;
            LocalVersion = null;
            RemoteVersion = null;
            UpdateDownloadRequestState = WebRequestState.None;
        }

        private void UpdateFiles()
        {
            EditorUtility.DisplayProgressBar(EditorGUIHelper.GetProgressBarTitle("Updater"), "Writing new files ...", 0);
            // set back to none so that all that happens here is done only once
            UpdateDownloadRequestState = WebRequestState.None;
            DownloadedFileList.Clear();

            MemoryStream zipStream = new MemoryStream(UpdateDownloadRequest.downloadHandler.data);
            using (var zip = new ZipArchive(zipStream, ZipArchiveMode.Read))
            {
                for (int i = 0; i < zip.Entries.Count; i++)
                {
                    var entry = zip.Entries[i];
                    string pathName = entry.FullName.Substring(ZIP_ROOT_FOLDER.Length);
                    if (string.IsNullOrWhiteSpace(pathName))
                    {
                        continue;
                    }
                    pathName = EditorHelper.GetPathInSayiTools(pathName);
                    DownloadedFileList.Add(pathName);
                    if (pathName.EndsWith("/"))
                    {
                        Directory.CreateDirectory(pathName);
                    }
                    else
                    {
                        using (var dataStream = new MemoryStream())
                        {
                            entry.Open().CopyTo(dataStream);
                            File.WriteAllBytes(pathName, dataStream.ToArray());
                        }
                    }
                    EditorUtility.DisplayProgressBar(EditorGUIHelper.GetProgressBarTitle("Updater"), "Writing new files ...", (float)i / zip.Entries.Count);
                }
            }
            EditorUtility.DisplayProgressBar(EditorGUIHelper.GetProgressBarTitle("Updater"), "Removing old files ...", 0.5f);

            try
            {
                RemoveOldFiles(EditorHelper.GetPathInSayiTools());
            }
            catch (System.Exception e)
            {
                Debug.LogError(e);
            }

            UpdateLocalVersion();
        }

        private void RemoveOldFiles(string path)
        {
            foreach (var directory in Directory.GetDirectories(path))
            {
                // ignore git folder
                if (directory.EndsWith(".git"))
                {
                    continue;
                }
                // replace \ with / in directory names to be consistent
                string correctedPath = directory.Replace('\\', '/');
                RemoveOldFiles(directory);
                // directory names when iterating over them like this don't have a trailing slash
                // in the downloaded files list however they do appear with one, so we add one here for comparison
                if (DownloadedFileList.Contains(correctedPath + "/") == false)
                {
                    try
                    {
                        Directory.Delete(directory);
                    }
                    catch (IOException e)
                    {
                        Debug.LogError(e);
                    }
                }
            }
            foreach (var file in Directory.GetFiles(path))
            {
                // replace \ with / in file names to be consistent
                if (DownloadedFileList.Contains(file.Replace('\\', '/')) == false)
                {
                    try
                    {
                        File.Delete(file);
                    }
                    catch (IOException e)
                    {
                        Debug.LogError(e);
                    }
                }
            }
        }

        private static void VersionRequestUpdate()
        {
            if (VersionRequest != null && ChangelogRequest != null)
            {
                if (VersionRequest.isDone && ChangelogRequest.isDone)
                {
                    UpdateDataRequestState = WebRequestState.Success;
                }
                else if (VersionRequest.isNetworkError || ChangelogRequest.isNetworkError)
                {
                    UpdateDataRequestState = WebRequestState.Error;
                }
                else
                {
                    return;
                }
            }
            else
            {
                UpdateDataRequestState = WebRequestState.None;
            }
            EditorApplication.update -= VersionRequestUpdate;
        }
        private static void UpdateDownload()
        {
            if (!UpdateDownloadRequest.isDone)
            {
                bool canceled = EditorUtility.DisplayCancelableProgressBar(EditorGUIHelper.GetProgressBarTitle("Updater"), "Downloading Files ...", UpdateDownloadRequest.downloadProgress);
                if (canceled)
                {
                    UpdateDownloadRequest.Abort();
                    UpdateDownloadRequest.Dispose();
                    UpdateDownloadRequestState = WebRequestState.None;
                    EditorUtility.ClearProgressBar();
                    EditorApplication.update -= UpdateDownload;
                }
                return;
            }
            if (UpdateDownloadRequest.isNetworkError)
            {
                UpdateDownloadRequestState = WebRequestState.Error;
                Debug.LogError(UpdateDownloadRequest.error);
            }
            else
            {
                UpdateDownloadRequestState = WebRequestState.Success;
            }
            EditorUtility.ClearProgressBar();
            EditorApplication.update -= UpdateDownload;
        }

        private void OnDestroy()
        {
            // when window is closed reset everything
            UpdateDataRequestState = WebRequestState.None;
            UpdateDownloadRequestState = WebRequestState.None;

            if (VersionRequest != null)
            {
                VersionRequest.Abort();
                VersionRequest.Dispose();
            }
            if (ChangelogRequest != null)
            {
                ChangelogRequest.Abort();
                ChangelogRequest.Dispose();
            }
            if (UpdateDownloadRequest != null)
            {
                UpdateDownloadRequest.Abort();
                UpdateDownloadRequest.Dispose();
            }

            LocalVersion = null;
            RemoteVersion = null;
        }
    }
}