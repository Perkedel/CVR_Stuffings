#if CVR_CCK_EXISTS
using System;
using ABI.CCK.Components;
using System.Collections.Generic;
using System.Linq;
using NAK.AASEmulator.Runtime.Extensions;
using NAK.AASEmulator.Runtime.SubSystems;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.Scripting.APIUpdating;
using UnityEngine.Serialization;
using Object = UnityEngine.Object;

namespace NAK.AASEmulator.Runtime
{
    [MovedFrom(autoUpdateAPI: false, sourceClassName: "AASEmulator")]
    [AddComponentMenu("")]
    [HelpURL(AAS_EMULATOR_GIT_URL)]
    public class AASEmulatorCore : MonoBehaviour
    {
        #region Constants
        
        public const string AAS_EMULATOR_VERSION = "0.1.3";
        
        // AAS Emulator Links
        public const string AAS_EMULATOR_GIT_URL = "https://github.com/NotAKidOnSteam/AASEmulator";
        public const string AAS_EMULATOR_GIT_API_RELEASE_URL = "https://api.github.com/repos/NotAKidOnSteam/AASEmulator/releases/latest";
        public const string AAS_EMULATOR_COMMON_FAQ_URL = "https://github.com/NotAKidOnSteam/AASEmulator/wiki/Common-Creator-FAQ";
        
        // Official Links
        public const string ABI_CCK_DOCUMENTATION_URL = "https://documentation.abinteractive.net/cck/";
        public const string ABI_HUB_URL = "https://hub.abinteractive.net/";
        
        #endregion Constants
        
        #region Support Delegates

        public delegate void AddTopComponent(Component component);

        public static AddTopComponent addTopComponentDelegate;

        public delegate void RuntimeInitialized(AASEmulatorRuntime runtime);

        public static RuntimeInitialized runtimeInitializedDelegate;
        
        public delegate void RemoteInitialized(AASEmulatorRemote remote);
        
        public static RemoteInitialized remoteInitializedDelegate;
        
        // public delegate void RuntimeCreated(AASEmulatorRuntime runtime);
        //
        // public static RuntimeCreated runtimeCreatedDelegate;
        
        public delegate void RuntimeDestroyed(AASEmulatorRuntime runtime);
        
        public static RuntimeDestroyed runtimeRemovedDelegate;

        #endregion Support Delegates

        public static AASEmulatorCore Instance { get; private set; }
        private readonly List<AASEmulatorRuntime> m_runtimes = new();
        private readonly HashSet<CVRAvatar> m_scannedAvatars = new();
        private GameObject m_CloneInstantiationTarget;

        #region Settings / Emulator Config
        
        [Tooltip("Only initialize AASEmulatorRuntime on avatar selection. This may help with any initial hitch when entering play mode.")]
        public bool OnlyInitializeOnSelect = true;
        
        [Tooltip("Emulate the AAS Menu on all avatars. This will add the AASMenu component to all avatars in the scene.")]
        public bool EmulateAASMenu = true;
        
        [Tooltip("Emulate the Shader Globals provided by ChilloutVR.")]
        public bool EmulateShaderGlobals;

        [Tooltip("The default animator controller to use for avatars that don't have an override controller set. Only change this if you know what you're doing.")]
        public RuntimeAnimatorController defaultRuntimeController;
        private const string CONTROLLER_GUID = "ff926e022d914b84e8975ba6188a26f0";
        private const string CONTROLLER_PATH = "Assets/ABI.CCK/Animations/AvatarAnimator.controller";
        
        #endregion Settings / Emulator Config

        #region Settings / Avatar Simulation

        [FormerlySerializedAs("EmulateEyeBlinking")] [Tooltip("Emulate the simulated eye blinking on avatars.")]
        public bool EmulateEyeBlink = true;
        
        [FormerlySerializedAs("EmulateEyeTracking")] [Tooltip("Emulate the simulated eye tracking on avatars.")]
        public bool EmulateEyeLook;

        [Tooltip("Emulate the FPRExclusion component. This applies to all local avatars within scene.")]
        public bool EmulateFPRExclusions;

        #endregion Settings / Avatar Simulation
        
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
        
        #region Public Properties
        
        public Vector3 GlobalLookAtPositionWorld { get; private set; }
        
        #endregion Public Properties
        
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
            
            if (EmulateShaderGlobals)
                gameObject.AddComponentIfMissing<ShaderGlobalController>();

            gameObject.AddComponentIfMissing<TransformHiderManager>();
            
            runtimeInitializedDelegate += OnRuntimeAdded;
            runtimeRemovedDelegate += OnRuntimeRemoved;

            LoadDefaultCCKController();
            StartEmulator();
        }

        private void Update()
        {
            UpdateGlobalLookAtPosition();
        }

        private void OnDestroy()
        {
            StopEmulator();
        }

        #endregion Unity Methods

        #region Public Methods

        // Instantiate clone onto disabled object to prevent Awake & OnEnable from firing :)
        public GameObject InstantiateClone(GameObject original)
        {
            GameObject clone = Instantiate(original, m_CloneInstantiationTarget.transform);
            clone.SetActive(true);
            clone.SetLayersOfChildren(10); // PlayerNetwork layer
            // NOTE: Triggers & Pointers can detect this layer shift on avatar load if they are not on the target layer already
            // If I get around to emulating Triggers & Pointers, I will need to replicate that... _-_
            return clone;
        }
        
