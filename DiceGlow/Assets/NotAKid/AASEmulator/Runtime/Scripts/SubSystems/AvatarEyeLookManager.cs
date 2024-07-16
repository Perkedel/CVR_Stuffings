#if CVR_CCK_EXISTS
using System.Collections.Generic;
using ABI.CCK.Components;
using UnityEngine;

namespace NAK.AASEmulator.Runtime.SubSystems
{
    public class AvatarEyeLookManager
    {
        #region Public Properties
        
        private bool _isEnabled;
        public bool IsEnabled
        {
            get => _isEnabled;
            set
            {
                if (_isEnabled && !value)
                {
                    // reset eye look
                    Reset_EyeLook();
                }
                _isEnabled = value;
            }
        }

        private bool _isDebugDrawEnabled = true;
        public bool IsDebugDrawEnabled
        {
            get => _isDebugDrawEnabled;
            set => _isDebugDrawEnabled = value;
        }
        
        private Vector3 _lookAtPositionWorld;
        public Vector3 LookAtPositionWorld
        {
            get => _lookAtPositionWorld;
            set
            {
                _lookAtPositionWorld = value;
                //UpdateLookAtPosition();
            }
        }
        
        #endregion Public Properties

        #region Eye Definition

        private readonly struct EyeDefinition
        {
            // taken from Unity's Humanoid rig defaults
            public const float MUSCLE_DEFAULT_MAX_EYE_UP = -10f;
            public const float MUSCLE_DEFAULT_MAX_EYE_DOWN = 15f;
            public const float MUSCLE_DEFAULT_MAX_EYE_LEFT = -20f;
            public const float MUSCLE_DEFAULT_MAX_EYE_RIGHT = 20f;
            
            public EyeDefinition(Transform avatarRoot, Transform eyeTransform, 
                float eyeAngleLimitUp, float eyeAngleLimitDown, 
                float eyeAngleLimitIn, float eyeAngleLimitOut)
            {
                this.eyeTransform = eyeTransform;
                //this.eyeRenderer = eyeRenderer;
                
                maxEyeUpLimit = eyeAngleLimitUp;
                maxEyeDownLimit = eyeAngleLimitDown;
                maxEyeLeftLimit = eyeAngleLimitIn;
                maxEyeRightLimit = eyeAngleLimitOut;
                
                // chilloutvr assumes the eye forward direction to be the initial rotation of the eye bone
                originalRotationLocal = eyeTransform.localRotation;
                
                // calculate the rotation from the eye bone to the eye forward direction
                // - https://www.youtube.com/watch?v=QI8U67CT42w
                Quaternion world_From_eyeBone = eyeTransform.rotation;
                Quaternion world_From_avatarRoot = avatarRoot.rotation;
                Quaternion eyeForward_From_world = Quaternion.Inverse(world_From_avatarRoot);
                Quaternion eyeForwardFromEyeBone = eyeForward_From_world * world_From_eyeBone;
                eyeBone_From_eyeForward = Quaternion.Inverse(eyeForwardFromEyeBone);
            }
            
            public readonly Transform eyeTransform;
            public readonly Quaternion originalRotationLocal;
            //public readonly SkinnedMeshRenderer eyeRenderer; // for eye blendshapes

            private readonly float maxEyeUpLimit;
            private readonly float maxEyeDownLimit;
            private readonly float maxEyeLeftLimit;
            private readonly float maxEyeRightLimit;

            private readonly Quaternion eyeBone_From_eyeForward;

            #region Eye Rotation Limit Properties

            public Quaternion maxRotationUpLocal => Quaternion.Euler(maxEyeUpLimit, 0, 0) * eyeBone_From_eyeForward;
            public Quaternion maxRotationDownLocal => Quaternion.Euler(maxEyeDownLimit, 0, 0) * eyeBone_From_eyeForward;
            public Quaternion maxRotationLeftLocal => Quaternion.Euler(0, maxEyeLeftLimit, 0) * eyeBone_From_eyeForward;
            public Quaternion maxRotationRightLocal => Quaternion.Euler(0, maxEyeRightLimit, 0) * eyeBone_From_eyeForward;

            #endregion

            #region Eye Forward Direction Methods
            
            // returns the original forward direction of the eye in world space
            public Vector3 GetOriginalForwardDirection()
                => eyeTransform.parent.rotation * originalRotationLocal * Vector3.forward;
            
            // returns the forward direction of the eye in world space
            public Vector3 GetForwardDirection()
                => eyeTransform.parent.rotation * eyeTransform.localRotation * eyeBone_From_eyeForward * Vector3.forward;
            
            // returns the forward direction of the eye parent bone in world space
            public Vector3 GetRootForwardDirection()
                => eyeTransform.parent.rotation * eyeBone_From_eyeForward * Vector3.forward;
            
            #endregion

            #region Public Methods
            
            // make the eye look at a position in world space
            public void LookAtPositionWorld(Vector3 positionWorld)
            {
                // get the direction from the eye to the target
                Vector3 direction = positionWorld - eyeTransform.position;
                direction.Normalize();
                
                // calculate the rotation from the eye forward direction to the target direction
                Quaternion eye_From_target = Quaternion.FromToRotation(GetOriginalForwardDirection(), direction);
                
                Vector3 eye_From_target_Euler = eye_From_target.eulerAngles;
                eye_From_target_Euler.x = AsymptoticClampMinMax(NormalizeAngle(eye_From_target_Euler.x), maxEyeUpLimit, maxEyeDownLimit);
                eye_From_target_Euler.y = AsymptoticClampMinMax(NormalizeAngle(eye_From_target_Euler.y), maxEyeLeftLimit, maxEyeRightLimit);
                eye_From_target_Euler.z = 0f; // no roll
                
                eye_From_target = Quaternion.Euler(eye_From_target_Euler);
                eyeTransform.localRotation = eye_From_target;
            }
            
            #endregion

            #region Math Utils

            private static float NormalizeAngle(float angle)
            {
                angle %= 360;
                if (angle < -180) angle += 360;
                if (angle > 180) angle -= 360;
                return angle;
            }
            
            private static float AsymptoticClampMinMax(float value, float minvalue, float maxValue)
                => value > 0 ? AsymptoticClamp(value, maxValue) : -AsymptoticClamp(-value, -minvalue);
            
            private static float AsymptoticClamp(float value, float maxValue)
            {
                const float steepness = 4.0f;
                float midpointOffset = value - maxValue * 0.5f;
                float sigmoidThreshold = maxValue / (1 + Mathf.Exp(-steepness / maxValue * midpointOffset));
                return Mathf.Min(value, sigmoidThreshold);
            }

            #endregion
        }
        
