#if UNITY_EDITOR && CVR_CCK_EXISTS
using System;
using System.Linq;
using System.Reflection;
using ABI.CCK.Scripts;
using UnityEditor;
using UnityEditorInternal;
using UnityEngine;
using static NAKModularSettings;

namespace NAK.SimpleAAS
{
    [CustomEditor(typeof(NAKModularSettings))]
    public class NAKModularSettingsEditor : Editor
    {
        public ReorderableList l_Settings;
        public NAKModularSettings targetScript;

        public override void OnInspectorGUI()
        {
            targetScript = (NAKModularSettings)target;

            serializedObject?.Update();

            if (l_Settings == null) l_Settings = GetSettingsList();
            l_Settings.DoLayoutList();

            serializedObject?.ApplyModifiedProperties();

            if (GUI.changed) EditorUtility.SetDirty(targetScript);
        }

        public ReorderableList GetSettingsList()
        {
            ReorderableList list = new ReorderableList(serializedObject,
                serializedObject?.FindProperty("settings"),
                true, true, true, true);

            list.drawElementCallback = OnDrawAASElement;
            list.elementHeightCallback = OnHeightAASElement;

            list.drawHeaderCallback = rect => { EditorGUI.LabelField(rect, "Advanced Avatar Settings"); };
            return list;
        }

