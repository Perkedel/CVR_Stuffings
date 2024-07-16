#if CVR_CCK_EXISTS
using ABI.CCK.Components;
using NAK.AASEmulator.Runtime.SubSystems;
using System;
using System.Collections.Generic;
using Experiment.NewHider;
using NAK.AASEmulator.Runtime.Extensions;
using UnityEngine;

namespace NAK.AASEmulator.Runtime
{
    [AddComponentMenu("")]
    [HelpURL(AASEmulatorCore.AAS_EMULATOR_GIT_URL)]
    public class AASEmulatorRuntime : EditorOnlyMonoBehaviour
    {
        #region EditorGUI

        public delegate void RepaintRequestHandler();

        public static event RepaintRequestHandler OnRequestRepaint;

        [HideInInspector] public bool remoteClonesFoldout;
        [HideInInspector] public bool localAvatarFoldout;
        [HideInInspector] public bool avatarInfoFoldout = true;
        [HideInInspector] public bool aasSyncingInfoFoldout;
        [HideInInspector] public bool bodyControlFoldout;
        [HideInInspector] public bool lipSyncFoldout = true;
        [HideInInspector] public bool builtInLocomotionFoldout = true;
        [HideInInspector] public bool builtInEmotesFoldout = true;
        [HideInInspector] public bool builtInGesturesFoldout = true;
        [HideInInspector] public bool joystickFoldout;
        [HideInInspector] public bool floatsFoldout;
        [HideInInspector] public bool intsFoldout;
        [HideInInspector] public bool boolsFoldout;

        private bool m_shouldRepaintEditor;

        #endregion EditorGUI

        #region Public Properties

        public bool IsInitialized { get; private set; }

        public bool UseEyeMovement
            => m_avatar is { useEyeMovement: true };

        public bool UseBlinkBlendshapes
            => m_avatar is { useBlinkBlendshapes: true };
        
        public bool UseLipsync
            => m_avatar is { useVisemeLipsync: true };
        
        public AvatarDefinitions.VisemeModeIndex VisemeMode
            => m_avatar != null ? (AvatarDefinitions.VisemeModeIndex)m_avatar.visemeMode : AvatarDefinitions.VisemeModeIndex.Visemes;

        public bool IsEmotePlaying { get; private set; }

        // this is not animatable in *latest* cck as i added NonKeyable attribute, but i forgor to mirror change to client so
        // if you remove that attribute you can animate off/on AAS syncing :)
        public bool IsUsingAvatarAdvancedSettings
            => m_avatar is { avatarUsesAdvancedSettings: true };
        
        public bool IsActiveOffset { get; private set; }

        #endregion Public Properties

        #region Remote Clones

        private readonly List<AASEmulatorRemote> m_RemoteClones = new();

        public int RemoteCloneCount
        {
            get => m_RemoteClones.Count;
            set
            {
                // validate stupidity
                if (value < 0) value = 0;
                if (value > 10) value = 10;
                if (value == m_RemoteClones.Count) 
                    return;
                
                // create new clones
                while (m_RemoteClones.Count < value)
                    CreateRemoteClone();
                
                // remove clones
                while (m_RemoteClones.Count > value)
                    RemoveRemoteClone();
            }
        }

        private void CreateRemoteClone()
        {
            Transform ourTransform = transform;
            
            GameObject remoteClone = Instantiate(m_SourceClone, ourTransform.position, ourTransform.rotation);
            remoteClone.name = gameObject.name + " (Remote)";
            
            DestroyImmediate(remoteClone.GetComponent<AASMenu>());
            DestroyImmediate(remoteClone.GetComponent<AASEmulatorRuntime>());
            
            AASEmulatorRemote cloneRuntime = remoteClone.AddComponent<AASEmulatorRemote>();
            cloneRuntime.isInitializedExternally = true;
            cloneRuntime.SourceRuntime = this;
            cloneRuntime.AnimatorManager = new AvatarAnimator(false);

            Animator cloneAnimator = remoteClone.GetComponent<Animator>();
            // TODO: instantiate copy as asset being shared breaks anim replacement
            cloneAnimator.runtimeAnimatorController = AnimatorManager.Animator.runtimeAnimatorController;
            cloneAnimator.keepAnimatorStateOnDisable = false;
            cloneAnimator.applyRootMotion = false;
            cloneRuntime.AnimatorManager.SetupManager(cloneAnimator);
            
            m_RemoteClones.Add(cloneRuntime);
            
            // offset by clone count
            cloneRuntime.transform.position += ourTransform.right * m_RemoteClones.Count;
        }
        
