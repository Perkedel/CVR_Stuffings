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

#if CVR_CCK_EXISTS
using ABI.CCK.Components;
using ABI.CCK;
using ABI;
#endif

#if UNITY_EDITOR && CVR_CCK_EXISTS


namespace Voy.IntermediateAvatar.Converter.FromIA
{

    public static class ChilloutVR
    {
        private static List<RenameDefinition> MenuRenames = new List<RenameDefinition>();


        public static void Convert(IAAvatar _iaAvatar, bool makeDuplicate = false, bool makeDuplicateFiles = false, bool convertActionLayer = false, bool convertHandLayer = false)
        {
            //Preamble
            IAAvatar iaAvatar = _iaAvatar;

            if (makeDuplicate)
            {
                iaAvatar = Object.Instantiate(_iaAvatar);
                Utils.AssetCopier.CopyAssets(iaAvatar.gameObject, "Assets/IAConvertFrom", makeDuplicateFiles);
                _iaAvatar.gameObject.SetActive(false);
            }

            GameObject gameObject = iaAvatar.gameObject;
            CVRAvatar cvrAvatar = gameObject.AddComponent<CVRAvatar>();

            //General
            cvrAvatar.viewPosition = iaAvatar.Viewpoint;
            cvrAvatar.voicePosition = iaAvatar.Viewpoint;
            cvrAvatar.voicePosition.y -= 0.05f;
            cvrAvatar.voiceParent = CVRAvatar.CVRAvatarVoiceParent.Head;

            meshTypePicked meshType = ResolveBodyMesh(cvrAvatar, iaAvatar);

            bool hasBlinkBlend = (meshType == meshTypePicked.Eye | meshType == meshTypePicked.Both);
            bool hasLipsyncBlend = (meshType == meshTypePicked.Body | meshType == meshTypePicked.Both);

            //Lipsync
            SetLipsync(cvrAvatar, iaAvatar, hasLipsyncBlend);

            SetupEyeLook(cvrAvatar, iaAvatar);

            //Eyelook
            EyelookResolver(cvrAvatar, iaAvatar);
            if (hasBlinkBlend)
            {
                cvrAvatar.blinkBlendshape[0] = cvrAvatar.bodyMesh.sharedMesh.GetBlendShapeName(iaAvatar.EyelidsBlendshapes[0]);
                cvrAvatar.useBlinkBlendshapes = true;
            }

            //Process Menu
            ProcessMenu(cvrAvatar, iaAvatar);

            ProcessAnimator(cvrAvatar, iaAvatar, convertActionLayer, convertHandLayer);

            ParameterStreamSetup(cvrAvatar, iaAvatar);

            //Cleanup
            Object.DestroyImmediate(iaAvatar);
            MenuRenames.Clear();
            AssetDatabase.SaveAssets();

            //Debug.Log("CVR Avatar Processing Finished");

        }

        private static void CreateDropdownOrSliderSetting(CVRAvatar cvrAvatar, IAAvatar iaAvatar, string parameterName, List<MenuSystem.Option> _options, RenameDefinition[] renames)
        {
            MenuSystem.Parameter parameter = null;
            
            // get parameter
            foreach (MenuSystem.Parameter _param in iaAvatar.Parameters)
            {
                if (_param.Name == parameterName)
                {
                    parameter = _param;
                    break;
                }
            }

            string machineName = parameterName;

            foreach (var rename in renames)
            {
                if (parameterName == rename.oldName)
                {
                    machineName = rename.newName;
                    break;
                }
            }

            ABI.CCK.Scripts.CVRAdvancedSettingsEntry newSetting = new()
            {
                name = parameterName,
                machineName = machineName
            };

            // Create a slider if the setting may be a float, I really am not interested in dealing with this logic right now.
            if (parameter != null & parameter.Type == MenuSystem.Parameter.ParameterType.Float)
            {
                newSetting.name = _options[0].Name;
                newSetting.type = ABI.CCK.Scripts.CVRAdvancedSettingsEntry.SettingsType.Slider;

                ABI.CCK.Scripts.CVRAdvancesAvatarSettingSlider slider = new();
                // slider.usedType = ABI.CCK.Scripts.CVRAdvancesAvatarSettingBase.ParameterType.GenerateFloat;
                slider.usedType = ABI.CCK.Scripts.CVRAdvancesAvatarSettingBase.ParameterType.Float; // JOELwindows7: NEW breaking change!!!
                slider.defaultValue = parameter.DefaultValue;

                cvrAvatar.avatarSettings.settings.Add(newSetting);
                return;
            }

            // newSetting.type = ABI.CCK.Scripts.CVRAdvancedSettingsEntry.SettingsType.GameObjectDropdown;
            newSetting.type = ABI.CCK.Scripts.CVRAdvancedSettingsEntry.SettingsType.Dropdown; // JOELwindows7: NEW breaking change!!!

            List<ABI.CCK.Scripts.CVRAdvancedSettingsDropDownEntry> dropdownEntries = new();

            var options = _options.OrderBy(o => o.Value);

            int idx = 0;
            foreach (var option in options)
            {
                if (option.Value < 0) continue; // shouldn't be possible, but can't handle negative numbers.
                
                // because cvr dropdowns assume that all options start at 0
                // and that all options are sequental, we need this in place
                // in order to avoid using the wrong values.

                // TODO: system for rebinding when we rebuild the Animator in AnimatorRebuilder.cs
                // TODO: proper float dropdown support (after adding the rebinding system)
                while (idx < System.Math.Round(option.Value))
                {
                    if (idx == 0) 
                        dropdownEntries.Add(new() { name = "Default" });
                    else 
                        dropdownEntries.Add(new() { name = "empty option" });
                    idx++;
                }

                dropdownEntries.Add(new() { name = option.Name });
                idx++;
            }

            ABI.CCK.Scripts.CVRAdvancesAvatarSettingGameObjectDropdown dropdownSetting = new()
            {
                options = dropdownEntries,
                // usedType = ABI.CCK.Scripts.CVRAdvancesAvatarSettingBase.ParameterType.GenerateInt,
                usedType = ABI.CCK.Scripts.CVRAdvancesAvatarSettingBase.ParameterType.Int, // JOELwindows7: NEW breaking change!!!
                // isCollapsed = false // JOELwindows7: NEW breaking change!!! 
            };

            if (parameter != null)
            {
                dropdownSetting.defaultValue = (int)System.Math.Round(parameter.DefaultValue);
            }

            newSetting.setting = dropdownSetting;

            cvrAvatar.avatarSettings.settings.Add(newSetting);
        }

