using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Linq;

#if UNITY_EDITOR
using Voy.IntermediateAvatar.Components;
using Voy.IntermediateAvatar.Behaviours;
using Voy.IntermediateAvatar.Utils;
using Voy.IntermediateAvatar;
using UnityEditor;
using UnityEditor.Animations;
#endif

#if VRC_SDK_VRCSDK3
using VRC.SDK3.Avatars.Components;
using VRC.SDK3.Dynamics.Contact.Components;
using VRC.SDK3.Avatars.ScriptableObjects;
using VRC.SDKBase;
#endif

#if UNITY_EDITOR && VRC_SDK_VRCSDK3

namespace Voy.IntermediateAvatar.Converter.ToIA
{

    public static class VRChat
    {

        public static void Convert(VRCAvatarDescriptor _vrcAvatar, bool makeDuplicate = false, bool makeDuplicateFiles = false, bool convertBones = false)
        {
            //Preamble
            VRCAvatarDescriptor vrcAvatar = _vrcAvatar;

            if (makeDuplicate)
            {
                vrcAvatar = Object.Instantiate(_vrcAvatar);
                Utils.AssetCopier.CopyAssets(vrcAvatar.gameObject, "Assets/IntermAssets/PreProcessed", makeDuplicateFiles);
                _vrcAvatar.gameObject.SetActive(false);
            }

            GameObject gameObject = vrcAvatar.gameObject;
            IAAvatar iaAvatar = gameObject.AddComponent<IAAvatar>();

            //Lipsync
            ToIA.VRChat.LipsyncResolver(vrcAvatar, iaAvatar);
            iaAvatar.Viewpoint = vrcAvatar.ViewPosition;
            iaAvatar.VisemeMesh = vrcAvatar.VisemeSkinnedMesh;
            iaAvatar.VisemeBlendShapes = vrcAvatar.VisemeBlendShapes;
            iaAvatar.LipSyncJawBlendShape = vrcAvatar.MouthOpenBlendShapeName;
            iaAvatar.LipSyncJawBone = vrcAvatar.lipSyncJawBone;
            iaAvatar.LipSyncJawClosedRotation = vrcAvatar.lipSyncJawClosed;
            iaAvatar.LipSyncJawOpenRotation = vrcAvatar.lipSyncJawOpen;

            //Eyelook
            ToIA.VRChat.EyelookResolver(vrcAvatar, iaAvatar);

            //Animators
            ToIA.VRChat.ResolveAnimators(vrcAvatar, iaAvatar);

            //Process Animators
            ProcessAnimators(iaAvatar);

            //Process Components
            ProcessComponents(vrcAvatar, iaAvatar);

            //Process Parameters
            ProcessParameters(vrcAvatar, iaAvatar);

            //Process Menu
            ProcessMenu(vrcAvatar, iaAvatar);

            //Cleanup
            VRC.Core.PipelineManager pipelinemanager = gameObject.GetComponent<VRC.Core.PipelineManager>();
            if (pipelinemanager != null) { Object.DestroyImmediate(pipelinemanager); }
            Object.DestroyImmediate(vrcAvatar);

            
        }

