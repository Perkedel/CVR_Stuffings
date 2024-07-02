#if UNITY_EDITOR && CVR_CCK_EXISTS
using System.Collections.Generic;
using System.Text.RegularExpressions;
using ABI.CCK.Scripts;
using ABI.CCK.Scripts.Editor;
using NAK.SimpleAAS.Extensions;
using UnityEditor;
using UnityEditorInternal;
using UnityEngine;
using static NAK.SimpleAAS.Extensions.SharedGUI;

namespace NAK.SimpleAAS.Components
{
    public partial class NAK_ModularSettingsEditor
    {
        #region Private Variables
        
        private SerializedProperty m_SelectedSettingProp;

        private ReorderableList _settingsList;
        private int _selectedSettingIndex = -1; // used to track selected setting for editing
        private int _lastSelectedSettingIndex = -1; // used to detect double click to deselect

        #endregion Private Variables
        
        private void Init_AdvancedSettingsList()
        {
            _settingsList = new ReorderableList(serializedObject, m_SettingsProp, true, true, true, true)
                {
                    drawHeaderCallback = DrawAdvancedSettingsHeader,
                    drawElementCallback = DrawAdvancedSettingsElement,
                    onAddCallback = AddAdvancedSettingsElement,
                    onRemoveCallback = RemoveAdvancedSettingsElement,
                    onMouseUpCallback = MouseUpAdvancedSettingsElement,
                    onSelectCallback = SelectAdvancedSettingElement,
                    list = _settings.settings
                };
        }
        
        private void Draw_AdvancedSettingsEntries()
        {
            _settingsList.DoLayoutList();
        }

        #region ReorderableList Callbacks
        
        private void DrawAdvancedSettingsHeader(Rect rect)
        {
            Rect labelRect = new(rect.x, rect.y, rect.width - 35, EditorGUIUtility.singleLineHeight);
            GUI.Label(labelRect, $"Advanced Settings ({_settingsList.count})");
            EditorGUIExtensions.UtilityMenu(rect, _settingsList, m_SettingsProp);
        }

        private void DrawAdvancedSettingsElement(Rect rect, int index, bool isActive, bool isFocused)
        {
            if (index >= _settingsList.serializedProperty.arraySize)
                return;
            
            // alternate row background (if not focused)
            if (!isFocused && index % 2 == 0) DrawAlternateBackground(rect);
            
            rect.y += 2; // offset for shit padding unity adds to top/bottom
            rect.height = EditorGUIUtility.singleLineHeight;

            SerializedProperty element = _settingsList.serializedProperty.GetArrayElementAtIndex(index);
            SerializedProperty nameProp = element.FindPropertyRelative(nameof(CVRAdvancedSettingsEntry.name));
            SerializedProperty machineNameProp = element.FindPropertyRelative(nameof(CVRAdvancedSettingsEntry.machineName));
            SerializedProperty typeProp = element.FindPropertyRelative(nameof(CVRAdvancedSettingsEntry.type));

            SerializedProperty settingProp = GetAdvancedSettingProperty(element, typeProp);
            SerializedProperty usedTypeProp = settingProp.FindPropertyRelative("usedType"); // part of the setting base, not entry _-_
            
            // fix the usedTypeProp if invalid (enum starts at 1, but unity defaults it to 0)
            if (usedTypeProp.enumValueIndex == -1)
                usedTypeProp.enumValueIndex = GetDefaultUsedTypeForSetting(typeProp.enumValueIndex);
            
            // calc field sizes
            float labelWidth = EditorGUIUtility.labelWidth;
            float fieldWidth = (rect.width - labelWidth) / 2;

            // shrink label rect so type tooltip doesnt fight
            rect.width = labelWidth;

            // draw setting name on left (i want to display local/synced state, but i dont know how to make it look good)
            EditorGUI.LabelField(rect, new GUIContent(nameProp.stringValue, machineNameProp.stringValue));
            
            // align rect to right
            rect.x += labelWidth;
            rect.width = fieldWidth * 2;

            // becomes OOB on copy/paste from CVRAvatar, as it is not a proper deep copy & enum starts at 1 (unity sets to 0)
            string type = IsOutOfBounds(typeProp.enumValueIndex, typeProp.enumDisplayNames) ? "Invalid Type" : typeProp.enumDisplayNames[typeProp.enumValueIndex];
            string usedType = IsOutOfBounds(usedTypeProp.enumValueIndex, typeProp.enumDisplayNames) ? "Invalid Type" : usedTypeProp.enumDisplayNames[usedTypeProp.enumValueIndex];
            string syncState = machineNameProp.stringValue.StartsWith("#") ? "Parameter is Local" : "Parameter is Synced";
            
            // draw setting type (and used type) on right
            EditorGUI.LabelField(rect, new GUIContent($"{type} ({usedType})", syncState), Styles.s_RightAlignedItalicLabel);
        }
        
