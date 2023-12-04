using ABI.CCK.Components;
using ABI_RC.Core.Player;
using ABI_RC.Core.Savior;
using UnityEngine;

namespace ml_prm
{
    [DisallowMultipleComponent]
    class RagdollTrigger : MonoBehaviour
    {
        const string c_ragdollPointerType = "ragdoll";

        Collider m_collider = null;
        Collider m_lastColliderTrigger = null;
        ParticleSystem m_lastParticleSystemTrigger = null;
        bool m_triggered = false;

        void Start()
        {
            m_collider = this.GetComponent<Collider>();

            CVRParticlePointerManager.volumes.Add(new RagdollTriggerVolume(m_collider, this));
            CVRParticlePointerManager.UpdateParticleSystems();
        }

        void OnDestroy()
        {
            if(m_collider != null)
                CVRParticlePointerManager.RemoveTrigger(m_collider);
            m_collider = null;

            m_lastColliderTrigger = null;
            m_lastParticleSystemTrigger = null;
        }

        void Update()
        {
            if(!ReferenceEquals(m_lastColliderTrigger, null))
            {
                if(m_lastColliderTrigger != null)
                {
                    if(!m_collider.bounds.Intersects(m_lastColliderTrigger.bounds))
                        m_lastColliderTrigger = null;
                }
                else
                    m_lastColliderTrigger = null;
            }
            if(!ReferenceEquals(m_lastParticleSystemTrigger, null))
            {
                if(m_lastParticleSystemTrigger != null)
                {
                    if(m_lastParticleSystemTrigger.particleCount == 0)
                        m_lastParticleSystemTrigger = null;
                }
                else
                    m_lastParticleSystemTrigger = null;
            }
        }

        void OnTriggerEnter(Collider p_other)
        {
            CVRPointer l_pointer = p_other.GetComponent<CVRPointer>();
            if((l_pointer != null) && (l_pointer.type == c_ragdollPointerType) && !IsIgnored(l_pointer.transform) && (m_lastColliderTrigger != p_other))
            {
                m_lastColliderTrigger = p_other;
                m_triggered = true;
            }
        }

        void OnTriggerExit(Collider p_other)
        {
            if(m_lastColliderTrigger == p_other)
                m_lastColliderTrigger = null;
        }

        public void OnPointerParticleEnter(CVRPointer p_pointer)
        {
            if(!this.gameObject.activeInHierarchy)
                return;

            if((p_pointer.type == c_ragdollPointerType) && !IsIgnored(p_pointer.transform) && (m_lastParticleSystemTrigger != p_pointer.particleSystem))
            {
                m_lastParticleSystemTrigger = p_pointer.particleSystem;
                m_triggered = true;
            }
        }

        public void OnPointerParticleExit(CVRPointer p_pointer)
        {
            // This seems to be very unreliable, and it's causing weird behavior
            // if (!gameObject.activeInHierarchy) return;
            // if(m_lastParticleSystemTrigger == p_pointer.particleSystem)
            //     m_lastParticleSystemTrigger = null;
        }

        public bool GetStateWithReset()
        {
            bool l_state = m_triggered;
            m_triggered = false;
            return l_state;
        }

        static bool IsIgnored(Transform p_transform)
        {
            return (Settings.IgnoreLocal && (p_transform.root == PlayerSetup.Instance.transform));
        }
    }
}
