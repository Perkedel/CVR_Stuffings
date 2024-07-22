using UnityEngine;
using UnityEditor;

namespace OccaSoftware.Crosshairs.Editor
{
    public class StartMenu : EditorWindow
    {
        // Source for UUID: https://shortunique.id/
        private static string modalId = "ShowCrosshairsModal=qtN0wW";
        private Texture2D logo;
        private GUIStyle header,
            button,
            contentSection;
        private GUILayoutOption[] contentLayoutOptions;
        private static bool listenToEditorUpdates;
        private static StartMenu startMenu;

        [MenuItem("OccaSoftware/Start Menu (Crosshairs)")]
        public static void SetupMenu()
        {
            startMenu = CreateWindow();
            CenterWindowInEditor(startMenu);
            LoadLogo(startMenu);
        }

        [InitializeOnLoadMethod]
        private static void Initialize()
        {
            RegisterModal();
        }

        void OnGUI()
        {
            SetupHeaderStyle(startMenu);
            SetupButtonStyle(startMenu);
            SetupContentSectionStyle(startMenu);

            DrawHeader();
            DrawReviewRequest();
            DrawHelpLinks();
            DrawUpgradeLinks();
        }

        #region Setup
        private static StartMenu CreateWindow()
        {
            StartMenu startMenu = (StartMenu)GetWindow(typeof(StartMenu));
            startMenu.position = new Rect(0, 0, 270, 480);
            return startMenu;
        }

        private static void CenterWindowInEditor(EditorWindow startMenu)
        {
            Rect mainWindow = EditorGUIUtility.GetMainWindowPosition();
            Rect currentWindowPosition = startMenu.position;
            float centerX = (mainWindow.width - currentWindowPosition.width) * 0.5f;
            float centerY = (mainWindow.height - currentWindowPosition.height) * 0.5f;
            currentWindowPosition.x = mainWindow.x + centerX;
            currentWindowPosition.y = mainWindow.y + centerY;
            startMenu.position = currentWindowPosition;
        }

        private static void LoadLogo(StartMenu startMenu)
        {
            startMenu.logo = (Texture2D)
                AssetDatabase.LoadAssetAtPath(
                    "Assets/OccaSoftware/Crosshairs/Editor/Textures/Logo.png",
                    typeof(Texture2D)
                );
        }

        private static void SetupHeaderStyle(StartMenu startMenu)
        {
            startMenu.header = new GUIStyle(EditorStyles.boldLabel);
            startMenu.header.fontSize = 18;
            startMenu.header.wordWrap = true;
            startMenu.header.padding = new RectOffset(0, 0, 0, 0);
        }

        private static void SetupButtonStyle(StartMenu startMenu)
        {
            startMenu.button = new GUIStyle("button");
            startMenu.button.fontSize = 18;
            startMenu.button.fontStyle = FontStyle.Bold;
            startMenu.button.fixedHeight = 40;
        }

        private static void SetupContentSectionStyle(StartMenu startMenu)
        {
            startMenu.contentSection = new GUIStyle("label");
            startMenu.contentSection.margin = new RectOffset(20, 20, 20, 20);
            startMenu.contentSection.padding = new RectOffset(0, 0, 0, 0);
            startMenu.contentLayoutOptions = new GUILayoutOption[] { GUILayout.MinWidth(230) };
        }
        #endregion


        #region Modal Handler
        private static void RegisterModal()
        {
            if (!listenToEditorUpdates && !EditorApplication.isPlayingOrWillChangePlaymode)
            {
                listenToEditorUpdates = true;
                EditorApplication.update += PopModal;
            }
        }

        private static void PopModal()
        {
            EditorApplication.update -= PopModal;

            bool showModal = EditorPrefs.GetBool(modalId, true);
            if (showModal)
            {
                EditorPrefs.SetBool(modalId, false);
                SetupMenu();
            }
        }
        #endregion



        #region UI Drawer
        private void DrawHeader()
        {
            GUILayout.BeginVertical(contentSection, contentLayoutOptions);
            GUIStyle logoStyle = new GUIStyle("label");
            GUILayoutOption[] logoOptions = new GUILayoutOption[] { GUILayout.Width(230) };
            logoStyle.padding = new RectOffset(0, 0, 0, 0);
            logoStyle.margin = new RectOffset(0, 0, 0, 0);
            logoStyle.alignment = TextAnchor.MiddleCenter;
            GUILayout.Label(logo, logoStyle, logoOptions);
            GUILayout.EndVertical();
        }

        private void DrawReviewRequest()
        {
            GUILayout.BeginVertical(contentSection, contentLayoutOptions);
            GUILayout.Label("What do you think about my free Crosshair pack?", header);

            if (
                GUILayout.Button(
                    "Leave a review",
                    button,
                    new GUILayoutOption[] { GUILayout.MaxWidth(300) }
                )
            )
            {
                Application.OpenURL("https://assetstore.unity.com/packages/slug/216732");
            }
            GUILayout.EndVertical();
        }

        private void DrawHelpLinks()
        {
            GUILayout.BeginVertical(contentSection, contentLayoutOptions);
            GUILayout.Label("I am here to help.", header);
            if (EditorGUILayout.LinkButton("Website"))
            {
                Application.OpenURL("https://www.occasoftware.com/assets/crosshairs");
            }

            if (EditorGUILayout.LinkButton("Discord"))
            {
                Application.OpenURL("https://www.occasoftware.com/discord");
            }
            EditorGUILayout.EndVertical();
        }

        private void DrawUpgradeLinks()
        {
            GUILayout.BeginVertical(contentSection, contentLayoutOptions);

            GUILayout.Label("Make your game a success.", header);
            if (EditorGUILayout.LinkButton("Upgrade to Crosshairs Pro"))
            {
                Application.OpenURL("https://assetstore.unity.com/packages/slug/239049");
            }
            if (EditorGUILayout.LinkButton("Join my Newsletter"))
            {
                Application.OpenURL("https://www.occasoftware.com/newsletter");
            }
            EditorGUILayout.EndVertical();
        }
        #endregion
    }
}
