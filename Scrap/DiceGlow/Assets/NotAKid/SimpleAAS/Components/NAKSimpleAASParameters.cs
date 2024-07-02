#if UNITY_EDITOR && CVR_CCK_EXISTS
using ABI.CCK.Components;
using UnityEngine;
using UnityEngine.Scripting.APIUpdating;

namespace NAK.SimpleAAS.Components
{
    [MovedFrom("NAK.SimpleAAS")]
    [HelpURL("https://github.com/NotAKidOnSteam/SimpleAAS")]
    public class NAKSimpleAASParameters : MonoBehaviour
    {
        #region Unity Methods

        private void Reset()
        {
            if (avatar == null)
                avatar = GetComponentInParent<CVRAvatar>();
        }

        #endregion

        #region Variables

        public CVRAvatar avatar;
        public NAKModularSettings[] simpleAASParameters;

        #endregion
    }
}
#endif