using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using UnityEngine.UIElements;
using Voy.IntermediateAvatar.Components;
#if CVR_CCK_EXISTS

using ABI.CCK;
using ABI.CCK.Components;

#endif

#if UNITY_EDITOR

namespace Voy.IntermediateAvatar.UI
{

    public class IntermConvertFromCVR : EditorWindow
    {
        [MenuItem("Intermediate Avatar/Convert to Interm from.../ChilloutVR")]
        public static void ShowWindow()
        {
            IntermConvertFromVRC wnd = GetWindow<IntermConvertFromVRC>();
            wnd.titleContent = new GUIContent("ChilloutVR to Interm Avatar");
        }

        public bool cvrCCKExists = false;

        public bool forNerds = false;

        public bool makeDuplicate = true;
        public bool duplicateAnimators = true;
        public bool convertBones = true;

        public bool cvrConvert = false;

#if CVR_CCK_EXISTS

        public IAAvatar iaAvatar;



        public void Awake()
        {

            if (Selection.activeGameObject != null)
            {
                IAAvatar descript = Selection.activeGameObject.GetComponent<IAAvatar>();
                if (descript != null)
                    iaAvatar = descript;
            }

        }
#endif

        public void OnGUI()
        {
            cvrCCKExists = false;

#if CVR_CCK_EXISTS
            cvrCCKExists = true;
#endif

            //EditorGUILayout.LabelField("Convert From...");
            if (!cvrCCKExists) EditorGUILayout.LabelField("CVR CCK is not Present.");
#if CVR_CCK_EXISTS



            EditorGUILayout.LabelField("Convert ChilloutVR Avatar to Intermediate Avatar");
            iaAvatar = (IAAvatar)EditorGUILayout.ObjectField(iaAvatar, typeof(IAAvatar), true);

            if (iaAvatar != null)
            {

                cvrConvert = GUILayout.Button("Convert CVR to Interm");

                //{
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField("Make Duplicate");
                makeDuplicate = EditorGUILayout.Toggle(makeDuplicate);
                EditorGUILayout.EndHorizontal();
                //}

                //{
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField("Duplicate Animators");
                duplicateAnimators = EditorGUILayout.Toggle(duplicateAnimators);
                EditorGUILayout.EndHorizontal();
                //}

                //EditorGUILayout.BeginHorizontal();
                //EditorGUILayout.LabelField("Convert Bones");
                //convertBones = EditorGUILayout.Toggle(convertBones);
                //EditorGUILayout.EndHorizontal();

                if (cvrConvert)
                {
                    Debug.Log("Interm to CVR Engaged");
                    IntermediateAvatar.Converter.FromIA.ChilloutVR.Convert(iaAvatar, makeDuplicate, duplicateAnimators);
                }

            }

#endif

        }

        public void NerdInfo()
        {

        }

    }
}

#endif