        public bool IsTagAllowed(CVRAvatarAdvancedTaggingEntry.Tags advTag)
        {
            return advTag switch
            {
                CVRAvatarAdvancedTaggingEntry.Tags.LoudAudio => advTagging.LoudAudio,
                CVRAvatarAdvancedTaggingEntry.Tags.LongRangeAudio => advTagging.LongRangeAudio,
                CVRAvatarAdvancedTaggingEntry.Tags.ScreenFx => advTagging.ScreenFx,
                CVRAvatarAdvancedTaggingEntry.Tags.FlashingColors => advTagging.FlashingColors,
                CVRAvatarAdvancedTaggingEntry.Tags.FlashingLights => advTagging.FlashingLights,
                CVRAvatarAdvancedTaggingEntry.Tags.Violence => advTagging.Violence,
                CVRAvatarAdvancedTaggingEntry.Tags.Gore => advTagging.Gore,
                CVRAvatarAdvancedTaggingEntry.Tags.Suggestive => advTagging.Suggestive,
                CVRAvatarAdvancedTaggingEntry.Tags.Nudity => advTagging.Nudity,
                CVRAvatarAdvancedTaggingEntry.Tags.Horror => advTagging.Horror,
                _ => false
            };
        }

        #endregion Public Methods

        #region Private Methods
        
        private void OnSceneLoaded(Scene scene, LoadSceneMode mode) 
            => ScanForAvatars(scene);

        private void StartEmulator()
        {
            SceneManager.sceneLoaded -= OnSceneLoaded;
            SceneManager.sceneLoaded += OnSceneLoaded;
            
            BodyControl.OnExecuteEnterTask.AddListener(OnBodyControlTask);
            BodyControl.OnExecuteExitTask.AddListener(OnBodyControlTask);

            if (m_CloneInstantiationTarget == null)
            {
                m_CloneInstantiationTarget = new GameObject("AASEmulatorInstantiationTarget")
                {
                    hideFlags = HideFlags.HideAndDontSave | HideFlags.HideInInspector
                };
                m_CloneInstantiationTarget.SetActive(false);
                //m_CloneInstantiationTarget.transform.SetParent(transform);
            }
            
            // get all loaded scenes
            for (int i = 0; i < SceneManager.sceneCount; i++)
                ScanForAvatars(SceneManager.GetSceneAt(i));
        }

        private void StopEmulator()
        {
            SceneManager.sceneLoaded -= OnSceneLoaded;
            
            BodyControl.OnExecuteEnterTask.RemoveListener(OnBodyControlTask);
            BodyControl.OnExecuteExitTask.RemoveListener(OnBodyControlTask);
            
            Destroy(m_CloneInstantiationTarget);
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

        private void UpdateGlobalLookAtPosition()
        {
            Camera foundCamera = Camera.main; // default to main camera
            if (foundCamera == null)
                return;
            
            Vector3 mousePosition = Input.mousePosition;
            mousePosition.x = Screen.width - mousePosition.x; // mirror
            mousePosition.y = Screen.height - mousePosition.y; // mirror
            mousePosition.z = -1f; // target behind camera
            
            GlobalLookAtPositionWorld = foundCamera.ScreenToWorldPoint(mousePosition);
        }

        #endregion Private Methods

        #region Game Events
        
        // body control
        private readonly Dictionary<int, AASEmulatorRuntime> m_runtimeMap = new();
        
        private void OnRuntimeAdded(AASEmulatorRuntime runtime)
            => m_runtimeMap[runtime.AnimatorHash] = runtime;
        
        private void OnRuntimeRemoved(AASEmulatorRuntime runtime)
            => m_runtimeMap.Remove(runtime.AnimatorHash);
        
        private void OnBodyControlTask(Animator animator, BodyControlTask task)
        {
            if (!m_runtimeMap.TryGetValue(animator.GetHashCode(), out AASEmulatorRuntime runtime))
                return;

            switch (task.target)
            {
                case BodyControlTask.BodyMask.Head:
                    runtime.BodyControl.Head = task.targetWeight > 0.5f;
                    break;
                case BodyControlTask.BodyMask.Pelvis:
                    runtime.BodyControl.Pelvis = task.targetWeight > 0.5f;
                    break;
                case BodyControlTask.BodyMask.LeftArm:
                    runtime.BodyControl.LeftArm = task.targetWeight > 0.5f;
                    break;
                case BodyControlTask.BodyMask.RightArm:
                    runtime.BodyControl.RightArm = task.targetWeight > 0.5f;
                    break;
                case BodyControlTask.BodyMask.LeftLeg:
                    runtime.BodyControl.LeftLeg = task.targetWeight > 0.5f;
                    break;
                case BodyControlTask.BodyMask.RightLeg:
                    runtime.BodyControl.RightLeg = task.targetWeight > 0.5f;
                    break;
                case BodyControlTask.BodyMask.Locomotion:
                    runtime.BodyControl.Locomotion = task.targetWeight > 0.5f;
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }
        }

        #endregion Game Events
    }
}
#endif