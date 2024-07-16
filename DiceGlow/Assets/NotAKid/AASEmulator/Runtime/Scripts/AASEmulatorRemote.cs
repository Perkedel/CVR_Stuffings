#if CVR_CCK_EXISTS
using ABI.CCK.Components;
using NAK.AASEmulator.Runtime.Extensions;
using NAK.AASEmulator.Runtime.SubSystems;
using UnityEngine;

namespace NAK.AASEmulator.Runtime
{
    [AddComponentMenu("")]
    [HelpURL(AASEmulatorCore.AAS_EMULATOR_GIT_URL)]
    public class AASEmulatorRemote : EditorOnlyMonoBehaviour
    {
        #region Public Properties
        
        public bool UseEyeMovement
            => m_avatar is { useEyeMovement: true };

        public bool UseBlinkBlendshapes
            => m_avatar is { useBlinkBlendshapes: true };
        
        public bool UseLipsync
            => m_avatar is { useVisemeLipsync: true };
        
        public bool IsEmotePlaying { get; private set;}
        
        public bool IsApplyingNetIk { get; private set; }

        #endregion Public Properties

        private bool IsInitialized { get; set; }
        
        public AASEmulatorRuntime SourceRuntime { get; set; }
        public AvatarAnimator AnimatorManager { get; set; }
        
        private AvatarEyeBlinkManager EyeBlinkManager { get; set; }

        public CVRAvatar m_avatar;

        private void Initialize()
        {
            if (IsInitialized)
                return;

            if (AASEmulatorCore.Instance == null)
            {
                SimpleLogger.LogWarning("AAS Emulator Control is missing from the scene. Remote will not run!", gameObject);
                return;
            }

            if (!gameObject.TryGetComponent(out m_avatar))
            {
                SimpleLogger.LogError("The CVRAvatar component is missing on the attached gameObject. Destroying...", gameObject);
                DestroyImmediate(this);
                return;
            }
            
            // CVR will ensure this on initialization
            if (!gameObject.TryGetComponent(out Animator animator))
                animator = gameObject.AddComponent<Animator>();

            // CVR replaces old CCK animation clips, but we won't even bother trying
            animator.runtimeAnimatorController = m_avatar.overrides != null
                ? m_avatar.overrides
                : AASEmulatorCore.Instance.defaultRuntimeController;

            animator.keepAnimatorStateOnDisable = false;
            animator.applyRootMotion = false;
            
            if (animator.isHuman)
                _poseHandler = new HumanPoseHandler(AnimatorManager.Animator.avatar, AnimatorManager.Animator.transform);
            
            AnimatorManager = new AvatarAnimator(false);
            AnimatorManager.SetupManager(animator);
            
            EyeBlinkManager = new AvatarEyeBlinkManager(m_avatar);
            //EyeLookManager = new AvatarEyeLookManager(m_avatar); // TODO: Implement
            //LipSyncHandler = new AvatarLipSyncHandler(this);
            
            AASEmulatorCore.addTopComponentDelegate?.Invoke(this);
            AASEmulatorCore.remoteInitializedDelegate?.Invoke(this);
            IsInitialized = true;
        }

        #region Unity Events
        
        private void Start()
        {
            Initialize();
        }

        private void OnDestroy()
        {
            SourceRuntime.RemoveRemoteClone(this);
        }
        
        private void LateUpdate()
        {
            IsEmotePlaying = AnimatorManager.IsEmotePlaying();
            IsApplyingNetIk = !IsEmotePlaying;
            
            if (AnimatorManager.IsHuman) ApplyMuscleValues();
            
            AnimatorManager.IsLocal = false;
            AnimatorManager.VisemeIdx = AnimatorManager.VisemeIdx;
            AnimatorManager.DistanceTo = Vector3.Distance(transform.position, SourceRuntime.transform.position);

            float handLayerWeight = IsEmotePlaying ? 0f : 1f;
            AnimatorManager.SetLayerWeight(AvatarDefinitions.HAND_LEFT_LAYER_NAME, handLayerWeight);
            AnimatorManager.SetLayerWeight(AvatarDefinitions.HAND_RIGHT_LAYER_NAME, handLayerWeight);
            
            // kind of lazy but works for now
            EyeBlinkManager.IsEnabled = UseBlinkBlendshapes && AASEmulatorCore.Instance.EmulateEyeBlink;
            EyeBlinkManager.OnLateUpdate();
        }
        
        #endregion Unity Events
        
        #region Core Parameter Handling

        public void ReceiveCoreParameters(AvatarAnimator sourceAnimator, bool shouldCancelEmote)
        {
            AnimatorManager.GestureLeft = sourceAnimator.GestureLeft;
            AnimatorManager.GestureRight = sourceAnimator.GestureRight;

            AnimatorManager.MovementX = sourceAnimator.MovementX;
            AnimatorManager.MovementY = sourceAnimator.MovementY;

            AnimatorManager.Crouching = sourceAnimator.Crouching;
            AnimatorManager.Prone = sourceAnimator.Prone;
            AnimatorManager.Flying = sourceAnimator.Flying;
            AnimatorManager.Sitting = sourceAnimator.Sitting;
            // AnimatorManager.Swimming = sourceAnimator.Swimming;
            AnimatorManager.Grounded = sourceAnimator.Grounded;

            AnimatorManager.Toggle = sourceAnimator.Toggle;
            AnimatorManager.Emote = sourceAnimator.Emote;
            AnimatorManager.CancelEmote = shouldCancelEmote;
        }
        
        #endregion Core Parameter Handling
        
        #region Net IK Handling
        
        private HumanPoseHandler _poseHandler;
        private HumanPose _humanPose;
        private HumanPose _lastReceivedPose;
        
        public void ReceiveMuscleValues(ref HumanPose pose)
        {
            _lastReceivedPose = pose;
        }

        private void ApplyMuscleValues()
        {
            if (!IsApplyingNetIk)
                return;
            
            if (_lastReceivedPose.muscles == null 
                || _lastReceivedPose.muscles.Length == 0)
                return;
            
            _poseHandler.GetHumanPose(ref _humanPose);
            
            _humanPose.bodyPosition = _lastReceivedPose.bodyPosition;
            _humanPose.bodyRotation = _lastReceivedPose.bodyRotation;

            // the first 54 muscles are synced over net ik always, so we don't need any
            // additional logic to handle ignoring the rest of the muscles :3
            const int SYNCED_MUSCLE_COUNT = 54; // 94 if we care about finger tracking
            for (int i = 0; i < SYNCED_MUSCLE_COUNT; i++)
                _humanPose.muscles[i] = _lastReceivedPose.muscles[i];
            
            _poseHandler.SetHumanPose(ref _humanPose);
        }

        #endregion Net IK Handling
    }
}
#endif