        private static void ProcessMenu(CVRAvatar cvrAvatar, IAAvatar iaAvatar)
        {
            // Initialize
            cvrAvatar.avatarUsesAdvancedSettings = true;
            if (cvrAvatar.avatarSettings == null) cvrAvatar.avatarSettings = new();
            if (cvrAvatar.avatarSettings.settings == null) cvrAvatar.avatarSettings.settings = new();
            if (cvrAvatar.avatarSettings.baseController == null) cvrAvatar.avatarSettings.baseController = AssetDatabase.LoadAssetAtPath<RuntimeAnimatorController>("Assets/ABI.CCK/Animations/AvatarAnimator.controller");
            cvrAvatar.avatarSettings.initialized = true;

            Dictionary<string, List<MenuSystem.Option>> Toggles = GetOptionAssociations(iaAvatar.OptionsSettings);

            List<RenameDefinition> renames = GetLocalRenameDefinitions(iaAvatar.Parameters, iaAvatar);

            List<MenuSystem.Option> options = iaAvatar.OptionsSettings;

            List<string> processedKeys = new();

            foreach(var option in options)
            {
                bool dictionaryValid = (Toggles != null && Toggles.Count > 0);
                bool optionIsToggleOrButton = (option.optionType == MenuSystem.Option.OptionType.Button | option.optionType == MenuSystem.Option.OptionType.Toggle);
                bool isInDictionary = Toggles.ContainsKey(option.MainParameter);
                bool alreadyHandled = processedKeys.Contains(option.MainParameter);

                if (alreadyHandled) continue;

                // if the option is valid for a toggle and is in the dictonary then it is ok for an attempt at creating a dropdown (or slider if it's a float)
                if (optionIsToggleOrButton && dictionaryValid && isInDictionary)
                {
                    CreateDropdownOrSliderSetting(cvrAvatar, iaAvatar, option.MainParameter, Toggles[option.MainParameter], renames.ToArray());
                    processedKeys.Add(option.MainParameter);
                    continue;
                }

                if (optionIsToggleOrButton)
                {
                    // get parameter
                    MenuSystem.Parameter parameter = null;
                    foreach (var _parameter in iaAvatar.Parameters)
                    {
                        if (_parameter.Name == option.MainParameter) parameter = _parameter;
                    }

                    // new toggle
                    ABI.CCK.Scripts.CVRAdvancesAvatarSettingGameObjectToggle toggle = new()
                    {
                        // usedType = ABI.CCK.Scripts.CVRAdvancesAvatarSettingBase.ParameterType.GenerateBool,
                        usedType = ABI.CCK.Scripts.CVRAdvancesAvatarSettingBase.ParameterType.Bool, // JOELwindows7: NEW breaking change!!!
                        // isCollapsed = false // JOELwindows7: NEW breaking change!!!
                    };

                    // set default value of option.
                    if (parameter != null) toggle.defaultValue = System.Convert.ToBoolean(parameter.DefaultValue);

                    // add setting to AAS settings.
                    cvrAvatar.avatarSettings.settings.Add(new()
                    {
                        machineName = option.MainParameter,
                        name = option.Name,
                        // type = ABI.CCK.Scripts.CVRAdvancedSettingsEntry.SettingsType.GameObjectToggle,
                        type = ABI.CCK.Scripts.CVRAdvancedSettingsEntry.SettingsType.Toggle, // JOELwindows7: NEW breaking change!!!
                        setting = toggle
                    });

                    continue;

                }

                if (option.optionType == MenuSystem.Option.OptionType.Joystick2D)
                {
                    // Get Parameter
                    MenuSystem.Parameter xParameter = null;
                    MenuSystem.Parameter yParameter = null;
                    foreach (var _parameter in iaAvatar.Parameters)
                    {
                        if (_parameter.Name == option.JoystickUpYParameter) yParameter = _parameter;
                        if (_parameter.Name == option.JoystickRightXParameter) xParameter = _parameter;
                    }

                    ABI.CCK.Scripts.CVRAdvancesAvatarSettingJoystick2D joystick = new()
                    {
                        // usedType = ABI.CCK.Scripts.CVRAdvancesAvatarSettingBase.ParameterType.GenerateFloat,
                        usedType = ABI.CCK.Scripts.CVRAdvancesAvatarSettingBase.ParameterType.Float, // JOELwindows7: NEW breaking change!!!
                        rangeMin = new(0f, 0f),
                        rangeMax = new(1f, 1f),
                        // isCollapsed = false // JOELwindows7: NEW breaking change!!!
                    };

                    Vector2 defaultValue = new(0.5f, 0.5f);

                    if (xParameter != null)
                        defaultValue.x = xParameter.DefaultValue;
                    if (yParameter != null)
                        defaultValue.y = yParameter.DefaultValue;
                    joystick.defaultValue = defaultValue;

                    ABI.CCK.Scripts.CVRAdvancedSettingsEntry entry = new()
                    {
                        machineName = option.JoystickUpYParameter,
                        name = option.Name,
                        type = ABI.CCK.Scripts.CVRAdvancedSettingsEntry.SettingsType.Joystick2D,
                        setting = joystick
                    };

                    cvrAvatar.avatarSettings.settings.Add(entry);

                    MenuRenames.Add(new()
                    { 
                        oldName = option.JoystickUpYParameter, 
                        newName = option.JoystickUpYParameter + "-x", 
                        ignoreAnimatorType = AnimatorType.GameDefault, 
                        type = AnimatorControllerParameterType.Float 
                    });

                    MenuRenames.Add(new()
                    {
                        oldName = option.JoystickRightXParameter,
                        newName = option.JoystickUpYParameter + "-y",
                        ignoreAnimatorType = AnimatorType.GameDefault,
                        type = AnimatorControllerParameterType.Float
                    });

                    continue;

                }

                if (option.optionType == MenuSystem.Option.OptionType.Joystick4Axis)
                {
                    // I'm just gonna create 4 sliders
                    // this code is shit and should be moved into a function
                    // I don't care right now.
                    {
                        // up
                        MenuSystem.Parameter upParameter = null;
                        foreach (var _parameter in iaAvatar.Parameters)
                        {
                            if (_parameter.Name == option.JoystickUpYParameter) upParameter = _parameter;
                        }

                        ABI.CCK.Scripts.CVRAdvancesAvatarSettingSlider upSlider = new()
                        {
                            // usedType = ABI.CCK.Scripts.CVRAdvancesAvatarSettingBase.ParameterType.GenerateFloat,
                            usedType = ABI.CCK.Scripts.CVRAdvancesAvatarSettingBase.ParameterType.Float, // JOELwindows7: NEW breaking change!!!
                            // isCollapsed = false // JOELwindows7: NEW breaking change!!!
                        };

                        if (upParameter != null) upSlider.defaultValue = upParameter.DefaultValue;

                        cvrAvatar.avatarSettings.settings.Add(new()
                        {
                            name = option.Name + " Up",
                            machineName = option.JoystickUpYParameter,
                            type = ABI.CCK.Scripts.CVRAdvancedSettingsEntry.SettingsType.Slider,
                            setting = upSlider
                        });
                    }

                    {
                        // down
                        MenuSystem.Parameter downParameter = null;
                        foreach (var _parameter in iaAvatar.Parameters)
                        {
                            if (_parameter.Name == option.JoystickDownYParameter) downParameter = _parameter;
                        }

                        ABI.CCK.Scripts.CVRAdvancesAvatarSettingSlider downSlider = new()
                        {
                            // usedType = ABI.CCK.Scripts.CVRAdvancesAvatarSettingBase.ParameterType.GenerateFloat,
                            usedType = ABI.CCK.Scripts.CVRAdvancesAvatarSettingBase.ParameterType.Float, // JOELwindows7: NEW breaking change!!!
                            // isCollapsed = false // JOELwindows7: NEW breaking change!!!
                        };

                        if (downParameter != null) downSlider.defaultValue = downParameter.DefaultValue;

                        cvrAvatar.avatarSettings.settings.Add(new()
                        {
                            name = option.Name + " Down",
                            machineName = option.JoystickDownYParameter,
                            type = ABI.CCK.Scripts.CVRAdvancedSettingsEntry.SettingsType.Slider,
                            setting = downSlider
                        });
                    }

                    {
                        // left
                        MenuSystem.Parameter leftParameter = null;
                        foreach (var _parameter in iaAvatar.Parameters)
                        {
                            if (_parameter.Name == option.JoystickLeftXParameter) leftParameter = _parameter;
                        }

                        ABI.CCK.Scripts.CVRAdvancesAvatarSettingSlider leftSlider = new()
                        {
                            // usedType = ABI.CCK.Scripts.CVRAdvancesAvatarSettingBase.ParameterType.GenerateFloat,
                            usedType = ABI.CCK.Scripts.CVRAdvancesAvatarSettingBase.ParameterType.Float, // JOELwindows7: NEW breaking change!!!
                            // isCollapsed = false // JOELwindows7: NEW breaking change!!!
                        };

                        if (leftParameter != null) leftSlider.defaultValue = leftParameter.DefaultValue;

                        cvrAvatar.avatarSettings.settings.Add(new()
                        {
                            name = option.Name + " Left",
                            machineName = option.JoystickLeftXParameter,
                            type = ABI.CCK.Scripts.CVRAdvancedSettingsEntry.SettingsType.Slider,
                            setting = leftSlider
                        });
                    }

                    {
                        // right
                        MenuSystem.Parameter rightParameter = null;
                        foreach (var _parameter in iaAvatar.Parameters)
                        {
                            if (_parameter.Name == option.JoystickRightXParameter) rightParameter = _parameter;
                        }

                        ABI.CCK.Scripts.CVRAdvancesAvatarSettingSlider rightSlider = new()
                        {
                            // usedType = ABI.CCK.Scripts.CVRAdvancesAvatarSettingBase.ParameterType.GenerateFloat,
                            usedType = ABI.CCK.Scripts.CVRAdvancesAvatarSettingBase.ParameterType.Float, // JOELwindows7: NEW breaking change!!!
                            // isCollapsed = false // JOELwindows7: NEW breaking change!!!
                        };

                        if (rightParameter != null) rightSlider.defaultValue = rightParameter.DefaultValue;

                        cvrAvatar.avatarSettings.settings.Add(new()
                        {
                            name = option.Name + " Right",
                            machineName = option.JoystickRightXParameter,
                            type = ABI.CCK.Scripts.CVRAdvancedSettingsEntry.SettingsType.Slider,
                            setting = rightSlider
                        });

                        continue;
                    }
                }

                if (option.optionType == MenuSystem.Option.OptionType.Slider)
                {
                    MenuSystem.Parameter parameter = null;
                    foreach (var _parameter in iaAvatar.Parameters)
                    {
                        if (_parameter.Name == option.SliderParameter) parameter = _parameter;
                    }

                    ABI.CCK.Scripts.CVRAdvancesAvatarSettingSlider slider = new()
                    {
                        // usedType = ABI.CCK.Scripts.CVRAdvancesAvatarSettingBase.ParameterType.GenerateFloat,
                        usedType = ABI.CCK.Scripts.CVRAdvancesAvatarSettingBase.ParameterType.Float, // JOELwindows7: NEW breaking change!!!
                        // isCollapsed = false // JOELwindows7: NEW breaking change!!!
                    };

                    if (parameter != null) slider.defaultValue = parameter.DefaultValue;

                    cvrAvatar.avatarSettings.settings.Add(new()
                    {
                        name = option.Name,
                        machineName = option.SliderParameter,
                        type = ABI.CCK.Scripts.CVRAdvancedSettingsEntry.SettingsType.Slider,
                        setting = slider
                    });

                    continue;
                }

                EditorUtility.SetDirty(cvrAvatar);

            }
        }


