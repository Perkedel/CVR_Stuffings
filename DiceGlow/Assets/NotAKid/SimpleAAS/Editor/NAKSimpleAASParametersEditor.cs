#if UNITY_EDITOR && CVR_CCK_EXISTS
using ABI.CCK.Scripts;
using NAK.SimpleAAS.Components;
using UnityEditor;
using UnityEditorInternal;
using UnityEngine;

namespace NAK.SimpleAAS
{
    [CustomEditor(typeof(NAKSimpleAASParameters))]
    public class NAKSimpleAASParametersEditor : Editor
    {
        private SerializedProperty _avatar;
        private ReorderableList _parameterList;
        private SerializedProperty _simpleAASParameters;

        private void OnEnable()
        {
            _avatar = serializedObject.FindProperty("avatar");
            _simpleAASParameters = serializedObject.FindProperty("simpleAASParameters");
            InitializeReorderableList();
        }

        public override void OnInspectorGUI()
        {
            serializedObject.UpdateIfRequiredOrScript();

            EditorGUILayout.PropertyField(_avatar);
            _parameterList.DoLayoutList();

            if (GUILayout.Button("Sync To Avatar")) SyncSettingsToAvatar((NAKSimpleAASParameters)target);

            serializedObject.ApplyModifiedProperties();
        }

        private void InitializeReorderableList()
        {
            _parameterList = new ReorderableList(serializedObject, _simpleAASParameters, true, true, true, true)
            {
                drawElementCallback = (rect, index, isActive, isFocused) =>
                {
                    SerializedProperty element = _parameterList.serializedProperty.GetArrayElementAtIndex(index);
                    EditorGUI.PropertyField(new Rect(rect.x, rect.y, rect.width, EditorGUIUtility.singleLineHeight),
                        element, GUIContent.none);
                },
                drawHeaderCallback = rect => EditorGUI.LabelField(rect, "Modular Settings")
            };
        }

        private static void SyncSettingsToAvatar(NAKSimpleAASParameters modularSettings)
        {
            modularSettings.avatar.avatarSettings.settings.Clear();
            foreach (NAKModularSettings settings in modularSettings.simpleAASParameters)
            foreach (CVRAdvancedSettingsEntry setting in settings.settings)
                modularSettings.avatar.avatarSettings.settings.Add(setting);
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
        }
    }
}
#endif