using System.Collections.Generic;
using System.Linq;
using Furality.SDK.Editor.External.Boop;
using Furality.SDK.Editor.External.FoxApi;
using Furality.SDK.Editor.Helpers;
using UnityEditor;
using UnityEditor.PackageManager;
using UnityEngine;

namespace Furality.SDK.Editor.Pages
{
    [InitializeOnLoad]
    public class MainWindow : EditorWindow
    {
        private Dictionary<string, MenuPage> _pages = new Dictionary<string, MenuPage>();
        
        private MenuPage _currentPage;
        private Texture2D _logo;
        private string _cachedVersion = "Unknown Version";

        public static FoxApi Api = new FoxApi();
        
        static MainWindow()
        {
            EditorApplication.update -= ShowOnFirstBoot;
            EditorApplication.update += ShowOnFirstBoot;
        }

        [MenuItem("Furality/Show Furality Asset Manager")]
        private static void ShowWindow()
        {
            var window = GetWindow<MainWindow>();
            window.titleContent = new GUIContent("Furality Asset Manager");
            window.minSize = new Vector2(350, 500);
            window.Show();
        }

        private string GetVersion()
        {
            // Query UPM for the current version of org.furality.sdk
            var list = Client.List(true);
            while (!list.IsCompleted)
            {
                // Wait for the query to complete
            }
            var package = list.Result.FirstOrDefault(p => p.name == "com.furality.sdk");
            if (package == null)
                return "Unknown Version";
            
            // Get the version from the package
            return package.version;
        }

        // Checks playerprefs to see if this is the first time the user has installed FAM
        // If it is, pop up the window and set the playerpref to true
        private static void ShowOnFirstBoot()
        {
            EditorApplication.update -= ShowOnFirstBoot;
            if (EditorApplication.isPlaying)
                return;

            if (!EditorPrefs.GetBool("furality.hasSeenBefore"))
                ShowWindow();
            
            EditorPrefs.SetBool("furality.hasSeenBefore", true);
        }

        private void OnEnable()
        {
            Debug.Log("OnEnable MainWindow");
            
            BoopAuth.Login();
            
            _pages = new Dictionary<string, MenuPage>
            {
                { "Assets", new DownloadsPage(this) },
                { "Tools", new ToolsPage(this) },
                { "Settings", new SettingsPage(this) }
            };
            
            if (_currentPage == null)
            {
                _currentPage = _pages.First().Value;
            }
        
            _logo = Resources.Load<Texture2D>("furality-logo");

            _cachedVersion = GetVersion();
            
            AssetDatabase.importPackageCompleted += UnityPackageImportQueue.OnPackageImportComplete;
        }

        private void OnGUI()
        {
            var maxLogoWidth = 200;
            var maxLogoHeight = 200;

            EditorGUILayout.BeginHorizontal(GUI.skin.box);
            GUILayout.FlexibleSpace();
            if (_logo != null)
            {
                var aspect = (float)_logo.width / (_logo.height+200);
                var logoWidth = Mathf.Min(maxLogoWidth, maxLogoHeight * aspect);
                var logoHeight = logoWidth / aspect;
                GUILayout.Label(_logo, GUILayout.Width(logoWidth), GUILayout.Height(logoHeight));
            }
            GUILayout.FlexibleSpace();
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            foreach (var page in _pages)
            {
                bool isSelected = page.Value == _currentPage;
                if (isSelected)
                    GUI.color = new Color(1.2f, 1.2f, 1.2f);

                if (GUILayout.Button(page.Key.Replace("Page", ""), GUILayout.ExpandWidth(true)))
                {
                    page.Value.BeforeDraw();
                    _currentPage = page.Value;
                }

                if (isSelected)
                    GUI.color = Color.white;
            }
            EditorGUILayout.EndHorizontal();

            // I would use if/else here, but unity runs a quick BOM check before displaying the window, and throws an error if something has changed
            if (_currentPage != null)
            {
                EditorGUILayout.Space(10);
                _currentPage.Draw();
            }
            
            // Displaying grey text in the bottom left corner
            GUIStyle greyTextStyle = new GUIStyle(GUI.skin.label);
            greyTextStyle.normal.textColor = Color.gray;
            GUILayout.BeginArea(new Rect(10, Screen.height - 50, 200, 20));
            GUILayout.Label(_cachedVersion, greyTextStyle);
            GUILayout.EndArea();
        }
    }
}
