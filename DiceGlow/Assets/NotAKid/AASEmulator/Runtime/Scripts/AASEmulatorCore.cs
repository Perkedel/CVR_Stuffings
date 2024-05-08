using System;
using ABI.CCK.Components;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.Scripting.APIUpdating;
using Object = UnityEngine.Object;

namespace NAK.AASEmulator.Runtime
{
    [MovedFrom(autoUpdateAPI: false, sourceClassName: "AASEmulator")]
    [HelpURL(AAS_EMULATOR_GIT_URL)]
    public class AASEmulatorCore : MonoBehaviour
    {
        #region Constants
        
        public const string AAS_EMULATOR_VERSION = "0.1.0";
        
        // AAS Emulator Links
        public const string AAS_EMULATOR_GIT_URL = "https://github.com/NotAKidOnSteam/AASEmulator";
        public const string AAS_EMULATOR_GIT_API_RELEASE_URL = "https://api.github.com/repos/NotAKidOnSteam/AASEmulator/releases/latest";
        public const string AAS_EMULATOR_COMMON_FAQ_URL = "https://github.com/NotAKidOnSteam/AASEmulator/wiki/Common-Creator-FAQ";
        
        // Official Links
        public const string ABI_CCK_DOCUMENTATION_URL = "https://documentation.abinteractive.net/cck/";
        public const string ABI_HUB_URL = "https://hub.abinteractive.net/";
        
        #endregion
        
        #region Support Delegates

        public delegate void AddTopComponent(Component component);

        public static AddTopComponent addTopComponentDelegate;

        public delegate void RuntimeInitialized(AASEmulatorRuntime runtime);

        public static RuntimeInitialized runtimeInitializedDelegate;

        #endregion Support Delegates

        public static AASEmulatorCore Instance;
        private readonly List<AASEmulatorRuntime> m_runtimes = new();
        private readonly HashSet<CVRAvatar> m_scannedAvatars = new();

        #region Settings / Emulator Config
        
        [Tooltip("Only initialize AASEmulatorRuntime on avatar selection. This may help with any initial hitch when entering play mode.")]
        public bool OnlyInitializeOnSelect = true;
        
        [Tooltip("Emulate the AAS Menu on all avatars. This will add the AASMenu component to all avatars in the scene.")]
        public bool EmulateAASMenu = true;

        [Tooltip("The default animator controller to use for avatars that don't have an override controller set. Only change this if you know what you're doing.")]
        public RuntimeAnimatorController defaultRuntimeController;
        private const string CONTROLLER_GUID = "ff926e022d914b84e8975ba6188a26f0";
        private const string CONTROLLER_PATH = "Assets/ABI.CCK/Animations/AvatarAnimator.controller";
        
        #endregion Settings / Emulator Config

        #region Settings / Avatar Tracking

        [Tooltip("Emulate the simulated eye blinking on avatars.")]
        public bool EmulateEyeBlinking = true;

        #endregion Settings / Avatar Tracking
        
        #region Settings / Advanced Tagging

        [Tooltip("Enable emulating Advanced Tagging. This will strip GameObjects tagged with Advanced Tagging based on the settings defined below.")]
        public bool EmulateAdvancedTagging = true;

        // Advanced Tagging Settings
        public AdvancedTags advTagging = new()
        {
            LoudAudio = true,
            LongRangeAudio = true,
            ScreenFx = true,
            FlashingColors = true,
            FlashingLights = true,
            Violence = true,
            Suggestive = true,
            Horror = true,
            Gore = false, // Not enabled by default
            Nudity = false, // Not enabled by default
        };
        
        [Serializable]
        public struct AdvancedTags
        {
            public bool LoudAudio;
            public bool LongRangeAudio;
            public bool ScreenFx;
            public bool FlashingColors;
            public bool FlashingLights;
            public bool Violence;
            public bool Gore;
            public bool Suggestive;
            public bool Nudity;
            public bool Horror;
        }
        
        #endregion Settings / Advanced Tagging
        
        #region Unity Methods

        private void OnValidate()
        {
            if (defaultRuntimeController == null)
                LoadDefaultCCKController();
        }

        private void Start()
        {
            if (Instance != null
                && Instance != this)
            {
                DestroyImmediate(this);
                return;
            }
            Instance = this;

            LoadDefaultCCKController();
            StartEmulator();
        }

        private void OnDestroy()
        {
            StopEmulator();
        }

        #endregion Unity Methods

        #region Private Methods
        
        private void OnSceneLoaded(Scene scene, LoadSceneMode mode) 
            => ScanForAvatars(scene);

        private void StartEmulator()
        {
            SceneManager.sceneLoaded -= OnSceneLoaded;
            SceneManager.sceneLoaded += OnSceneLoaded;
            ScanForAvatars(gameObject.scene);
        }

        private void StopEmulator()
        {
            SceneManager.sceneLoaded -= OnSceneLoaded;
            
            foreach (AASEmulatorRuntime runtime in m_runtimes)
                Destroy(runtime);

            m_runtimes.Clear();
            m_scannedAvatars.Clear();
        }
        
        private void LoadDefaultCCKController()
        {
            if (defaultRuntimeController != null)
                return;
            
#if UNITY_EDITOR
            string path = UnityEditor.AssetDatabase.GUIDToAssetPath(CONTROLLER_GUID);
            Object controllerObject = UnityEditor.AssetDatabase.LoadAssetAtPath<Object>(path) 
                ?? UnityEditor.AssetDatabase.LoadAssetAtPath<Object>(CONTROLLER_PATH);
            
            defaultRuntimeController = controllerObject as RuntimeAnimatorController;
#endif
            if (defaultRuntimeController == null)
                SimpleLogger.LogError("Failed to load default avatar controller. Did you move the ABI.CCK folder?", gameObject);
        }

        private void ScanForAvatars(Scene scene)
        {
            var newAvatars = scene.GetRootGameObjects()
                .SelectMany(x => x.GetComponentsInChildren<CVRAvatar>(true))
                .Where(avatar => !m_scannedAvatars.Contains(avatar))
                .ToList();

            foreach (CVRAvatar avatar in newAvatars)
            {
                if (!avatar.TryGetComponent(out AASEmulatorRuntime runtime))
                {
                    runtime = avatar.gameObject.AddComponent<AASEmulatorRuntime>();
                    runtime.isInitializedExternally = true;
                    m_runtimes.Add(runtime);
                }
                m_scannedAvatars.Add(avatar);
            }
            
            if (newAvatars.Count > 0)
                SimpleLogger.Log("Setting up AASEmulator on " + newAvatars.Count + " new avatars.", gameObject);
        }

        #endregion Private Methods
    }
}