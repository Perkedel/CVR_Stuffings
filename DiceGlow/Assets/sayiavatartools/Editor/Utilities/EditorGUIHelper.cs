using UnityEngine;
using UnityEditor;

namespace SayiTools
{
    public class EditorGUIHelper
    {
        public const string PROGRESS_TITLE = "Sayi Tools";

        private static GUIStyle FoldoutStyle = null;

        public static void HeaderLevel1(string headerText)
        {
            Header(headerText, 18, Color.cyan);
        }

        public static void HeaderLevel2(string headerText)
        {
            Header(headerText, 14, Color.cyan);
        }

        public static void Separator()
        {
            GUILayout.Space(5);
            Rect rect = EditorGUILayout.GetControlRect(GUILayout.Height(2));
            rect.height = 2;
            EditorGUI.DrawRect(rect, new Color(0, 0, 0, 0.15f));
            GUILayout.Space(5);
        }

        private static void Header(string headerText, int fontSize, Color colour)
        {
            GUIStyle headerStyle = new GUIStyle();
            headerStyle.fontStyle = FontStyle.Bold;
            headerStyle.fontSize = fontSize;
            headerStyle.normal.textColor = colour;
            headerStyle.alignment = TextAnchor.MiddleCenter;
            GUILayout.Label(headerText, headerStyle);
            EditorGUILayout.LabelField("", GUI.skin.horizontalSlider);
            GUILayout.Space(EditorGUIUtility.singleLineHeight);
        }

        public static GUIStyle GetFoldoutStyle()
        {
            if (FoldoutStyle == null)
            {
                FoldoutStyle = new GUIStyle(EditorStyles.foldout);
                FoldoutStyle.fontStyle = FontStyle.Bold;
                FoldoutStyle.fontSize = 14;
                FoldoutStyle.normal.textColor = Color.cyan;
                FoldoutStyle.onNormal.textColor = Color.cyan;
            }

            return FoldoutStyle;
        }

        public static void BeginBox()
        {
            // the multiple vertical/horizontal layouts and
            // the space after the horizontal is important for proper spacing
            EditorGUILayout.BeginVertical();
            EditorGUILayout.BeginHorizontal(GUI.skin.box);
            GUILayout.Space(EditorGUIUtility.singleLineHeight);
            EditorGUILayout.BeginVertical();
        }

        public static void EndBox()
        {
            EditorGUILayout.EndVertical();
            GUILayout.Space(EditorGUIUtility.singleLineHeight);
            EditorGUILayout.EndHorizontal();
            EditorGUILayout.EndVertical();
            GUILayout.Space(EditorGUIUtility.singleLineHeight);
        }

        public static string GetProgressBarTitle(string title = null)
        {
            if (string.IsNullOrWhiteSpace(title))
            {
                return PROGRESS_TITLE;
            }
            else
            {
                return PROGRESS_TITLE + " - " + title;
            }
        }

        public static void FlexSpaceText(string label, string text)
        {
            EditorGUILayout.BeginHorizontal();
            EditorGUILayout.LabelField(label);
            GUILayout.FlexibleSpace();
            EditorGUILayout.LabelField(text);
            EditorGUILayout.EndHorizontal();
        }
    }
}