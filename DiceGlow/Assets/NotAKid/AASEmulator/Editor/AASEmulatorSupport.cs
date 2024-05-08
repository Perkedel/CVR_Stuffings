using System.Linq;
using NAK.AASEmulator.Runtime;
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
            Initialize();
        }
        
        private static void Initialize()
        {
            AASEmulatorCore.addTopComponentDelegate -= MoveComponentToTop;
            AASEmulatorCore.addTopComponentDelegate += MoveComponentToTop;
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
            const string AAS_EMULATOR_CONTROL_NAME = "AAS Emulator Control";
            
            AASEmulatorCore control = AASEmulatorCore.Instance; // check for existing instance
            if (control == null)
            {
                GameObject foundSceneControl = SceneManager.GetActiveScene()
                    .GetRootGameObjects()
                    .SelectMany(root => root.GetComponentsInChildren<Transform>(true))
                    .FirstOrDefault(t => t.name == AAS_EMULATOR_CONTROL_NAME)?.gameObject; // check for existing object

                control = foundSceneControl == null // create new object if not found, or use existing object and add component
                    ? new GameObject(AAS_EMULATOR_CONTROL_NAME).AddComponent<AASEmulatorCore>() 
                    : foundSceneControl.AddComponentIfMissing<AASEmulatorCore>();
            }
            
            control.enabled = true;
            
            GameObject gameObject = control.gameObject;
            gameObject.SetActive(true);
            GameObjectUtility.RemoveMonoBehavioursWithMissingScript(gameObject);
            Selection.SetActiveObjectWithContext(gameObject, gameObject);
            EditorGUIUtility.PingObject(gameObject);
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