        private static Dictionary<string, List<MenuSystem.Option>> GetOptionAssociations(List<MenuSystem.Option> options)
        {
            // because CVR uses a Long list of options rather than a menu of 8 individual toggles, it contains a system for "dropdowns".
            // because of this we need to walk through each option, check if they use the same parameter, and add them to a list of sorts.
            // to organize this, we use a custom class called "OptionAssociation" which associates our options to a parameter.

            Dictionary<string, List<MenuSystem.Option>> OptionAssociations = new();

            foreach (MenuSystem.Option option in options)
            {
                bool isToggleOrButton = (option.optionType == MenuSystem.Option.OptionType.Toggle | option.optionType == MenuSystem.Option.OptionType.Button);
                if (!isToggleOrButton) continue;

                if (OptionAssociations.ContainsKey(option.MainParameter))
                {
                    OptionAssociations[option.MainParameter].Add(option); // if the key exists, add the option.
                }
                else
                {
                    OptionAssociations.Add(option.MainParameter, new() { option }); // if the key doesn't exist, create it and add the option.
                }
            }

            { // Scope for flagged keys List.
                List<string> flaggedKeys = new(); // List of Keys that contain 1 or less options.

                foreach (var item in OptionAssociations)
                {
                    int itemCount = item.Value.Count; // don't ask why I'm creating a variable for this, I'm trying to be safe.
                    if (itemCount <= 1) flaggedKeys.Add(item.Key);
                    // Adding these to a list to remove them later. If I remove them here there would be errors.
                }

                // Remove keys from dictonary that have 1 item or less.
                foreach (string key in flaggedKeys)
                {
                    if (OptionAssociations.ContainsKey(key)) // avoiding errors
                    {
                        OptionAssociations.Remove(key);
                    }
                }
            }

            return OptionAssociations;

        }

