using UnityEngine;

namespace ml_prm
{
    public class RagdollToggle : MonoBehaviour
    {
        [Tooltip("Whether or not is should use the isOn property to override the current Ragdoll State of the Avatar.")]
        [SerializeField] public bool shouldOverride;
        [Tooltip("Whether Ragdoll State is active or not on the Avatar. Requires shouldOverride to be true to work.")]
        [SerializeField] public bool isOn;
    }
}