        private void RemoveRemoteClone()
        {
            if (m_RemoteClones.Count == 0)
                return;

            AASEmulatorRemote clone = m_RemoteClones[^1];
            m_RemoteClones.RemoveAt(m_RemoteClones.Count - 1);
            Destroy(clone.gameObject);
        }

        internal void RemoveRemoteClone(AASEmulatorRemote clone)
        {
            if (m_RemoteClones.Contains(clone)) m_RemoteClones.Remove(clone);
        }
        
        #endregion Remote Clones

        #region Local Avatar

        private bool _displayFPRExclusions;
        public bool DisplayFPRExclusions
        {
            get => _displayFPRExclusions;
            set
            {
                if (_displayFPRExclusions == value) 
                    return;
            }
        }

        private MirrorClone _mirrorReflection;

        private bool _displayMirrorReflection;
        public bool DisplayMirrorReflection
        {
            get => _displayMirrorReflection && _mirrorReflection != null;
            set
            {
                if (_displayMirrorReflection == value) return;
                _displayMirrorReflection = value;

                if (_displayMirrorReflection && _mirrorReflection == null)
                {
                    _mirrorReflection = MirrorClone.Create(transform);
                    _mirrorReflection.transform.position -= transform.right;
                }
                else if (!_displayMirrorReflection && _mirrorReflection != null)
                    Destroy(_mirrorReflection.gameObject); 
            }
        }

        #endregion Local Avatar

        #region Body Control

        public struct BodyControlState
        {
            public bool Head;
            public bool Pelvis;
            public bool LeftArm;
            public bool RightArm;
            public bool LeftLeg;
            public bool RightLeg;
            public bool Locomotion;
        }

        public BodyControlState BodyControl = new()
        {
            Head = true,
            Pelvis = true,
            LeftArm = true,
            RightArm = true,
            LeftLeg = true,
            RightLeg = true,
            Locomotion = true
        };

        #endregion Body Control
        
        #region Lip Sync / Visemes

        [Header("Lip Sync / Visemes")]
        [SerializeField][Range(0, 14)] private int _viseme;

        private AvatarDefinitions.VisemeIndex _visemeIdx;

        public AvatarDefinitions.VisemeIndex VisemeIdx
        {
            get => _visemeIdx;
            set
            {
                _visemeIdx = value;
                _viseme = (int)value;
            }
        }

        public int Viseme
        {
            get => _viseme;
            set
            {
                _viseme = value;
                _visemeIdx = (AvatarDefinitions.VisemeIndex)value;
            }
        }

        // Single Blendshape & Jaw Bone
        public float VisemeLoudness { get; set; }

        #endregion Lip Sync / Visemes

        #region Built-in inputs / Hand Gestures

        [Header("Built-in inputs / Hand Gestures")]
        [SerializeField][Range(-1, 6)] private float _gestureLeft;

        [SerializeField][Range(-1, 6)] private float _gestureRight;
        private AvatarDefinitions.GestureIndex _gestureLeftIdx;
        private AvatarDefinitions.GestureIndex _gestureRightIdx;

        public AvatarDefinitions.GestureIndex GestureLeftIdx
        {
            get => _gestureLeftIdx;
            set
            {
                _gestureLeftIdx = value;
                _gestureLeft = (float)value - 1;
            }
        }

        public float GestureLeft
        {
            get => _gestureLeft;
            set
            {
                _gestureLeft = value;
                if (_gestureLeft is > 0 and <= 1)
                {
                    _gestureLeftIdx = AvatarDefinitions.GestureIndex.Fist;
                    return;
                }

                _gestureLeftIdx = (AvatarDefinitions.GestureIndex)Mathf.FloorToInt(value + 1);
            }
        }

        public AvatarDefinitions.GestureIndex GestureRightIdx
        {
            get => _gestureRightIdx;
            set
            {
                _gestureRightIdx = value;
                _gestureRight = (float)value - 1;
            }
        }

        public float GestureRight
        {
            get => _gestureRight;
            set
            {
                _gestureRight = value;
                if (_gestureRight is > 0 and <= 1)
                {
                    _gestureRightIdx = AvatarDefinitions.GestureIndex.Fist;
                    return;
                }

                _gestureRightIdx = (AvatarDefinitions.GestureIndex)Mathf.FloorToInt(value + 1);
            }
        }

        #endregion Built-in inputs / Hand Gestures