        private static ABI.CCK.Scripts.CVRAdvancedSettingsEntry.SettingsType GetAASType(MenuSystem.Option.OptionType type)
        {
            switch (type)
            {
                default:
                    // return ABI.CCK.Scripts.CVRAdvancedSettingsEntry.SettingsType.GameObjectToggle;
                    return ABI.CCK.Scripts.CVRAdvancedSettingsEntry.SettingsType.Toggle; // JOELwindows7: NEW breaking change!!!
            }
        }

        private static void ProcessAnimator(CVRAvatar cvrAvatar, IAAvatar iaAvatar, bool convertActionLayer = false, bool convertHandLayer = false)
        {
            List<AnimatorController> animators = new List<AnimatorController>();
            List<AnimatorType> types = new List<AnimatorType>();

            animators.Add(AssetDatabase.LoadAssetAtPath<AnimatorController>("Assets/ABI.CCK/Animations/AvatarAnimator.controller"));
            types.Add(AnimatorType.GameDefault);

            animators.Add(AssetDatabase.LoadAssetAtPath<AnimatorController>("Assets/Voy/AvatarIntermediateUtil/Converters/ChilloutVR/VRC Gesture Translator.controller"));
            types.Add(AnimatorType.GameDefault);

            foreach (AvatarAnimatorDefinition definition in iaAvatar.BaseAnimatorLayers)
            {
                if (definition.animator == null) continue; // no point in processing a null value

                bool isVRC = (definition.fromGame == "VRChat");
                bool isInvalidTypeForCVR = 
                    (definition.type == AnimatorType.Base && isVRC ) || //VRC Loco Layer
                    (definition.type == AnimatorType.Action && isVRC && !convertActionLayer) || //VRC Action Layer
                    (definition.type == AnimatorType.IKPose ) || 
                    (definition.type == AnimatorType.Sitting) || 
                    (definition.type == AnimatorType.TPose) || 
                    (definition.type == AnimatorType.Gesture && isVRC && ! convertHandLayer) //VRC Gesture/Hand Layer
                    ;
                
                if (isInvalidTypeForCVR) continue;

                types.Add(definition.type);
                animators.Add(AssetDatabase.LoadAssetAtPath<AnimatorController>(AssetDatabase.GetAssetPath(definition.animator)));
            }

            AnimatorController animator = AnimatorRebuilder.ProcessAndMerge(animators, types, GetLocalRenameDefinitions(iaAvatar.Parameters, iaAvatar), AnimatorRebuilder.Mode.FromIA);

            AnimatorOverrideController animatorOverride = new AnimatorOverrideController()
            { runtimeAnimatorController = animator };

            string animatorSavePath = "Assets/IAProcessed/ChilloutVR/" + UnityEditor.SceneManagement.EditorSceneManager.GetActiveScene().name + "/" + cvrAvatar.gameObject.name + "/cvrAnimator.controller";
            string animatorOverrideSavePath = "Assets/IAProcessed/ChilloutVR/" + UnityEditor.SceneManagement.EditorSceneManager.GetActiveScene().name + "/" + cvrAvatar.gameObject.name + "/cvrAnimatorOverrides.overrideController";

            bool animatorSavePathValid = DirectoryCreator.CreateDirectoryIfNotExists(animatorSavePath);
            //bool animatorOverrideSavePathValid = DirectoryCreator.CreateDirectoryIfNotExists(animatorOverrideSavePath);

            if (!animatorSavePathValid)
            {
                Debug.LogError("\"Could not make path: " + animatorSavePath);
                return;
            }

            EditorUtility.SetDirty(animator);
            EditorUtility.SetDirty(animatorOverride);

            AssetDatabase.CreateAsset(animator, AssetDatabase.GenerateUniqueAssetPath(animatorSavePath));
            AssetDatabase.CreateAsset(animatorOverride, AssetDatabase.GenerateUniqueAssetPath(animatorOverrideSavePath));

            cvrAvatar.overrides = animatorOverride;

            if (cvrAvatar.avatarSettings != null && cvrAvatar.avatarSettings.initialized)
            {
                cvrAvatar.avatarSettings.baseController = animator;
                cvrAvatar.avatarSettings.baseOverrideController = animatorOverride;
            }

        }

