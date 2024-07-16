using System;
using System.Collections;
using NAK.AASEmulator.Runtime;
using UnityEditor;
using UnityEngine;
using UnityEngine.Networking;

namespace NAK.AASEmulator.Editor
{
    [CustomEditor(typeof(AASEmulatorCore))]
    public class AASEmulatorCoreEditor : UnityEditor.Editor
    {
        #region Private Variables

        private AASEmulatorCore _core;

        #endregion Private Variables

        #region Serialized Properties
        
        private SerializedProperty m_onlyInitializeOnSelect;
        private SerializedProperty m_emulateAASMenu;
        private SerializedProperty m_emulateShaderGlobals;
        private SerializedProperty m_defaultRuntimeController;
        
        private SerializedProperty m_emulateEyeBlink;
        private SerializedProperty m_emulateEyeLook;
        private SerializedProperty m_emulateFPRExclusions;
        
        private SerializedProperty m_emulateAdvancedTagging;
        private SerializedProperty m_tagLoudAudio;
        private SerializedProperty m_tagLongRangeAudio;
        private SerializedProperty m_tagScreenFx;
        private SerializedProperty m_tagFlashingColors;
        private SerializedProperty m_tagFlashingLights;
        private SerializedProperty m_tagViolence;
        private SerializedProperty m_tagGore;
        private SerializedProperty m_tagSuggestive;
        private SerializedProperty m_tagNudity;
        private SerializedProperty m_tagHorror;

        #endregion Serialized Properties

        #region Unity / GUI Methods

        private void OnEnable()
        {
            if (target == null) return;
            _core = (AASEmulatorCore)target;
            
            // version check state this session
            _hasCheckedForUpdates = SessionState.GetBool(CHECKED_VERSION_THIS_SESSION_KEY, false);
            _isLatestVersion = SessionState.GetBool(LATEST_VERSION_KEY, false);
            
            // serialized properties
            m_onlyInitializeOnSelect = serializedObject.FindProperty(nameof(AASEmulatorCore.OnlyInitializeOnSelect));
            m_emulateAASMenu = serializedObject.FindProperty(nameof(AASEmulatorCore.EmulateAASMenu));
            m_emulateShaderGlobals = serializedObject.FindProperty(nameof(AASEmulatorCore.EmulateShaderGlobals));
            m_defaultRuntimeController = serializedObject.FindProperty(nameof(AASEmulatorCore.defaultRuntimeController));
            
            m_emulateEyeBlink = serializedObject.FindProperty(nameof(AASEmulatorCore.EmulateEyeBlink));
            m_emulateEyeLook = serializedObject.FindProperty(nameof(AASEmulatorCore.EmulateEyeLook));
            m_emulateFPRExclusions = serializedObject.FindProperty(nameof(AASEmulatorCore.EmulateFPRExclusions));
            
            m_emulateAdvancedTagging = serializedObject.FindProperty(nameof(AASEmulatorCore.EmulateAdvancedTagging));
            m_tagLoudAudio = GetTaggingProperty(nameof(AASEmulatorCore.AdvancedTags.LoudAudio));
            m_tagLongRangeAudio = GetTaggingProperty(nameof(AASEmulatorCore.AdvancedTags.LongRangeAudio));
            m_tagScreenFx = GetTaggingProperty(nameof(AASEmulatorCore.AdvancedTags.ScreenFx));
            m_tagFlashingColors = GetTaggingProperty(nameof(AASEmulatorCore.AdvancedTags.FlashingColors));
            m_tagFlashingLights = GetTaggingProperty(nameof(AASEmulatorCore.AdvancedTags.FlashingLights));
            m_tagViolence = GetTaggingProperty(nameof(AASEmulatorCore.AdvancedTags.Violence));
            m_tagGore = GetTaggingProperty(nameof(AASEmulatorCore.AdvancedTags.Gore));
            m_tagSuggestive = GetTaggingProperty(nameof(AASEmulatorCore.AdvancedTags.Suggestive));
            m_tagNudity = GetTaggingProperty(nameof(AASEmulatorCore.AdvancedTags.Nudity));
            m_tagHorror = GetTaggingProperty(nameof(AASEmulatorCore.AdvancedTags.Horror));
            
            return;
            
            SerializedProperty GetTaggingProperty(string propName) 
                => serializedObject.FindProperty(nameof(AASEmulatorCore.advTagging) + "." + propName);
        }
        