        private void OnDrawAASElement(Rect rect, int index, bool isActive, bool isFocused)
        {
            if (index >= targetScript.settings.Count) return;
            CVRAdvancedSettingsEntry entity = targetScript.settings[index];
            rect.y += 2;
            rect.x += 12;
            rect.width -= 12;

            //name foldout
            Rect foldoutRect = new Rect(rect.x, rect.y, 100, EditorGUIUtility.singleLineHeight);
            entity.setting.isCollapsed = EditorGUI.Foldout(foldoutRect, entity.setting.isCollapsed, "Menu Name:", true);
            //setting name field (menu name)
            Rect name_textFieldRect = new Rect(foldoutRect.x + foldoutRect.width, rect.y, rect.width - foldoutRect.width,
                EditorGUIUtility.singleLineHeight);
            entity.name = EditorGUI.TextField(name_textFieldRect, entity.name);

            if (!entity.setting.isCollapsed) return;

            rect.y += EditorGUIUtility.singleLineHeight * 1.25f;

            //setting machinename field (animator name)
            Rect machineName_labelFieldRect = new Rect(foldoutRect.x, rect.y, rect.width, EditorGUIUtility.singleLineHeight);
            EditorGUI.LabelField(machineName_labelFieldRect, "Animator Name:");
            Rect machineName_textFieldRect = new Rect(foldoutRect.x + foldoutRect.width, rect.y,
                rect.width - foldoutRect.width, EditorGUIUtility.singleLineHeight);
            entity.machineName = EditorGUI.TextField(machineName_textFieldRect, entity.machineName);

            rect.y += EditorGUIUtility.singleLineHeight * 1.25f;

            EditorGUILayout.BeginHorizontal();

            var leftOffset = foldoutRect.x + foldoutRect.width;

            //setting type (input type)
            Rect type_labelFieldRect = new Rect(foldoutRect.x, rect.y, rect.width / 3, EditorGUIUtility.singleLineHeight);
            EditorGUI.LabelField(type_labelFieldRect, "Setting Type:");
            Rect type_enumPopupRect = new Rect(leftOffset, rect.y, (rect.width - leftOffset) / 2,
                EditorGUIUtility.singleLineHeight);
            CVRAdvancedSettingsEntry.SettingsType type =
                (CVRAdvancedSettingsEntry.SettingsType)EditorGUI.EnumPopup(type_enumPopupRect,
                    (SimpleAAS_SettingsType)entity.type);
            if (type != entity.type)
            {
                entity.type = type;
                switch (type)
                {
                    case CVRAdvancedSettingsEntry.SettingsType.GameObjectToggle:
                        entity.setting = new CVRAdvancesAvatarSettingGameObjectToggle();
                        entity.setting.usedType =
                            GetDefaultType(CVRAdvancedSettingsEntry.SettingsType.GameObjectToggle);
                        break;
                    case CVRAdvancedSettingsEntry.SettingsType.GameObjectDropdown:
                        entity.setting = new CVRAdvancesAvatarSettingGameObjectDropdown();
                        entity.setting.usedType =
                            GetDefaultType(CVRAdvancedSettingsEntry.SettingsType.GameObjectDropdown);
                        break;
                    case CVRAdvancedSettingsEntry.SettingsType.MaterialColor:
                        entity.setting = new CVRAdvancedAvatarSettingMaterialColor();
                        entity.setting.usedType = GetDefaultType(CVRAdvancedSettingsEntry.SettingsType.MaterialColor);
                        break;
                    case CVRAdvancedSettingsEntry.SettingsType.Slider:
                        entity.setting = new CVRAdvancesAvatarSettingSlider();
                        entity.setting.usedType = GetDefaultType(CVRAdvancedSettingsEntry.SettingsType.Slider);
                        break;
                    case CVRAdvancedSettingsEntry.SettingsType.Joystick2D:
                        entity.setting = new CVRAdvancesAvatarSettingJoystick2D();
                        entity.setting.usedType = GetDefaultType(CVRAdvancedSettingsEntry.SettingsType.Joystick2D);
                        break;
                    case CVRAdvancedSettingsEntry.SettingsType.Joystick3D:
                        entity.setting = new CVRAdvancesAvatarSettingJoystick3D();
                        entity.setting.usedType = GetDefaultType(CVRAdvancedSettingsEntry.SettingsType.Joystick3D);
                        break;
                    case CVRAdvancedSettingsEntry.SettingsType.InputSingle:
                        entity.setting = new CVRAdvancesAvatarSettingInputSingle();
                        entity.setting.usedType = GetDefaultType(CVRAdvancedSettingsEntry.SettingsType.InputSingle);
                        break;
                    case CVRAdvancedSettingsEntry.SettingsType.InputVector2:
                        entity.setting = new CVRAdvancesAvatarSettingInputVector2();
                        entity.setting.usedType = GetDefaultType(CVRAdvancedSettingsEntry.SettingsType.InputVector2);
                        break;
                    case CVRAdvancedSettingsEntry.SettingsType.InputVector3:
                        entity.setting = new CVRAdvancesAvatarSettingInputVector3();
                        entity.setting.usedType = GetDefaultType(CVRAdvancedSettingsEntry.SettingsType.InputVector3);
                        break;
                }
            }

            // Get the supported types for the current setting type
            var supportedTypes = GetSupportedTypes(entity.type);

            // Create the enum popup rect
            Rect usedType_enumPopupRect = new Rect((rect.width + leftOffset) / 2, rect.y, (rect.width - leftOffset) / 2,
                EditorGUIUtility.singleLineHeight);

            // Filter the CVRAdvancesAvatarSettingBase.ParameterType enum values to only show the supported types
            var filteredEnum = Enum.GetValues(typeof(CVRAdvancesAvatarSettingBase.ParameterType))
                .Cast<SimpleAAS_ParameterType>()
                .Where(x => supportedTypes.Contains((CVRAdvancesAvatarSettingBase.ParameterType)x))
                .ToList();

            // Error-proofing: Check if the stored usedType value is valid and within the supported types
            CVRAdvancesAvatarSettingBase.ParameterType currentParameterType;
            if (Enum.IsDefined(typeof(CVRAdvancesAvatarSettingBase.ParameterType), entity.setting.usedType) &&
                supportedTypes.Contains(entity.setting.usedType))
            {
                currentParameterType = entity.setting.usedType;
            }
            else
            {
                // If the stored usedType value is not valid, use the first supported type as a default
                currentParameterType = supportedTypes[0];
                entity.setting.usedType = currentParameterType;
            }

            // Show the filtered enum popup
            CVRAdvancesAvatarSettingBase.ParameterType selectedParameterType =
                (CVRAdvancesAvatarSettingBase.ParameterType)filteredEnum[
                    EditorGUI.Popup(usedType_enumPopupRect,
                        filteredEnum.IndexOf((SimpleAAS_ParameterType)currentParameterType),
                        filteredEnum.Select(x => x.ToString()).ToArray())];

            // Update the setting if the enum value has changed
            if (selectedParameterType != currentParameterType) entity.setting.usedType = selectedParameterType;

            EditorGUILayout.EndHorizontal();

            //now we show the settings
            switch (type)
            {
                case CVRAdvancedSettingsEntry.SettingsType.GameObjectToggle:
                    CVRAdvancesAvatarSettingGameObjectToggle setting_toggle =
                        (CVRAdvancesAvatarSettingGameObjectToggle)entity.setting;
                    DrawToggleField(foldoutRect, ref rect, ref setting_toggle.defaultValue, "Default Value:");
                    break;
                case CVRAdvancedSettingsEntry.SettingsType.GameObjectDropdown:
                    CVRAdvancesAvatarSettingGameObjectDropdown setting_dropdown =
                        (CVRAdvancesAvatarSettingGameObjectDropdown)entity.setting;
                    DrawDropdownField(foldoutRect, ref rect, ref setting_dropdown.defaultValue, "Default Value:",
                        setting_dropdown.getOptionsList());
                    //draw modified reorderable list
                    rect.y += EditorGUIUtility.singleLineHeight * 1.25f;
                    ReorderableList options = setting_dropdown.GetReorderableList(null);
                    Initialize_Modified_Dropdown_List(setting_dropdown, options);
                    options.DoList(new Rect(rect.x, rect.y, rect.width, 20f));
                    break;
                case CVRAdvancedSettingsEntry.SettingsType.MaterialColor:
                    CVRAdvancedAvatarSettingMaterialColor setting_color =
                        (CVRAdvancedAvatarSettingMaterialColor)entity.setting;
                    DrawColorField(foldoutRect, ref rect, ref setting_color.defaultValue, "Default Value:");
                    var helpText_Color =
                        $"Setting Type will use three animator parameters with added suffixes:\n\n{entity.machineName}-r\n{entity.machineName}-g\n{entity.machineName}-b";
                    DrawHelpBox(foldoutRect, ref rect, ref helpText_Color, 4);
                    break;
                case CVRAdvancedSettingsEntry.SettingsType.Slider:
                    CVRAdvancesAvatarSettingSlider setting_slider = (CVRAdvancesAvatarSettingSlider)entity.setting;
                    DrawSliderField(foldoutRect, ref rect, ref setting_slider.defaultValue, 0f, 1f, "Default Value:");
                    break;
                case CVRAdvancedSettingsEntry.SettingsType.Joystick2D:
                    CVRAdvancesAvatarSettingJoystick2D setting_inputjoystick2d =
                        (CVRAdvancesAvatarSettingJoystick2D)entity.setting;
                    DrawVector2Field(foldoutRect, ref rect, ref setting_inputjoystick2d.defaultValue, "Default Value:");
                    DrawVector2Field(foldoutRect, ref rect, ref setting_inputjoystick2d.rangeMin, "Range Min:");
                    DrawVector2Field(foldoutRect, ref rect, ref setting_inputjoystick2d.rangeMax, "Range Max:");
                    var helpText_Joy2D =
                        $"Setting Type will use two animator parameters with added suffixes:\n\n{entity.machineName}-x\n{entity.machineName}-y";
                    DrawHelpBox(foldoutRect, ref rect, ref helpText_Joy2D, 3);
                    break;
                case CVRAdvancedSettingsEntry.SettingsType.Joystick3D:
                    CVRAdvancesAvatarSettingJoystick3D setting_inputjoystick3d =
                        (CVRAdvancesAvatarSettingJoystick3D)entity.setting;
                    DrawVector3Field(foldoutRect, ref rect, ref setting_inputjoystick3d.defaultValue, "Default Value:");
                    DrawVector3Field(foldoutRect, ref rect, ref setting_inputjoystick3d.rangeMin, "Range Min:");
                    DrawVector3Field(foldoutRect, ref rect, ref setting_inputjoystick3d.rangeMax, "Range Max:");
                    var helpText_Joy3D =
                        $"Setting Type will use two animator parameters with added suffixes:\n\n{entity.machineName}-x\n{entity.machineName}-y";
                    DrawHelpBox(foldoutRect, ref rect, ref helpText_Joy3D, 3);
                    break;
                case CVRAdvancedSettingsEntry.SettingsType.InputSingle:
                    CVRAdvancesAvatarSettingInputSingle setting_inputsingle =
                        (CVRAdvancesAvatarSettingInputSingle)entity.setting;
                    DrawFloatField(foldoutRect, ref rect, ref setting_inputsingle.defaultValue, "Default Value:");
                    break;
                case CVRAdvancedSettingsEntry.SettingsType.InputVector2:
                    CVRAdvancesAvatarSettingInputVector2 setting_inputvector2 =
                        (CVRAdvancesAvatarSettingInputVector2)entity.setting;
                    DrawVector2Field(foldoutRect, ref rect, ref setting_inputvector2.defaultValue, "Default Value:");
                    var helpText_Input2 =
                        $"Setting Type will use two animator parameters with added suffixes:\n\n{entity.machineName}-x\n{entity.machineName}-y";
                    DrawHelpBox(foldoutRect, ref rect, ref helpText_Input2, 3);
                    break;
                case CVRAdvancedSettingsEntry.SettingsType.InputVector3:
                    CVRAdvancesAvatarSettingInputVector3 setting_inputvector3 =
                        (CVRAdvancesAvatarSettingInputVector3)entity.setting;
                    DrawVector3Field(foldoutRect, ref rect, ref setting_inputvector3.defaultValue, "Default Value:");
                    var helpText_Input3 =
                        $"Setting Type will use three animator parameters with added suffixes:\n\n{entity.machineName}-x\n{entity.machineName}-y\n{entity.machineName}-z";
                    DrawHelpBox(foldoutRect, ref rect, ref helpText_Input3, 4);
                    break;
            }
        }

