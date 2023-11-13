using UnityEngine;

namespace NAK.AASEmulator.Runtime
{
    public static class SimpleLogger
    {
        // NOTE: Pass gameobject instead of component, as context is lost if component is removed.

        private const string projectName = nameof(AASEmulator);
        private const string messageColor = "orange";

        public static void Log(string message, Object context = null)
        {
            Debug.Log($"<color={messageColor}>[{projectName}]</color> : {message}", context);
        }

        public static void LogWarning(string message, Object context = null)
        {
            Debug.LogWarning($"<color={messageColor}>[{projectName}]</color> : {message}", context);
        }

        public static void LogError(string message, Object context = null)
        {
            Debug.LogError($"<color={messageColor}>[{projectName}]</color> : {message}", context);
        }
    }
}