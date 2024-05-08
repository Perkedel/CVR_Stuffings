using System.Linq;
using UnityEditor;
using UnityEngine;

namespace NAK.UnusedBoneRefCleaner
{
    public class CCK_UnusedBoneRefCleaner_Window : EditorWindow
    {
        [MenuItem("NotAKid/Unused Bone Ref Cleaner")]
        public static void ShowWindow()
            => GetWindow<CCK_UnusedBoneRefCleaner_Window>("Unused Bone Ref Cleaner");

        private GameObject avatar;
        
        private void OnGUI()
        {
            // i am paranoid i'll break some super obscure edge case setup, so i'll just add a bunch of warnings :))
            DrawTheVeryScaryWarnings();
            
            DrawAvatarSelection();
            if (avatar == null)
            {
                EditorGUILayout.HelpBox("Please select an Avatar first!", MessageType.Info);
                return;
            }
            
            if (GUILayout.Button("Clean Unused Bone References"))
            {
                if (!EditorUtility.DisplayDialog(
                    "Clean Unused Bone References",
                    "This action, while likely to not change anything visually or functionally, is irreversible. Are you sure you want to proceed? (You can technically reverse this by re-importing your avatar from the original source.)",
                    "Yes", "No"))
                    return;
                
                CleanUnusedBoneReferences();
            }
        }

        #region Drawing Methods
        
        private void DrawTheVeryScaryWarnings()
        {
            EditorGUILayout.HelpBox(
                "This tool removes bone **references** on your Skinned Mesh Renderers that have no weights from the selected Avatar. " +
                "This can help with local performance of the avatar while worn in ChilloutVR (due to technical reasons related to the head-hiding technique used).",
                MessageType.Info);
            
            EditorGUILayout.HelpBox(
                "Please note that this process is irreversible when invoked manually. " +
                "By default, this process is automatically applied to a clone of your avatar before they are bundled and uploaded to ChilloutVR.",
                MessageType.Warning);
            
            EditorGUILayout.HelpBox(
                "There should be no functional or noticeable difference after running this process on your source mesh, " +
                "but it is always recommended to create a backup of your avatar before proceeding.",
                MessageType.Warning);
        }
        
        private void DrawAvatarSelection()
        {
            avatar = (GameObject)EditorGUILayout.ObjectField(
                "Selected Avatar", avatar, typeof(GameObject), true);
#if CVR_CCK_EXISTS
            if (GUILayout.Button("Use Selection"))
            {
                avatar = Selection.gameObjects
                    .Select(obj => obj.GetComponentInParent<ABI.CCK.Components.CVRAvatar>())
                    .FirstOrDefault()?.gameObject;
            }
#endif
        }
        
        #endregion Drawing Methods

        #region Private Methods
        
        private void CleanUnusedBoneReferences()
        {
            EditorUtility.DisplayProgressBar("Removing No Weight Bones", "Processing Avatar", 0f);
            
            var renderers = avatar.GetComponentsInChildren<SkinnedMeshRenderer>(true);
            if (renderers.Length <= 0) return;

            for (var index = 0; index < renderers.Length; index++)
            {
                SkinnedMeshRenderer renderer = renderers[index];
                CCK_UnusedBoneRefCleaner.CleanupNoWeightBonesFromSkinnedMeshRenderer(renderer);
                EditorUtility.DisplayProgressBar("Removing No Weight Bones", "Processing Avatar", (float)index / renderers.Length);
            }
            
            EditorUtility.DisplayProgressBar("Removing No Weight Bones", "Saving Changes", 1f);

            AssetDatabase.SaveAssets(); // Save *after* all modifications
            EditorUtility.ClearProgressBar();
        }
        
        #endregion Private Methods
    }
}