        private void AddAdvancedSettingsElement(ReorderableList list)
        {
            // verify the selected setting is valid (cause undo/redo can break it) (before we add a new one)
            bool isSelectionValid = _selectedSettingIndex != -1 && _selectedSettingIndex < list.count;
            
            // needed to fix enums not defaulting to proper values
            SerializedProperty newElement = list.serializedProperty.AddWithDefaults<CVRAdvancedSettingsEntry>();
            serializedObject.ApplyModifiedProperties(); // apply immediately
            
            // SettingsType enum starts at 0
            // ParameterType enum starts at 1
            // :)

            if (!isSelectionValid)
            {
                // create a new setting with default values
                newElement.FindPropertyRelative(nameof(CVRAdvancedSettingsEntry.name)).stringValue = "New Setting";
                newElement.FindPropertyRelative(nameof(CVRAdvancedSettingsEntry.machineName)).stringValue = "NewSetting";
            
                newElement.FindPropertyRelative(nameof(CVRAdvancedSettingsEntry.type)).intValue = 0; // default to Toggle
                newElement.FindPropertyRelative("toggleSettings").FindPropertyRelative("usedType").intValue = 3; // default to Bool 
            }
            else
            {
                // copy the selected setting but increment the name and machine name by 1
                SerializedProperty selectedElement = list.serializedProperty.GetArrayElementAtIndex(_selectedSettingIndex);

                newElement.FindPropertyRelative(nameof(CVRAdvancedSettingsEntry.name)).stringValue = IncrementName(selectedElement.FindPropertyRelative(nameof(CVRAdvancedSettingsEntry.name)).stringValue);
                newElement.FindPropertyRelative(nameof(CVRAdvancedSettingsEntry.machineName)).stringValue = IncrementName(selectedElement.FindPropertyRelative(nameof(CVRAdvancedSettingsEntry.machineName)).stringValue);
                newElement.FindPropertyRelative(nameof(CVRAdvancedSettingsEntry.type)).intValue = selectedElement.FindPropertyRelative(nameof(CVRAdvancedSettingsEntry.type)).intValue;
                newElement.FindPropertyRelative("toggleSettings").FindPropertyRelative("usedType").intValue = selectedElement.FindPropertyRelative("toggleSettings").FindPropertyRelative("usedType").intValue;
            }
            
            // select the new setting
            list.index = _selectedSettingIndex = list.count - 1;
            m_SelectedSettingProp = newElement;
            
            // force serialized update so gui draw doesn't null ref
            serializedObject.ApplyModifiedProperties();
        }
        
        private void RemoveAdvancedSettingsElement(ReorderableList list)
        {
            if (list.index == -1)
                return;
            
            // remove the setting
            list.serializedProperty.DeleteArrayElementAtIndex(list.index);
            
            // select the previous setting if it exists
            if (list.index < list.serializedProperty.arraySize) 
                return;
            
            list.index = _selectedSettingIndex = list.serializedProperty.arraySize - 1;
            m_SelectedSettingProp = _selectedSettingIndex != -1 
                ? list.serializedProperty.GetArrayElementAtIndex(_selectedSettingIndex) : null;
            
            // force serialized update so gui draw doesn't null ref
            serializedObject.ApplyModifiedProperties();
        }
        
        private void MouseUpAdvancedSettingsElement(ReorderableList list)
        {
            if (list.index != _lastSelectedSettingIndex)
            {
                _lastSelectedSettingIndex = list.index;
            }
            else
            {
                if (list.index == -1)
                    return;
                
                list.Deselect(_lastSelectedSettingIndex);
                list.index = _selectedSettingIndex = _lastSelectedSettingIndex = -1;
                Repaint();
            }
        }
        
        private void SelectAdvancedSettingElement(ReorderableList list)
        {
            if (list.index == -1)
                return;

            _selectedSettingIndex = list.index;
            m_SelectedSettingProp = list.serializedProperty.GetArrayElementAtIndex(_selectedSettingIndex);
            
            // reset dropdown list
            _dropdownList = null;
            
            // check if the settingType is a dropdown
            // SerializedProperty settingType = m_SelectedSettingProp.FindPropertyRelative(nameof(CVRAdvancedSettingsEntry.type));
            // if (settingType.enumValueIndex == 1)
            //     Init_DropdownList();
            // else
            //     _dropdownList = null;
        }

        #endregion ReorderableList Callbacks

        #region Private Methods
        
        private static bool IsOutOfBounds(int index, IReadOnlyCollection<string> array)
            => index < 0 || index >= array.Count;
        
        private static string IncrementName(string originalName)
        {
            const string pattern = @"(.+?)(\d*)$";
            Match match = Regex.Match(originalName, pattern);

            string baseName = match.Groups[1].Value;
            string numberPart = match.Groups[2].Value;

            if (int.TryParse(numberPart, out var number))
                number++;
            else
                number = 1;

            return $"{baseName}{number}";
        }

        #endregion Private Methods
    }
}
#endif
