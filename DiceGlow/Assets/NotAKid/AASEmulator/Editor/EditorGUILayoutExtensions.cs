using UnityEditor;
using UnityEngine;

namespace NAK.AASEmulator.Editor
{
    public static class EditorExtensions
    {
        #region Constructor

        static EditorExtensions()
        {
            // init styles
            s_BoldLabelStyle = new GUIStyle(EditorStyles.label) { fontStyle = FontStyle.Bold };
            s_BoldFoldoutStyle = new GUIStyle(EditorStyles.foldout) { fontStyle = FontStyle.Bold };
        }
        
        #endregion Constructor
        
        #region Shared Styles

        internal static readonly GUIStyle s_BoldLabelStyle;
        internal static readonly GUIStyle s_BoldFoldoutStyle;

        #endregion
        
        #region Popup Scroll
        
        public static void HandlePopupScroll(ref int newIndex, int minIndex, int maxIndex)
        {
            if (Event.current.type == EventType.ScrollWheel &&
                GUILayoutUtility.GetLastRect().Contains(Event.current.mousePosition))
            {
                if (Event.current.delta.y < 0)
                {
                    newIndex = Mathf.Clamp(newIndex + 1, minIndex, maxIndex);
                    Event.current.Use();
                }
                else if (Event.current.delta.y > 0)
                {
                    newIndex = Mathf.Clamp(newIndex - 1, minIndex, maxIndex);
                    Event.current.Use();
                }
            }
        }
        
        #endregion

        #region Joystick 2D Field
        
        private static float _joystickClickTime;

        public static Vector2 Joystick2DField(Rect position, Vector2 value, bool shouldNormalize = false)
        {
            int controlID = GUIUtility.GetControlID(FocusType.Passive);
            Event currentEvent = Event.current;
            
            Rect joystickArea = new(position.x, position.y, position.width, position.height);
            
            // background
            EditorGUI.DrawRect(joystickArea, Color.grey);

            // handle
            Vector2 handlePosition = new(value.x * (joystickArea.width / 2), -value.y * (joystickArea.height / 2));
            Vector2 screenHandlePosition = joystickArea.center + handlePosition;
            Handles.color = Color.white;
            Handles.DrawSolidDisc(screenHandlePosition, Vector3.forward, 6);

            // handle input
            if (currentEvent.type == EventType.MouseDown && joystickArea.Contains(currentEvent.mousePosition))
            {
                GUIUtility.hotControl = controlID;
                currentEvent.Use();

                // double-click reset
                if ((Time.realtimeSinceStartup - _joystickClickTime) < 0.5f)
                    value = Vector2.zero;

                _joystickClickTime = Time.realtimeSinceStartup;
            }
            else if (currentEvent.type == EventType.MouseUp && GUIUtility.hotControl == controlID)
            {
                GUIUtility.hotControl = 0;
                currentEvent.Use();
            }
            else if (currentEvent.type == EventType.MouseDrag && GUIUtility.hotControl == controlID)
            {
                Vector2 newJoystickPosition = currentEvent.mousePosition - joystickArea.center;
                newJoystickPosition.x /= joystickArea.width / 2;
                newJoystickPosition.y /= -joystickArea.height / 2;
                value = new Vector2(Mathf.Clamp(newJoystickPosition.x, -1, 1),
                    Mathf.Clamp(newJoystickPosition.y, -1, 1));
                currentEvent.Use();
            }
            
            if (shouldNormalize && value.magnitude > value.normalized.magnitude)
                value.Normalize();

            return value;
        }
        
        #endregion
    }
}