        private void DrawToggleField(Rect foldoutRect, ref Rect rect, ref bool value, string label)
        {
            rect.y += EditorGUIUtility.singleLineHeight * 1.25f;
            Rect labelRect = new Rect(foldoutRect.x, rect.y, foldoutRect.width * 0.4f, EditorGUIUtility.singleLineHeight);
            var toggleX = labelRect.x + labelRect.width + EditorStyles.label.CalcSize(new GUIContent(label)).x - 20f;
            Rect toggleRect = new Rect(toggleX, rect.y, foldoutRect.width * 0.6f, EditorGUIUtility.singleLineHeight);
            EditorGUI.PrefixLabel(labelRect, new GUIContent(label));
            value = EditorGUI.Toggle(toggleRect, value);
        }

        private void DrawDropdownField(Rect foldoutRect, ref Rect rect, ref int value, string label, string[] options)
        {
            rect.y += EditorGUIUtility.singleLineHeight * 1.25f;
            Rect fieldRect = new Rect(foldoutRect.x, rect.y, rect.width, EditorGUIUtility.singleLineHeight);
            value = EditorGUI.Popup(fieldRect, label, value, options);
        }

        private void DrawColorField(Rect foldoutRect, ref Rect rect, ref Color value, string label)
        {
            rect.y += EditorGUIUtility.singleLineHeight * 1.25f;
            Rect fieldRect = new Rect(foldoutRect.x, rect.y, rect.width, EditorGUIUtility.singleLineHeight);
            value = EditorGUI.ColorField(fieldRect, label, value);
        }

