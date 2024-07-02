#if UNITY_EDITOR && CVR_CCK_EXISTS
using NAK.SimpleAAS.Components;
using UnityEditor;
using UnityEditorInternal;
using UnityEngine;
using static NAK.SimpleAAS.ControllerCompiler;

namespace NAK.SimpleAAS
{
    [CustomEditor(typeof(NAKSimpleAAS))]
    public class NAKSimpleAASEditor : Editor
    {
        #region Variables

        private SerializedProperty _avatar;
        private SerializedProperty _overrideController;
        private SerializedProperty _customControllers;
        private ReorderableList _controllerReorderableList;

        #endregion

        #region GUI Methods

        private void OnEnable()
        {
            _avatar = serializedObject.FindProperty(nameof(NAKSimpleAAS.avatar));
            _overrideController = serializedObject.FindProperty(nameof(NAKSimpleAAS.overrideController));
            _customControllers = serializedObject.FindProperty(nameof(NAKSimpleAAS.customControllers));

            _controllerReorderableList =
                new ReorderableList(serializedObject, _customControllers, true, true, true, true)
                {
                    drawHeaderCallback = DrawControllerListHeader,
                    drawElementCallback = DrawControllerListItems
                };
        }

        public override void OnInspectorGUI()
        {
            NAKSimpleAAS script = (NAKSimpleAAS)target;
            serializedObject.UpdateIfRequiredOrScript();

            EditorGUILayout.PropertyField(_avatar);
            EditorGUILayout.PropertyField(_overrideController);
            EditorGUILayout.Space();

            var parameterUsage = script.GetParameterSyncUsage();
            EditorGUI.ProgressBar(
                EditorGUILayout.GetControlRect(false, EditorGUIUtility.singleLineHeight),
                parameterUsage / 3200f,
                parameterUsage + " of 3200 Synced Bits used."
            );

            _controllerReorderableList.DoLayoutList();

            using (new EditorGUI.DisabledScope(script.IsInvalid()))
            {
                if (GUILayout.Button("Compile Controllers"))
                    CompileControllers(script);
            }

            serializedObject.ApplyModifiedProperties();
        }

        #endregion

        #region Controller Reorderable List Drawing

        private void DrawControllerListHeader(Rect rect)
        {
            EditorGUI.LabelField(rect, "Avatar Controllers");
        }

        private void DrawControllerListItems(Rect rect, int index, bool isActive, bool isFocused)
        {
            SerializedProperty element = _controllerReorderableList.serializedProperty.GetArrayElementAtIndex(index);

            EditorGUI.PropertyField(
                new Rect(rect.x, rect.y, rect.width, EditorGUIUtility.singleLineHeight),
                element,
                GUIContent.none
            );
        }

        #endregion
    }
}
#endif