using System.Collections;
using System.Collections.Generic;
using System;
using UnityEngine;
using UnityEngine.UIElements;
#if UNITY_EDITOR
using UnityEditor;
using UnityEditor.Animations;
#endif
using Voy.IntermediateAvatar;

#if UNITY_EDITOR

namespace Voy.IntermediateAvatar.Components
{
    public class IAAvatar : MonoBehaviour
    {
        public Vector3 Viewpoint = new Vector3(0, 0, 0);

        // Lipsync Time!

        public Renderer VisemeMesh; // Will be used as Face Mesh, nothing else will be supported in CVR. There will be logic to check.
        // CVR and VRC do not support the use of Mesh Renders, this is just for potential future proofing for if any other game sdks are supported.
        public enum LipsyncMode : int
        {
            None,
            JawFlap,
            JawBone,
            Viseme
        }

        public LipsyncMode lipsyncMode;

        public Transform LipSyncJawBone;
        public Quaternion LipSyncJawClosedRotation = new Quaternion(0, 0, 0, 1);
        public Quaternion LipSyncJawOpenRotation = new Quaternion(0, 0, 0, 1);
        public string LipSyncJawBlendShape;
        public string[] VisemeBlendShapes = new string[15];

        // EyeLook Settings
        public bool UseEyeLook;

        //CVR does not support any Eye Bone Look beyond this, setup is needed on the Rig in Unity!
        public Transform LeftEyeBone;
        public Transform RightEyeBone;

        public float EyeConfidence = 0.2f;
        public float EyeExcitement = 0.2f;
        // I have no idea what these do and I assume these will never be supported in CVR, storing anyway.

        public EyeDirection EyeLookStraight;
        public EyeDirection EyeLookUp;
        public EyeDirection EyeLookDown;
        public EyeDirection EyeLookLeft;
        public EyeDirection EyeLookRight;

        //Eyelid Time!
        //CVR only supports Blinking and does not support Look Up/Look Down, Storing Anyway!
        public enum EyelidType : int
        {
            None,
            Bones, // Not Supported in CVR
            Blendshapes
        }

        public EyelidType eyelidType;

        public EyeLid EyelidsDefault;
        public EyeLid EyelidsClosed;
        public EyeLid EyelidsLookUp;
        public EyeLid EyelidsLookDown;

        public Renderer EyelidBlendshapeMesh; //Not supported in CVR, will if not same will not enable.
        public int[] EyelidsBlendshapes = new int[3]; //Seems this uses Index instead of string name? Interesting... probably faster.

        public AvatarAnimatorDefinition[] BaseAnimatorLayers;
        public AvatarAnimatorDefinition[] SpecialAnimatorLayers;

        public List<MenuSystem.Parameter> Parameters = new List<MenuSystem.Parameter>();

        public List<MenuSystem.Option> OptionsSettings = new List<MenuSystem.Option>();

        public AnimatorCombinerDefinition GetCombinerDefinition(AnimatorType type)
        {
            AnimatorCombinerDefinition combiner = new AnimatorCombinerDefinition();
            combiner.type = type;
            foreach (AvatarAnimatorDefinition definition in BaseAnimatorLayers)
            {
                bool isType = (definition.type == type);
                bool isValid = (definition.animator != null);
                if (isType & isValid)
                {
                    combiner.runtimeAnimatorControllers.Add(definition.animator);

                }
            }

            if (combiner.runtimeAnimatorControllers.Count <= 0) return null;

            return combiner;

        }

    }


    [Serializable]
    public class EyeDirection
    {
        public bool Linked = true;
        public Quaternion Left = new Quaternion(0, 0, 0, 1);
        public Quaternion Right = new Quaternion(0, 0, 0, 1);
    }

    [Serializable]
    public class EyeLid
    {
        public EyeDirection Upper = new();
        public EyeDirection Lower = new();
    }

    [Serializable]

    public enum AnimatorType : int
    {
        Base = 0, // Not Supported, only here to ensure data is not lost
        Additive = 1,
        Gesture = 2,
        FX = 3,
        Sitting = 4, // Not supported
        TPose = 5, // Not Supported
        IKPose = 6, // Not Supported
        Action = 7,
        GameDefault = 100,
        iaLoco = 200,
        iaGesture = 201,
        iaEmote = 202
    }

    [Serializable]
    public class AvatarAnimatorDefinition
    {
        public RuntimeAnimatorController animator;
        public AnimatorType type;
        public string fromGame;
    }

    public class AnimatorCombinerDefinition
    {
        public AnimatorType type;
        public List<RuntimeAnimatorController> runtimeAnimatorControllers = new List<RuntimeAnimatorController>();

        public List<UnityEditor.Animations.AnimatorController> GetAnimatorControllers()
        {

            List<AnimatorController> trueControllers = new List<AnimatorController>();
            foreach (RuntimeAnimatorController runController in runtimeAnimatorControllers)
            {
                UnityEditor.Animations.AnimatorController controller = Utils.AnimatorHelper.GetAnimator(runController);
                trueControllers.Add(controller);
            }

            return trueControllers;
        }

    }

#if UNITY_EDITOR

    [SerializeField]
    [CustomEditor(typeof(IAAvatar))]
    class IntermAvatarEditor : Editor
    {

        bool showDebug = false;
        bool convertVRCActionLayer = false;
        bool convertVRCHandLayer = false;
        public override void OnInspectorGUI()
        {
#if UDON
            EditorGUILayout.HelpBox("The VRC World SDK is Present in your Project, please ensure you have the VRC Avatar SDK Present in the Project too.", MessageType.Warning);
            EditorGUILayout.Space();
#endif
            RenderConversion();

            EditorGUILayout.Space();

            showDebug = EditorGUILayout.ToggleLeft("Show Debug Info", showDebug);

            if (showDebug)
            {

                DrawDefaultInspector();

            }
        }

        public void RenderConversion()
        {
            bool canConvert = false;



#if VRC_SDK_VRCSDK3
            canConvert = true;
#endif

#if CVR_CCK_EXISTS
            canConvert = true;
#endif

            int indentDefault = EditorGUI.indentLevel;
            EditorGUI.indentLevel += 1;

            if (canConvert) EditorGUILayout.LabelField("Convert to...");

            VRCButton();

            CVRButton();





            //GUILayout.EndVertical();
            EditorGUI.indentLevel = indentDefault;

        }

        public void VRCButton()
        {
#if VRC_SDK_VRCSDK3
            /*
            if (GUILayout.Button("VRChat SDK3 Avatar"))
            {

                Debug.Log("Clicked");

            }
            */
#endif
        }

        public void CVRButton()
        {
#if CVR_CCK_EXISTS
            if (GUILayout.Button("ChilloutVR Avatar"))
            {
                MonoBehaviour bev = (MonoBehaviour)target;
                Voy.IntermediateAvatar.Converter.FromIA.ChilloutVR.Convert(bev.GetComponent<IAAvatar>(), true, true, convertVRCActionLayer, convertVRCHandLayer);
                Debug.Log("CVR Button Clicked");

            }

            EditorGUILayout.LabelField("The following aren't recommended and may not work as desired:");
            convertVRCActionLayer = EditorGUILayout.ToggleLeft("Convert VRC Action/Emote Layer", convertVRCActionLayer);
            convertVRCHandLayer = EditorGUILayout.ToggleLeft("Convert VRC Hand Layers", convertVRCHandLayer);

#endif
        }
    }

#endif
}

#endif