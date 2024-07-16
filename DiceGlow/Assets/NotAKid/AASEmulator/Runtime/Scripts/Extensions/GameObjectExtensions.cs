using UnityEngine;

namespace NAK.AASEmulator.Runtime.Extensions
{
    public static class GameObjectExtensions
    {
        public static void SetLayersOfChildren(this GameObject obj, int newLayer)
        {
            if (obj == null) return;
            foreach (Transform component in obj.GetComponentsInChildren<Transform>(true))
                component.gameObject.layer = newLayer;
        }
        
        public static T AddComponentIfMissing<T>(this GameObject go) where T : Component
        {
            return go.GetComponent<T>() ?? go.AddComponent<T>();
        }
    }
}