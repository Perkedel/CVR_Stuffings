using System.Linq;
using UnityEditor;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace NAK.AASEmulator.Support
{
    [InitializeOnLoad]
    public static class AASEmulatorSupport
    {
        static AASEmulatorSupport()
        {
            InitDefaults();
        }
        
        private static void InitDefaults()
        {
            Runtime.AASEmulator.addTopComponentDelegate = MoveComponentToTop;
        }

        private static void MoveComponentToTop(Component c)
        {
            GameObject go = c.gameObject;
            Component[] components = go.GetComponents<Component>();
            try
            {
                if (PrefabUtility.IsPartOfAnyPrefab(go))
                    PrefabUtility.UnpackPrefabInstance(go, PrefabUnpackMode.Completely, InteractionMode.AutomatedAction);
            }
            catch (System.Exception)
            {
                // ignored
            }

            if (PrefabUtility.IsPartOfAnyPrefab(go.GetComponents<Component>()[1])) 
                return;

            int moveUpCalls = components.Length - 2;
            for (int i = 0; i < moveUpCalls; i++)
                UnityEditorInternal.ComponentUtility.MoveComponentUp(c);
        }

        [MenuItem("Tools/Enable AAS Emulator")]
        public static void EnableAASTesting()
        {
            Runtime.AASEmulator control = Runtime.AASEmulator.Instance ?? AddComponentIfMissing<Runtime.AASEmulator>(
                SceneManager.GetActiveScene()
                    .GetRootGameObjects()
                    .SelectMany(root => root.GetComponentsInChildren<Transform>(true))
                    .FirstOrDefault(t => t.name == "AAS Emulator Control")?.gameObject ?? new GameObject("AAS Emulator Control"));
            
            control.enabled = true;
            control.gameObject.SetActive(true);
            GameObjectUtility.RemoveMonoBehavioursWithMissingScript(control.gameObject);
            Selection.SetActiveObjectWithContext(control.gameObject, control.gameObject);
            EditorGUIUtility.PingObject(control.gameObject);
        }

        public static T AddComponentIfMissing<T>(this GameObject go) where T : Component
        {
            return go.GetComponent<T>() ?? go.AddComponent<T>();
        }
        
        public static T AddComponentIfMissing<T>(this Component component) where T : Component
        {
            return component.gameObject.AddComponentIfMissing<T>();
        }
    }
}