        #region Built-in inputs / Locomotion

        [Header("Built-in inputs / Locomotion")]
        
        [SerializeField] private Vector2 _movement;
        public Vector2 Movement
        {
            get => _movement;
            set
            {
                _movement.x = Mathf.Clamp(value.x, -1f, 1f);
                _movement.y = Mathf.Clamp(value.y, -1f, 1f);
            }
        }

        private bool _crouching;
        public bool Crouching
        {
            get => _crouching;
            set
            {
                if (_crouching == value
                    || !CanCrouchProne) 
                    return;
                
                _crouching = value;
                if (!_crouching)
                {
                    if (!_prone) Upright = 1f;
                    return;
                }
                Prone = false;
                _upright = AVATAR_CROUCH_LIMIT;
            }
        }
        
        private bool _prone;
        public bool Prone
        {
            get => _prone;
            set
            {
                if (_prone == value
                    || !CanCrouchProne) 
                    return;
                
                _prone = value;
                if (!_prone)
                {
                    if (!_crouching) Upright = 1f;
                    return;
                }
                Crouching = false;
                _upright = AVATAR_PRONE_LIMIT;
            }
        }

        private bool _flying;

        public bool Flying
        {
            get => _flying;
            set
            {
                if (_flying == value) 
                    return;
                
                _flying = value;
                if (!_flying) return;
                Crouching = false;
                Prone = false;
            }
        }
        
        private bool _sitting;

        public bool Sitting
        {
            get => _sitting;
            set
            {
                if (_sitting == value) 
                    return;
                
                _sitting = value;
                if (!_sitting) return;
                Crouching = false;
                Prone = false;
                Flying = false;
                Grounded = true;
            }
        }
        
        public bool Swimming;
        public bool Grounded = true;
        
        public bool CanCrouchProne => !Flying && !Swimming && !Sitting;
        
        #endregion Built-in inputs / Locomotion

        #region Built-in inputs / Emotes

        [Header("Built-in inputs / Toggles & Emotes")]
        [SerializeField][Range(0, 8)] private int _toggle;
        public int Toggle
        {
            get => _toggle;
            set => _toggle = value;
        }

        [SerializeField][Range(0, 8)] private int _emote;
        public int Emote
        {
            get => _emote;
            set => _emote = value;
        }

        public bool CancelEmote;

        #endregion Built-in inputs / Emotes

        #region Variables
        
        public int AnimatorHash { get; private set; }
        
        //public AnimatorManager AnimatorManager { get; private set; }
        public AvatarAnimator AnimatorManager { get; private set; }
        private AvatarEyeBlinkManager EyeBlinkManager { get; set; }
        private AvatarEyeLookManager EyeLookManager { get; set; }
        private AvatarLipSyncHandler LipSyncHandler { get; set; }
        
        public CVRAvatar m_avatar;
        public Animator m_animator;

        public GameObject m_SourceClone;
        
        // Emotes
        private const float EMOTE_TIMEOUT = 0.1f; // seconds
        private float emoteTimer;

        // Humanoid handling
        internal HumanPoseHandler m_humanPoseHandler;
        internal HumanPose m_humanPose;
        private Transform m_headTransform;
        private Transform m_hipTransform;
        
        // IK handling

        // not configurable at this time :(
        private const float AVATAR_CROUCH_LIMIT = 0.75f;
        private const float AVATAR_PRONE_LIMIT = 0.4f;
        
        // VR Upright value
        private float _upright = 1f;
        public float Upright
        {
            get => _upright;
            set
            {
                float newValue = Mathf.Clamp(value, 0f, 1f);
                if (newValue <= Mathf.Min(AVATAR_PRONE_LIMIT, AVATAR_CROUCH_LIMIT))
                {
                    Crouching = false;
                    Prone = true;
                }
                else if (newValue <= Mathf.Max(AVATAR_PRONE_LIMIT, AVATAR_CROUCH_LIMIT))
                {
                    Crouching = true;
                    Prone = false;
                }
                else
                {
                    Crouching = false;
                    Prone = false;
                }
                _upright = newValue;
            }
        }
        
        // Constant Jumping
        private bool _inputJump;
        public bool InputJump 
        {
            get => _inputJump;
            set
            {
                if (_inputJump == value) 
                    return;
                
                _inputJump = value;
                if (_inputJump) 
                    return;
                
                _jumpTime = 0f;
                Grounded = true;
            }
        }
        private float _jumpTime { get; set; }
        