        private void DrawFloatField(Rect foldoutRect, ref Rect rect, ref float value, string label)
        {
            rect.y += EditorGUIUtility.singleLineHeight * 1.25f;
            Rect fieldRect = new Rect(foldoutRect.x, rect.y, rect.width, EditorGUIUtility.singleLineHeight);
            value = EditorGUI.FloatField(fieldRect, label, value);
        }

        private void DrawSliderField(Rect foldoutRect, ref Rect rect, ref float value, float min, float max,
            string label)
        {
            rect.y += EditorGUIUtility.singleLineHeight * 1.25f;
            Rect fieldRect = new Rect(foldoutRect.x, rect.y, rect.width, EditorGUIUtility.singleLineHeight);
            value = EditorGUI.Slider(fieldRect, label, value, min, max);
        }

        private void DrawVector2Field(Rect foldoutRect, ref Rect rect, ref Vector2 value, string label)
        {
            rect.y += EditorGUIUtility.singleLineHeight * 1.25f;
            Rect fieldRect = new Rect(foldoutRect.x, rect.y, rect.width, EditorGUIUtility.singleLineHeight);
            value = EditorGUI.Vector2Field(fieldRect, label, value);
        }

        private void DrawVector3Field(Rect foldoutRect, ref Rect rect, ref Vector3 value, string label)
        {
            rect.y += EditorGUIUtility.singleLineHeight * 1.25f;
            Rect fieldRect = new Rect(foldoutRect.x, rect.y, rect.width, EditorGUIUtility.singleLineHeight);
            value = EditorGUI.Vector3Field(fieldRect, label, value);
        }

        private void DrawHelpBox(Rect foldoutRect, ref Rect rect, ref string helpText, float lines)
        {
            rect.y += EditorGUIUtility.singleLineHeight * 1.25f;
            Rect helpBoxRect = new Rect(foldoutRect.x, rect.y, rect.width, EditorGUIUtility.singleLineHeight * lines);
            EditorGUI.HelpBox(helpBoxRect, helpText, MessageType.Info);
        }

