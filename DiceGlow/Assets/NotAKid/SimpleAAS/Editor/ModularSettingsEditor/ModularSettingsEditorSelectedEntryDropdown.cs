#if UNITY_EDITOR && CVR_CCK_EXISTS
using System.Text.RegularExpressions;
using ABI.CCK.Scripts;
using ABI.CCK.Scripts.Editor;
using UnityEditor;
using UnityEditorInternal;
using UnityEngine;
using SerializedProperty = UnityEditor.SerializedProperty;
using static NAK.SimpleAAS.Extensions.SharedGUI;

namespace NAK.SimpleAAS.Components
{
    public partial class NAK_ModularSettingsEditor
    {
        #region Private Variables

        private SerializedProperty m_DropdownOptionsProp;
        
        private ReorderableList _dropdownList;
        private int _selectedDropdownIndex = -1;
        private int _lastSelectedDropdownIndex = -1; // used to detect double click to deselect

        #endregion Private Variables
        
        private void Init_DropdownList()
        {
            SerializedProperty dropdownSettings = m_SelectedSettingProp.FindPropertyRelative("dropDownSettings");
            m_DropdownOptionsProp = dropdownSettings.FindPropertyRelative("options");
            
            _dropdownList = new ReorderableList(serializedObject, m_DropdownOptionsProp, true, true, true, true)
            {
                drawHeaderCallback = DrawDropdownHeader,
                drawElementCallback = DrawDropdownElement,
                onAddCallback = AddDropdownElement,
                onRemoveCallback = RemoveDropdownElement,
                onMouseUpCallback = MouseUpDropdownElement,
                onSelectCallback = SelectDropdownElement,
                list = _settings.settings[_selectedSettingIndex].dropDownSettings.options
            };
        }

        private void Draw_DropdownDefault(SerializedProperty defaultValue)
        {
            string[] options = _settings.settings[_selectedSettingIndex].dropDownSettings.optionNames;
            
            // draw popup for default value
            int index = defaultValue.intValue;
            if (index < 0 || index >= options.Length) index = 0;
            index = EditorGUILayout.Popup("Default Value", index, options);
            defaultValue.intValue = index;
        }

        private void Draw_DropdownList()
        {
            if (_dropdownList == null)
                Init_DropdownList();
            
            _dropdownList?.DoLayoutList();
        }

        #region ReorderableList Callbacks
        
        private void DrawDropdownHeader(Rect rect)
        {
            Rect labelRect = new(rect.x, rect.y, rect.width - 35, EditorGUIUtility.singleLineHeight);
            GUI.Label(labelRect, $"Dropdown Options ({_dropdownList.count})");
            EditorGUIExtensions.UtilityMenu(rect, _dropdownList, m_DropdownOptionsProp);
        }
        
        private void DrawDropdownElement(Rect rect, int index, bool isActive, bool isFocused)
        {
            if (index >= _dropdownList.serializedProperty.arraySize)
                return;
            
            // alternate row background (if not focused)
            if (!isFocused && index % 2 == 0) DrawAlternateBackground(rect);
            
            rect.y += 2; // offset for shit padding unity adds to top/bottom
            rect.height = EditorGUIUtility.singleLineHeight;
            
            SerializedProperty element = _dropdownList.serializedProperty.GetArrayElementAtIndex(index);
            SerializedProperty optionName = element.FindPropertyRelative("name");
            EditorGUI.PropertyField(rect, optionName, GUIContent.none);
        }
        
        private void AddDropdownElement(ReorderableList list)
        {
            // verify the selected setting is valid (cause undo/redo can break it) (before we add a new one)
            bool isSelectionValid = _selectedDropdownIndex != -1 && _selectedDropdownIndex < list.count;
            
            // needed to fix enums not defaulting to proper values
            list.serializedProperty.arraySize++;
            SerializedProperty newElement = list.serializedProperty.GetArrayElementAtIndex(list.count - 1);
            serializedObject.ApplyModifiedProperties(); // apply immediately
            
            // SettingsType enum starts at 0
            // ParameterType enum starts at 1
            // :)

            if (!isSelectionValid)
            {
                newElement.FindPropertyRelative("name").stringValue = "New Option";
            }
            else
            {
                SerializedProperty selectedElement = list.serializedProperty.GetArrayElementAtIndex(_selectedDropdownIndex);
                newElement.FindPropertyRelative("name").stringValue = IncrementName(selectedElement.FindPropertyRelative("name").stringValue);
            }
            
            // select the new setting
            list.index = _selectedDropdownIndex = list.count - 1;
            
            // force serialized update so gui draw doesn't null ref
            serializedObject.ApplyModifiedProperties();
        }
        
        private void RemoveDropdownElement(ReorderableList list)
        {            
            if (list.index == -1)
                return;

            list.serializedProperty.DeleteArrayElementAtIndex(_selectedDropdownIndex);
            
            // select the previous setting if it exists
            if (list.index < list.serializedProperty.arraySize) 
                return;
            
            list.index = _selectedDropdownIndex = list.serializedProperty.arraySize - 1;
            
            serializedObject.ApplyModifiedProperties();
        }
        
        private void MouseUpDropdownElement(ReorderableList list)
        {
            if (list.index != _lastSelectedDropdownIndex)
            {
                _lastSelectedDropdownIndex = list.index;
            }
            else
            {
                if (list.index == -1)
                    return;
                
                list.Deselect(_lastSelectedDropdownIndex);
                list.index = _selectedDropdownIndex = _lastSelectedDropdownIndex = -1;
                Repaint();
            }
        }
        
        private void SelectDropdownElement(ReorderableList list)
        {
            if (list.index == -1) return;
            _selectedDropdownIndex = list.index;
        }
        
        #endregion ReorderableList Callbacks
    }
}
#endif