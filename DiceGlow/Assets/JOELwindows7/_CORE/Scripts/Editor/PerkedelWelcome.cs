#if UNITY_EDITOR

using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System;
using UnityEngine;
using UnityEngine.UIElements;
using UnityEditor;
// using EditorGUILayout;

namespace com.perkedel.DiceGlow{
    public class PerkedelWelcomeScreen : EditorWindow
    {
        // First, Yoink basic CCK window elements. sorry marm. No mean.. idk, basically not any of it.
        private int _tab;
        private Vector2 _scroll;

        public VisualElement root;
        public Texture2D perkedelLogo;

        [MenuItem("Perkedel/Welcome Screen")]
        public static void Init()
        {
            PerkedelWelcomeScreen wnd = GetWindow<PerkedelWelcomeScreen>();
            wnd.titleContent = new GUIContent("Welcome");
        }

        private void OnEnable(){
            perkedelLogo = AssetDatabase.LoadAssetAtPath<Texture2D>("Assets/JOELwindows7/_CORE/Sprites/Logo/Perkedel Profile CutoutType.png");
        }

        public void CreateGUI()
        {
            // Each editor window contains a root VisualElement object
            root = rootVisualElement;


            // VisualElements objects can contain other VisualElement following a tree hierarchy
            // Label label = new Label("Hello World!");
            // root.Add(label);

            // Create button
            // Button button = new Button();
            // button.name = "button";
            // button.text = "Button";
            // root.Add(button);

            // Create toggle
            // Toggle toggle = new Toggle();
            // toggle.name = "toggle";
            // toggle.label = "Toggle";
            // root.Add(toggle);

            // NAAAAW
            // Label title = new Label("Welcome to DiceGlow!");
            // root.Add(title);
        }

        public void OnGUI(){
            // Yoink from CCK lmao, sorry marm.
            GUIStyle centeredStyle = new GUIStyle(GUI.skin.label)
            {
                alignment = TextAnchor.MiddleCenter,
                fixedHeight = 70, // Fixes size when Android
            };

            // Now add this myself!
            GUILayout.Label(perkedelLogo, centeredStyle);

            EditorGUILayout.BeginVertical();

            // Apply CCK yoinks to here, add our twists!
            _tab = GUILayout.Toolbar(_tab, new string []{"Home", "Dependency"});
            _scroll = EditorGUILayout.BeginScrollView(_scroll);

            switch(_tab){
                case 0:
                    Tab_Home();
                    break;
                default:
                    break;
            }

            EditorGUILayout.EndScrollView();
            EditorGUILayout.EndVertical();
        }

        private void Tab_Home(){
            EditorGUILayout.LabelField("Welcome to DiceGlow!",EditorStyles.boldLabel);

            EditorGUILayout.LabelField("Haha: ", "hihi");
            EditorGUILayout.LabelField("Hehe: ", "hoho");
        }

        void Update()
        {

        }
    }
}


#endif