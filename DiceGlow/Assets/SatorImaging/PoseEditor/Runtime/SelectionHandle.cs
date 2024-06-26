#if UNITY_EDITOR

using UnityEngine;
using UnityEditor;



namespace SatorImaging.PoseEditor
{
    public class SelectionHandle : MonoBehaviour
    {
        public PoseEditorManager manager;
        public bool hideChildren = false;
        public bool selected = false;

        //[Space]
        [Multiline]
        public string label = "";

        [Space]
        public float handleScale = 1.0f;



        [MenuItem("GameObject/Add Annotation", priority = 39)]
        [MenuItem("Component/Add Annotation", priority = 9999)]
        static void AddSelectionHandle()
        {
            foreach (var s in Selection.GetTransforms(SelectionMode.Unfiltered))
            {
                var handle = s.GetComponent<SelectionHandle>();
                if (handle)
                {
                    handle.OnValidate();
                    continue;
                }

                handle = s.gameObject.AddComponent<SelectionHandle>();
                handle.label = "Annotation";
                handle.OnValidate();

                // create manager
                if (null == handle.manager)
                {
                    handle.manager = handle.transform.root.GetComponent<PoseEditorManager>();
                    if (null == handle.manager)
                    {
                        handle.manager = handle.transform.root.gameObject.AddComponent<PoseEditorManager>();
                    }
                }

            }

        }



        void OnValidate()
        {
            label = label.Trim();
            if (!string.IsNullOrEmpty(label))
            {
                label = label.TrimEnd(new char[] { '\n', ' ', '|' }) + "\n|";
            }

            // update once
            EditorApplication.delayCall -= Refresh;
            EditorApplication.delayCall += Refresh;

        }



        void Refresh()
        {
            if(manager)
            {
                manager.UpdatePoseEditor();
                SceneView.RepaintAll();
            }
        }



    }//class
}//namespace
#endif
