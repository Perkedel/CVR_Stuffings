#if UNITY_EDITOR
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using UnityEditorInternal;

namespace CVRLua
{
    [CustomEditor(typeof(LuaScript))]
    public class LuaScriptEditor : Editor
    {
        private const string VariableHelpText = "Variables can be accessed by each attached script.";
        private const string VariableObjectHelpText = "VariableObjects can be accessed by each attached script.";
        private const string ScriptHelpText = "All attached scripts are treated as one combined script.";

        private LuaScript script;
        private ReorderableList variableList;
        private ReorderableList variableObjectList;
        private ReorderableList scriptList;

        void OnEnable()
        {
            script = (LuaScript)target;
            CreateVariableList();
            CreateVariableObjectList();
            CreateScriptList();
        }

        public override void OnInspectorGUI()
        {
            serializedObject.Update();

            DrawVariableButtons();
            variableList.DoLayoutList();

            DrawVariableObjectButtons();
            variableObjectList.DoLayoutList();

            DrawScriptButtons();
            scriptList.DoLayoutList();

            serializedObject.ApplyModifiedProperties();
        }

        void CreateVariableList()
        {
            variableList = new ReorderableList(serializedObject, serializedObject.FindProperty("VariableNames"), true, true, true, true);
            variableList.drawHeaderCallback = rect =>
            {
                EditorGUI.LabelField(new Rect(rect.x, rect.y, rect.width * 0.5f, rect.height), "Variable Names");
                EditorGUI.LabelField(new Rect(rect.x + rect.width * 0.5f, rect.y, rect.width * 0.5f, rect.height), "Variable Values");
            };
            variableList.drawElementCallback = (rect, index, isActive, isFocused) =>
            {
                var element = variableList.serializedProperty.GetArrayElementAtIndex(index);
                rect.y += 2;
                rect.height = EditorGUIUtility.singleLineHeight;
                var nameRect = new Rect(rect.x, rect.y, rect.width * 0.5f, rect.height);
                var valueRect = new Rect(rect.x + rect.width * 0.5f + 5f, rect.y, rect.width * 0.5f - 5f, rect.height);

                EditorGUI.PropertyField(nameRect, element, GUIContent.none);
                EditorGUI.PropertyField(valueRect, serializedObject.FindProperty("VariableValues").GetArrayElementAtIndex(index), GUIContent.none);
            };
            variableList.onReorderCallbackWithDetails = (list, oldIndex, newIndex) =>
            {
                var valuesProperty = serializedObject.FindProperty("VariableValues");
                valuesProperty.MoveArrayElement(oldIndex, newIndex);
                serializedObject.ApplyModifiedProperties();
            };
            variableList.elementHeightCallback = index =>
            {
                const float padding = 4f;
                return EditorGUIUtility.singleLineHeight + padding;
            };
            variableList.drawFooterCallback = rect =>
            {
                EditorGUI.HelpBox(rect, VariableHelpText, MessageType.Info);
            };
        }

        void CreateVariableObjectList()
        {
            variableObjectList = new ReorderableList(serializedObject, serializedObject.FindProperty("VariableObjectNames"), true, true, true, true);
            variableObjectList.drawHeaderCallback = rect =>
            {
                EditorGUI.LabelField(new Rect(rect.x, rect.y, rect.width * 0.5f, rect.height), "VariableObject Names");
                EditorGUI.LabelField(new Rect(rect.x + rect.width * 0.5f, rect.y, rect.width * 0.5f, rect.height), "VariableObject Values");
            };
            variableObjectList.drawElementCallback = (rect, index, isActive, isFocused) =>
            {
                var element = variableObjectList.serializedProperty.GetArrayElementAtIndex(index);
                rect.y += 2;
                rect.height = EditorGUIUtility.singleLineHeight;
                var nameRect = new Rect(rect.x, rect.y, rect.width * 0.5f, rect.height);
                var valueRect = new Rect(rect.x + rect.width * 0.5f + 5f, rect.y, rect.width * 0.5f - 5f, rect.height);

                EditorGUI.PropertyField(nameRect, element, GUIContent.none);
                EditorGUI.PropertyField(valueRect, serializedObject.FindProperty("VariableObjectValues").GetArrayElementAtIndex(index), GUIContent.none);
            };
            variableObjectList.onReorderCallbackWithDetails = (list, oldIndex, newIndex) =>
            {
                var valuesProperty = serializedObject.FindProperty("VariableObjectValues");
                valuesProperty.MoveArrayElement(oldIndex, newIndex);
                serializedObject.ApplyModifiedProperties();
            };
            variableObjectList.elementHeightCallback = index =>
            {
                const float padding = 4f;
                return EditorGUIUtility.singleLineHeight + padding;
            };
            variableObjectList.drawFooterCallback = rect =>
            {
                EditorGUI.HelpBox(rect, VariableObjectHelpText, MessageType.Info);
            };
        }

