using System;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Net.Http;
using System.Reflection;
using System.Threading;
using System.Threading.Tasks;
using Furality.SDK.Editor.Helpers;
using UnityEditor;
using UnityEditor.PackageManager;
using UnityEngine;

namespace Furality.SDK.Editor.Updater
{
    [Serializable]
    class Package
    {
        public string name;
        public string version;
        public string downloadUrl;
    }

    [Serializable]
    class Repository
    {
        public int manifestVersion;
        public Package[] packages;
    }

    [InitializeOnLoad]
    public class Updater
    {
        private static readonly HttpClient HttpClient = new HttpClient();

        static Updater()
        {
            UpdateAll();
        }

        public static async Task<PackageCollection> ListInstalledPackages()
        {
            return await AsyncHelper.MainThread(() =>
            {
                var req = Client.List(true, false);
                while (!req.IsCompleted) Thread.Sleep(10);
                return req.Result;
            });
        }

        private static bool updating = false;

        public static void UpdateAll()
        {
            if (updating)
            {
                Debug.Log("Furality SDK update already in progress");
                return;
            }

            Task.Run(async () =>
            {
                updating = true;
                await CheckAndUpdate();
                updating = false;
            });
        }

        private static async Task CheckAndUpdate()
        {
            string json =
                await DownloadString("https://raw.githubusercontent.com/furality/unity-sdk/prod/furality_package.json");

            var repo = JsonUtility.FromJson<Repository>(json);
            if (repo.packages == null)
            {
                throw new Exception("Failed to fetch packages from update server");
            }

            var deps = await ListInstalledPackages();
            var remotePackage = repo.packages.First(x => x.name == "com.furality.sdk");
            var furalityPackage = deps.FirstOrDefault(x => x.name == "com.furality.sdk");
            if (furalityPackage != default &&
                furalityPackage.version != remotePackage.version &&
                !HasLocalDirectoryFuralityPackage())
            {
                var tempFile = await AsyncHelper.MainThread(FileUtil.GetUniqueTempPathInProject) + ".zip";
                var url = remotePackage.downloadUrl; //"https://github.com/furality/unity-sdk/releases/latest/download/com.furality.sdk.zip";
                try
                {
                    using (var response = await HttpClient.GetAsync(url))
                    {
                        response.EnsureSuccessStatusCode();
                        using (var fs = new FileStream(tempFile, FileMode.CreateNew))
                        {
                            await response.Content.CopyToAsync(fs);
                        }
                    }
                }
                catch (Exception e)
                {
                    throw new Exception($"Failed to download {url}\n{e.Message}", e);
                }
                
                AsyncHelper.EnqueueOnMainThread(() =>
                {
                    var appRootDir = Path.GetDirectoryName(Application.dataPath);
                    Directory.CreateDirectory(appRootDir + "/Temp/furalityInstalling");

                    CleanManifest(false);
                    Delete("Assets/FuralitySDK-installer");
                    Delete("Packages/com.furality.sdk");
                    Delete("Packages/com.furality.updater");
                });
                
                Debug.Log("Extracting ...");
                var tmpDir = await AsyncHelper.MainThread(FileUtil.GetUniqueTempPathInProject);
                using (var stream = File.OpenRead(tempFile))
                {
                    using (var archive = new ZipArchive(stream))
                    {
                        foreach (var entry in archive.Entries)
                        {
                            if (string.IsNullOrWhiteSpace(entry.Name)) continue;
                            var outPath = tmpDir + "/" + entry.FullName;
                            var outDir = Path.GetDirectoryName(outPath);
                            if (!Directory.Exists(outDir)) Directory.CreateDirectory(outDir);
                            using (var entryStream = entry.Open())
                            {
                                using (var outFile = new FileStream(outPath, FileMode.Create, FileAccess.Write))
                                {
                                    await entryStream.CopyToAsync(outFile);
                                }
                            }
                        }
                    }
                }

                AsyncHelper.EnqueueOnMainThread(() =>
                {
                    var appRootDir = Path.GetDirectoryName(Application.dataPath);
                    Directory.CreateDirectory(appRootDir + "/Temp/furalityInstalling");

                    CleanManifest(false);
                    Delete("Assets/FuralitySDK-installer");
                    Delete("Packages/com.furality.sdk");

                    Debug.Log($"Moving {tmpDir} to Packages/com.furality.sdk");
                    Directory.Move(tmpDir, "Packages/com.furality.sdk");

                    RefreshPackages();
                });
            }
        }

        private static void RefreshPackages()
        {
            Debug.Log("Triggering Package Resolve ...");
            MethodInfo method = typeof(Client).GetMethod("Resolve",
                BindingFlags.Static | BindingFlags.NonPublic | BindingFlags.Public,
                null,
                new Type[] { },
                null
            );
            method.Invoke(null, null);
        }

        private static bool HasLocalDirectoryFuralityPackage()
        {
            var manifestPath = "Packages/manifest.json";
            if (!File.Exists(manifestPath)) return false;
            var lines = File.ReadLines(manifestPath).ToArray();
            return lines.Any(line => line.Contains("com.furality.") && line.Contains("file:") && !line.Contains("tgz"));
        }

        private static bool CleanManifest(bool mainOnly)
        {
            var manifestPath = "Packages/manifest.json";
            if (!File.Exists(manifestPath)) return false;
            var lines = File.ReadLines(manifestPath).ToArray();

            bool ShouldRemoveLine(string line)
            {
                var remove = line.Contains("org.furality.") && (!mainOnly || line.Contains("org.furality.sdk"));
                if (remove)
                {
                    Debug.Log($"Removing manifest line: {line}");
                }

                return remove;
            }

            var linesToKeep = lines.Where(l => !ShouldRemoveLine(l)).ToArray();
            if (lines.Length == linesToKeep.Length) return false;
            var tempManifestPath = FileUtil.GetUniqueTempPathInProject();
            File.WriteAllLines(tempManifestPath, linesToKeep);
            File.Delete(manifestPath);
            File.Move(tempManifestPath, manifestPath);
            return true;
        }

        private static bool Delete(string path)
        {
            if (string.IsNullOrWhiteSpace(path)) return false;
            if (Directory.Exists(path))
            {
                Debug.Log("Deleting directory: " + path);
                Directory.Delete(path, true);
                return true;
            }

            if (File.Exists(path))
            {
                Debug.Log("Deleting file: " + path);
                File.Delete(path);
                return true;
            }

            return false;
        }

        private static async Task<string> DownloadString(string url)
        {
            try
            {
                using (var response = await HttpClient.GetAsync(url))
                {
                    response.EnsureSuccessStatusCode();
                    return await response.Content.ReadAsStringAsync();
                }
            }
            catch (Exception e)
            {
                throw new Exception($"Failed to download {url}\n\n{e.Message}", e);
            }
        }
    }
}