        public static void ProcessMenuControls(VRCExpressionsMenu vrcMenu, IAAvatar iaAvatar, List<string> subMenuHistory = default(List<string>))
        {

            foreach (VRCExpressionsMenu.Control control in vrcMenu.controls)
            {
                bool isButton = control.type == VRCExpressionsMenu.Control.ControlType.Button;
                bool isToggle = control.type == VRCExpressionsMenu.Control.ControlType.Toggle;
                bool isSubMenu = control.type == VRCExpressionsMenu.Control.ControlType.SubMenu;
                bool isTwoAxisPuppet = control.type == VRCExpressionsMenu.Control.ControlType.TwoAxisPuppet;
                bool isFourAxisPuppet = control.type == VRCExpressionsMenu.Control.ControlType.FourAxisPuppet;
                bool isRadial = control.type == VRCExpressionsMenu.Control.ControlType.RadialPuppet;
                bool mainParameterValid = control.parameter != null && control.parameter.name != "";
                bool hasSubParameters = control.subParameters.Length > 0;
                bool typeUsesSubParams = isTwoAxisPuppet | isFourAxisPuppet | isRadial;
                //bool typeUsesMainValue = (isButton | isToggle | isSubMenu);

                if (control.type == VRCExpressionsMenu.Control.ControlType.SubMenu)
                {
                    Debug.Log("Control is SubMenu, Processing");
                    List<string> workingSubMenuHistory = new List<string>();
                    if (subMenuHistory != null && subMenuHistory.Count > 0) workingSubMenuHistory.Concat(subMenuHistory);
                    workingSubMenuHistory.Add(control.name);
                    ProcessMenuControls(control.subMenu, iaAvatar, workingSubMenuHistory);
                }

                if (mainParameterValid)
                {
                    if (control.parameter.name == "VRCEmote" | control.parameter.name == "VRCFaceBlendH" | control.parameter.name == "VRCFaceBlendV")
                    {
                        Debug.Log("Parameter is Default VRC, not creating Menu Option");
                        continue;
                    }
                }

                if (mainParameterValid | hasSubParameters)
                {
                    Debug.Log("Control uses Parameters");
                    MenuSystem.Option option = new();

                    if (mainParameterValid)
                    {
                        Debug.Log("Control uses Main Parameter");
                        option.MainParameter = control.parameter.name;
                        option.Value = control.value;
                        if (isSubMenu && mainParameterValid) option.Value = 1f;
                    }
                    option.Name = control.name;
                    option.SubMenuHistory = subMenuHistory;

                    if (hasSubParameters)
                    {
                        Debug.Log("Control uses Sub Parameters");
                        if (isTwoAxisPuppet)
                        {
                            Debug.Log("Control is Two Axis Puppet");
                            option.JoystickRightXParameter = control.subParameters[0].name;
                            option.JoystickUpYParameter = control.subParameters[1].name;
                        }
                        else if (isFourAxisPuppet)
                        {
                            Debug.Log("Control is Four Axis Puppet");
                            option.JoystickUpYParameter = control.subParameters[0].name;
                            option.JoystickRightXParameter = control.subParameters[1].name;
                            option.JoystickDownYParameter = control.subParameters[2].name;
                            option.JoystickLeftXParameter = control.subParameters[3].name;
                        }
                        else if (isRadial)
                        {
                            Debug.Log("Control is Radial");
                            option.SliderParameter = control.subParameters[0].name;
                        }
                    }

                    Debug.Log("Setting Type...");


                    // I tried using a Switch Statement here but it caused a bug in the loop.
                    if (isButton)
                    {
                        option.optionType = MenuSystem.Option.OptionType.Button;
                        Debug.Log("Type: Button");
                    }
                    else if (isTwoAxisPuppet)
                    {
                        Debug.Log("Type: Joystick 2D");
                        option.optionType = MenuSystem.Option.OptionType.Joystick2D;
                    }
                    else if (isFourAxisPuppet)
                    {
                        Debug.Log("Type: 4 Axis Joystick 2D");
                        option.optionType = MenuSystem.Option.OptionType.Joystick4Axis;
                    }
                    else if (isRadial)
                    {
                        Debug.Log("Type: Slider");
                        option.optionType = MenuSystem.Option.OptionType.Slider;
                    }
                    else
                    {
                        Debug.Log("Type: Toggle");
                        option.optionType = MenuSystem.Option.OptionType.Toggle;
                    }

                    //subOptions.Add(option);
                    //options.Concat(subOptions);
                    Debug.Log("Adding Option to List");

                    iaAvatar.OptionsSettings.Add(option);

                    string DebugStringOutput;
                    DebugStringOutput = "Option Named " + option.Name;
                    DebugStringOutput += " of Type " + option.optionType.ToString();
                    if (option.MainParameter != "") DebugStringOutput += " using Parameter Named " + option.MainParameter;
                    DebugStringOutput += " Has been Added.";
                    Debug.Log(DebugStringOutput);
                }

            }

            Debug.Log("Finished with Options");
        }

        public static void ProcessMenu(VRCAvatarDescriptor vrcAvatar, IAAvatar iaAvatar)
        {
            if (!vrcAvatar.customExpressions | vrcAvatar.expressionsMenu == null)
            {
                Debug.Log("Expressions Disabled or Menu Not Present, not Processing Menu");
            }

            ProcessMenuControls(vrcAvatar.expressionsMenu, iaAvatar);

        }