        private static List<RenameDefinition> GetLocalRenameDefinitions(List<MenuSystem.Parameter> parameters, IAAvatar iaAvatar)
        {
            List<RenameDefinition> renameDefinitions = new List<RenameDefinition>();
            foreach (MenuSystem.Parameter parameter in parameters)
            {
                if (parameter.Local)
                {
                    if (parameter.Name.StartsWith("#")) continue;
                    RenameDefinition renameDefinition = new RenameDefinition()
                    {
                        oldName = parameter.Name,
                        newName = "#" + parameter.Name,
                        ignoreAnimatorType = AnimatorType.GameDefault
                    };

                    renameDefinitions.Add(renameDefinition);
                    //Debug.Log("Redefinition Added for " + renameDefinition.oldName);
                }
            }

            /* Added in CVR r175 and CCK 3.9
            renameDefinitions.Add(
                new RenameDefinition()
                {
                    oldName = "IsLocal",
                    newName = "#IsLocal",
                    ignoreAnimatorType = AnimatorType.GameDefault
                }
                );
            */

            // This isn't going to be accurate to VRC's behaviour but I doubt many are using the 0-100 feature.
            // if you are this is going to break something about your avatar... I'm gonna have to base my future spec on this to be absolutes cause
            // this "conversion" thing doesn't work when one game and another game don't share the same behaviour.
            // "It's just unity" that's not remotely true.
            renameDefinitions.Add(
                new RenameDefinition()
                {
                    oldName = "Viseme",
                    newName = "VisemeIdx", // Core Parameter
                    ignoreAnimatorType = AnimatorType.GameDefault
                }
                );
            renameDefinitions.Add(
                new RenameDefinition()
                {
                    oldName = "Voice",
                    newName = "VisemeLoudness", // Core Parameter
                    ignoreAnimatorType = AnimatorType.GameDefault
                }
                );
            renameDefinitions.Add(
                new RenameDefinition()
                {
                    oldName = "InStation",
                    newName = "Sitting", // Core Parameter
                    ignoreAnimatorType = AnimatorType.GameDefault
                }
                );
            renameDefinitions.Add(
                new RenameDefinition()
                {
                    oldName = "#iaLeftGesture",
                    newName = "#GestureLeftIdxVRC", // Driven by Custom Animator Driver Animator
                    ignoreAnimatorType = AnimatorType.GameDefault
                }
                );
            renameDefinitions.Add(
                new RenameDefinition()
                {
                    oldName = "#iaRightGesture",
                    newName = "#GestureRightIdxVRC", // Driven by Custom Animator Driver Animator
                    ignoreAnimatorType = AnimatorType.GameDefault
                }
                );

            renameDefinitions.AddRange(MenuRenames);

            return renameDefinitions;
        }

