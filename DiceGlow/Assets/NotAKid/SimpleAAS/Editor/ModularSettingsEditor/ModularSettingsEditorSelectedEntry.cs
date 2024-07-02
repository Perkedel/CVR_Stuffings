#if UNITY_EDITOR && CVR_CCK_EXISTS
using System.Text.RegularExpressions;
using ABI.CCK.Scripts;
using UnityEditor;
using UnityEngine;

namespace NAK.SimpleAAS.Components
{
    public partial class NAK_ModularSettingsEditor
    {
        private void Draw_SelectedAdvancedSetting()
        {
            if (_selectedSettingIndex == -1 // no selected entry
                || _selectedSettingIndex >=
                _settingsList.serializedProperty.arraySize) // out of bounds after undo operation
            {
                EditorGUILayout.LabelField("No setting selected", EditorStyles.boldLabel);
                return; // no selected entry
            }

            // get selected setting (drawing used to set it, but then undo/redo would break it)
            m_SelectedSettingProp = _settingsList.serializedProperty.GetArrayElementAtIndex(_selectedSettingIndex);
            if (m_SelectedSettingProp == null)
            {
                EditorGUILayout.LabelField("Invalid setting selected", EditorStyles.boldLabel);
                return; // invalid selected entry
            }

            // CVRAdvancedSettingsEntry properties
            SerializedProperty settingName = m_SelectedSettingProp.FindPropertyRelative(nameof(CVRAdvancedSettingsEntry.name));
            SerializedProperty settingMachineName = m_SelectedSettingProp.FindPropertyRelative(nameof(CVRAdvancedSettingsEntry.machineName));
            SerializedProperty settingType = m_SelectedSettingProp.FindPropertyRelative(nameof(CVRAdvancedSettingsEntry.type));
            SerializedProperty unlinkNameFromMachineName = m_SelectedSettingProp.FindPropertyRelative(nameof(CVRAdvancedSettingsEntry.unlinkNameFromMachineName));

            EditorGUILayout.LabelField($"Settings for {settingName.stringValue}", EditorStyles.boldLabel);
            using (new EditorGUILayout.VerticalScope("box"))
            {
                // create rect to display GUI.Button for unlinkNameFromMachineName.boolValue
                Rect rect = EditorGUILayout.GetControlRect();
                
                // calculate label and field widths
                float labelWidth = EditorGUIUtility.labelWidth;
                float fieldWidth = (rect.width - labelWidth);
                float halfFieldWidth = fieldWidth / 2;

                // draw label for settingName field
                rect.width = labelWidth;
                EditorGUI.LabelField(rect, "Name");
                
                // adjust rect for the GUI.Button
                rect.x += labelWidth; // offset to button position
                rect.width = 20f; // button width
                if (GUI.Button(rect, unlinkNameFromMachineName.boolValue 
                            ? Styles.s_LinkIconContent : Styles.s_UnlinkIconContent, GUIStyle.none))
                    unlinkNameFromMachineName.boolValue = !unlinkNameFromMachineName.boolValue;

                // adjust rect for the settingName field
                rect.x += 20f;
                rect.width = fieldWidth - 20f; // settingName field width
                
                string oldSettingName = settingName.stringValue;
                settingName.stringValue = EditorGUI.TextField(rect, settingName.stringValue);
                
                // reset rect for the settingMachineName field
                rect = EditorGUILayout.GetControlRect();
                if (unlinkNameFromMachineName.boolValue)
                {
                    EditorGUI.PropertyField(rect, settingMachineName);
                }
                else
                {
                    GUI.enabled = false; // prettier to grey out instead of using text field
                    if (oldSettingName != settingName.stringValue)
                        settingMachineName.stringValue = Regex.Replace(settingName.stringValue, @"[^a-zA-Z0-9/\-_#]", "");
                    EditorGUI.PropertyField(rect, settingMachineName);
                    GUI.enabled = true;
                }

                SerializedProperty settingProp = GetAdvancedSettingProperty(m_SelectedSettingProp, settingType);
                SerializedProperty usedTypeProp = settingProp.FindPropertyRelative("usedType"); // part of the setting base, not entry _-_
                var oldSettingType = settingType.enumValueIndex;

                rect = EditorGUILayout.GetControlRect();

                rect.width = labelWidth; // label
                EditorGUI.LabelField(rect, "Setting Type");

                // two pixel padding on dropdown, offset so we align with text fields with gap in between
                // yes, this matters enough for me to bother with it

                rect.x += labelWidth + 1f;
                rect.width = halfFieldWidth - 2f; // setting type
                EditorGUI.PropertyField(rect, settingType, GUIContent.none);

                rect.x += halfFieldWidth + 2f; // used type
                EditorGUI.PropertyField(rect, usedTypeProp, GUIContent.none);
                
                // update settingType and settingProp so we don't have one draw error on change
                settingType = m_SelectedSettingProp.FindPropertyRelative(nameof(CVRAdvancedSettingsEntry.type));
                settingProp = GetAdvancedSettingProperty(m_SelectedSettingProp, settingType);
                usedTypeProp = settingProp.FindPropertyRelative("usedType");
                if (oldSettingType != settingType.enumValueIndex)
                    usedTypeProp.enumValueIndex = GetDefaultUsedTypeForSetting(settingType.enumValueIndex);
                
                // rest of gui uses EditorGUILayout
                EditorGUILayout.Space();
                
                SerializedProperty defaultValue = settingProp.FindPropertyRelative("defaultValue");
                
                switch (settingType.enumValueIndex)
                {
                    case (int)CVRAdvancedSettingsEntry.SettingsType.Slider:
                        EditorGUILayout.Slider(defaultValue, 0f, 1f);
                        break;
                    case (int)CVRAdvancedSettingsEntry.SettingsType.Dropdown:
                        Draw_DropdownDefault(defaultValue);
                        Draw_DropdownList();
                        break;
                    case (int)CVRAdvancedSettingsEntry.SettingsType.Joystick2D:
                    case (int)CVRAdvancedSettingsEntry.SettingsType.Joystick3D:
                        SerializedProperty min = settingProp.FindPropertyRelative("rangeMin");
                        SerializedProperty max = settingProp.FindPropertyRelative("rangeMax");
                        EditorGUILayout.PropertyField(defaultValue);
                        EditorGUILayout.PropertyField(min);
                        EditorGUILayout.PropertyField(max);
                        break;
                    default:
                        EditorGUILayout.PropertyField(defaultValue);
                        break;
                }
            }
        }
    }
}
#endif