        public static void ProcessParameters(VRCAvatarDescriptor vrcAvatar, IAAvatar iaAvatar)
        {
            if (!vrcAvatar.customExpressions | vrcAvatar.expressionParameters == null) return;

            VRCExpressionParameters vrcParams = vrcAvatar.expressionParameters;

            foreach (VRCExpressionParameters.Parameter vrcParam in vrcParams.parameters)
            {
                Voy.IntermediateAvatar.MenuSystem.Parameter iaParam = new();

                iaParam.Name = vrcParam.name;
                iaParam.Local = !vrcParam.networkSynced;
                iaParam.DefaultValue = vrcParam.defaultValue;
                
                switch (vrcParam.valueType)
                {
                    case VRCExpressionParameters.ValueType.Int:
                        iaParam.Type = MenuSystem.Parameter.ParameterType.Int;
                        break;
                    case VRCExpressionParameters.ValueType.Bool:
                        iaParam.Type = MenuSystem.Parameter.ParameterType.Bool;
                        break;
                    default:
                        iaParam.Type = MenuSystem.Parameter.ParameterType.Float;
                        break;
                }

                iaAvatar.Parameters.Add(iaParam);
            }

        }

        public static void ProcessComponents(VRCAvatarDescriptor vrcAvatar, IAAvatar iaAvatar)
        {

            GameObject mainGO = vrcAvatar.gameObject;

            List<Component> components = mainGO.GetComponentsInChildren(typeof(Component), true).ToList<Component>();

            foreach (Component component in components)
            {
                bool yeet = false;

                GameObject workGO = component.gameObject;
                if (component.GetType() == typeof(VRCContactSender))
                {
                    VRCContactSender vrcSender = (VRCContactSender)component;
                    IAContactSender iaConnector = workGO.AddComponent<IAContactSender>();
                    iaConnector.CollisionTags = vrcSender.collisionTags;
                    iaConnector.RootTransform = vrcSender.rootTransform;
                    iaConnector.Radius = vrcSender.radius;
                    iaConnector.Height = vrcSender.height;
                    iaConnector.Position = vrcSender.position;
                    iaConnector.Rotation = vrcSender.rotation;
                    iaConnector.ShapeType = ResolveShapeType(vrcSender.shapeType);

                    yeet = true;
                }

                if (component.GetType() == typeof(VRCContactReceiver))
                {
                    VRCContactReceiver vrcReciever = (VRCContactReceiver)component;
                    IAContactReciever iaPad = workGO.AddComponent<IAContactReciever>();
                    iaPad.CollisionTags = vrcReciever.collisionTags;
                    iaPad.RootTransform = vrcReciever.rootTransform;
                    iaPad.Radius = vrcReciever.radius;
                    iaPad.Height = vrcReciever.height;
                    iaPad.Position = vrcReciever.position;
                    iaPad.Rotation = vrcReciever.rotation;
                    iaPad.ShapeType = ResolveShapeType(vrcReciever.shapeType);
                    iaPad.AllowSelf = vrcReciever.allowSelf;
                    iaPad.AllowOthers = vrcReciever.allowOthers;
                    iaPad.LocalOnly = vrcReciever.localOnly;
                    iaPad.Parameter = vrcReciever.parameter;
                    iaPad.ReceiverType = ResolveRecieverType(vrcReciever.receiverType);
                    iaPad.MinVelocity = vrcReciever.minVelocity;

                    yeet = true;
                }

                if (yeet)
                {
                    Object.DestroyImmediate(component);
                }

            }


        }

        public static ReceiverTypeEnum ResolveRecieverType(VRC.Dynamics.ContactReceiver.ReceiverType receiverType)
        {
            switch (receiverType)
            {
                case VRC.Dynamics.ContactReceiver.ReceiverType.Constant:
                    return ReceiverTypeEnum.Constant;
                case VRC.Dynamics.ContactReceiver.ReceiverType.Proximity:
                    return ReceiverTypeEnum.Proximity;
                default:
                    return ReceiverTypeEnum.OnEnter;
            }
        }