        private float OnHeightAASElement(int index)
        {
            if (index >= targetScript.settings.Count) return EditorGUIUtility.singleLineHeight * 1f;
            CVRAdvancedSettingsEntry entity = targetScript.settings[index];

            // When collapsed only return one line height
            if (!entity.setting.isCollapsed) return EditorGUIUtility.singleLineHeight * 1.25f;

            switch (entity.type)
            {
                //just one line needed
                case CVRAdvancedSettingsEntry.SettingsType.GameObjectToggle:
                case CVRAdvancedSettingsEntry.SettingsType.InputSingle:
                case CVRAdvancedSettingsEntry.SettingsType.Slider:
                {
                    return EditorGUIUtility.singleLineHeight * 5f;
                }
                //has fat helpbox
                case CVRAdvancedSettingsEntry.SettingsType.InputVector2:
                {
                    return EditorGUIUtility.singleLineHeight * 9f;
                }
                case CVRAdvancedSettingsEntry.SettingsType.InputVector3:
                case CVRAdvancedSettingsEntry.SettingsType.MaterialColor:
                {
                    return EditorGUIUtility.singleLineHeight * 10f;
                }
                //has fatter vector fields
                case CVRAdvancedSettingsEntry.SettingsType.Joystick2D:
                case CVRAdvancedSettingsEntry.SettingsType.Joystick3D:
                {
                    return EditorGUIUtility.singleLineHeight * 11.5f;
                }
                //special lil dumbfuck
                case CVRAdvancedSettingsEntry.SettingsType.GameObjectDropdown:
                {
                    CVRAdvancesAvatarSettingGameObjectDropdown setting_dropdown =
                        (CVRAdvancesAvatarSettingGameObjectDropdown)entity.setting;
                    var height = EditorGUIUtility.singleLineHeight * 1.25f * 7f;
                    var lineHeight =
                        Math.Max(EditorGUIUtility.singleLineHeight * 1.25f * setting_dropdown.options.Count, 20f);
                    return height + lineHeight;
                }
                default:
                {
                    return EditorGUIUtility.singleLineHeight * 5f;
                }
            }
        }

        // i know this is a really fucking weird way of doing this lol

        private void Initialize_Modified_Dropdown_List(CVRAdvancesAvatarSettingGameObjectDropdown setting_dropdown,
            ReorderableList dropdown_list)
        {
            // Get the MethodInfo object of the method that the onChangedCallback delegate refers to
            MethodInfo onChangedCallbackMethod = dropdown_list.onChangedCallback.Method;
            // Get the MethodInfo object of the OnChanged_DropdownList method
            MethodInfo onChangedDropdownListMethod =
                typeof(NAKModularSettingsEditor).GetMethod("OnChanged_DropdownList",
                    BindingFlags.NonPublic | BindingFlags.Instance);
            // Compare the MethodInfo objects
            if (onChangedCallbackMethod != onChangedDropdownListMethod)
            {
                dropdown_list.onChangedCallback = OnChanged_DropdownList;
                dropdown_list.elementHeightCallback = index => { return EditorGUIUtility.singleLineHeight * 1.25f; };
                dropdown_list.drawHeaderCallback = rect => { EditorGUI.LabelField(rect, "Dropdown Options"); };
                dropdown_list.onAddCallback = list =>
                {
                    setting_dropdown.options.Add(new CVRAdvancedSettingsDropDownEntry());
                };
                dropdown_list.drawElementCallback = (rect, index, isactive, isfocused) =>
                {
                    if (index > setting_dropdown.options.Count) return;
                    CVRAdvancedSettingsDropDownEntry entity = setting_dropdown.options[index];
                    //dropdown entry name label (this is all we need)
                    Rect dropdown_element_labelFieldRect = new Rect(rect.x, rect.y, 100, EditorGUIUtility.singleLineHeight);
                    EditorGUI.LabelField(dropdown_element_labelFieldRect, $"Option {index}:");
                    //dropdown entry name field
                    Rect dropdown_element_textFieldRect =
                        new Rect(dropdown_element_labelFieldRect.x + dropdown_element_labelFieldRect.width, rect.y,
                            rect.width - dropdown_element_labelFieldRect.width, EditorGUIUtility.singleLineHeight);
                    entity.name = EditorGUI.TextField(dropdown_element_textFieldRect, entity.name);
                };
            }
        }

        private void OnChanged_DropdownList(ReorderableList list)
        {
            EditorUtility.SetDirty(targetScript);
        }
    }
}
#endif