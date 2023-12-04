using ABI.CCK.Components;
using ABI_RC.Core.InteractionSystem;
using ABI_RC.Core.Player;
using ABI_RC.Core.Savior;
using ABI_RC.Systems.Camera;
using ABI_RC.Systems.IK;
using ABI_RC.Systems.IK.SubSystems;
using ABI_RC.Systems.InputManagement;
using ABI_RC.Systems.MovementSystem;
using RootMotion.Dynamics;
using RootMotion.FinalIK;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace ml_prm
{
    [DisallowMultipleComponent]
    public class RagdollController : MonoBehaviour
    {
        const float c_defaultFriction = 0.6f;

        public static RagdollController Instance { get; private set; } = null;

        bool m_inVr = false;
        VRIK m_vrIK = null;
        bool m_applyHipsPosition = false;
        bool m_applyHipsRotation = false;

        bool m_enabled = false;
        bool m_forcedSwitch = false;

        readonly List<Rigidbody> m_rigidBodies = null;
        readonly List<Collider> m_colliders = null;
        Transform m_puppetRoot = null;
        Transform m_puppet = null;
        BipedRagdollReferences m_puppetReferences;
        readonly List<System.Tuple<Transform, Transform>> m_boneLinks = null;
        readonly List<System.Tuple<CharacterJoint, Vector3>> m_jointAnchors = null;
        readonly List<PhysicsInfluencer> m_physicsInfluencers = null;

        bool m_avatarReady = false;
        Coroutine m_initCoroutine = null;
        Vector3 m_lastPosition = Vector3.zero;
        Vector3 m_velocity = Vector3.zero;
        Vector3 m_ragdollLastPos = Vector3.zero;

        RagdollToggle m_avatarRagdollToggle = null;
        RagdollTrigger m_ragdollTrigger = null;
        AvatarBoolParameter m_ragdolledParameter = null;
        PhysicMaterial m_physicsMaterial = null;

        bool m_reachedGround = true;
        float m_groundedTime = 0f;
        float m_downTime = float.MinValue;

        internal RagdollController()
        {
            m_rigidBodies = new List<Rigidbody>();
            m_colliders = new List<Collider>();
            m_boneLinks = new List<System.Tuple<Transform, Transform>>();
            m_jointAnchors = new List<System.Tuple<CharacterJoint, Vector3>>();
            m_physicsInfluencers = new List<PhysicsInfluencer>();
        }

        // Unity events
        void Start()
        {
            if(Instance == null)
                Instance = this;

            m_inVr = Utils.IsInVR();

            m_physicsMaterial = new PhysicMaterial("Ragdoll");
            m_physicsMaterial.dynamicFriction = c_defaultFriction;
            m_physicsMaterial.staticFriction = c_defaultFriction;
            m_physicsMaterial.frictionCombine = PhysicMaterialCombine.Average;
            m_physicsMaterial.bounciness = 0f;
            m_physicsMaterial.bounceCombine = PhysicMaterialCombine.Average;

            m_puppetRoot = new GameObject("[PlayerAvatarPuppet]").transform;
            m_puppetRoot.parent = PlayerSetup.Instance.transform;
            m_puppetRoot.localPosition = Vector3.zero;
            m_puppetRoot.localRotation = Quaternion.identity;

            m_ragdollTrigger = MovementSystem.Instance.proxyCollider.gameObject.AddComponent<RagdollTrigger>();
            m_ragdollTrigger.enabled = false;

            Settings.MovementDragChange += this.OnMovementDragChange;
            Settings.AngularDragChange += this.OnAngularDragChange;
            Settings.GravityChange += this.OnGravityChange;
            Settings.SlipperinessChange += this.OnPhysicsMaterialChange;
            Settings.BouncinessChange += this.OnPhysicsMaterialChange;
            Settings.BuoyancyChange += this.OnBuoyancyChange;
        }

        void OnDestroy()
        {
            if(Instance == this)
                Instance = null;

            if(m_initCoroutine != null)
                StopCoroutine(m_initCoroutine);
            m_initCoroutine = null;

            if(m_puppetRoot != null)
                Object.Destroy(m_puppetRoot);
            m_puppetRoot = null;
            m_puppet = null;
            m_rigidBodies.Clear();
            m_colliders.Clear();
            m_boneLinks.Clear();
            m_jointAnchors.Clear();
            m_physicsInfluencers.Clear();
            m_avatarRagdollToggle = null;

            if(m_ragdollTrigger != null)
                Object.Destroy(m_ragdollTrigger);
            m_ragdollTrigger = null;

            if(m_physicsMaterial != null)
                Object.Destroy(m_physicsMaterial);
            m_physicsMaterial = null;

            Settings.MovementDragChange -= this.OnMovementDragChange;
            Settings.AngularDragChange -= this.OnAngularDragChange;
            Settings.GravityChange -= this.OnGravityChange;
            Settings.SlipperinessChange -= this.OnPhysicsMaterialChange;
            Settings.BouncinessChange -= this.OnPhysicsMaterialChange;
            Settings.BuoyancyChange -= this.OnBuoyancyChange;
        }

        void Update()
        {
            if(m_avatarReady && m_enabled)
            {
                Vector3 l_dif = m_puppetReferences.hips.position - m_ragdollLastPos;
                PlayerSetup.Instance.transform.position += l_dif;
                m_puppetReferences.hips.position -= l_dif;
                m_ragdollLastPos = m_puppetReferences.hips.position;

                BodySystem.TrackingPositionWeight = 0f;
            }

            if(m_avatarReady && !m_enabled)
            {
                Vector3 l_pos = PlayerSetup.Instance.transform.position;
                m_velocity = (m_velocity + (l_pos - m_lastPosition) / Time.deltaTime) * 0.5f;
                m_lastPosition = l_pos;

                if(!m_reachedGround && MovementSystem.Instance.IsGrounded())
                {
                    m_groundedTime += Time.deltaTime;
                    if(m_groundedTime >= 0.25f)
                        m_reachedGround = true;
                }
            }

            if(m_avatarReady && m_enabled && Settings.AutoRecover)
            {
                m_downTime += Time.deltaTime;
                if(m_downTime >= Settings.RecoverDelay)
                {
                    SwitchRagdoll();
                    m_downTime = float.MinValue; // One attepmt to recover
                }
            }

            if((m_avatarRagdollToggle != null) && m_avatarRagdollToggle.isActiveAndEnabled && m_avatarRagdollToggle.shouldOverride && (m_enabled != m_avatarRagdollToggle.isOn))
                SwitchRagdoll();

            if((m_ragdollTrigger != null) && m_ragdollTrigger.GetStateWithReset() && m_avatarReady && !m_enabled && Settings.PointersReaction)
                SwitchRagdoll();

            if(Settings.Hotkey && Input.GetKeyDown(Settings.HotkeyKey) && !ViewManager.Instance.isGameMenuOpen())
                SwitchRagdoll();

            if(m_avatarReady && m_enabled && CVRInputManager.Instance.jump && Settings.JumpRecover)
                SwitchRagdoll();
        }

        void LateUpdate()
        {
            if(m_avatarReady)
            {
                if(m_enabled)
                {
                    foreach(var l_link in m_boneLinks)
                        l_link.Item1.CopyGlobal(l_link.Item2);
                }
                else
                {
                    foreach(var l_link in m_boneLinks)
                        l_link.Item2.CopyGlobal(l_link.Item1);
                }
            }
        }

        // Game events
        internal void OnAvatarClear()
        {
            if(m_initCoroutine != null)
            {
                StopCoroutine(m_initCoroutine);
                m_initCoroutine = null;
            }

            if(m_enabled)
            {
                TryRestoreMovement();
                BodySystem.TrackingPositionWeight = 1f;
            }

            if(m_puppet != null)
                Object.Destroy(m_puppet.gameObject);
            m_puppet = null;

            if(m_ragdollTrigger != null)
            {
                m_ragdollTrigger.GetStateWithReset();
                m_ragdollTrigger.enabled = false;
            }

            m_vrIK = null;
            m_applyHipsPosition = false;
            m_enabled = false;
            m_avatarReady = false;
            m_avatarRagdollToggle = null;
            m_ragdolledParameter = null;
            m_rigidBodies.Clear();
            m_colliders.Clear();
            m_puppetReferences = new BipedRagdollReferences();
            m_boneLinks.Clear();
            m_jointAnchors.Clear();
            m_physicsInfluencers.Clear();
            m_reachedGround = true;
            m_groundedTime = 0f;
            m_downTime = float.MinValue;
            m_puppetRoot.localScale = Vector3.one;
        }

        internal void OnAvatarSetup()
        {
            m_inVr = Utils.IsInVR();

            if(PlayerSetup.Instance._animator.isHuman)
            {
                BipedRagdollReferences l_avatarReferences = BipedRagdollReferences.FromAvatar(PlayerSetup.Instance._animator);

                m_puppet = new GameObject("Root").transform;
                m_puppet.parent = m_puppetRoot;
                m_puppet.localPosition = Vector3.zero;
                m_puppet.localRotation = Quaternion.identity;

                m_puppetReferences.root = m_puppet;
                m_puppetReferences.hips = CloneTransform(l_avatarReferences.hips, m_puppetReferences.root, "Hips");
                m_puppetReferences.spine = CloneTransform(l_avatarReferences.spine, m_puppetReferences.hips, "Spine");

                if(l_avatarReferences.chest != null)
                    m_puppetReferences.chest = CloneTransform(l_avatarReferences.chest, m_puppetReferences.spine, "Chest");

                m_puppetReferences.head = CloneTransform(l_avatarReferences.head, (m_puppetReferences.chest != null) ? m_puppetReferences.chest : m_puppetReferences.spine, "Head");

                m_puppetReferences.leftUpperArm = CloneTransform(l_avatarReferences.leftUpperArm, (m_puppetReferences.chest != null) ? m_puppetReferences.chest : m_puppetReferences.spine, "LeftUpperArm");
                m_puppetReferences.leftLowerArm = CloneTransform(l_avatarReferences.leftLowerArm, m_puppetReferences.leftUpperArm, "LeftLowerArm");
                m_puppetReferences.leftHand = CloneTransform(l_avatarReferences.leftHand, m_puppetReferences.leftLowerArm, "LeftHand");

                m_puppetReferences.rightUpperArm = CloneTransform(l_avatarReferences.rightUpperArm, (m_puppetReferences.chest != null) ? m_puppetReferences.chest : m_puppetReferences.spine, "RightUpperArm");
                m_puppetReferences.rightLowerArm = CloneTransform(l_avatarReferences.rightLowerArm, m_puppetReferences.rightUpperArm, "RightLowerArm");
                m_puppetReferences.rightHand = CloneTransform(l_avatarReferences.rightHand, m_puppetReferences.rightLowerArm, "RightHand");

                m_puppetReferences.leftUpperLeg = CloneTransform(l_avatarReferences.leftUpperLeg, m_puppetReferences.hips, "LeftUpperLeg");
                m_puppetReferences.leftLowerLeg = CloneTransform(l_avatarReferences.leftLowerLeg, m_puppetReferences.leftUpperLeg, "LeftLowerLeg");
                m_puppetReferences.leftFoot = CloneTransform(l_avatarReferences.leftFoot, m_puppetReferences.leftLowerLeg, "LeftFoot");

                m_puppetReferences.rightUpperLeg = CloneTransform(l_avatarReferences.rightUpperLeg, m_puppetReferences.hips, "RightUpperLeg");
                m_puppetReferences.rightLowerLeg = CloneTransform(l_avatarReferences.rightLowerLeg, m_puppetReferences.rightUpperLeg, "RightLowerLeg");
                m_puppetReferences.rightFoot = CloneTransform(l_avatarReferences.rightFoot, m_puppetReferences.rightLowerLeg, "RightFoot");

                // Move to world origin to overcome possible issues, maybe?
                m_puppetRoot.position = Vector3.zero;
                m_puppetRoot.rotation = Quaternion.identity;

                BipedRagdollCreator.Options l_options = BipedRagdollCreator.AutodetectOptions(m_puppetReferences);
                l_options.joints = RagdollCreator.JointType.Character;
                BipedRagdollCreator.Create(m_puppetReferences, l_options);

                Transform[] l_puppetTransforms = m_puppetReferences.GetRagdollTransforms();
                Transform[] l_avatarTransforms = l_avatarReferences.GetRagdollTransforms();
                for(int i = 0; i < l_puppetTransforms.Length; i++)
                {
                    if(l_puppetTransforms[i] != null)
                    {
                        Rigidbody l_body = l_puppetTransforms[i].GetComponent<Rigidbody>();
                        if(l_body != null)
                        {
                            m_rigidBodies.Add(l_body);
                            l_body.isKinematic = true;
                            l_body.angularDrag = Settings.AngularDrag;
                            l_body.drag = (Utils.IsWorldSafe() ? Settings.MovementDrag : 1f);
                            l_body.useGravity = (!Utils.IsWorldSafe() || Settings.Gravity);
                            l_body.collisionDetectionMode = CollisionDetectionMode.ContinuousDynamic;
                            l_body.gameObject.layer = LayerMask.NameToLayer("PlayerLocal");
                        }

                        CharacterJoint l_joint = l_puppetTransforms[i].GetComponent<CharacterJoint>();
                        if(l_joint != null)
                        {
                            l_joint.enablePreprocessing = false;
                            l_joint.enableProjection = true;
                            m_jointAnchors.Add(System.Tuple.Create(l_joint, l_joint.connectedAnchor));
                        }

                        Collider l_collider = l_puppetTransforms[i].GetComponent<Collider>();
                        if(l_collider != null)
                        {
                            Physics.IgnoreCollision(l_collider, MovementSystem.Instance.controller, true);
                            Physics.IgnoreCollision(l_collider, MovementSystem.Instance.proxyCollider, true);
                            Physics.IgnoreCollision(l_collider, MovementSystem.Instance.forceCollider, true);
                            l_collider.sharedMaterial = m_physicsMaterial;
                            l_collider.material = m_physicsMaterial;
                            m_colliders.Add(l_collider);
                        }

                        if((l_body != null) && (l_collider != null) && (l_puppetTransforms[i] == m_puppetReferences.hips || l_puppetTransforms[i] == m_puppetReferences.spine || l_puppetTransforms[i] == m_puppetReferences.chest))
                        {
                            PhysicsInfluencer l_physicsInfluencer = l_puppetTransforms[i].gameObject.AddComponent<PhysicsInfluencer>();
                            l_physicsInfluencer.airDrag = (Utils.IsWorldSafe() ? Settings.MovementDrag : 1f);
                            l_physicsInfluencer.airAngularDrag = Settings.AngularDrag;
                            l_physicsInfluencer.fluidDrag = 3f;
                            l_physicsInfluencer.fluidAngularDrag = 1f;
                            l_physicsInfluencer.enableBuoyancy = true;
                            l_physicsInfluencer.enableInfluence = false;
                            float mass = l_body.mass;
                            l_physicsInfluencer.UpdateDensity();
                            l_body.mass = mass;
                            l_physicsInfluencer.volume = mass * 0.005f;
                            l_physicsInfluencer.enableLocalGravity = true;

                            m_physicsInfluencers.Add(l_physicsInfluencer);
                        }

                        if(l_avatarTransforms[i] != null)
                            m_boneLinks.Add(System.Tuple.Create(l_puppetTransforms[i], l_avatarTransforms[i]));
                    }
                }

                // And return back
                m_puppetRoot.localPosition = Vector3.zero;
                m_puppetRoot.localRotation = Quaternion.identity;
                m_puppetRoot.gameObject.SetActive(true);

                m_vrIK = PlayerSetup.Instance._avatar.GetComponent<VRIK>();
                if(m_vrIK != null)
                    m_vrIK.onPostSolverUpdate.AddListener(this.OnIKPostUpdate);

                m_avatarRagdollToggle = PlayerSetup.Instance._avatar.GetComponentInChildren<RagdollToggle>(true);
                m_ragdolledParameter = new AvatarBoolParameter("Ragdolled", PlayerSetup.Instance.animatorManager);

                m_initCoroutine = StartCoroutine(WaitForPhysicsInfluencers());
            }
        }

        IEnumerator WaitForPhysicsInfluencers()
        {
            while(!m_physicsInfluencers.TrueForAll(p => p.IsReady()))
                yield return null;

            m_puppetRoot.gameObject.SetActive(false);

            m_ragdollTrigger.enabled = true;
            m_avatarReady = true;
            m_initCoroutine = null;

            OnGravityChange(Settings.Gravity);
            OnBuoyancyChange(Settings.Buoyancy);
            OnMovementDragChange(Settings.MovementDrag);
            OnAngularDragChange(Settings.AngularDrag);
        }

        internal void OnAvatarScaling(float p_scaleDifference)
        {
            if(m_puppetRoot != null)
                m_puppetRoot.localScale = Vector3.one * p_scaleDifference;

            foreach(var l_pair in m_jointAnchors)
                l_pair.Item1.connectedAnchor = l_pair.Item2 * p_scaleDifference;
        }

        internal void OnSeatSitDown(CVRSeat p_seat)
        {
            if(m_avatarReady && m_enabled && !p_seat.occupied)
            {
                m_forcedSwitch = true;
                SwitchRagdoll();
                m_forcedSwitch = false;
            }
        }

        internal void OnStartCalibration()
        {
            if(m_avatarReady && m_enabled)
            {
                m_forcedSwitch = true;
                SwitchRagdoll();
                m_forcedSwitch = false;
            }
        }

        internal void OnWorldSpawn()
        {
            if(m_avatarReady && m_enabled)
                SwitchRagdoll();

            OnGravityChange(Settings.Gravity);
            OnPhysicsMaterialChange(true);
            OnMovementDragChange(Settings.MovementDrag);
            OnBuoyancyChange(Settings.Buoyancy);
        }

        internal void OnCombatDown()
        {
            if(m_avatarReady && !m_enabled && Settings.CombatReaction)
            {
                m_reachedGround = true;
                m_forcedSwitch = true;
                SwitchRagdoll();
                m_forcedSwitch = false;
            }
        }

        internal void OnChangeFlight()
        {
            if(m_avatarReady && m_enabled && MovementSystem.Instance.flying)
            {
                m_forcedSwitch = true;
                SwitchRagdoll();
                m_forcedSwitch = false;
            }
        }

        internal void OnPlayerTeleport()
        {
            if(m_avatarReady && m_enabled)
                m_ragdollLastPos = m_puppetReferences.hips.position;
        }

        internal void OnDroneModeDisable()
        {
            if(m_avatarReady && m_enabled)
                MovementSystem.Instance.canRot = false;
        }

        // IK updates
        void OnIKPostUpdate()
        {
            if(!m_enabled)
            {
                foreach(var l_link in m_boneLinks)
                    l_link.Item2.CopyGlobal(l_link.Item1);
            }
        }

        // Settings
        void OnMovementDragChange(float p_value)
        {
            if(m_avatarReady)
            {
                float l_drag = (Utils.IsWorldSafe() ? p_value : 1f);
                foreach(Rigidbody l_body in m_rigidBodies)
                {
                    l_body.drag = l_drag;
                    if(m_enabled)
                        l_body.WakeUp();
                }
                foreach(PhysicsInfluencer l_influencer in m_physicsInfluencers)
                    l_influencer.airDrag = l_drag;
            }
        }
        void OnAngularDragChange(float p_value)
        {
            if(m_avatarReady)
            {
                foreach(Rigidbody l_body in m_rigidBodies)
                {
                    l_body.angularDrag = p_value;
                    if(m_enabled)
                        l_body.WakeUp();
                }
                foreach(PhysicsInfluencer l_influencer in m_physicsInfluencers)
                    l_influencer.airAngularDrag = p_value;
            }
        }
        void OnGravityChange(bool p_state)
        {
            if(m_avatarReady)
            {
                bool l_gravity = (!Utils.IsWorldSafe() || p_state);
                foreach(Rigidbody l_body in m_rigidBodies)
                    l_body.useGravity = l_gravity;
                foreach(PhysicsInfluencer l_influencer in m_physicsInfluencers)
                    l_influencer.enabled = l_gravity;

                if(!l_gravity)
                {
                    OnMovementDragChange(Settings.MovementDrag);
                    OnAngularDragChange(Settings.AngularDrag);
                }
            }
        }
        void OnPhysicsMaterialChange(bool p_state)
        {
            if(m_physicsMaterial != null)
            {
                bool l_slipperiness = (Settings.Slipperiness && Utils.IsWorldSafe());
                bool l_bounciness = (Settings.Bounciness && Utils.IsWorldSafe());
                m_physicsMaterial.dynamicFriction = (l_slipperiness ? 0f : c_defaultFriction);
                m_physicsMaterial.staticFriction = (l_slipperiness ? 0f : c_defaultFriction);
                m_physicsMaterial.frictionCombine = (l_slipperiness ? PhysicMaterialCombine.Minimum : PhysicMaterialCombine.Average);
                m_physicsMaterial.bounciness = (l_bounciness ? 1f : 0f);
                m_physicsMaterial.bounceCombine = (l_bounciness ? PhysicMaterialCombine.Maximum : PhysicMaterialCombine.Average);
            }
        }
        void OnBuoyancyChange(bool p_state)
        {
            if(m_avatarReady)
            {
                bool l_buoyancy = (!Utils.IsWorldSafe() || p_state);
                foreach(PhysicsInfluencer l_influencer in m_physicsInfluencers)
                    l_influencer.enableInfluence = l_buoyancy;

                if(!l_buoyancy)
                {
                    OnMovementDragChange(Settings.MovementDrag);
                    OnAngularDragChange(Settings.AngularDrag);
                }
            }
        }

        // Arbitrary
        public void SwitchRagdoll()
        {
            if(m_avatarReady)
            {
                if(!m_enabled)
                {
                    if(CanRagdoll())
                    {
                        if(MovementSystem.Instance.flying)
                            MovementSystem.Instance.ChangeFlight(false);
                        MovementSystem.Instance.SetImmobilized(true);
                        MovementSystem.Instance.ClearFluidVolumes();
                        BodySystem.TrackingPositionWeight = 0f;
                        m_applyHipsPosition = IKSystem.Instance.applyOriginalHipPosition;
                        IKSystem.Instance.applyOriginalHipPosition = true;
                        m_applyHipsRotation = IKSystem.Instance.applyOriginalHipRotation;
                        IKSystem.Instance.applyOriginalHipRotation = true;

                        PlayerSetup.Instance.animatorManager.SetAnimatorParameterTrigger("CancelEmote");
                        m_ragdolledParameter.SetValue(true);

                        if(!Utils.IsWorldSafe())
                        {
                            m_reachedGround = false; // Force player to unragdoll and reach ground first
                            m_groundedTime = 0f;
                        }

                        m_puppetRoot.gameObject.SetActive(true);

                        foreach(Rigidbody l_body in m_rigidBodies)
                            l_body.isKinematic = false;

                        Vector3 l_velocity = Vector3.ClampMagnitude(m_velocity * (Utils.IsWorldSafe() ? Settings.VelocityMultiplier : 1f), Utils.GetWorldMovementLimit());
                        if(Settings.ViewVelocity && Utils.IsWorldSafe())
                        {
                            float l_mag = l_velocity.magnitude;
                            l_velocity = PlayerSetup.Instance.GetActiveCamera().transform.forward * l_mag;
                        }

                        foreach(Rigidbody l_body in m_rigidBodies)
                        {
                            l_body.velocity = l_velocity;
                            l_body.angularVelocity = Vector3.zero;
                        }

                        m_ragdollLastPos = m_puppetReferences.hips.position;
                        m_downTime = 0f;

                        m_enabled = true;
                    }
                }
                else
                {
                    if(CanUnragdoll())
                    {
                        MovementSystem.Instance.TeleportTo(m_puppetReferences.hips.position, new Vector3(0f, PlayerSetup.Instance.GetActiveCamera().transform.rotation.eulerAngles.y, 0f));
                        TryRestoreMovement();
                        if(!Utils.IsWorldSafe())
                        {
                            Vector3 l_vec = MovementSystem.Instance.GetAppliedGravity();
                            l_vec.y = Mathf.Clamp(l_vec.y, float.MinValue, 0f);
                            MovementSystem.Instance.SetAppliedGravity(l_vec);
                        }
                        BodySystem.TrackingPositionWeight = 1f;
                        IKSystem.Instance.applyOriginalHipPosition = m_applyHipsPosition;
                        IKSystem.Instance.applyOriginalHipRotation = m_applyHipsRotation;

                        if(m_vrIK != null)
                            m_vrIK.solver.Reset();

                        m_ragdolledParameter.SetValue(false);

                        m_puppetRoot.gameObject.SetActive(false);
                        m_puppetRoot.localPosition = Vector3.zero;
                        m_puppetRoot.localRotation = Quaternion.identity;

                        foreach(Rigidbody l_body in m_rigidBodies)
                            l_body.isKinematic = true;

                        foreach(PhysicsInfluencer l_physicsInfluencer in m_physicsInfluencers)
                            l_physicsInfluencer.ClearFluidVolumes();

                        m_lastPosition = PlayerSetup.Instance.transform.position;
                        m_velocity = Vector3.zero;
                        m_downTime = float.MinValue;

                        // Restore rigidbody properties that could be affected by buoyancy
                        OnMovementDragChange(Settings.MovementDrag);
                        OnAngularDragChange(Settings.AngularDrag);

                        m_enabled = false;
                    }
                }
            }
        }

        public bool IsRagdolled() => (m_avatarReady && m_enabled);

        static Transform CloneTransform(Transform p_source, Transform p_parent, string p_name)
        {
            Transform l_target = new GameObject(p_name).transform;
            l_target.parent = p_parent;
            p_source.CopyGlobal(l_target);
            return l_target;
        }

        bool CanRagdoll()
        {
            bool l_result = m_reachedGround;
            l_result &= !BodySystem.isCalibrating;
            l_result &= (MovementSystem.Instance.lastSeat == null);
            l_result &= ((CombatSystem.Instance == null) || !CombatSystem.Instance.isDown);
            return (l_result || m_forcedSwitch);
        }

        bool CanUnragdoll()
        {
            bool l_result = true;
            l_result &= ((CombatSystem.Instance == null) || !CombatSystem.Instance.isDown);
            return (l_result || m_forcedSwitch);
        }

        static void TryRestoreMovement()
        {
            bool l_state = true;
            l_state &= ((CombatSystem.Instance == null) || !CombatSystem.Instance.isDown);
            l_state &= (MovementSystem.Instance.lastSeat == null);

            if(l_state)
            {
                MovementSystem.Instance.SetImmobilized(false);
                if(PortableCamera.Instance.CheckModActive(typeof(ABI_RC.Systems.Camera.VisualMods.DroneMode)))
                    MovementSystem.Instance.canRot = false;
            }
        }
    }
}
