#if CVR_CCK_EXISTS
using ABI.CCK.Scripts.Editor;
using UnityEditor;
using UnityEngine;

namespace NAK.UnusedBoneRefCleaner
{
    [InitializeOnLoad]
    public static class CCK_UnusedBoneRefCleaner_BuildHook
    {
        static CCK_UnusedBoneRefCleaner_BuildHook()
        {
            if (CCK_BuildUtility.PreAvatarBundleEvent == null) 
                return;
            
            CCK_BuildUtility.PreAvatarBundleEvent.RemoveListener(OnPreBundleEvent); // idk if this is necessary
            CCK_BuildUtility.PreAvatarBundleEvent.AddListener(OnPreBundleEvent);
            
            EditorApplication.playModeStateChanged -= OnPlayModeStateChanged; // but i believe this is
            EditorApplication.playModeStateChanged += OnPlayModeStateChanged;
        }
        
        private static void OnPreBundleEvent(GameObject uploadedObject)
        {
            var renderers = uploadedObject.GetComponentsInChildren<SkinnedMeshRenderer>(true);
            if (renderers.Length <= 0) return;
            
            foreach (SkinnedMeshRenderer renderer in renderers) 
                CCK_UnusedBoneRefCleaner.CleanupNoWeightBonesOnCopy(renderer);
            
            AssetDatabase.SaveAssets(); // Save *after* all modifications
        }
        
        private static void OnPlayModeStateChanged(PlayModeStateChange state)
        {
            if (state != PlayModeStateChange.ExitingPlayMode)
                return;
            
            // Clean up temporary assets
            if (AssetDatabase.IsValidFolder(CCK_UnusedBoneRefCleaner.TempAssetPath))
                AssetDatabase.DeleteAsset(CCK_UnusedBoneRefCleaner.TempAssetPath);
        }
    }
}
#endif