        public static ShapeTypes ResolveShapeType(VRC.Dynamics.ContactBase.ShapeType shapeType)
        {
            switch (shapeType)
            {
                case VRC.Dynamics.ContactBase.ShapeType.Capsule:
                    return ShapeTypes.Capsule;
                default:
                    return ShapeTypes.Sphere;
            }
        }

        private static List<AvatarAnimatorDefinition> GetControllerDef(Dictionary<AnimatorType, List<AnimatorController>> controllers, string startOfSavePath)
        {
            List<AvatarAnimatorDefinition> newDefList = new();

            foreach (var item in controllers)
            {
                List<AnimatorType> types = new();

                while (types.Count < item.Value.Count) // this feels jank but I don't care rn.
                {
                    types.Add(item.Key);
                }

                AvatarAnimatorDefinition newDef = new();

                AnimatorController newCon = AnimatorRebuilder.ProcessAndMerge(item.Value, types, GetToIARenameDefinitions(), AnimatorRebuilder.Mode.ToIA);

                if (newCon == null) continue;

                // Save Asset
                {
                    string animatorSavePath = startOfSavePath + "ia" + item.Key.ToString() + ".controller";

                    bool animatorSavePathValid = DirectoryCreator.CreateDirectoryIfNotExists(animatorSavePath);

                    if (!animatorSavePathValid)
                    {
                        Debug.LogError("\"Could not make path: " + animatorSavePath);
                        continue;
                    }

                    AssetDatabase.CreateAsset(newCon, AssetDatabase.GenerateUniqueAssetPath(animatorSavePath));
                }

                newDef.animator = newCon;
                newDef.fromGame = "VRChat";
                newDef.type = item.Key;

                newDefList.Add(newDef);
            }

            return newDefList;
        }

        public static void ProcessAnimators(IAAvatar iaAvatar)
        {
            string startOfSavePath = "Assets/IntermAssets/Processed/IntermAvatar/" + UnityEditor.SceneManagement.EditorSceneManager.GetActiveScene().name + "/" + iaAvatar.gameObject.name + "/vrc";

            Dictionary<AnimatorType, List<AnimatorController>> baseControllers = new();
            Dictionary<AnimatorType, List<AnimatorController>> specialControllers = new();

            // Populate Dictonaries
            {
                foreach (AvatarAnimatorDefinition avatarAnimator in iaAvatar.BaseAnimatorLayers)
                {
                    // if key exists, add to it. Else create key and add current animator to it.
                    if (baseControllers.ContainsKey(avatarAnimator.type))
                    {
                        // add to key
                        baseControllers[avatarAnimator.type].Add(AssetDatabase.LoadAssetAtPath<AnimatorController>(AssetDatabase.GetAssetPath(avatarAnimator.animator)));
                        continue;
                    }
                    else
                    {
                        // create key and add animator to it
                        baseControllers.Add(avatarAnimator.type, new() { AssetDatabase.LoadAssetAtPath<AnimatorController>(AssetDatabase.GetAssetPath(avatarAnimator.animator)) });
                        continue;
                    }
                }

                foreach (AvatarAnimatorDefinition avatarAnimator in iaAvatar.SpecialAnimatorLayers)
                {
                    // if key exists, add to it. Else create key and add current animator to it.
                    if (specialControllers.ContainsKey(avatarAnimator.type))
                    {
                        // add to key
                        specialControllers[avatarAnimator.type].Add(AssetDatabase.LoadAssetAtPath<AnimatorController>(AssetDatabase.GetAssetPath(avatarAnimator.animator)));
                        continue;
                    }
                    else
                    {
                        // create key and add animator to it.
                        specialControllers.Add(avatarAnimator.type, new() { AssetDatabase.LoadAssetAtPath<AnimatorController>(AssetDatabase.GetAssetPath(avatarAnimator.animator)) });
                        continue;
                    }
                }
            }

            iaAvatar.BaseAnimatorLayers = GetControllerDef(baseControllers, startOfSavePath).ToArray();
            iaAvatar.SpecialAnimatorLayers = GetControllerDef(specialControllers, startOfSavePath).ToArray();
        }

        public static void ProcessAnimator(AnimatorController animatorController)
        {
            if (animatorController == null)
            {
                Debug.LogError("Animator Controller is not assigned.");
                return;
            }

            ProcessAnimatorLayers(animatorController.layers);
        }

