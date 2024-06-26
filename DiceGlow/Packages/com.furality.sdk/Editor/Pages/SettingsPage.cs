using Furality.SDK.Editor.External.Boop;
using UnityEditor;
using UnityEngine;

namespace Furality.SDK.Editor.Pages
{
    public class SettingsPage : MenuPage
    {
        private bool _authExpanded = true;
        private GUIStyle _guiStyle;
        
        public SettingsPage(MainWindow mainWindow) : base(mainWindow)
        {
        }

        public override void BeforeDraw()
        {
            _guiStyle ??= new GUIStyle(GUI.skin.box)
            {
                normal =
                {
                    // Create grey box tex2d
                    background = Texture2D.grayTexture,
                    textColor = Color.white
                },
                alignment = TextAnchor.MiddleCenter,
                padding = new RectOffset(10, 10, 10, 10)
            };
        }
        
        public override void Draw()
        {
            _authExpanded = EditorGUILayout.Foldout(_authExpanded, "Authentication");

            if (!_authExpanded) return;
            EditorGUI.indentLevel++;
            EditorGUILayout.BeginVertical(_guiStyle);

            var foxApi = MainWindow.Api;
                
            if (foxApi.IsLoggedIn) // If we're logged in and have a valid user
            {
                var cachedProfile = MainWindow.Api.UsersApi.CurrentUser;
                    
                EditorGUILayout.BeginHorizontal(_guiStyle);
                var centerStyle = new GUIStyle(GUI.skin.label)
                {
                    alignment = TextAnchor.MiddleCenter
                };

                EditorGUILayout.LabelField("Logged in as: ", centerStyle, GUILayout.Width(100));
                EditorGUILayout.LabelField(cachedProfile.displayName, centerStyle);

                EditorGUILayout.EndHorizontal();

                EditorGUILayout.BeginHorizontal(_guiStyle);
                    
                EditorGUILayout.LabelField("Attendance: ", centerStyle, GUILayout.Width(100));
                EditorGUILayout.LabelField(cachedProfile.GetLevel().ToString(), centerStyle);
                EditorGUILayout.EndHorizontal();
                    
                EditorGUILayout.BeginHorizontal(_guiStyle);
                EditorGUILayout.LabelField("Patreon: ", centerStyle, GUILayout.Width(100));
                EditorGUILayout.LabelField(cachedProfile.patreon.GetTier().ToString(), centerStyle);
                EditorGUILayout.EndHorizontal();

                EditorGUILayout.Space();

                if (GUILayout.Button("Logout"))
                {
                    BoopAuth.Logout();
                }
            }
            else
            {
                bool isLoggingIn = BoopAuth.IsAwaitingCallback;
                GUI.enabled = !isLoggingIn;
                if (GUILayout.Button(!isLoggingIn ? "Login" : "Logging in..."))
                {
                    BoopAuth.Login();
                }
                GUI.enabled = true;
            }
                
            EditorGUILayout.EndVertical();
                
                
            EditorGUI.indentLevel--;
        }
    }
}