        public static List<StateMachineBehaviour> ProcessBehaviors(StateMachineBehaviour[] behaviours)
        {
            //Debug.Log("Processing IA Behaviours for CVR");

            List<StateMachineBehaviour> newBehaviours = new List<StateMachineBehaviour>();

            RenameDefinition[] renames = AnimatorRebuilder.GetRenames();

            foreach (StateMachineBehaviour behaviour in behaviours)
            {
                
                if (behaviour.GetType() == typeof(IAParameterDriver))
                {

                    //Debug.Log("Found IA Parameter Driver!");

                    // Parameter Driver
                    IAParameterDriver iaDriver = (IAParameterDriver)behaviour;
                    AnimatorDriver cvrDriver = ScriptableObject.CreateInstance<AnimatorDriver>();

                    cvrDriver.localOnly = iaDriver.LocalOnly;
                    foreach (Task iaTask in iaDriver.Tasks)
                    {
                        AnimatorDriverTask cvrTask = new AnimatorDriverTask();

                        cvrTask.targetName = iaTask.Dest;

                        Behaviours.TypeList curtype = iaTask.Type;

                        // Did a switch statement for this, I assume it kept breaking out of the loop instead of the switch somehow.
                        // So I'm just doing a bunch of if else statements. It's an editor script it shouldn't matter that much.
                        if (curtype == TypeList.Set)
                        {
                            cvrTask.op = AnimatorDriverTask.Operator.Set;
                            cvrTask.aType = AnimatorDriverTask.SourceType.Static;
                            cvrTask.aValue = iaTask.Val;
                        }
                        else if (curtype == TypeList.Add)
                        {
                            cvrTask.op = AnimatorDriverTask.Operator.Addition;
                            cvrTask.aType = AnimatorDriverTask.SourceType.Parameter;
                            cvrTask.aName = iaTask.Dest;
                            cvrTask.bType = AnimatorDriverTask.SourceType.Static;
                            cvrTask.bValue = iaTask.Val;
                        }
                        else if (curtype == TypeList.Random)
                        {
                            cvrTask.op = AnimatorDriverTask.Operator.Set;
                            cvrTask.aType = AnimatorDriverTask.SourceType.Random;
                            cvrTask.aValue = iaTask.Val;
                            cvrTask.aMax = iaTask.RandomMax;
                        }
                        else if (curtype == TypeList.Copy)
                        {
                            cvrTask.op = AnimatorDriverTask.Operator.Set;
                            cvrTask.aType = AnimatorDriverTask.SourceType.Parameter;
                            cvrTask.aName = iaTask.Src;
                        }
                        else continue;

                        foreach (RenameDefinition rename in renames)
                        {
                            if (iaTask.Dest == rename.oldName)
                            { 
                                cvrTask.targetName = rename.newName;
                                if (curtype == TypeList.Add) cvrTask.aName = rename.newName;
                            }

                            if (curtype == TypeList.Copy)
                            {
                                if (iaTask.Src == rename.oldName) cvrTask.aName = rename.newName;
                            }
                        }

                        foreach (AnimatorData data in AnimatorRebuilder.DataGroups)
                        {
                            AnimatorControllerParameter tempParam = data.getParameterOfName(cvrTask.aName);
                            if (tempParam != null)
                                cvrTask.aParamType = getSourceTypeFromAnimatorType(tempParam.type);

                            if (cvrTask.bName != null && cvrTask.bName != "")
                            {
                                tempParam = data.getParameterOfName(cvrTask.bName);
                                if (tempParam != null)
                                    cvrTask.aParamType = getSourceTypeFromAnimatorType(tempParam.type);
                            }


                        }
                        cvrDriver.EnterTasks.Add(cvrTask);
                    }

                    EditorUtility.SetDirty(cvrDriver);

                    newBehaviours.Add(cvrDriver);
                }

                if (behaviour.GetType() == typeof(IATrackingControl))
                {
                    //Debug.Log("Found IA Tracking Control!");

                    IATrackingControl iaControl = (IATrackingControl)behaviour;
                    BodyControl cvrControl = ScriptableObject.CreateInstance<BodyControl>();

                    BodyControlTask currentTask;

                    //Head
                    currentTask = getCVRBodyTask(iaControl.Head, BodyControlTask.BodyMask.Head);
                    if (currentTask != null) cvrControl.EnterTasks.Add(currentTask);
                    //Pelvis
                    currentTask = getCVRBodyTask(iaControl.Hip, BodyControlTask.BodyMask.Pelvis);
                    if (currentTask != null) cvrControl.EnterTasks.Add(currentTask);
                    //Left Arm
                    currentTask = getCVRBodyTask(iaControl.LeftHand, BodyControlTask.BodyMask.LeftArm);
                    if (currentTask != null) cvrControl.EnterTasks.Add(currentTask);
                    //Right Arm
                    currentTask = getCVRBodyTask(iaControl.RightHand, BodyControlTask.BodyMask.RightArm);
                    if (currentTask != null) cvrControl.EnterTasks.Add(currentTask);
                    //Left Leg
                    currentTask = getCVRBodyTask(iaControl.LeftFoot, BodyControlTask.BodyMask.LeftArm);
                    if (currentTask != null) cvrControl.EnterTasks.Add(currentTask);
                    //Right Leg
                    currentTask = getCVRBodyTask(iaControl.RightFoot, BodyControlTask.BodyMask.RightLeg);
                    if (currentTask != null) cvrControl.EnterTasks.Add(currentTask);
                    //Locomotion will have to be handled with another component.

                    EditorUtility.SetDirty(cvrControl);

                    newBehaviours.Add(cvrControl);

                }
            }

            return newBehaviours;

        }

        private static BodyControlTask getCVRBodyTask(IATrackingControl.Tracking tracking, BodyControlTask.BodyMask target)
        {
            if (hasTrackingChange(tracking) == false) return null;
            BodyControlTask task = new BodyControlTask();

            task.target = target;

            if (tracking == IATrackingControl.Tracking.Tracking) task.targetWeight = 1;
            else task.targetWeight = 0;

            return task;
        }

        private static bool hasTrackingChange(IATrackingControl.Tracking tracking)
        {
            switch (tracking)
            {
                case IATrackingControl.Tracking.NoChange:
                    return false;
                case IATrackingControl.Tracking.Tracking:
                    return true;
                case IATrackingControl.Tracking.Animation:
                    return true;
                default:
                    return false;
            }
        }

        private static AnimatorDriverTask.ParameterType getSourceTypeFromAnimatorType(AnimatorControllerParameterType type)
        {
            switch(type)
            {
                default:
                    return AnimatorDriverTask.ParameterType.Bool;
                case AnimatorControllerParameterType.Float:
                    return AnimatorDriverTask.ParameterType.Float;
                case AnimatorControllerParameterType.Int:
                    return AnimatorDriverTask.ParameterType.Int;
                case AnimatorControllerParameterType.Trigger:
                    return AnimatorDriverTask.ParameterType.Trigger;
            }
        }

