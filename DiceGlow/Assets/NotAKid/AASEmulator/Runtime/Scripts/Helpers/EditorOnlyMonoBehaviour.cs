using UnityEngine;

namespace NAK.AASEmulator.Runtime
{
    [AddComponentMenu("")] // Hide from Inspector search
    public class EditorOnlyMonoBehaviour : MonoBehaviour
    {
        [HideInInspector]
        public bool isInitializedExternally;

        // Created via Inspector in Edit Mode
        internal virtual void Reset() => SetHideFlags();
        
        // Created via script in Play Mode
        internal virtual void Awake() => SetHideFlags();

        // Prevent from being saved to prefab or scene
        private void SetHideFlags()
        {
#if UNITY_EDITOR
            if ((hideFlags & HideFlags.DontSaveInEditor) != HideFlags.DontSaveInEditor)
                hideFlags |= HideFlags.DontSaveInEditor;
#endif
        }
    }
}