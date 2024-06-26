using UnityEditor;



namespace SatorImaging.PoseEditor
{
    [CanEditMultipleObjects]
    [CustomEditor(typeof(SelectionHandle))]
    public class SelectionHandleInspector : Editor
    {
        static Editor cachedEditor;
        static bool showManagerInspector = false;



        public override void OnInspectorGUI()
        {
            base.OnInspectorGUI();



            var targetHandle = target as SelectionHandle;

            EditorGUI.BeginChangeCheck();

            targetHandle.handleScale = EditorGUILayout.Slider("Handle Scale (incl. Children)", targetHandle.handleScale, 0f, 5f);

            if (EditorGUI.EndChangeCheck())
            {
                foreach (var handle in targetHandle.GetComponentsInChildren<SelectionHandle>())
                {
                    handle.handleScale = targetHandle.handleScale;
                }
                // need to force update
                SceneView.RepaintAll();
            }


            // draw manager inspector
            try
            {
                EditorGUILayout.Space();

                showManagerInspector = EditorGUILayout.Foldout(showManagerInspector, "Pose Editor Manager");
                if (showManagerInspector)
                {
                    CreateCachedEditor(targetHandle.manager, null, ref cachedEditor);

                    //cachedEditor.DrawHeader();
                    cachedEditor.OnInspectorGUI();
                    //cachedEditor.DrawDefaultInspector();
                }
            }
            catch { }

        }



        void OnSceneGUI()
        {
            var handle = target as SelectionHandle;

            // prevent drawing multiple times.
            if (handle.gameObject != Selection.activeGameObject || null == handle.manager)
            {
                return;
            }

            handle.manager.DrawHandle();

        }



        void OnDestroy()
        {
            var handle = target as SelectionHandle;
            if (null == handle.manager) return;

            handle.manager.OnSelectionChanged();

        }




    }//class
}//namespace
