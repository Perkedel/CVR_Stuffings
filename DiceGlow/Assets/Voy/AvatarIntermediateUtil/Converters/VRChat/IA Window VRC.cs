using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using UnityEngine.UIElements;
#if VRC_SDK_VRCSDK3

using VRC.SDK3.Avatars.Components;

#endif

#if UNITY_EDITOR

namespace Voy.IntermediateAvatar.UI
{

    public class IntermConvertFromVRC : EditorWindow
    {
#if VRC_SDK_VRCSDK3
        [MenuItem("Intermediate Avatar/Convert to Interm from.../VRChat")]
#endif
        public static void ShowWindow()
        {
            IntermConvertFromVRC wnd = GetWindow<IntermConvertFromVRC>();
            wnd.titleContent = new GUIContent("VRChat to Interm Avatar");
        }

        public bool vrcSDKExists = false;

        public bool forNerds = false;

        public bool makeDuplicate = true;
        public bool duplicateAnimators = false;
        public bool convertBones = true;

        public bool vrcConvert = false;

#if VRC_SDK_VRCSDK3

        public VRCAvatarDescriptor VRCAvatar;



        public void Awake()
        {

            if (Selection.activeGameObject != null)
            {
                VRCAvatarDescriptor descript = Selection.activeGameObject.GetComponent<VRCAvatarDescriptor>();
                if (descript != null)
                    VRCAvatar = descript;
            }

        }
#endif

        public void OnGUI()
        {
            vrcSDKExists = false;

#if VRC_SDK_VRCSDK3
            vrcSDKExists = true;
#endif

            //EditorGUILayout.LabelField("Convert From...");
            if (!vrcSDKExists) EditorGUILayout.LabelField("VRC SDK is not Present.");
#if VRC_SDK_VRCSDK3



            EditorGUILayout.LabelField("Convert VRChat SDK3 Avatar to Intermediate Avatar");
            VRCAvatar = (VRCAvatarDescriptor)EditorGUILayout.ObjectField(VRCAvatar, typeof(VRCAvatarDescriptor), true);

            if (VRCAvatar != null)
            {

                vrcConvert = GUILayout.Button("Convert VRC to Interm");

                //{
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField("Make Duplicate");
                makeDuplicate = EditorGUILayout.Toggle(makeDuplicate);
                EditorGUILayout.EndHorizontal();
                //}

                //{
                /*
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField("Duplicate Animators");
                duplicateAnimators = EditorGUILayout.Toggle(duplicateAnimators);
                EditorGUILayout.EndHorizontal();
                */
                //}

                //EditorGUILayout.BeginHorizontal();
                //EditorGUILayout.LabelField("Convert Bones");
                //convertBones = EditorGUILayout.Toggle(convertBones);
                //EditorGUILayout.EndHorizontal();

                if (vrcConvert)
                {
                    Debug.Log("VRC to Interm Engaged");
                    IntermediateAvatar.Converter.ToIA.VRChat.Convert(VRCAvatar, makeDuplicate, duplicateAnimators, convertBones);
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