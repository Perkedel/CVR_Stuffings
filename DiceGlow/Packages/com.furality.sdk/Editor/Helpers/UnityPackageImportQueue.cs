using System;
using System.Linq;
using UnityEditor;
using UnityEngine;

namespace Furality.SDK.Editor.Helpers
{
    public static class UnityPackageImportQueue
    {
        public static Action onImportsFinished = () => { };

        private static readonly SavedState<string[]> ImportQueue = new("importQueue", Array.Empty<string>());
        private static readonly SavedState<int> FailCount = new("importFailCount");
        
        public static void OnPackageImportComplete(string packageName)
        {
            // wasQueue exists to ensure that we had packages in the queue to start with
            // if it is false, we can assume this package import was not requested by us
            bool wasQueue = ImportQueue.Value.Length >= 1;
            ImportQueue.Value = ImportQueue.Value.Skip(1).ToArray();

            if (ImportQueue.Value.Length == 0 && wasQueue)
            {
                //AssetDatabase.importPackageCompleted -= OnPackageImportComplete;

                ImportQueue.Value = Array.Empty<string>();

                UnityEngine.Object obj =
                    AssetDatabase.LoadAssetAtPath("Assets/Furality", typeof(UnityEngine.Object));

                EditorGUIUtility.PingObject(obj);

                onImportsFinished();

                Debug.Log("FINISHED IMPORT DONE");

                return;
            }

            Execute();
        }

        public static void Execute()
        {
            Debug.LogWarning("Checking import queue...");
            
            if (ImportQueue.Value.Length == 0)
                return;
            
            var package = ImportQueue.Value[0];
            Debug.Log("Importing package: "+package);
            AsyncHelper.EnqueueOnMainThread(() => AssetDatabase.ImportPackage(package, false));
            
            Debug.LogWarning("Import queue started. Importing "+ImportQueue.Value.Length+" packages.");
        }
        
        public static void Add(string package)
        {
            Debug.LogWarning("Adding package to import queue: "+package);
            ImportQueue.Value = ImportQueue.Value.Concat(new[] { package }).ToArray();
        }
    }
}