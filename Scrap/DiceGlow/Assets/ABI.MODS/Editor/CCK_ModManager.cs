using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Xml.Linq;
using UnityEditor;
using UnityEngine;
using UnityEngine.Networking;
using UnityEngine.Serialization;
using Random = UnityEngine.Random;

public class CCK_ModManager : EditorWindow
{
    public Texture2D abiLogo;
    private UnityWebRequest _webRequest;
    private XDocument _doc;
    public bool isUpdating = false;
    
    WebClient client = new WebClient();
    string tempSavePath;
    
    [MenuItem("Alpha Blend Interactive/Modules/Module Manager")]
    static void Init()
    {
        CCK_ModManager window = (CCK_ModManager)GetWindow(typeof(CCK_ModManager), false, "CCK :: Module Manager");
        window.Show();
    }

    private void OnEnable()
    {
        abiLogo = (Texture2D) AssetDatabase.LoadAssetAtPath("Assets/ABI.CCK/GUIAssets/abibig.png", typeof(Texture2D));
    }

    private void OnGUI()
    {
        GUILayout.Label(abiLogo);
        EditorGUILayout.BeginVertical();
        ModulesList();
        EditorGUILayout.EndVertical();
    }

    private void ModulesList()
    {
        EditorGUILayout.LabelField("Alpha Blend Interactive - CCK Module manager", EditorStyles.boldLabel);
        EditorGUILayout.HelpBox("Below you can find a list of available modules. Those are not necessary to use our CCK but can extend its features when required. ", MessageType.Info);
        EditorGUILayout.LabelField("");
        
        RequestList();
        
        var wordwrapStyle = new GUIStyle();
        wordwrapStyle.wordWrap = true;
        wordwrapStyle.padding = new RectOffset(4, 4, 0, 0);

        try
        {
            while (!_webRequest.isDone)
            {
                //Wait
            }
            
            foreach (XElement xe in _doc.Descendants("Module"))
            {
                EditorGUILayout.LabelField("Module name:", EditorStyles.boldLabel);
                EditorGUILayout.LabelField((string) xe.Element("ModuleName"));
                EditorGUILayout.LabelField("Description:", EditorStyles.boldLabel);
                GUILayout.Label((string) xe.Element("ModuleDescription"), wordwrapStyle);
                EditorGUILayout.LabelField("Author:", EditorStyles.boldLabel);
                EditorGUILayout.LabelField((string) xe.Element("Author"));

                var docLink = (string) xe.Element("HowToLink");

                if (docLink != "")
                {
                    if (GUILayout.Button("Documentation")) Application.OpenURL(docLink);
                }
                
                if (GUILayout.Button("Install " + (string) xe.Element("ModuleName")))
                {
                    DownloadFile((string) xe.Element("ModuleName"), (string) xe.Element("PackageUrl"));
                }
                EditorGUILayout.LabelField("");
            }
        }
        catch
        {
            //nothing
        }
            
    }

    private void RequestList()
    {
        if (isUpdating) return;
        var values = new Dictionary<string, string> {{"user", EditorPrefs.GetString("m_ABI_Username")}, {"accesskey", EditorPrefs.GetString("m_ABI_Key")}};
        _webRequest = UnityWebRequest.Post("https://api.alphablend.cloud/IContentCreation/GetContentCreationKitModules", values);
        _webRequest.SendWebRequest();
        while (!_webRequest.isDone)
        {
            //Wait
        }
        try { _doc = XDocument.Parse(_webRequest.downloadHandler.text); } 
        catch { Debug.Log("[CCK:ModManager] Unable to load modules list from Alpha Blend Interactive Public Api."); }
        isUpdating = true;
    }
    
    private void DownloadFile (string name, string url)
    {
        Debug.Log("[CCK:ModManager] Now downloading module: " + name);
        tempSavePath = Application.dataPath + "/Temp/" + "tempPackage" + Random.Range(0, 10000) + ".unitypackage";
        if (!Directory.Exists(Application.dataPath + "/Temp/"))
            Directory.CreateDirectory(Application.dataPath + "/Temp/");

        client = new WebClient();
        client.DownloadFileCompleted += new System.ComponentModel.AsyncCompletedEventHandler(DownloadFileCompleted);
        client.DownloadProgressChanged += new DownloadProgressChangedEventHandler(DownloadProgressCallback);
        client.DownloadFileAsync(new System.Uri(url), tempSavePath);
    }

    private void DownloadProgressCallback (object sender, DownloadProgressChangedEventArgs e)
    {
        EditorUtility.DisplayCancelableProgressBar("Alpha Blend Interactive CCK", "Downloading Package", e.ProgressPercentage / 100f);
    }

    private void DownloadFileCompleted (object sender, System.ComponentModel.AsyncCompletedEventArgs e)
    {
        if (e.Error != null)
        {
            Debug.LogError(e.Error);
            return;
        }
        
        client.Dispose();
        client = null;

        AssetDatabase.importPackageCompleted += ImportCallback;
        AssetDatabase.ImportPackage(tempSavePath, false);
    }

    private void ImportCallback (string packageName)
    {
        AssetDatabase.importPackageCompleted -= ImportCallback;
        AssetDatabase.DeleteAsset(tempSavePath);
        AssetDatabase.Refresh();
    }

}