        private static void ParameterStreamSetup(CVRAvatar cvrAvatar, IAAvatar iaAvatar)
        {
            CVRParameterStream parameterStream = cvrAvatar.gameObject.AddComponent<CVRParameterStream>();

            AnimatorController controller = AssetDatabase.LoadAssetAtPath<AnimatorController>(AssetDatabase.GetAssetPath(cvrAvatar.overrides.runtimeAnimatorController));

            foreach (AnimatorControllerParameter parameter in controller.parameters)
            {
                if (parameter.name == "Upright")
                {
                    CVRParameterStreamEntry entry = new CVRParameterStreamEntry();

                    entry.targetType = CVRParameterStreamEntry.TargetType.AvatarAnimator;
                    entry.parameterName = parameter.name;
                    entry.type = CVRParameterStreamEntry.Type.AvatarUpright;
                    entry.applicationType = CVRParameterStreamEntry.ApplicationType.Override;

                    parameterStream.entries.Add(entry);
                    continue;
                }

                if (parameter.name == "Voice")
                {
                    CVRParameterStreamEntry entry = new CVRParameterStreamEntry();

                    entry.targetType = CVRParameterStreamEntry.TargetType.AvatarAnimator;
                    entry.parameterName = parameter.name;
                    entry.type = CVRParameterStreamEntry.Type.VisemeLevel;
                    entry.applicationType = CVRParameterStreamEntry.ApplicationType.Override;

                    parameterStream.entries.Add(entry);
                    continue;
                }

                // isLocal is removed because it was added in CVR 175

                /*
                if (parameter.name == "#IsLocal")
                {

                    CVRParameterStreamEntry entry = new CVRParameterStreamEntry();

                    entry.targetType = CVRParameterStreamEntry.TargetType.AvatarAnimator;
                    entry.parameterName = "#IsLocal";
                    entry.type = CVRParameterStreamEntry.Type.DeviceMode;
                    entry.applicationType = CVRParameterStreamEntry.ApplicationType.CompareMoreThen;
                    entry.staticValue = -1;
                    // Mimic Functionality by making Parameter Local, and comparing if a value is greater than -1
                    // because DeviceMode is always greater than -1, IsLocal is set to true, but it is not Synced because it starts with #.
                    // Yes this is kind of a hack, it works.

                    parameterStream.entries.Add(entry);
                    continue;
                }
                */

                if (parameter.name == "GestureLeftWeight")
                {
                    CVRParameterStreamEntry entry = new CVRParameterStreamEntry();

                    entry.targetType = CVRParameterStreamEntry.TargetType.AvatarAnimator;
                    entry.parameterName = parameter.name;
                    entry.type = CVRParameterStreamEntry.Type.GripLeftValue;
                    entry.applicationType = CVRParameterStreamEntry.ApplicationType.Override;

                    parameterStream.entries.Add(entry);
                    continue;
                }

                if (parameter.name == "GestureRightWeight")
                {
                    CVRParameterStreamEntry entry = new CVRParameterStreamEntry();

                    entry.targetType = CVRParameterStreamEntry.TargetType.AvatarAnimator;
                    entry.parameterName = parameter.name;
                    entry.type = CVRParameterStreamEntry.Type.GripRightValue;
                    entry.applicationType = CVRParameterStreamEntry.ApplicationType.Override;

                    parameterStream.entries.Add(entry);
                    continue;
                }

                if (parameter.name == "MuteSelf")
                {
                    CVRParameterStreamEntry entry = new CVRParameterStreamEntry();

                    entry.targetType = CVRParameterStreamEntry.TargetType.AvatarAnimator;
                    entry.parameterName = parameter.name;
                    entry.type = CVRParameterStreamEntry.Type.LocalPlayerMuted;
                    entry.applicationType = CVRParameterStreamEntry.ApplicationType.Override;

                    parameterStream.entries.Add(entry);
                    continue;
                }

            }

            EditorUtility.SetDirty(parameterStream);

        }

        public enum meshTypePicked
        { None, Body, Eye, Both }

        private static meshTypePicked ResolveBodyMesh(CVRAvatar cvrAvatar, IAAvatar iaAvatar)
        {
            SkinnedMeshRenderer visMesh = (SkinnedMeshRenderer)iaAvatar.VisemeMesh;
            SkinnedMeshRenderer eyeMesh = (SkinnedMeshRenderer)iaAvatar.EyelidBlendshapeMesh;

            bool isBodyMeshValid = visMesh != null;
            bool isEyeMeshValid = eyeMesh != null;
            bool meshesMatch = visMesh == eyeMesh;

            if (meshesMatch)
            {
                cvrAvatar.bodyMesh = (SkinnedMeshRenderer)iaAvatar.VisemeMesh;
                cvrAvatar.useVisemeLipsync = true;
                return meshTypePicked.Both;
            }
            else if (isBodyMeshValid)
            {
                cvrAvatar.bodyMesh = (SkinnedMeshRenderer)iaAvatar.VisemeMesh;
                return meshTypePicked.Body;
            }
            else if (isEyeMeshValid)
            {
                cvrAvatar.bodyMesh = (SkinnedMeshRenderer)iaAvatar.EyelidBlendshapeMesh;
                return meshTypePicked.Eye;
            }

            return meshTypePicked.None;

        }