        private static void ProcessAnimatorLayers(AnimatorControllerLayer[] layers)
        {
            foreach (var layer in layers)
            {
                Debug.Log(layer.name);
                foreach (var stateMachine in layer.stateMachine.stateMachines)
                {
                    ProcessAnimatorStateMachines(stateMachine.stateMachine);
                }

                ProcessAnimatorStateMachines(layer.stateMachine);
            }
        }

        private static void ProcessAnimatorStateMachines(AnimatorStateMachine stateMachine)
        {
            foreach (var state in stateMachine.states)
            {
                    ProcessBehaviours(state.state);
            }

            foreach (var subStateMachine in stateMachine.stateMachines)
            {
                ProcessAnimatorStateMachines(subStateMachine.stateMachine);
            }
        }

        public static List<RenameDefinition> GetToIARenameDefinitions()
        {
            List<RenameDefinition> renameDefinitions = new();

            renameDefinitions.Add(
                new RenameDefinition()
                {
                    oldName = "Seated",
                    newName = "Sitting",
                    ignoreAnimatorType = AnimatorType.GameDefault
                }
                );
            renameDefinitions.Add(
                new RenameDefinition()
                {
                    oldName = "GestureLeft",
                    newName = "#iaLeftGesture",
                    ignoreAnimatorType = AnimatorType.GameDefault
                }
                );
            renameDefinitions.Add(
                new RenameDefinition()
                {
                    oldName = "GestureRight",
                    newName = "#iaRightGesture",
                    ignoreAnimatorType = AnimatorType.GameDefault
                }
                );

            return renameDefinitions;
        }

        public static List<StateMachineBehaviour> ProcessBehaviours(StateMachineBehaviour[] behaviours)
        {
            List<StateMachineBehaviour> newBehaviours = new List<StateMachineBehaviour>();

            RenameDefinition[] renames = AnimatorRebuilder.GetRenames();

            foreach (StateMachineBehaviour behaviour in behaviours)
            {
                if (behaviour.GetType() == typeof(VRCAvatarParameterDriver))
                {
                    Debug.Log("Processing VRC Avatar Parameter Driver");
                    VRCAvatarParameterDriver vrcDriver = (VRCAvatarParameterDriver)behaviour;
                    IAParameterDriver iaDriver = ScriptableObject.CreateInstance<IAParameterDriver>();

                    iaDriver.Tasks = new List<Task>();

                    foreach (VRC_AvatarParameterDriver.Parameter vrcParam in vrcDriver.parameters)
                    {
                        Task iaTask = new()
                        {
                            Dest = vrcParam.name,
                            Val = vrcParam.value,
                            Src = vrcParam.source,
                            RandomMax = vrcParam.valueMax
                        };

                        switch (vrcParam.type)
                        {
                            case VRC_AvatarParameterDriver.ChangeType.Set:
                                iaTask.Type = Behaviours.TypeList.Set;
                                break;
                            case VRC_AvatarParameterDriver.ChangeType.Add:
                                iaTask.Type = Behaviours.TypeList.Add;
                                break;
                            case VRC_AvatarParameterDriver.ChangeType.Random:
                                iaTask.Type = Behaviours.TypeList.Random;
                                break;
                            case VRC_AvatarParameterDriver.ChangeType.Copy:
                                iaTask.Type = Behaviours.TypeList.Copy;
                                break;
                        }

                        iaDriver.Tasks.Add(iaTask);

                    }

                    newBehaviours.Add(iaDriver);
                }

                if (behaviour.GetType() == typeof(VRCAnimatorTrackingControl))
                {

                    VRCAnimatorTrackingControl vrcTrack = (VRCAnimatorTrackingControl)behaviour;
                    IATrackingControl iaTrack = ScriptableObject.CreateInstance<IATrackingControl>();

                    iaTrack.Eyes = ResolveBEHTrack(vrcTrack.trackingEyes);
                    iaTrack.Head = ResolveBEHTrack(vrcTrack.trackingHead);
                    iaTrack.Hip = ResolveBEHTrack(vrcTrack.trackingHip);
                    iaTrack.LeftHand = ResolveBEHTrack(vrcTrack.trackingLeftHand);
                    iaTrack.LeftFingers = ResolveBEHTrack(vrcTrack.trackingLeftFingers);
                    iaTrack.LeftFoot = ResolveBEHTrack(vrcTrack.trackingLeftFoot);
                    iaTrack.RightHand = ResolveBEHTrack(vrcTrack.trackingRightHand);
                    iaTrack.RightFingers = ResolveBEHTrack(vrcTrack.trackingRightFingers);
                    iaTrack.RightFoot = ResolveBEHTrack(vrcTrack.trackingRightFoot);
                    iaTrack.Mouth = ResolveBEHTrack(vrcTrack.trackingMouth);

                    newBehaviours.Add(iaTrack);

                }
            }

            return newBehaviours;

        }