        #endregion Variables

        #region Initialization

        internal override void Awake()
        {
            base.Awake();
            
            if (AASEmulatorCore.Instance == null)
            {
                SimpleLogger.LogWarning("AAS Emulator Control is missing from the scene. Emulator will not run!", gameObject);
                return;
            }
            
            // Create clone of avatar prior to anything initializing so we can use it later
            m_SourceClone = AASEmulatorCore.Instance.InstantiateClone(gameObject);
        }
        
        private void Start()
        {
            //AASEmulatorCore.runtimeCreatedDelegate?.Invoke(this);
            
            if (AASEmulatorCore.Instance == null)
            {
                SimpleLogger.LogWarning("AAS Emulator Control is missing from the scene. Emulator will not run!", gameObject);
                return;
            }
            
            if (AASEmulatorCore.Instance.OnlyInitializeOnSelect)
                return;

            Initialize();
        }

        private void OnDestroy()
        {
            AASEmulatorCore.runtimeRemovedDelegate?.Invoke(this);
        }
        
        public void Initialize()
        {
            if (IsInitialized)
                return;

            if (AASEmulatorCore.Instance == null)
            {
                SimpleLogger.LogWarning("AAS Emulator Control is missing from the scene. Emulator will not run!", gameObject);
                return;
            }

            if (!gameObject.TryGetComponent(out m_avatar))
            {
                SimpleLogger.LogError("The CVRAvatar component is missing on the attached gameObject. Destroying...", gameObject);
                DestroyImmediate(this);
                return;
            }

            // Place on PlayerLocal layer
            gameObject.SetLayersOfChildren(8);
            
            // CVR will ensure this on initialization
            if (!gameObject.TryGetComponent(out m_animator))
                m_animator = gameObject.AddComponent<Animator>();

            // CVR replaces old CCK animation clips, but we won't even bother trying
            m_animator.runtimeAnimatorController = m_avatar.overrides != null
                ? m_avatar.overrides
                : AASEmulatorCore.Instance.defaultRuntimeController;

            m_animator.cullingMode = AnimatorCullingMode.AlwaysAnimate;
            m_animator.applyRootMotion = false;
            if (!m_animator.enabled) // only enforced for local client... if in vr...
            {
                SimpleLogger.LogError("Avatars animator is disabled by default. You must fix this prior to upload.", gameObject);
                m_animator.enabled = true; // we will enable, but will also alert user
            }
            
            if (m_animator.isHuman)
            {
                m_humanPoseHandler?.Dispose();
                m_humanPoseHandler = new HumanPoseHandler(m_animator.avatar, m_animator.transform);
                m_humanPoseHandler.GetHumanPose(ref m_humanPose);
                m_hipTransform = m_animator.GetBoneTransform(HumanBodyBones.Hips);
            }

            // we do this because identifying a runtime by component reference *will* fail
            // if the component is destroyed before our callbacks can execute
            AnimatorHash = m_animator.GetHashCode();
            
            AnimatorManager = new AvatarAnimator(true);
            AnimatorManager.SetupManager(m_animator);
            
            EyeBlinkManager = new AvatarEyeBlinkManager(m_avatar);
            EyeLookManager = new AvatarEyeLookManager(m_avatar);
            LipSyncHandler = new AvatarLipSyncHandler(this);
            
            AASEmulatorCore.addTopComponentDelegate?.Invoke(this);
            AASEmulatorCore.runtimeInitializedDelegate?.Invoke(this);
            IsInitialized = true;
            
            SetValuesToDefault();
            
            TransformHiderUtils.SetupAvatar(gameObject);
        }

        private void SetValuesToDefault()
        {
            _viseme = 0;
            _visemeIdx = 0;

            _gestureLeft = 0f;
            _gestureLeftIdx = AvatarDefinitions.GestureIndex.Neutral;

            _gestureRight = 0f;
            _gestureRightIdx = AvatarDefinitions.GestureIndex.Neutral;

            Grounded = true;
        }

        #endregion Initialization

        #region Unity Methods

        private void Update()
        {
            if (!IsInitialized)
                return;
            
            // run via SchedulerSystem.Update
            DoRemoteCoreSyncUpdate();
            DoForceAASSyncUpdate();
            DoSyncAASUpdate();

            Update_EmoteValues_Update();
            Update_CachedParametersFromAnimator();

            Apply_Parameters();

            CancelEmote = false;
            if (m_shouldRepaintEditor)
            {
                OnRequestRepaint?.Invoke();
                m_shouldRepaintEditor = false;
            }
        }

