using ABI_RC.Core.Savior;
using ABI.CCK.Components;
using UnityEngine;

namespace ml_prm
{
    class RagdollTriggerVolume : CVRTriggerVolume
    {
        readonly RagdollTrigger m_trigger = null;

        public Collider collider { get; set; }

        internal RagdollTriggerVolume(Collider p_collider, RagdollTrigger p_trigger)
        {
            collider = p_collider;
            m_trigger = p_trigger;
        }

        public void TriggerEnter(CVRPointer pointer) => m_trigger.OnPointerParticleEnter(pointer);
        public void TriggerExit(CVRPointer pointer) => m_trigger.OnPointerParticleExit(pointer);
    }
}
