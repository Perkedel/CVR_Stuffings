#if UNITY_EDITOR && CVR_CCK_EXISTS
using ABI.CCK.Scripts;
using UnityEditor;
using UnityEngine;

namespace NAK.SimpleAAS.Components
{
    [CustomEditor(typeof(NAKModularSettings))]
    public partial class NAK_ModularSettingsEditor : Editor
    {
        #region EditorGUI Styles
        
        private static class Styles
        {
            public static readonly GUIContent s_UnlinkIconContent = new(EditorGUIUtility.Load("d_Unlinked") as Texture2D, "Unlink Name from Machine");
            public static readonly GUIContent s_LinkIconContent = new(EditorGUIUtility.Load("d_Linked") as Texture2D, "Link Name to Machine");
            
            public static readonly GUIStyle s_RightAlignedItalicLabel = new(EditorStyles.label)
            {
                fontStyle = FontStyle.Italic,
                alignment = TextAnchor.MiddleRight
            };
        }

        #endregion EditorGUI Styles
        
        #region Private Variables

        private NAKModularSettings _settings;

        #endregion Private Variables
        
        #region Serialized Properties

        private SerializedProperty m_SettingsProp;
        
        #endregion Serialized Properties

        #region Unity Events

        private void OnEnable()
        {
            if (target == null) return;
            _settings = (NAKModularSettings)target;
            
            m_SettingsProp = serializedObject.FindProperty(nameof(NAKModularSettings.settings));
            
            Init_AdvancedSettingsList();
        }
        
        public override void OnInspectorGUI()
        {
            if (_settings == null)
                return;

            serializedObject.Update();
            
            Draw_AdvancedSettingsEntries();
            Draw_SelectedAdvancedSetting();
            
            serializedObject.ApplyModifiedProperties();
        }

        #endregion Unity Events
        
        #region Private Methods
        
        // get the property for the specific setting type
        private static SerializedProperty GetAdvancedSettingProperty(SerializedProperty settingProp, SerializedProperty settingType)
        {
            return settingType.enumValueIndex switch
            {
                (int)CVRAdvancedSettingsEntry.SettingsType.Color => settingProp.FindPropertyRelative(
                    "materialColorSettings"),
                (int)CVRAdvancedSettingsEntry.SettingsType.Dropdown => settingProp.FindPropertyRelative(
                    "dropDownSettings"),
                (int)CVRAdvancedSettingsEntry.SettingsType.Slider => settingProp.FindPropertyRelative(
                    "sliderSettings"),
                (int)CVRAdvancedSettingsEntry.SettingsType.Joystick2D => settingProp.FindPropertyRelative(
                    "joystick2DSetting"),
                (int)CVRAdvancedSettingsEntry.SettingsType.Joystick3D => settingProp.FindPropertyRelative(
                    "joystick3DSetting"),
                (int)CVRAdvancedSettingsEntry.SettingsType.InputSingle => settingProp.FindPropertyRelative(
                    "inputSingleSettings"),
                (int)CVRAdvancedSettingsEntry.SettingsType.InputVector2 => settingProp.FindPropertyRelative(
                    "inputVector2Settings"),
                (int)CVRAdvancedSettingsEntry.SettingsType.InputVector3 => settingProp.FindPropertyRelative(
                    "inputVector3Settings"),
                _ => settingProp.FindPropertyRelative("toggleSettings")
            };
        }
        
        private static int GetDefaultUsedTypeForSetting(int settingType)
        {
            return settingType switch
            {
                // -1 of the enum value cause it starts at 1 -_-
                0 => 2, // toggle -> bool
                1 => 1, // dropdown -> int
                _ => 0 // color, slider, joystick, input -> float
            };
        }
        
        #endregion Private Methods
    }
}
#endif