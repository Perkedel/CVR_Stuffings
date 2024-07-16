#if CVR_CCK_EXISTS
using ABI.CCK.Components;
using UnityEngine;

namespace NAK.AASEmulator.Runtime.SubSystems
{
    public static class AdvancedTagging
    {
        #region Static Initialization

        [RuntimeInitializeOnLoadMethod]
        private static void Initialize()
        {
            AASEmulatorCore.runtimeInitializedDelegate -= OnRuntimeInitialized; // unsub from last play mode session
            AASEmulatorCore.runtimeInitializedDelegate += OnRuntimeInitialized;
            
            AASEmulatorCore.remoteInitializedDelegate -= OnRemoteInitialized; // unsub from last play mode session
            AASEmulatorCore.remoteInitializedDelegate += OnRemoteInitialized;
        }
        
        private static void OnRuntimeInitialized(AASEmulatorRuntime runtime)
            => CheckAdvancedTagging(runtime.m_avatar);
        
        private static void OnRemoteInitialized(AASEmulatorRemote remote)
            => CheckAdvancedTagging(remote.m_avatar);

        private static void CheckAdvancedTagging(CVRAvatar avatar)
        {
            if (AASEmulatorCore.Instance == null 
                || !AASEmulatorCore.Instance.EmulateAdvancedTagging)
                return;

            if (avatar == null || !avatar.enableAdvancedTagging)
            {
                if (avatar.advancedTaggingList.Count > 0)
                    SimpleLogger.LogError("Advanced Tagging entries found, but Advanced Tagging is disabled!", avatar.gameObject);
                return;
            }

            RunAdvancedTagging(avatar);
        }
        
        #endregion Static Initialization

        #region Private Methods

        private static void RunAdvancedTagging(CVRAvatar avatar)
        {
            var advTaggingList = avatar != null ? avatar.advancedTaggingList : null;
            if (advTaggingList == null || advTaggingList.Count == 0)
            {
                SimpleLogger.LogWarning("Advanced Tagging List is empty or null!");
                return;
            }
            
            SimpleLogger.Log($"Executing {advTaggingList.Count} Advanced Tagging entries for {avatar.name}.");

            foreach (CVRAvatarAdvancedTaggingEntry advTaggingEntry in advTaggingList)
                ExecuteAdvancedTagging(advTaggingEntry);
        }

        private static void ExecuteAdvancedTagging(CVRAvatarAdvancedTaggingEntry advTaggingEntry)
        {
            if (advTaggingEntry == null)
            {
                SimpleLogger.LogError("Unable to execute Advanced Tagging: Entry is missing!");
                return;
            }

            foreach (CVRAvatarAdvancedTaggingEntry.Tags tag in System.Enum.GetValues(typeof(CVRAvatarAdvancedTaggingEntry.Tags)))
            {
                // ReSharper disable once BitwiseOperatorOnEnumWithoutFlags
                if ((advTaggingEntry.tags & tag) == 0 || AASEmulatorCore.Instance.IsTagAllowed(tag)) 
                    continue;
                
                if (advTaggingEntry.gameObject != null) Object.DestroyImmediate(advTaggingEntry.gameObject);
                if (advTaggingEntry.fallbackGameObject != null) advTaggingEntry.fallbackGameObject.SetActive(true);
                break;
            }
        }
        
        #endregion Public Methods
    }
}
#endif
