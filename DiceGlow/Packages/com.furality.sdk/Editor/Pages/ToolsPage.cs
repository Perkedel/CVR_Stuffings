using System;
using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEngine;

namespace Furality.SDK.Editor.Pages
{
    public class ToolsPage : MenuPage
    {
        private Dictionary<string, Type> _windows = new Dictionary<string, Type>();
        private (string, EditorWindow)? _currentPage;
        
        public ToolsPage(MainWindow mainWindow) : base(mainWindow)
        {
        }

        public override void BeforeDraw()
        {
            // Get all namespaces present under the Furality.Editor.Tools namespace under all assemblies
            var namespaces = AppDomain.CurrentDomain.GetAssemblies()
                .SelectMany(assembly => assembly.GetTypes())
                .Where(type => type.Namespace != null && type.Namespace.StartsWith("Furality.Editor.Tools"))
                .Select(type => type.Namespace)
                .Distinct()
                .ToArray();
            
            // For each one of these namespaces, look for a class that extends EditorWindow
            foreach (var ns in namespaces)
            {
                var type = AppDomain.CurrentDomain.GetAssemblies()
                    .SelectMany(assembly => assembly.GetTypes())
                    .Where(t => t.Namespace == ns)
                    .FirstOrDefault(t => t.BaseType == typeof(EditorWindow));

                if (type == null)
                    continue;

                // Figure out the name of the class by adding spaces before each capital letter
                var name = string.Concat(type.Name.Select(x => char.IsUpper(x) ? " " + x : x.ToString())).TrimStart(' ');
                
                // Add it to our list of windows (if it doesn't already exist)
                _windows.TryAdd(name, type);
            }
        }

        public override void Draw()
        {
            if (_currentPage == null)
            {
                var first = _windows.FirstOrDefault();
                if (first.Value != null)
                    _currentPage = (first.Key, (EditorWindow)ScriptableObject.CreateInstance(first.Value));
            }
            
            GUILayout.BeginHorizontal();
            foreach (var tool in _windows)
            {
                bool isSelected = tool.Key == (_currentPage.Value.Item1 ?? "");
                if (isSelected)
                    GUI.color = new Color(1.2f, 1.2f, 1.2f);

                if (GUILayout.Button(tool.Key))
                    _currentPage = (tool.Key, (EditorWindow)ScriptableObject.CreateInstance(tool.Value));

                if (isSelected)
                    GUI.color = Color.white;
            }
            GUILayout.EndHorizontal();
            
            EditorGUILayout.Space(5);
            
            // If windows is empty, display a warning box 
            if (_windows.Count == 0)
            {
                EditorGUILayout.HelpBox("No tools found! Install some from the Downloads Tab!", MessageType.Warning);
                return;
            }
            
            // Invoke their OnGUI method by name
            var type = _windows[_currentPage.Value.Item1];
            var method = type.GetMethod("OnGUI", System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.NonPublic);
            method?.Invoke(_currentPage.Value.Item2, null);
        }
    }
}