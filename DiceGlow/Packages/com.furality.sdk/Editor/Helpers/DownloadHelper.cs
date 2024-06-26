using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using Unity.Jobs;
using UnityEditor;
using UnityEngine;

namespace Furality.SDK.Editor.Helpers
{
    public static class DownloadHelper
    {
        private static readonly Queue<(string id, string url)> DownloadQueue = new Queue<(string, string)>();

        public static void Enqueue(string id, string url)
        {
            Debug.Log("Enqueueing "+id);
            DownloadQueue.Enqueue((id, url));
        }

        public static async void Execute()
        {
            while (DownloadQueue.Any())
            {
                var (id, url) = DownloadQueue.Dequeue();
                var path = await DownloadFile(id, url, f => AsyncHelper.EnqueueOnMainThread(() => EditorUtility.DisplayProgressBar("Downloading File", id, f)));
                Debug.Log("Downloaded File path "+path);
                if (!string.IsNullOrEmpty(path))
                    UnityPackageImportQueue.Add(path);
                
                AsyncHelper.EnqueueOnMainThread(EditorUtility.ClearProgressBar);
            }

            UnityPackageImportQueue.Execute();
        }

        private static async Task<string> DownloadFile(string id, string url, Action<float> onDownloadProgress)
        {
            string path = await AsyncHelper.MainThread(() =>
                $"{Application.temporaryCachePath}/{id}.unitypackage");

            using var client = new WebClient();
            
            client.DownloadProgressChanged += (sender, eventArgs) =>
                onDownloadProgress.Invoke(eventArgs.ProgressPercentage / 100f);

            try
            {
                await client.DownloadFileTaskAsync(url, path);
            }
            catch (Exception e)
            {
                Debug.LogWarning($"Error downloading file {id}: {e.Message}");
                return null;
            }

            return path;
        }
        
        public static Texture2D DownloadImage(string url)
        {
#pragma warning disable CS0618
            var www = new WWW(url);
#pragma warning restore CS0618
            while (!www.isDone)
            {
            }

            return www.texture;
        }
    }
}