        #endregion
        
        // Avatar info
        private readonly CVRAvatar m_avatar;
        private readonly List<EyeDefinition> m_eyeDefinitions = new();
        
        public AvatarEyeLookManager(CVRAvatar avatar)
        {
            m_avatar = avatar;
            InitializeEyeLook();
        }
        
        public void OnLateUpdate()
        {
            if (!IsEnabled)
                return;
            
            Handle_EyeLook();
        }
        
        public void OnDrawGizmosSelected()
        {
            if (!IsEnabled)
                return;
            
            if (!_isDebugDrawEnabled)
                return;
            
            // draw sphere at the look at position
            Gizmos.color = Color.red;
            Gizmos.DrawSphere(LookAtPositionWorld, 0.1f);
        }

        #region Private Methods

        private void InitializeEyeLook()
        {
            if (m_avatar == null)
                return;

            if (m_avatar.eyeMovementInfo.type == CVRAvatar.CVRAvatarEyeLookMode.Muscle)
                InitializeMuscleEyeLook();
            else if (m_avatar.eyeMovementInfo.type == CVRAvatar.CVRAvatarEyeLookMode.Transform)
                InitializeTransformEyeLook();
        }

        private void InitializeMuscleEyeLook()
        {
            Transform root = m_avatar.transform;
            Animator animator = root.GetComponent<Animator>();
            if (animator == null) return;
            
            Transform leftEyeTransform = animator.GetBoneTransform(HumanBodyBones.LeftEye);
            Transform rightEyeTransform = animator.GetBoneTransform(HumanBodyBones.RightEye);
            if (leftEyeTransform == null && rightEyeTransform == null) return;
            
            // get eye limits from humanoid configuration
            Vector2 upDownLimitRight;
            Vector2 inOutLimitRight;
            Vector2 upDownLimitLeft = upDownLimitRight = new Vector2(EyeDefinition.MUSCLE_DEFAULT_MAX_EYE_UP, EyeDefinition.MUSCLE_DEFAULT_MAX_EYE_DOWN);
            Vector2 inOutLimitLeft = inOutLimitRight = new Vector2(EyeDefinition.MUSCLE_DEFAULT_MAX_EYE_LEFT, EyeDefinition.MUSCLE_DEFAULT_MAX_EYE_RIGHT);

            string leftEyeBoneName = HumanBodyBones.LeftEye.ToString();
            string rightEyeBoneName = HumanBodyBones.RightEye.ToString();
            foreach (HumanBone humanBone in animator.avatar.humanDescription.human)
            {
                if (humanBone.humanName == leftEyeBoneName)
                {
                    upDownLimitLeft = humanBone.limit.useDefaultValues
                        ? upDownLimitLeft
                        : new Vector2(humanBone.limit.min.z, humanBone.limit.max.z);
                    inOutLimitLeft = humanBone.limit.useDefaultValues
                        ? inOutLimitLeft
                        : new Vector2(-humanBone.limit.max.y, -humanBone.limit.min.y);
                }
                else if (humanBone.humanName == rightEyeBoneName)
                {
                    upDownLimitRight = humanBone.limit.useDefaultValues
                        ? upDownLimitRight
                        : new Vector2(humanBone.limit.min.z, humanBone.limit.max.z);
                    inOutLimitRight = humanBone.limit.useDefaultValues
                        ? inOutLimitRight
                        : new Vector2(humanBone.limit.min.y, humanBone.limit.max.y);
                }
            }
            
            if (leftEyeTransform != null) 
                m_eyeDefinitions.Add(new EyeDefinition(root, leftEyeTransform, 
                    upDownLimitLeft.x, upDownLimitLeft.y, inOutLimitLeft.x, inOutLimitLeft.y));
            if (rightEyeTransform != null)
                m_eyeDefinitions.Add(new EyeDefinition(root, rightEyeTransform, 
                    upDownLimitRight.x, upDownLimitRight.y, inOutLimitRight.x, inOutLimitRight.y));
        }