        private void LateUpdate()
        {
            if (!IsInitialized)
                return;

            //Apply_LipSync();
            Apply_ActiveBodyOffset();
            
            LipSyncHandler.OnLateUpdate();
            
            // kind of lazy but works for now
            EyeBlinkManager.IsEnabled = UseBlinkBlendshapes && AASEmulatorCore.Instance.EmulateEyeBlink;
            EyeBlinkManager.OnLateUpdate();

            EyeLookManager.IsEnabled = UseEyeMovement && AASEmulatorCore.Instance.EmulateEyeLook;
            EyeLookManager.LookAtPositionWorld = AASEmulatorCore.Instance.GlobalLookAtPositionWorld; // todo: expose look at position
            EyeLookManager.OnLateUpdate();
        }

        // fixedDeltaTime is wack in ChilloutVR... Needs proper handling.
        // Desktop = 0.02 : OpenXR = 0.02 : OpenVR = Headset Refresh Rate
        private void FixedUpdate()
        {
            if (!IsInitialized)
                return;

            if (!InputJump) 
                return;
            
            // todo: fix this cause this shit probably is dependent on physics rate for project lol
            _jumpTime += Time.fixedDeltaTime;
            if (_jumpTime > 0.6f)
            {
                _jumpTime = 0f;
                Grounded = true;
            }
            else if (_jumpTime > 0.01f) // basically next frame insta jump
            {
                Grounded = false;
            }
        }

        private void OnDrawGizmosSelected()
        {
            if (!IsInitialized)
                return;
            
            // todo: expose IsDebugDrawEnabled in AASEmulatorCore

            EyeLookManager.OnDrawGizmosSelected();
        }

        #endregion Unity Methods

        #region Private Methods
        
        private void Apply_ActiveBodyOffset()
        {
            IsActiveOffset = !Sitting && !IsEmotePlaying;
            
            // Also does not run in FBT
            if (!IsActiveOffset)
                return;

            if (m_headTransform == null
                || m_hipTransform == null)
                return;
            
            Vector3 headPosition = m_headTransform.position;
            Vector3 offset = headPosition - m_animator.transform.position;
            offset.y = 0f; // let me use with {} please :(
            m_hipTransform.position -= offset;
        }
        
        private void Update_EmoteValues_Update()
        {
            bool emotePlaying = AnimatorManager.IsEmotePlaying();
            if (emotePlaying != IsEmotePlaying)
            {
                IsEmotePlaying = emotePlaying;
                m_shouldRepaintEditor = true;
            }
            
            // Emote timeout (sets Emote to 0 after 0.1s)
            if (emoteTimer >= 0f)
            {
                emoteTimer += Time.deltaTime;
                if (!(emoteTimer >= EMOTE_TIMEOUT)) 
                    return;
                
                emoteTimer = -1f;
                Emote = 0;
                m_shouldRepaintEditor = true;
            }
            else if (Emote > 0) emoteTimer = 0f;
        }

        private void Update_CachedParametersFromAnimator()
        {
            // Will not support Animator -> Core Parameter
            // It is bloat...

            // Additional Parameters
            foreach (ParameterDefinition parameterDefinition in AnimatorManager.Parameters.GetParameters())
            {
                switch (parameterDefinition.GetParameterType())
                {
                    case AnimatorControllerParameterType.Float:
                        if (Math.Abs(parameterDefinition.GetFloat() - m_animator.GetFloat(parameterDefinition.name)) > float.Epsilon)
                        {
                            parameterDefinition.UpdateValue();
                            m_shouldRepaintEditor = true;
                        }
                        break;

                    case AnimatorControllerParameterType.Int:
                        if (parameterDefinition.GetInt() != m_animator.GetInteger(parameterDefinition.name))
                        {
                            parameterDefinition.UpdateValue();
                            m_shouldRepaintEditor = true;
                        }
                        break;

                    case AnimatorControllerParameterType.Bool:
                        if (parameterDefinition.GetBool() != m_animator.GetBool(parameterDefinition.name))
                        {
                            parameterDefinition.UpdateValue();
                            m_shouldRepaintEditor = true;
                        }
                        break;
                }
            }
        }

