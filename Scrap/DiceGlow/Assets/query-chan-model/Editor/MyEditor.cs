using System.Collections;
using UnityEditor;
using UnityEngine;
using System.Collections.Generic;
using System.IO;


public class MyEditor : AssetPostprocessor {


    public static void OnPostprocessAllAssets(string[] importedAsset, string[] deletedAssets, string[] movedAssets, string[] movedFromAssetPaths)
    {
       
        foreach (string str in importedAsset)
        {
           
            CheckSceneSetting();
        }
        //foreach (string str in deletedAssets)
        //{
           
        //    GUIController.CheckSceneSetting();
        //}
        //foreach (string str in movedAssets)
        //{

        //    GUIController.CheckSceneSetting();
        //}
        //foreach (string str in movedFromAssetPaths)
        //{

        //    GUIController.CheckSceneSetting();
        //}
    }

     static int cnt = 0;
    public static void CheckSceneSetting()
    {

        if(cnt > 0)
        {
            return;
        }
      
        List<string> dirs = new List<string>();
        GetDirs(Application.dataPath, ref dirs);
        EditorBuildSettingsScene[] newSettings = new EditorBuildSettingsScene[dirs.Count];
        for (int i = 0; i < newSettings.Length; i++)
        {
            newSettings[i] = new EditorBuildSettingsScene(dirs[i], true);
        }
        EditorBuildSettings.scenes = newSettings;
        AssetDatabase.SaveAssets();

        cnt++;

    }
    public static void GetDirs(string dirPath, ref List<string> dirs)
    {
        foreach (string path in Directory.GetFiles(dirPath))
        {
            if (System.IO.Path.GetExtension(path) == ".unity")
            {
                dirs.Add(path.Substring(path.IndexOf("Assets/")));
            }
        }
        if (Directory.GetDirectories(dirPath).Length > 0)
        {
            foreach (string path in Directory.GetDirectories(dirPath))
                GetDirs(path, ref dirs);
        }
    }



}

