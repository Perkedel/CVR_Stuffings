using System.Collections.Generic;
using System.Linq;
using Furality.SDK.Editor.External.FoxApi;
using Furality.SDK.Editor.Pages;
using UnityEditor;
using UnityEngine;

namespace Furality.SDK.Editor.External.AssetHandling
{
    public class PrivilegeCategory
    {
        public readonly string CategoryName;
        private readonly List<AssetClass> _assetClasses;
        private readonly int _numAssetClasses;
        
        private AssetClass _selectedClass; 
        
        public PrivilegeCategory(string categoryName, List<AssetClass> assetClasses)
        {
            CategoryName = categoryName;
            _assetClasses = assetClasses;
            _numAssetClasses = _assetClasses.Count();
        }

        public void Draw()
        {
            if (_selectedClass == null)
                _selectedClass = _assetClasses.First();

            var profile = MainWindow.Api.UsersApi.CurrentUser;
            if (CategoryName == "Patreon Assets" && profile.patreon.GetTier() <= PatreonLevel.Green)
            {
                EditorGUILayout.HelpBox("You need to be a Patreon to access this content", MessageType.Warning);
                return;
            }
            
            GUILayout.BeginHorizontal();
            if (_numAssetClasses > 1)
            {
                foreach (var assetClass in _assetClasses)
                {
                    bool isSelected = assetClass?.Name == _selectedClass?.Name;
                    if (isSelected)
                    {
                        GUI.color = new Color(1.2f, 1.2f, 1.2f);
                    }

                    if (GUILayout.Button(assetClass.Name, GUILayout.ExpandWidth(true)))
                    {
                        _selectedClass = assetClass;
                    }

                    if (isSelected)
                    {
                        GUI.color = Color.white;
                    }
                }
            }

            GUILayout.EndHorizontal();

            GUILayout.BeginVertical();
            _selectedClass?.Draw();
            GUILayout.EndVertical();
        }
    }
}