        // TODO: Rework this so multiple streams of input can set Core Parameters!
        private void Apply_Parameters()
        {
            AnimatorManager.IsLocal = true;
            AnimatorManager.VisemeIdx = Viseme;
            AnimatorManager.VisemeLoudness = VisemeLoudness;
            
            AnimatorManager.GestureLeft = _gestureLeft;
            AnimatorManager.GestureRight = _gestureRight;

            AnimatorManager.MovementX = _movement.x;
            AnimatorManager.MovementY = _movement.y;
            
            AnimatorManager.Grounded = Grounded;
            AnimatorManager.Crouching = Crouching;
            AnimatorManager.Prone = Prone;
            AnimatorManager.Flying = Flying;
            AnimatorManager.Sitting = Sitting;
            AnimatorManager.Swimming = Swimming;
            
            AnimatorManager.Emote = _emote;
            AnimatorManager.Toggle = _toggle;

            AnimatorManager.SetLayerWeight(AvatarDefinitions.HAND_LEFT_LAYER_NAME, IsEmotePlaying ? 0f : 1f);
            AnimatorManager.SetLayerWeight(AvatarDefinitions.HAND_RIGHT_LAYER_NAME, IsEmotePlaying ? 0f : 1f);
            
            // TODO: if player is in FBT the Locomotion/Emotes layer is disabled, but only locally...

            // CancelEmote is treated like a bool instead of a trigger
            if ((AnimatorManager.IsEmotePlaying() && _movement.magnitude > 0f) || CancelEmote)
            {
                if (!AnimatorManager.CancelEmote) AnimatorManager.CancelEmote = true;
            }
            else if (AnimatorManager.CancelEmote || CancelEmote)
                AnimatorManager.CancelEmote = false;
        }

        #endregion Private Methods

        #region Remote Clone Syncing
        
        private const float CORE_SYNC_RATE = 1 / 20f; // 20 times per second
        private const float AAS_FORCE_SYNC_RATE = 2f; // every 2 seconds
        private const float AAS_SYNC_RATE = 1 / 10f; // 10 times per second
        
        private float coreDataTimer;
        private float aasForcedSyncTimer;
        private float aasSyncTimer;

        private void DoRemoteCoreSyncUpdate()
        {
            coreDataTimer += Time.deltaTime;
            if (!(coreDataTimer >= CORE_SYNC_RATE)) return;
            coreDataTimer = 0f;
            
            // just gonna check this once
            bool shouldCancelEmote = (AnimatorManager.CancelEmote
                                      || AnimatorManager.MovementX > 0f
                                      || AnimatorManager.MovementY > 0f
                                      || !AnimatorManager.Grounded); // TODO: this is fixed next update
            
            m_humanPoseHandler?.GetHumanPose(ref m_humanPose);
            foreach (AASEmulatorRemote clone in m_RemoteClones)
            {
                clone.ReceiveCoreParameters(AnimatorManager, shouldCancelEmote);
                if (m_humanPoseHandler != null && AnimatorManager.IsHuman)
                    clone.ReceiveMuscleValues(ref m_humanPose);
            }
        }

        private void DoForceAASSyncUpdate()
        {
            aasForcedSyncTimer += Time.deltaTime;
            if (!(aasForcedSyncTimer >= AAS_FORCE_SYNC_RATE)) return;
            aasForcedSyncTimer = 0f;
            
            // force flag on so next aas sync check goes through
            // NOTE: rn Swimming parameter is not core, its AAS, so new avatars basically sync at full-tilt always lol
            AnimatorManager.OutboundBuffer.AASParameterChangedSinceLastSync = true;
        }

        private void DoSyncAASUpdate()
        {
            aasSyncTimer += Time.deltaTime;
            if (!(aasSyncTimer >= AAS_SYNC_RATE)) return;
            aasSyncTimer = 0f;

            if (!IsUsingAvatarAdvancedSettings)
                return; // did you know you could animate that :3
            
            if (!AnimatorManager.OutboundBuffer.AASParameterChangedSinceLastSync)
                return;
            
            foreach (AASEmulatorRemote clone in m_RemoteClones)
            {
                clone.AnimatorManager.InboundBuffer.ApplyAASToBuffer(AnimatorManager.OutboundBuffer.GetSyncData());
                // only apply if enabled- todo ig is to apply buffer OnEnable if wanting to replicate distance-hider ?
                if (clone.isActiveAndEnabled) clone.AnimatorManager.InboundBuffer.ApplyAdvancedAvatarSettingsFromBuffer();
            }

            AnimatorManager.OutboundBuffer.AASParameterChangedSinceLastSync = false;
        }

        #endregion Remote Clone Syncing
    }
}
#endif