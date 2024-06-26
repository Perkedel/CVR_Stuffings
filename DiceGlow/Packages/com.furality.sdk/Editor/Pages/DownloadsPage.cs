using System.Collections.Generic;
using System.Linq;
using Furality.SDK.Editor.External.AssetHandling;
using UnityEditor;
using UnityEngine;

namespace Furality.SDK.Editor.Pages
{
    public class DownloadsPage : MenuPage
    {
        private List<PrivilegeCategory> _categories = new List<PrivilegeCategory>();
        private readonly List<IPackageDataSource> _packageDataSources;
        private PrivilegeCategory _currentPage;

        private static string FormatString(string str) => $"{str[0].ToString().ToUpper()}{str.Substring(1)}".Replace('_', ' ');
        
        public DownloadsPage(MainWindow mainWindow) : base(mainWindow)
        {
            Debug.Log("Construct DownloadsPage");
            _packageDataSources = new List<IPackageDataSource>
            {
                MainWindow.Api.FilesApi,
                new LocalDataSource()
            };

            MainWindow.Api.FilesApi.OnLoggedIn += RefreshPage;
        }

        private void RefreshPage()
        {
            var downloads = _packageDataSources.SelectMany(pds => pds.GetPackages());

            _categories = downloads.GroupBy(d => d.Category).OrderBy(p => p.Key).Select(g =>
                new PrivilegeCategory(FormatString(g.Key.ToString()),
                    g.GroupBy(a => a.AttendanceLevel).OrderBy(g2 => g2.Key).Select(c =>
                        new AssetClass(FormatString(c.Key.ToString()), c.ToArray(), _packageDataSources)).ToList())).ToList();

            if (_currentPage == null)
                _currentPage = _categories[0];
        }

        public override void BeforeDraw()
        {
            RefreshPage();
        }

        public override void Draw()
        {
            if (!MainWindow.Api.IsLoggedIn)
            {
                EditorGUILayout.HelpBox("You must be logged in to download assets. Please log-in using the settings tab", MessageType.Warning);
                return;
            }

            GUILayout.BeginHorizontal();
            foreach (var privilegeCategory in _categories)
            {
                bool isSelected = privilegeCategory == _currentPage;
                if (isSelected)
                    GUI.color = new Color(1.2f, 1.2f, 1.2f);

                if (GUILayout.Button(privilegeCategory.CategoryName))
                    _currentPage = privilegeCategory;
                
                if (isSelected)
                    GUI.color = Color.white;
            }
            GUILayout.EndHorizontal();
            
            EditorGUILayout.Space(5);
            
            _currentPage?.Draw();
        }
    }
}