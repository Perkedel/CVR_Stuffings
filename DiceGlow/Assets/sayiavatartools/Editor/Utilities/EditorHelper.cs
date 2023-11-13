using System.IO;
using UnityEditor;
using UnityEngine;

namespace SayiTools
{
    // for a workaround this class has to be a scriptable object to get the SayiTools path lol
    public class EditorHelper : ScriptableObject
    {
        private static string SayiToolsRoot;

        // appends the given path to the SayiTools root folder path
        public static string GetPathInSayiTools(string path = "")
        {
            ValidateSayiToolsPath();
            return string.Format("{0}/{1}", SayiToolsRoot, path);
        }

        private static void ValidateSayiToolsPath()
        {
            if (string.IsNullOrWhiteSpace(SayiToolsRoot) || AssetDatabase.IsValidFolder(SayiToolsRoot) == false)
            {
                // workaround to get paths relative to this scripts location; this is done so this stuff
                // still works even if endusers don't place it directly in the Asset folder as long as the
                // files relative position is correct
                string path = AssetDatabase.GetAssetPath(MonoScript.FromScriptableObject(ScriptableObject.CreateInstance<EditorHelper>()));
                // directory is Utilities, Parent is Editor folder, Parent of that is SayTools root
                // not perfect but okay for now
                path = path.Remove(path.LastIndexOf('/'));
                path = path.Remove(path.LastIndexOf('/'));
                SayiToolsRoot = path.Remove(path.LastIndexOf('/'));
            }
        }
    }
}