        private static void ProcessBehaviours(AnimatorState state)
        {
            List<StateMachineBehaviour> newBehaviours = new List<StateMachineBehaviour> { };

            foreach (var behaviour in state.behaviours)
            {
                //Debug.Log(behaviour.GetType().ToString());


                // VRCAvatarParameterDriver
                if (behaviour.GetType() == typeof(VRCAvatarParameterDriver))
                {
                    Debug.Log("Processing VRC Avatar Parameter Driver");
                    VRCAvatarParameterDriver vrcDriver = (VRCAvatarParameterDriver)behaviour;
                    IAParameterDriver iaDriver = ScriptableObject.CreateInstance<IAParameterDriver>();

                    iaDriver.Tasks = new List<Task>();

                    foreach (VRC_AvatarParameterDriver.Parameter vrcParam in vrcDriver.parameters)
                    {
                        Task iaTask = new()
                        {
                            Dest = vrcParam.name,
                            Val = vrcParam.value,
                            Src = vrcParam.source,
                            RandomMax = vrcParam.valueMax
                        };

                        switch (vrcParam.type)
                        {
                            case VRC_AvatarParameterDriver.ChangeType.Set:
                                iaTask.Type = Behaviours.TypeList.Set;
                                break;
                            case VRC_AvatarParameterDriver.ChangeType.Add:
                                iaTask.Type = Behaviours.TypeList.Add;
                                break;
                            case VRC_AvatarParameterDriver.ChangeType.Random:
                                iaTask.Type = Behaviours.TypeList.Random;
                                break;
                            case VRC_AvatarParameterDriver.ChangeType.Copy:
                                iaTask.Type = Behaviours.TypeList.Copy;
                                break;
                        }

                        iaDriver.Tasks.Add(iaTask);

                    }

                    newBehaviours.Add(iaDriver);
                }

                if (behaviour.GetType() == typeof(VRCAnimatorTrackingControl))
                {

                    VRCAnimatorTrackingControl vrcTrack = (VRCAnimatorTrackingControl)behaviour;
                    IATrackingControl iaTrack = ScriptableObject.CreateInstance<IATrackingControl>();

                    iaTrack.Eyes = ResolveBEHTrack(vrcTrack.trackingEyes);
                    iaTrack.Head = ResolveBEHTrack(vrcTrack.trackingHead);
                    iaTrack.Hip = ResolveBEHTrack(vrcTrack.trackingHip);
                    iaTrack.LeftHand = ResolveBEHTrack(vrcTrack.trackingLeftHand);
                    iaTrack.LeftFingers = ResolveBEHTrack(vrcTrack.trackingLeftFingers);
                    iaTrack.LeftFoot = ResolveBEHTrack(vrcTrack.trackingLeftFoot);
                    iaTrack.RightHand = ResolveBEHTrack(vrcTrack.trackingRightHand);
                    iaTrack.RightFingers = ResolveBEHTrack(vrcTrack.trackingRightFingers);
                    iaTrack.RightFoot = ResolveBEHTrack(vrcTrack.trackingRightFoot);
                    iaTrack.Mouth = ResolveBEHTrack(vrcTrack.trackingMouth);

                    newBehaviours.Add(iaTrack);

                }
            }
            state.behaviours = newBehaviours.ToArray();
            Debug.Log(state.behaviours.ToString());
        }

