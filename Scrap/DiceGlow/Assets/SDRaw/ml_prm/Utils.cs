using ABI.CCK.Components;
using ABI_RC.Core.Savior;
using ABI_RC.Systems.MovementSystem;
using System.Collections.Generic;
using System.Reflection;
using UnityEngine;

namespace ml_prm
{
    static class Utils
    {
        static readonly FieldInfo ms_groundedRaw = typeof(MovementSystem).GetField("_isGroundedRaw", BindingFlags.NonPublic | BindingFlags.Instance);
        static readonly FieldInfo ms_appliedGravity = typeof(MovementSystem).GetField("_appliedGravity", BindingFlags.NonPublic | BindingFlags.Instance);
        static readonly FieldInfo ms_touchingVolumes = typeof(MovementSystem).GetField("_touchingVolumes", BindingFlags.NonPublic | BindingFlags.Instance);
        static readonly FieldInfo ms_referencePoints = typeof(PhysicsInfluencer).GetField("_referencePoints", BindingFlags.NonPublic | BindingFlags.Instance);
        static readonly FieldInfo ms_influencerTouchingVolumes = typeof(PhysicsInfluencer).GetField("_touchingVolumes", BindingFlags.NonPublic | BindingFlags.Instance);
        static readonly FieldInfo ms_influencerSubmergedColliders = typeof(PhysicsInfluencer).GetField("_submergedColliders", BindingFlags.NonPublic | BindingFlags.Instance);

        public static bool IsInVR() => ((CheckVR.Instance != null) && CheckVR.Instance.hasVrDeviceLoaded);
        public static bool IsWorldSafe() => ((CVRWorld.Instance != null) && CVRWorld.Instance.allowFlying);
        public static float GetWorldMovementLimit()
        {
            float l_result = 1f;
            if(CVRWorld.Instance != null)
            {
                l_result = CVRWorld.Instance.baseMovementSpeed;
                l_result *= CVRWorld.Instance.sprintMultiplier;
                l_result *= CVRWorld.Instance.inAirMovementMultiplier;
                l_result *= CVRWorld.Instance.flyMultiplier;
            }
            return l_result;
        }

        public static bool IsGrounded(this MovementSystem p_instance) => (bool)ms_groundedRaw.GetValue(p_instance);
        public static Vector3 GetAppliedGravity(this MovementSystem p_instance) => (Vector3)ms_appliedGravity.GetValue(p_instance);
        public static void SetAppliedGravity(this MovementSystem p_instance, Vector3 p_vec) => ms_appliedGravity.SetValue(p_instance, p_vec);
        public static void ClearFluidVolumes(this MovementSystem p_instance) => (ms_touchingVolumes.GetValue(p_instance) as List<FluidVolume>)?.Clear();

        public static void CopyGlobal(this Transform p_source, Transform p_target)
        {
            p_target.position = p_source.position;
            p_target.rotation = p_source.rotation;
        }

        public static bool IsReady(this PhysicsInfluencer p_instance)
        {
            return ((ms_referencePoints.GetValue(p_instance) as List<Vector3>).Count > 0);
        }
        public static void ClearFluidVolumes(this PhysicsInfluencer p_instance)
        {
            (ms_influencerTouchingVolumes.GetValue(p_instance) as List<FluidVolume>)?.Clear();
            (ms_influencerSubmergedColliders.GetValue(p_instance) as Dictionary<FluidVolume, int>)?.Clear();
        }
    }
}