        public override void OnInspectorGUI()
        {
            if (_core == null)
                return;
            
            serializedObject.Update();
            
            Draw_Emulator_Configuration();
            EditorGUILayout.Space();
            
            Draw_Emulator_AvatarSim();
            EditorGUILayout.Space();
            
            Draw_Emulator_AdvTagging();
            EditorGUILayout.Space();
            
            Draw_Links();
            EditorGUILayout.Space();
            
            Draw_VersionCheck();
            
            serializedObject.ApplyModifiedProperties();
        }

        #endregion Unity / GUI Methods
        
        #region Drawing Methods
        
        private void Draw_Emulator_Configuration()
        {
            EditorGUILayout.LabelField("Emulator / Configuration", EditorStyles.boldLabel);
            EditorGUILayout.PropertyField(m_onlyInitializeOnSelect);
            EditorGUILayout.PropertyField(m_emulateAASMenu);
            EditorGUILayout.PropertyField(m_emulateShaderGlobals);
            EditorGUILayout.PropertyField(m_defaultRuntimeController);
        }

        private void Draw_Emulator_AvatarSim()
        {
            EditorGUILayout.LabelField("Emulator / Avatar Simulation", EditorStyles.boldLabel);
            EditorGUILayout.PropertyField(m_emulateEyeBlink);
            EditorGUILayout.PropertyField(m_emulateEyeLook);
            EditorGUILayout.PropertyField(m_emulateFPRExclusions);
        }

        private void Draw_Emulator_AdvTagging()
        {
            EditorGUILayout.LabelField("Emulator / Advanced Tagging", EditorStyles.boldLabel);
            EditorGUILayout.PropertyField(m_emulateAdvancedTagging);
            
            if (Application.isPlaying)
                EditorGUILayout.HelpBox("Advanced Tagging settings cannot be dynamically changed while in play mode. They only apply on initial avatar load!", MessageType.Warning);
            
            EditorGUILayout.BeginHorizontal("box");
            EditorGUI.indentLevel++;
            
            EditorGUILayout.BeginVertical();
            
            EditorGUILayout.PropertyField(m_tagLoudAudio);
            EditorGUILayout.PropertyField(m_tagLongRangeAudio);
            EditorGUILayout.PropertyField(m_tagScreenFx);
            EditorGUILayout.PropertyField(m_tagFlashingColors);
            EditorGUILayout.PropertyField(m_tagFlashingLights);
            EditorGUILayout.PropertyField(m_tagViolence);
            EditorGUILayout.PropertyField(m_tagHorror);
            EditorGUILayout.PropertyField(m_tagSuggestive);
            
            EditorGUI.indentLevel--;
            EditorGUILayout.EndVertical();
            
            EditorGUILayout.BeginVertical();
            
            EditorGUILayout.HelpBox("The following tags are locked behind the Mature Content DLC and are disabled by default for new users.", MessageType.None);

            EditorGUI.indentLevel++;
            EditorGUILayout.PropertyField(m_tagGore);
            EditorGUILayout.PropertyField(m_tagNudity);
            EditorGUI.indentLevel--;
            
            EditorGUILayout.Space(8);
            EditorGUILayout.HelpBox("When an AdvTagging entry is found to be blocked, the target GameObject is destroyed and the Fallback is set active.", MessageType.None);
            
            if (GUILayout.Button("Reset to Default"))
            {
                m_tagLoudAudio.boolValue = true;
                m_tagLongRangeAudio.boolValue = true;
                m_tagScreenFx.boolValue = true;
                m_tagFlashingColors.boolValue = true;
                m_tagFlashingLights.boolValue = true;
                m_tagViolence.boolValue = true;
                m_tagSuggestive.boolValue = true;
                m_tagHorror.boolValue = true;
                m_tagGore.boolValue = false; // client blocks gore by default
                m_tagNudity.boolValue = false; // client blocks nudity by default
            }
            
            EditorGUILayout.EndVertical();
            
            EditorGUILayout.EndVertical();
        }
        