        public static IATrackingControl.Tracking ResolveBEHTrack(VRCAnimatorTrackingControl.TrackingType vrcTrackType)
        {

            switch (vrcTrackType)
            {
                case VRC_AnimatorTrackingControl.TrackingType.Tracking:
                    return IATrackingControl.Tracking.Tracking;
                case VRC_AnimatorTrackingControl.TrackingType.Animation:
                    return IATrackingControl.Tracking.Animation;
                default:
                    return IATrackingControl.Tracking.NoChange;
            }

        }

        public static void LipsyncResolver(VRCAvatarDescriptor vrcAvatar, IAAvatar iaAvatar)
        {

            switch(vrcAvatar.lipSync)
            {
                case VRC_AvatarDescriptor.LipSyncStyle.VisemeBlendShape:
                    iaAvatar.lipsyncMode = IAAvatar.LipsyncMode.Viseme;
                    break;
                case VRC_AvatarDescriptor.LipSyncStyle.JawFlapBlendShape:
                    iaAvatar.lipsyncMode = IAAvatar.LipsyncMode.JawFlap;
                    break;
                case VRC_AvatarDescriptor.LipSyncStyle.JawFlapBone:
                    iaAvatar.lipsyncMode = IAAvatar.LipsyncMode.JawBone;
                    break;
                default:
                    iaAvatar.lipsyncMode = IAAvatar.LipsyncMode.None;
                    break;
            }

        }

        public static void EyelidResolver(VRCAvatarDescriptor vrcAvatar, IAAvatar iaAvatar)
        {
            VRCAvatarDescriptor.CustomEyeLookSettings vrcEyes = vrcAvatar.customEyeLookSettings;
            switch (vrcAvatar.customEyeLookSettings.eyelidType)
            {
                case VRCAvatarDescriptor.EyelidType.Bones:
                    iaAvatar.eyelidType = IAAvatar.EyelidType.Bones;
                    iaAvatar.LeftEyeBone = vrcEyes.leftEye;
                    iaAvatar.RightEyeBone = vrcEyes.rightEye;
                    break;
                case VRCAvatarDescriptor.EyelidType.Blendshapes:
                    iaAvatar.eyelidType = IAAvatar.EyelidType.Blendshapes;
                    break;
                default:
                    iaAvatar.eyelidType = IAAvatar.EyelidType.None;
                    break;
            }
        }

        public static void EyelookResolver(VRCAvatarDescriptor vrcAvatar, IAAvatar iaAvatar)
        {
            iaAvatar.UseEyeLook = vrcAvatar.enableEyeLook;

            VRCAvatarDescriptor.CustomEyeLookSettings eyesVRC = vrcAvatar.customEyeLookSettings;

            if (eyesVRC.Equals(null)) return;

            iaAvatar.EyeConfidence = eyesVRC.eyeMovement.confidence;
            iaAvatar.EyeExcitement = eyesVRC.eyeMovement.excitement;
            iaAvatar.EyelidBlendshapeMesh = eyesVRC.eyelidsSkinnedMesh;
            iaAvatar.EyelidsBlendshapes = eyesVRC.eyelidsBlendshapes;

            //
            
            // Eye Bone Stuff

            // if Eye Bone stuff is commented out, it means it doesn't resolve for lord only knows what reason.
            // spent too much time debugging. Object is not an instance of a object. I'm done debugging this today.

            if (eyesVRC.eyesLookingUp != null)
            iaAvatar.EyeLookUp = EyeRotationConverter(eyesVRC.eyesLookingUp);

            if (eyesVRC.eyesLookingDown != null)
            iaAvatar.EyeLookDown = EyeRotationConverter(eyesVRC.eyesLookingDown);

            if (eyesVRC.eyesLookingLeft != null)
            iaAvatar.EyeLookLeft = EyeRotationConverter(eyesVRC.eyesLookingLeft);

            if (eyesVRC.eyesLookingRight != null)
            iaAvatar.EyeLookRight = EyeRotationConverter(eyesVRC.eyesLookingRight);

            EyelidResolver(vrcAvatar, iaAvatar);

            if (eyesVRC.eyelidsLookingUp != null)
            {
                if (iaAvatar.EyelidsLookUp == null) iaAvatar.EyelidsLookUp = new();

                if (iaAvatar.EyelidsLookUp.Lower == null) iaAvatar.EyelidsLookUp.Lower = new();
                if (iaAvatar.EyelidsLookUp.Upper == null) iaAvatar.EyelidsLookUp.Upper = new();

                if (eyesVRC.eyelidsLookingUp.lower != null)
                iaAvatar.EyelidsLookUp.Lower = EyeRotationConverter(eyesVRC.eyelidsLookingUp.lower);

                if (eyesVRC.eyelidsLookingUp.upper != null)
                iaAvatar.EyelidsLookUp.Upper = EyeRotationConverter(eyesVRC.eyelidsLookingUp.upper);
            }

            if (eyesVRC.eyelidsLookingDown != null)
            {
                if (iaAvatar.EyelidsLookDown == null) iaAvatar.EyelidsLookDown = new();

                if (iaAvatar.EyelidsLookDown.Lower == null) iaAvatar.EyelidsLookDown.Lower = new();
                if (iaAvatar.EyelidsLookDown.Upper == null) iaAvatar.EyelidsLookDown.Upper = new();

                if (eyesVRC.eyelidsLookingDown.lower != null)
                iaAvatar.EyelidsLookDown.Lower = EyeRotationConverter(eyesVRC.eyelidsLookingDown.lower);

                if (eyesVRC.eyelidsLookingDown.upper != null)
                iaAvatar.EyelidsLookDown.Upper = EyeRotationConverter(eyesVRC.eyelidsLookingDown.upper);
            }
            
        }

