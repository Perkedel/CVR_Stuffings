using UnityEngine;
using UnityEditor;



namespace SatorImaging.PoseEditor
{
    //[CanEditMultipleObjects]
    [CustomEditor(typeof(PoseEditorManager))]
    public class PoseEditorManagerInspector : Editor
    {
        public static bool showOptions = true;



        public override void OnInspectorGUI()
        {
            EditorGUILayout.BeginHorizontal();
            {
                EditorGUILayout.HelpBox("Mouse drag on sphere is required to select manipulator. Shift+Click to add selection.", MessageType.Info);
                if (GUILayout.Button("Remove Pose Editor\n& Handles Associated", GUILayout.MinWidth(144f), GUILayout.MinHeight(38f)))
                {
                    (target as PoseEditorManager).RemovePoseEditor();
                    // need to return here, to avoid error in the following code.
                    return;
                }
            }
            EditorGUILayout.EndHorizontal();



            showOptions = EditorGUILayout.ToggleLeft("Properties", showOptions);

            if (showOptions)
            {
                base.OnInspectorGUI();
            }


        }



        void OnSceneGUI()
        {
            var manager = (target as PoseEditorManager);

            // prevent drawing multiple times.
            if (manager.gameObject != Selection.activeGameObject)
            {
                return;
            }
            manager.DrawHandle();

        }



        void OnDestroy()
        {
            var manager = target as PoseEditorManager;
            manager.OnSelectionChanged();

        }




    }//class
}//namespace