        private static void SetupEyeLook(CVRAvatar cvrAvatar, IAAvatar iaAvatar)
        {
            if (!iaAvatar.UseEyeLook) return;

            cvrAvatar.eyeMovementInfo = new()
            {
                type = CVRAvatar.CVRAvatarEyeLookMode.Transform
            };

            CVRAvatar.EyeMovementInfoEye rightEye = new CVRAvatar.EyeMovementInfoEye();
            rightEye.isLeft = false;
            rightEye.eyeTransform = iaAvatar.RightEyeBone;

            CVRAvatar.EyeMovementInfoEye leftEye = new CVRAvatar.EyeMovementInfoEye();
            leftEye.isLeft = true;
            leftEye.eyeTransform = iaAvatar.LeftEyeBone;

            // WHY ARE EYELOOK DOWN/UP INVERTED!?!
            // Update: so apparently they're not inverted... they follow Unity's Rig Standard where Up is Negative and Down is Positive... geniuses at Unity.
            if (iaAvatar.EyeLookUp != null)
            {
                rightEye.eyeAngleLimitUp = getLookLimit(iaAvatar.EyeLookUp.Right.eulerAngles.x) * -1f;
                leftEye.eyeAngleLimitUp = getLookLimit(iaAvatar.EyeLookUp.Left.eulerAngles.x) * -1f;
            }

            if (iaAvatar.EyeLookDown != null)
            {
                rightEye.eyeAngleLimitDown = getLookLimit(iaAvatar.EyeLookDown.Right.eulerAngles.x) * -1;
                leftEye.eyeAngleLimitDown = getLookLimit(iaAvatar.EyeLookDown.Left.eulerAngles.x) * -1;
            }

            // I hope I'm doing this right. Why in/out instead of left/right?
            if (iaAvatar.EyeLookLeft != null)
            {
                rightEye.eyeAngleLimitIn = getLookLimit(iaAvatar.EyeLookLeft.Right.eulerAngles.y); ;
                leftEye.eyeAngleLimitIn = getLookLimit(iaAvatar.EyeLookLeft.Left.eulerAngles.y); ;
            }

            // I hope I'm doing this right. Why in/out instead of left/right?
            if (iaAvatar.EyeLookRight != null)
            {
                rightEye.eyeAngleLimitOut = getLookLimit(iaAvatar.EyeLookRight.Right.eulerAngles.y); ;
                leftEye.eyeAngleLimitOut = getLookLimit(iaAvatar.EyeLookRight.Left.eulerAngles.y); ;
            }

            cvrAvatar.eyeMovementInfo.eyes = new CVRAvatar.EyeMovementInfoEye[] { rightEye, leftEye };
        }

        private static float getLookLimit(float rotation)
        {

            float limit = rotation;

            if (limit > 180)
                limit = limit - 360;

            return limit;
        }

        private static void SetLipsync(CVRAvatar cvrAvatar, IAAvatar iaAvatar, bool hasLipsyncBlend = false)
        {
            cvrAvatar.visemeMode = ResolveVisemeMode(iaAvatar.lipsyncMode);
            if (hasLipsyncBlend)
            {
                if (cvrAvatar.visemeMode == CVRAvatar.CVRAvatarVisemeMode.Visemes)
                {
                    cvrAvatar.visemeBlendshapes = iaAvatar.VisemeBlendShapes;
                }
                else
                {
                    cvrAvatar.visemeBlendshapes[0] = iaAvatar.LipSyncJawBlendShape;
                }
            }

        }

        public static void EyelookResolver(CVRAvatar cvrAvatar, IAAvatar iaAvatar, bool hasBlinkBlend = false)
        {
            if (iaAvatar.eyelidType == IAAvatar.EyelidType.Blendshapes && cvrAvatar.bodyMesh != null && hasBlinkBlend)
            {
                cvrAvatar.blinkBlendshape[0] = cvrAvatar.bodyMesh.sharedMesh.GetBlendShapeName(iaAvatar.EyelidsBlendshapes[0]);
            }
        }

        public static CVRAvatar.CVRAvatarVisemeMode ResolveVisemeMode(IntermediateAvatar.Components.IAAvatar.LipsyncMode iaLipsync)
        {
            switch (iaLipsync)
            {
                case IAAvatar.LipsyncMode.JawFlap:
                    return CVRAvatar.CVRAvatarVisemeMode.SingleBlendshape;
                case IAAvatar.LipsyncMode.JawBone:
                    return CVRAvatar.CVRAvatarVisemeMode.JawBone;
                default:
                    return CVRAvatar.CVRAvatarVisemeMode.Visemes;
            }
        }

        public static void ProcessComponents(CVRAvatar cvrAvatar, IAAvatar iaAvatar)
        {

            GameObject mainGO = cvrAvatar.gameObject;

            List<Component> components = mainGO.GetComponentsInChildren(typeof(Component), true).ToList<Component>();

            foreach (Component component in components)
            {
                bool yeet = false;

                GameObject workGO = component.gameObject;
                if (component.GetType() == typeof(IAContactSender))
                {
                    IAContactSender iaSender = (IAContactSender)component;
                    CVRPointer cvrPointer = iaSender.RootTransform.gameObject.AddComponent<CVRPointer>();

                    yeet = true;
                }

                if (component.GetType() == typeof(IAContactReciever))
                {
                    IAContactReciever iaReciever = (IAContactReciever)component;
                    CVRAdvancedAvatarSettingsTrigger cvrTrigger = iaReciever.RootTransform.gameObject.AddComponent<CVRAdvancedAvatarSettingsTrigger>();

                    yeet = true;
                }

                if (yeet)
                {
                    Object.DestroyImmediate(component);
                }

            }


        }


    }

    public class OptionAssociation
    {
        // This Exists Purely for the Dropdown System
        public string machineName;
        public List<MenuSystem.Option> settings;
    }

}
#endif