        private void Draw_Links()
        {
            EditorGUILayout.LabelField("Links / Community", EditorStyles.boldLabel);
            if (GUILayout.Button("Common Creator FAQ")) Application.OpenURL(AASEmulatorCore.AAS_EMULATOR_COMMON_FAQ_URL);
            if (GUILayout.Button("AAS Emulator GitHub")) Application.OpenURL(AASEmulatorCore.AAS_EMULATOR_GIT_URL);
            
            EditorGUILayout.Space();
            
            EditorGUILayout.LabelField("Links / Official", EditorStyles.boldLabel);
            if (GUILayout.Button("CCK Documentation")) Application.OpenURL(AASEmulatorCore.ABI_CCK_DOCUMENTATION_URL);
            if (GUILayout.Button("Alpha Blend Interactive Hub")) Application.OpenURL(AASEmulatorCore.ABI_HUB_URL);
        }

        private void Draw_VersionCheck()
        {
            EditorGUILayout.LabelField("Version Check", EditorStyles.boldLabel);
            EditorGUILayout.LabelField("Current Version: v" + AASEmulatorCore.AAS_EMULATOR_VERSION);

            if (_isAttemptingVersionCheck)
            {
                EditorGUILayout.HelpBox("Checking for updates...", MessageType.Info);
                return;
            }
            
            if (_hasCheckedForUpdates)
            {
                if (_isLatestVersion)
                {
                    EditorGUILayout.HelpBox("You are using the latest version of AAS Emulator.", MessageType.Info);
                }
                else
                {
                    EditorGUILayout.HelpBox("A new version of AAS Emulator is available.", MessageType.Warning);
                    if (GUILayout.Button("Open Latest Release Page")) Application.OpenURL(AASEmulatorCore.AAS_EMULATOR_GIT_URL + "/releases/latest");
                }
            }
            else if (GUILayout.Button("Check for Updates"))
            {
                CheckForUpdates();
            }
        }
        
        #endregion Drawing Methods
        
        #region Version Check Implementation
        
        private static Coroutine _versionCheckCoroutine;
        
        private static bool _isLatestVersion;
        private static bool _isAttemptingVersionCheck;
        private static bool _hasCheckedForUpdates;
        
        private const string CHECKED_VERSION_THIS_SESSION_KEY = nameof(AASEmulatorCore) + "_CheckedVersionThisSession";
        private const string LATEST_VERSION_KEY = nameof(AASEmulatorCore) + "_LatestVersion";

        [Serializable]
        private class GitHubRelease
        {
            public string tag_name;
        }

        private void CheckForUpdates()
        {
            // mono behaviour owns the coroutine (this works in-editor surprisingly)
            if (_versionCheckCoroutine != null) _core.StopCoroutine(_versionCheckCoroutine);
            _versionCheckCoroutine = _core.StartCoroutine(CheckForUpdatesCoroutine()); 
            _hasCheckedForUpdates = true;
        }
        
        private IEnumerator CheckForUpdatesCoroutine()
        {
            _isAttemptingVersionCheck = true;
            
            using UnityWebRequest webRequest = UnityWebRequest.Get(AASEmulatorCore.AAS_EMULATOR_GIT_API_RELEASE_URL);
            
            yield return webRequest.SendWebRequest();

            if (webRequest.result is UnityWebRequest.Result.ConnectionError or UnityWebRequest.Result.ProtocolError)
            {
                SimpleLogger.LogError("Error fetching latest version from GitHub: " + webRequest.error, _core.gameObject);
            }
            else
            {
                GitHubRelease latestVersionInfo = JsonUtility.FromJson<GitHubRelease>(webRequest.downloadHandler.text);
                var latestVersion = latestVersionInfo.tag_name.TrimStart('v'); // remove 'v' prefix
                
                bool isCurrentVersionValid = Version.TryParse(AASEmulatorCore.AAS_EMULATOR_VERSION, out Version currentVersion);
                bool isNewVersionValid = Version.TryParse(latestVersion, out Version newVersion);

                if (isCurrentVersionValid && isNewVersionValid)
                {
                    _isLatestVersion = newVersion <= currentVersion;
                    SimpleLogger.Log("Successfully fetched latest version from GitHub: " + latestVersion, _core.gameObject);
                }
                else
                {
                    SimpleLogger.LogError("Invalid version format. Current Version: " + AASEmulatorCore.AAS_EMULATOR_VERSION + ", New Version: " + latestVersion, _core.gameObject);
                }
            }
            
            _versionCheckCoroutine = null;
            _isAttemptingVersionCheck = false;
            SessionState.SetBool(CHECKED_VERSION_THIS_SESSION_KEY, true);
            SessionState.SetBool(LATEST_VERSION_KEY, _isLatestVersion);
        }

        #endregion Version Check Implementation
    }
}