        public static EyeDirection EyeRotationConverter(VRCAvatarDescriptor.CustomEyeLookSettings.EyeRotations eyeRotations)
        {
            EyeDirection eyeDir = new();
            eyeDir.Linked = eyeRotations.linked;
            eyeDir.Left = eyeRotations.left;
            eyeDir.Right = eyeRotations.right;

            return eyeDir;
        }

        public static void ResolveAnimators(VRCAvatarDescriptor vrcAvatar, IAAvatar iaAvatar)
        {
            List<AvatarAnimatorDefinition> iaBaseAnimators = new List<AvatarAnimatorDefinition>();
            List<AvatarAnimatorDefinition> iaSpecialAnimators = new List<AvatarAnimatorDefinition>();

            foreach (VRCAvatarDescriptor.CustomAnimLayer animLayer in vrcAvatar.baseAnimationLayers)
            {

                AvatarAnimatorDefinition animDefIA = new AvatarAnimatorDefinition();
                animDefIA.animator = animLayer.animatorController;

                switch (animLayer.type)
                {
                    case VRCAvatarDescriptor.AnimLayerType.FX:
                        animDefIA.type = AnimatorType.FX;
                        break;
                    case VRCAvatarDescriptor.AnimLayerType.Base:
                        animDefIA.type = AnimatorType.Base;
                        break;
                    case VRCAvatarDescriptor.AnimLayerType.Additive:
                        animDefIA.type = AnimatorType.Additive;
                        break;
                    case VRCAvatarDescriptor.AnimLayerType.Gesture:
                        animDefIA.type = AnimatorType.Gesture;
                        break;
                    case VRCAvatarDescriptor.AnimLayerType.Action:
                        animDefIA.type = AnimatorType.Action;
                        break;
                }

                iaBaseAnimators.Add(animDefIA);

            }

            foreach (VRCAvatarDescriptor.CustomAnimLayer animLayer in vrcAvatar.specialAnimationLayers)
            {

                AvatarAnimatorDefinition animDefIA = new AvatarAnimatorDefinition();
                animDefIA.animator = animLayer.animatorController;

                switch (animLayer.type)
                {
                    case VRCAvatarDescriptor.AnimLayerType.IKPose:
                        animDefIA.type = AnimatorType.IKPose;
                        break;
                    case VRCAvatarDescriptor.AnimLayerType.Sitting:
                        animDefIA.type = AnimatorType.Sitting;
                        break;
                    case VRCAvatarDescriptor.AnimLayerType.TPose:
                        animDefIA.type = AnimatorType.TPose;
                        break;
                }

                iaSpecialAnimators.Add(animDefIA);

            }

            iaAvatar.BaseAnimatorLayers = iaBaseAnimators.ToArray();
            iaAvatar.SpecialAnimatorLayers = iaSpecialAnimators.ToArray();

        }

    }

}

#endif