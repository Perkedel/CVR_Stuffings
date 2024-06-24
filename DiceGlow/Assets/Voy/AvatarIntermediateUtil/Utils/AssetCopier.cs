using System.Collections;
using System.Collections.Generic;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;

namespace Voy.IntermediateAvatar.Utils
{

    public static class UtilTests
    {
        //[MenuItem("Voy/Interm Avatar/Duplicate Selected Object")]
        public static void CopyTest()

        {
            GameObject testgo = Object.Instantiate<GameObject>(Selection.activeGameObject);
            AssetCopier.CopyAssets(testgo, "Assets/IntermAvatarUtilTest/CopyAssets", true);
        }

        
    }

    // I used ChatGPT for most of this because I'm lazy, it kept screwing shit up cause I'm using the free version.
    // oh and I kept having to make changes to the code it was spitting out, it was correct up until it had to deal.
    // with file paths, kept trying to shoe horn System.IO into here and it never, ever used it in a way that worked.
    // AssetDatabase only, this is why you don't just leave an AI to write code without fact checking it.

    public static class AssetCopier
    {
        public static void CopyAssets(GameObject parentGameObject, string destinationFolder, bool animatorOnly = false)
        {
            if (parentGameObject == null)
            {
                Debug.LogWarning("Parent GameObject is null.");
                return;
            }

            string assetsFolder = Application.dataPath;

            Component[] components = parentGameObject.GetComponentsInChildren<Component>(true);

            foreach (Component component in components)
            {
                if (component == null) continue;

                //Debug.Log(component.name);
                SerializedObject obj = new SerializedObject(component);
                SerializedProperty prop = obj.GetIterator();
                while (prop.NextVisible(true))
                {
                    if (prop.propertyType == SerializedPropertyType.ObjectReference && prop.objectReferenceValue != null)
                    {

                        string assetPath = AssetDatabase.GetAssetPath(prop.objectReferenceValue);
                        if (!string.IsNullOrEmpty(assetPath) && AssetDatabase.IsMainAsset(prop.objectReferenceValue))
                        {
                            System.Type assetType = AssetDatabase.GetMainAssetTypeAtPath(assetPath);
                            bool isAnimator = (assetType == typeof(UnityEditor.Animations.AnimatorController));

                            if (!animatorOnly | (animatorOnly && isAnimator))
                            {

                                string relativeAssetPath = assetPath.Substring("Assets/".Length);
                                string copyPath = destinationFolder + "/" + relativeAssetPath;

                                if (!DirectoryCreator.CreateDirectoryIfNotExists(copyPath)) break;

                                // Ensure the copy path is unique
                                copyPath = AssetDatabase.GenerateUniqueAssetPath(copyPath);

                                //if (string.IsNullOrEmpty(copyPath)) break;

                                bool SuccessStatus = AssetDatabase.CopyAsset(assetPath, copyPath);
                                //Debug.Log("Copied asset: " + assetPath + ", " + copyPath + ", " + SuccessStatus.ToString());


                                // Update the reference to the copied asset
                                prop.objectReferenceValue = AssetDatabase.LoadAssetAtPath<Object>(copyPath);
                                obj.ApplyModifiedProperties();
                            }
                            else if (animatorOnly)
                            {
                                //Debug.Log("Asset is not Animator");
                            }
                        }

                        
                    }
                }
                
            }

            AssetDatabase.Refresh();
            //Debug.Log("Asset copying complete.");
        }

        private static string GetUniqueAssetPath(string path)
        {
            string result = path;
            int index = 1;
            while (AssetDatabase.LoadAssetAtPath(result, typeof(Object)) != null)
            {
                result = $"{path}_{index}";
                index++;
            }
            return result;
        }
    }

    public static class DirectoryCreator
    {
        public static bool CreateDirectoryIfNotExists(string filePath)
        {
            string[] directories = filePath.Substring("Assets/".Length).Split('/');
            string parentPath = "Assets";

            bool success;

            // Exclude the last item in the directories array (filename)
            for (int i = 0; i < directories.Length - 1; i++)
            {
                parentPath += "/" + directories[i];
                if (!AssetDatabase.IsValidFolder(parentPath))
                {
                    //Debug.Log("Creating directory: " + parentPath);
                    success = AssetDatabase.CreateFolder(parentPath.Substring(0, parentPath.LastIndexOf('/')), directories[i]) == null;
                    AssetDatabase.Refresh();

                    if (!success)
                    {
                        if (!AssetDatabase.IsValidFolder(parentPath.Substring(0, parentPath.LastIndexOf('/')) + "/" + directories[i]))
                        {
                            //Debug.LogError("Failed to create directory: " + parentPath);
                            return false;
                        }
                    }
                }
                else
                {
                    //Debug.Log("Directory already exists: " + parentPath);
                }
            }

            return true;
        }
    }


}
#endif