        private void InitializeTransformEyeLook()
        {
            Transform root = m_avatar.transform;
            
            // get eye entries from avatar
            var eyeEntries = m_avatar.eyeMovementInfo.eyes;
            foreach (CVRAvatar.EyeMovementInfoEye eyeInfo in eyeEntries)
            {
                Transform eyeTransform = eyeInfo.eyeTransform;
                if (eyeTransform == null) continue; // skip if no eye transform
                m_eyeDefinitions.Add(new EyeDefinition(root, eyeTransform, 
                    -eyeInfo.eyeAngleLimitUp, -eyeInfo.eyeAngleLimitDown, // up is negative, down is positive, invert!
                    eyeInfo.isLeft ? eyeInfo.eyeAngleLimitIn : -eyeInfo.eyeAngleLimitOut, 
                    eyeInfo.isLeft ? eyeInfo.eyeAngleLimitOut : -eyeInfo.eyeAngleLimitIn));
            }
        }

        private void Handle_EyeLook()
        {
            if (m_avatar == null 
                || m_avatar.eyeMovementInfo.type == CVRAvatar.CVRAvatarEyeLookMode.None)
                return;

            foreach (EyeDefinition eye in m_eyeDefinitions)
            {
                if (!eye.eyeTransform) return;
                eye.LookAtPositionWorld(LookAtPositionWorld);
                DrawEyeLookDebug(eye); // draw after the eye look
            }
        }

        private void Reset_EyeLook()
        {
            foreach (EyeDefinition eye in m_eyeDefinitions)
            {
                if (!eye.eyeTransform) return;
                eye.eyeTransform.localRotation = eye.originalRotationLocal;
            }
        }
        
        private void DrawEyeLookDebug(EyeDefinition eye)
        {
            if (!_isDebugDrawEnabled)
                return;
            
            Vector3 eyePositionWorld = eye.eyeTransform.position;
            
            // eye's current forward direction
            Debug.DrawLine(eyePositionWorld, eyePositionWorld + eye.GetForwardDirection(), Color.red);
            
            Vector3 eyeOriginalForwardWorld = eye.GetRootForwardDirection();
            // the max eye rotation, but in relation to the eye's original forward direction
            Debug.DrawLine(eyePositionWorld, eyePositionWorld + eyeOriginalForwardWorld, Color.blue); // original forward
            Debug.DrawLine(eyePositionWorld, eyePositionWorld + eye.maxRotationUpLocal * eyeOriginalForwardWorld, Color.green);
            Debug.DrawLine(eyePositionWorld, eyePositionWorld + eye.maxRotationDownLocal * eyeOriginalForwardWorld, Color.yellow);
            Debug.DrawLine(eyePositionWorld, eyePositionWorld + eye.maxRotationLeftLocal * eyeOriginalForwardWorld, Color.cyan);
            Debug.DrawLine(eyePositionWorld, eyePositionWorld + eye.maxRotationRightLocal * eyeOriginalForwardWorld, Color.magenta);
        }
        
        #endregion
    }
}
#endif