        void CreateScriptList()
        {
            scriptList = new ReorderableList(serializedObject, serializedObject.FindProperty("Scripts"), true, true, true, true);
            scriptList.drawHeaderCallback = rect => EditorGUI.LabelField(rect, "Scripts");
            scriptList.drawElementCallback = (rect, index, isActive, isFocused) =>
            {
                var element = scriptList.serializedProperty.GetArrayElementAtIndex(index);
                rect.y += 2;
                EditorGUI.PropertyField(new Rect(rect.x, rect.y, rect.width, EditorGUIUtility.singleLineHeight), element, GUIContent.none);
            };
            scriptList.elementHeightCallback = index =>
            {
                const float padding = 4f;
                return EditorGUIUtility.singleLineHeight + padding;
            };
            scriptList.drawFooterCallback = rect =>
            {
                EditorGUI.HelpBox(rect, ScriptHelpText, MessageType.Info);
            };
        }

        void DrawVariableButtons()
        {
            EditorGUILayout.BeginHorizontal();
            if (GUILayout.Button("Add Variable"))
            {
                Undo.RecordObject(script, "Add Variable");
                script.VariableNames.Add("");
                script.VariableValues.Add(null);
            }
            EditorGUI.BeginDisabledGroup(script.VariableNames.Count == 0);
            if (GUILayout.Button("Remove Variable"))
            {
                int removeIndex = variableList.index >= 0 && variableList.index < script.VariableNames.Count ? variableList.index : script.VariableNames.Count - 1;

                if (removeIndex >= 0 && removeIndex < script.VariableNames.Count)
                {
                    string variableName = script.VariableNames[removeIndex];

                    Undo.RecordObject(script, "Remove Variable: " + variableName);

                    script.VariableNames.RemoveAt(removeIndex);
                    script.VariableValues.RemoveAt(removeIndex);
                }
            }
            EditorGUI.EndDisabledGroup();
            EditorGUILayout.EndHorizontal();
        }

        void DrawVariableObjectButtons()
        {
            EditorGUILayout.BeginHorizontal();
            if (GUILayout.Button("Add VariableObject"))
            {
                Undo.RecordObject(script, "Add VariableObject");
                script.VariableObjectNames.Add("");
                script.VariableObjectValues.Add(null);
            }
            EditorGUI.BeginDisabledGroup(script.VariableObjectNames.Count == 0);
            if (GUILayout.Button("Remove VariableObject"))
            {
                int removeIndex = variableObjectList.index >= 0 && variableObjectList.index < script.VariableObjectNames.Count ? variableObjectList.index : script.VariableObjectNames.Count - 1;

                if (removeIndex >= 0 && removeIndex < script.VariableObjectNames.Count)
                {
                    string variableObjectName = script.VariableObjectNames[removeIndex];

                    Undo.RecordObject(script, "Remove VariableObject: " + variableObjectName);

                    script.VariableObjectNames.RemoveAt(removeIndex);
                    script.VariableObjectValues.RemoveAt(removeIndex);
                }
            }
            EditorGUI.EndDisabledGroup();
            EditorGUILayout.EndHorizontal();
        }

        void DrawScriptButtons()
        {
            EditorGUILayout.BeginHorizontal();
            if (GUILayout.Button("Add Script"))
            {
                Undo.RecordObject(script, "Add Script");
                script.Scripts.Add(null);
            }
            EditorGUI.BeginDisabledGroup(script.Scripts.Count == 0);
            if (GUILayout.Button("Remove Script"))
            {
                int removeIndex = scriptList.index >= 0 && scriptList.index < script.Scripts.Count ? scriptList.index : script.Scripts.Count - 1;

                if (removeIndex >= 0 && removeIndex < script.Scripts.Count)
                {
                    TextAsset removedScript = script.Scripts[removeIndex];

                    Undo.RecordObject(script, "Remove Script: " + (removedScript != null ? removedScript.name : ""));

                    script.Scripts.RemoveAt(removeIndex);
                }
            }
            EditorGUI.EndDisabledGroup();
            EditorGUILayout.EndHorizontal();
        }
    }
}
#endif