using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using Voy.IntermediateAvatar;

#if UNITY_EDITOR
using UnityEditor;
using UnityEditor.Animations;

namespace Voy.IntermediateAvatar.Utils
{
    public static class AnimatorRebuilder
    {
        static string workingFilePath = "";

        // Lists that exist outside functions so I can just access them
        private static List<string> alreadyProcessedParameterNames = new List<string>();
        private static List<RenameDefinition> Renames = new List<RenameDefinition>();

        // Classes Contain InstanceIDs and the state said instance is to be replaced with.
        private static List<StateAssociation> stateAssociations = new List<StateAssociation>();
        private static List<StateMachineAssociation> stateMachineAssociations = new List<StateMachineAssociation>();

        public static List<AnimatorData> DataGroups = new List<AnimatorData>();
        private static Components.AnimatorType tempType;

        private static Mode mode;

        private static bool disableLayerRenaming;


        public static RenameDefinition[] GetRenames()
        {
            return Renames.ToArray();
        }

        public enum Mode : int
        {
            ToIA = 0,
            FromIA = 1
        }

        public static AnimatorController ProcessAndMerge(List<AnimatorController> animators, List<Components.AnimatorType> types, List<RenameDefinition> renameDefinitions, Mode _mode, bool _disableLayerRenaming = false)
        {
            if (animators.Count <= 0) return null;

            Renames = renameDefinitions;

            mode = _mode;

            disableLayerRenaming = _disableLayerRenaming;

            workingFilePath = "Assets/IntermAssets/Processed/IntermAvatar/AnimatorFiles/" + UnityEditor.SceneManagement.EditorSceneManager.GetActiveScene().name + "/";

            AnimatorController animatorNew = new AnimatorController();

            int idx = 0;
            foreach (AnimatorController animator in animators)
            {
                if (animator == null) continue;
                DataGroups.Add(
                    ProcessAnimator(animator, types[idx])
                    );

                idx++;
            }

            List<AnimatorControllerLayer> layers = new List<AnimatorControllerLayer>();

            List<AnimatorControllerParameter> parameters = new List<AnimatorControllerParameter>();

            List<string> parameterTracker = new List<string>();

            foreach (AnimatorData data in DataGroups)
            {
                if (data == null) continue;
                if (data.parameters != null && data.parameters.Count > 0)
                {
                    foreach (AnimatorControllerParameter parameter in data.parameters)
                    {
                        if (parameter == null) continue;
                        if (!parameterTracker.Contains(parameter.name))
                        {
                            parameters.Add(parameter);
                            parameterTracker.Add(parameter.name);
                        }
                    }
                }

                foreach (AnimatorControllerLayer layer in data.layers)
                {
                    string compareString = GetUniqueLayerName(layers, layer.name);

                    if (compareString != null)
                    {
                        layer.name = compareString;
                        layers.Add(layer);
                    }
                }
            }

            if (parameters != null && parameters.Count > 0)
            {
                foreach (AnimatorControllerParameter parameter in parameters)
                {
                    if (parameter != null)
                    animatorNew.AddParameter(parameter);
                }
            }

            foreach (AnimatorControllerLayer layer in layers)
            {
                animatorNew.AddLayer(layer);
            }

            //Cleanup
            Renames.Clear();
            stateAssociations.Clear();
            stateMachineAssociations.Clear();
            alreadyProcessedParameterNames.Clear();
            uniqueNameAttempts = 0;
            DataGroups.Clear();
            tempType = 0;

            return animatorNew;

        }

        

        // Declare this outside of the function so it can accumulate.
        private static int uniqueNameAttempts = 0;
        private static string GetUniqueLayerName(List<AnimatorControllerLayer> layers, string layerName)
        {
            int maxAttempts = 10;
            string returnString = layerName;
            bool canReturn = true;
            int increment = 0;

            foreach (AnimatorControllerLayer layer in layers)
            {
                if (layerName == layer.name) canReturn = false;
            }

            if (!canReturn && uniqueNameAttempts < maxAttempts)
            {
                uniqueNameAttempts++;
                returnString = GetUniqueLayerName(layers, (layerName + " " + increment));
            }
            else if (uniqueNameAttempts >= maxAttempts)
            {
                returnString = null;
            }

            uniqueNameAttempts = 0;
            return returnString;
        }

        private static AnimatorData ProcessAnimator(AnimatorController animator, Components.AnimatorType type)
        {
            if (animator == null) return null;

            tempType = type;
            //Declare this, add to it, return later
            AnimatorData animatorData = new AnimatorData();

            if (animator.parameters != null && animator.parameters.Length > 0)
            {
                foreach (AnimatorControllerParameter parameter in animator.parameters)
                {
                    if (parameter == null) continue;

                    string parameterName = parameter.name;

                    foreach (RenameDefinition rename in Renames)
                        if ((parameterName == rename.oldName) & (tempType != rename.ignoreAnimatorType)) parameterName = rename.newName;

                    if (alreadyProcessedParameterNames.Contains(parameterName)) continue;

                    AnimatorControllerParameter newParam = ProcessParameter(parameter);

                    if (newParam == null) continue;

                    animatorData.parameters.Add(newParam);
                    alreadyProcessedParameterNames.Add(newParam.name);
                }
            }

            bool isFirstLayer = true;
            foreach (AnimatorControllerLayer layer in animator.layers)
            {
                AnimatorControllerLayer newLayer = ProcessLayer(layer, type, isFirstLayer);

                isFirstLayer = false;

                if (newLayer == null) continue;

                animatorData.layers.Add(newLayer);
            }

            tempType = 0;

            return animatorData;
        }

        private static AnimatorControllerParameter ProcessParameter(AnimatorControllerParameter parameter)
        {
            AnimatorControllerParameter newParam = new AnimatorControllerParameter()
            {
                defaultBool = parameter.defaultBool,
                defaultFloat = parameter.defaultFloat,
                defaultInt = parameter.defaultInt,
                name = parameter.name,
                type = parameter.type
            };

            foreach (RenameDefinition rename in Renames)
            {
                if ((newParam.name == rename.oldName) & (tempType != rename.ignoreAnimatorType))
                    newParam.name = rename.newName;
            }

            return newParam;
        }

        private static AnimatorControllerLayer ProcessLayer(AnimatorControllerLayer layer, Components.AnimatorType type, bool isFirst = false)
        {
            // No point in processing a null state machine
            if (layer.stateMachine == null) return null;

            if (!isFirst)
            {
                bool noBehaviours = layer.stateMachine.behaviours.Length <= 0;
                bool noStatesOrMachines = layer.stateMachine.states.Length + layer.stateMachine.states.Length <= 0;

                if (noBehaviours & noStatesOrMachines) return null;
            }

            AnimatorControllerLayer newLayer = new AnimatorControllerLayer();

            newLayer.avatarMask = layer.avatarMask;
            newLayer.blendingMode = layer.blendingMode;
            newLayer.defaultWeight = layer.defaultWeight;
            newLayer.iKPass = layer.iKPass;
            newLayer.syncedLayerAffectsTiming = layer.syncedLayerAffectsTiming;
            newLayer.syncedLayerIndex = layer.syncedLayerIndex;

            if (type == Components.AnimatorType.Additive)
                newLayer.blendingMode = AnimatorLayerBlendingMode.Additive;

            if (newLayer.avatarMask == null)
            {
                switch(type)
                {
                    case Components.AnimatorType.Gesture:
                        newLayer.avatarMask = AssetDatabase.LoadAssetAtPath<AvatarMask>("Assets/Voy/AvatarIntermediateUtil/AvatarMasks/IA Hands.mask");
                        break;
                    case Components.AnimatorType.FX:
                        newLayer.avatarMask = AssetDatabase.LoadAssetAtPath<AvatarMask>("Assets/Voy/AvatarIntermediateUtil/AvatarMasks/IA FX.mask");
                        break;
                }
            }

            if (type != Components.AnimatorType.GameDefault && mode != Mode.ToIA && !disableLayerRenaming) newLayer.name = "[" + type.ToString() + "] " + layer.name;
            else newLayer.name = layer.name;

            if (isFirst) newLayer.defaultWeight = 1f;

            CreateStateMachineAssociations(layer.stateMachine);

            AnimatorStateMachine newStateMachine = ProcessStateMachine(layer.stateMachine);

            if (newStateMachine == null) Debug.LogError("newStateMachine returned null");

            newLayer.stateMachine = newStateMachine;

            if (newLayer.stateMachine == null)
                return null;

            return newLayer;

        }

        private static void CreateStateMachineAssociations(AnimatorStateMachine stateMachine)
        {
            foreach(var childStateMachine in stateMachine.stateMachines)
            {
                CreateStateMachineAssociations(childStateMachine.stateMachine);
            }

            foreach (var childState in stateMachine.states)
            {
                CreateStateAssociations(childState.state);
            }

            AnimatorStateMachine newStateMachine = new AnimatorStateMachine();

            StateMachineAssociation association = new StateMachineAssociation()
            {
                ReferenceInstanceID = stateMachine.GetInstanceID(),
                replacement = newStateMachine
            };

            stateMachineAssociations.Add(association);
        }

        private static void CreateStateAssociations(AnimatorState state)
        {
            AnimatorState newState = new AnimatorState();

            StateAssociation association = new StateAssociation()
            {
                ReferenceInstanceID = state.GetInstanceID(),
                replacement = newState
            };

            stateAssociations.Add(association);
        }

        private static AnimatorStateMachine ProcessStateMachine(AnimatorStateMachine stateMachine)
        {
            AnimatorStateMachine newStateMachine = null;

            foreach(StateMachineAssociation association in stateMachineAssociations)
            {
                if (association.ReferenceInstanceID == stateMachine.GetInstanceID())
                {
                    newStateMachine = association.replacement;
                    break;
                }
            }

            if (newStateMachine == null)
            {
                Debug.LogError("Association Returned Null");
                return null;
            }

            {
                List<ChildAnimatorStateMachine> newStateMachines = new List<ChildAnimatorStateMachine>();

                // Process Child State Machines
                foreach (ChildAnimatorStateMachine childStateMachine in stateMachine.stateMachines)
                {
                    ChildAnimatorStateMachine newChildStateMachine = new ChildAnimatorStateMachine();

                    newChildStateMachine.position = childStateMachine.position;

                    newChildStateMachine.stateMachine = ProcessStateMachine(childStateMachine.stateMachine);

                    foreach (var transition in stateMachine.GetStateMachineTransitions(childStateMachine.stateMachine))
                    {
                        AnimatorTransition newTransition = null;
                        if (transition.isExit)
                        {
                            newTransition = newStateMachine.AddStateMachineExitTransition(newChildStateMachine.stateMachine);
                            newTransition.mute = transition.mute;
                            newTransition.name = transition.name;
                            newTransition.solo = transition.solo;
                        }

                        if (newTransition == null) continue;

                        if (transition.conditions.Length > 0)
                        {
                            foreach (AnimatorCondition condition in transition.conditions)
                            {
                                string parameter = condition.parameter;
                                AnimatorConditionMode mode = condition.mode;
                                float threshold = condition.threshold;

                                foreach (RenameDefinition rename in Renames)
                                {
                                    if (parameter == rename.oldName)
                                    {
                                        parameter = rename.newName;
                                        break;
                                    }
                                }
                                newTransition.AddCondition(mode, threshold, parameter);
                            }
                        }
                    }

                    newStateMachines.Add(newChildStateMachine);
                }


                newStateMachine.stateMachines = newStateMachines.ToArray();
            }

            AnimatorState defaultState = null;

            {

                List<ChildAnimatorState> newStates = new List<ChildAnimatorState>();

                // Process Child States
                foreach (ChildAnimatorState state in stateMachine.states)
                {
                    ChildAnimatorState newState = new ChildAnimatorState();

                    newState.position = state.position;

                    AnimatorState newRealState = ProcessState(state.state);

                    newState.state = newRealState;

                    if (newRealState != null)
                    {
                        newStates.Add(newState);

                        if (state.state == stateMachine.defaultState)
                        {
                            defaultState = newRealState;
                        }
                    }
                }

                newStateMachine.states = newStates.ToArray();
            }

            if (defaultState != null)
            {
                newStateMachine.defaultState = defaultState;

                if (newStateMachine.defaultState != defaultState)
                {
                    Debug.LogWarning(newStateMachine.name + " Default State is " +
                        newStateMachine.defaultState.name + " but should be " + defaultState.name);
                }
            }

            newStateMachine.anyStatePosition = stateMachine.anyStatePosition;
            newStateMachine.entryPosition = stateMachine.entryPosition;
            newStateMachine.exitPosition = stateMachine.exitPosition;
            newStateMachine.name = stateMachine.name;

            var newBehaviours = ProcessBehaviors(stateMachine.behaviours);

            {
                int idx = 0;
                foreach (var behaviour in newStateMachine.behaviours)
                {
                    GameObject.Destroy(newStateMachine.behaviours[idx]);
                    idx++;
                }
            }

            newStateMachine.behaviours = ProcessBehaviors(stateMachine.behaviours);

            foreach (AnimatorStateTransition transition in stateMachine.anyStateTransitions)
            {
                AnimatorStateTransition newTransition = null;

                var destState = transition.destinationState;
                var destStateMachine = transition.destinationStateMachine;
                bool destIsStateMachine = false;

                if (transition.destinationState != null)
                {
                    int destStateID = transition.destinationState.GetInstanceID();
                    foreach (var association in stateAssociations)
                    {
                        if (destStateID == association.ReferenceInstanceID)
                        {
                            destState = association.replacement;
                        }
                    }

                    newTransition = newStateMachine.AddAnyStateTransition(destState);
                    destIsStateMachine = false;
                }

                else if (transition.destinationStateMachine != null)
                {
                    int destMachineID = transition.destinationStateMachine.GetInstanceID();
                    foreach (var association in stateMachineAssociations)
                    {
                        if (destMachineID == association.ReferenceInstanceID)
                        {
                            destStateMachine = association.replacement;
                        }
                    }

                    newTransition = newStateMachine.AddAnyStateTransition(destStateMachine);
                    destIsStateMachine = true;
                }

                if (newTransition == null) continue;

                {
                    newTransition.canTransitionToSelf = transition.canTransitionToSelf;
                    newTransition.duration = transition.duration;
                    newTransition.exitTime = transition.exitTime;
                    newTransition.hasExitTime = transition.hasExitTime;
                    newTransition.hasFixedDuration = transition.hasFixedDuration;
                    newTransition.interruptionSource = transition.interruptionSource;
                    newTransition.isExit = transition.isExit;
                    newTransition.mute = transition.mute;
                    newTransition.name = transition.name;
                    newTransition.offset = transition.offset;
                    newTransition.orderedInterruption = transition.orderedInterruption;
                    newTransition.solo = transition.solo;
                }

                foreach (AnimatorCondition condition in transition.conditions)
                {
                    string parameter = condition.parameter;
                    AnimatorConditionMode mode = condition.mode;
                    float threshold = condition.threshold;

                    foreach (RenameDefinition rename in Renames)
                    {
                        if ((parameter == rename.oldName) & (tempType != rename.ignoreAnimatorType))
                            parameter = rename.newName;
                    }

                    newTransition.AddCondition(mode, threshold, parameter);
                }

                string filename = newTransition.name;

                if (filename == null | filename == string.Empty | filename == "")
                {
                    if (destIsStateMachine)
                        filename = "AnyState -> " + destStateMachine.name;
                    else
                        filename = "AnyState -> " + destState.name;
                }

                string saveTransitionPath = workingFilePath + "states/transitions/" + newStateMachine.name + "/anystate/" + filename + ".asset";

                if (DirectoryCreator.CreateDirectoryIfNotExists(saveTransitionPath))
                {
                    try
                    {
                        AssetDatabase.CreateAsset(newTransition, AssetDatabase.GenerateUniqueAssetPath(saveTransitionPath));
                    }
                    catch { }
                }
            }

            foreach (AnimatorTransition transition in stateMachine.entryTransitions)
            {
                var destState = transition.destinationState;
                var destStateMachine = transition.destinationStateMachine;
                bool destIsStateMachine = false;

                AnimatorTransition newTransition = null;

                if (transition.destinationState != null)
                {
                    int destStateID = transition.destinationState.GetInstanceID();
                    foreach (var association in stateAssociations)
                    {
                        if (destStateID == association.ReferenceInstanceID)
                        {
                            destState = association.replacement;
                        }
                    }

                    newTransition = newStateMachine.AddEntryTransition(destState);
                    destIsStateMachine = false;
                }

                else if (transition.destinationStateMachine != null)
                {
                    int destMachineID = transition.destinationStateMachine.GetInstanceID();
                    foreach (var association in stateMachineAssociations)
                    {
                        if (destMachineID == association.ReferenceInstanceID)
                        {
                            destStateMachine = association.replacement;
                        }
                    }

                    newTransition = newStateMachine.AddEntryTransition(destStateMachine);
                    destIsStateMachine = true;
                }

                if (newTransition == null) continue;

                {
                    newTransition.isExit = transition.isExit;
                    newTransition.mute = transition.mute;
                    newTransition.name = transition.name;
                    newTransition.solo = transition.solo;
                }

                foreach (AnimatorCondition condition in transition.conditions)
                {
                    string parameter = condition.parameter;
                    AnimatorConditionMode mode = condition.mode;
                    float threshold = condition.threshold;

                    foreach (RenameDefinition rename in Renames)
                    {
                        if ((parameter == rename.oldName) & (tempType != rename.ignoreAnimatorType)) parameter = rename.newName;
                    }

                    newTransition.AddCondition(mode, threshold, parameter);
                }

                string filename = newTransition.name;

                if (filename == null | filename == string.Empty | filename == "")
                {
                    if (destIsStateMachine)
                        filename = "Entry -> " + destStateMachine.name;
                    else
                        filename = "Entry -> " + destState.name;
                }

                string saveTransitionPath = workingFilePath + "states/transitions/" + newStateMachine.name + "/entry/" + filename + ".asset";

                if (DirectoryCreator.CreateDirectoryIfNotExists(saveTransitionPath))
                {
                    try
                    {
                        AssetDatabase.CreateAsset(newTransition, AssetDatabase.GenerateUniqueAssetPath(saveTransitionPath));
                    }
                    catch { }
                }
                

            }

            EditorUtility.SetDirty(newStateMachine);

            string savePath = workingFilePath + "stateMachines/" + newStateMachine.name + ".asset";

            if (DirectoryCreator.CreateDirectoryIfNotExists(savePath))
            {
                try
                {
                    AssetDatabase.CreateAsset(newStateMachine, AssetDatabase.GenerateUniqueAssetPath(savePath));
                }
                catch { }
            }

            return newStateMachine;
        }

        private static AnimatorState ProcessState(AnimatorState state)
        {
            AnimatorState newState = null;

            foreach (var association in stateAssociations)
            {
                if (state.GetInstanceID() == association.ReferenceInstanceID)
                {
                    newState = association.replacement;
                }
            }

            //Setup NewState
            newState.cycleOffset = state.cycleOffset;
            newState.cycleOffsetParameter = state.cycleOffsetParameter;
            newState.cycleOffsetParameterActive = state.cycleOffsetParameterActive;
            newState.iKOnFeet = state.iKOnFeet;
            newState.mirror = state.mirror;
            newState.mirrorParameter = state.mirrorParameter;
            newState.mirrorParameterActive = state.mirrorParameterActive;
            newState.motion = state.motion;
            newState.name = state.name;
            newState.speed = state.speed;
            newState.speedParameter = state.speedParameter;
            newState.speedParameterActive = state.speedParameterActive;
            newState.tag = state.tag;
            newState.timeParameter = state.timeParameter;
            newState.timeParameterActive = state.timeParameterActive;
            newState.writeDefaultValues = state.writeDefaultValues;

            if (newState == null)
            {
                Debug.LogError("State Association Failed on State " + state.name);
                return null;
            }

            newState.motion = state.motion;

            foreach (RenameDefinition rename in Renames)
            {
                if ((state.cycleOffsetParameter == rename.oldName) & (tempType != rename.ignoreAnimatorType)) newState.cycleOffsetParameter = rename.newName;
                if ((state.mirrorParameter == rename.oldName) & (tempType != rename.ignoreAnimatorType)) newState.speedParameter = rename.newName;
                if ((state.timeParameter == rename.oldName) & (tempType != rename.ignoreAnimatorType)) newState.timeParameter = rename.newName;
            }

            if (state.motion != null)
            {
                if (state.motion.GetType() == typeof(BlendTree))
                {
                    newState.motion = (Motion)ProcessBlendTree((BlendTree)state.motion);
                }
            }

            //List<AnimatorStateTransition> newTransitions = new List<AnimatorStateTransition>();

            foreach (AnimatorStateTransition transition in state.transitions)
            {

                var destState = transition.destinationState;
                var destStateMachine = transition.destinationStateMachine;
                AnimatorStateTransition newTransition = null;

                if (transition.isExit == true)
                {
                    newTransition = state.AddExitTransition();
                }

                else if (transition.destinationState != null)
                {
                    int destStateID = transition.destinationState.GetInstanceID();
                    foreach (var association in stateAssociations)
                    {
                        if (destStateID == association.ReferenceInstanceID)
                        {
                            destState = association.replacement;
                        }
                    }

                    newTransition = state.AddTransition(destState);
                }

                else if (transition.destinationStateMachine != null)
                {
                    int destMachineID = transition.destinationStateMachine.GetInstanceID();
                    foreach (var association in stateMachineAssociations)
                    {
                        if (destMachineID == association.ReferenceInstanceID)
                        {
                            destStateMachine = association.replacement;
                        }
                    }

                    newTransition = state.AddTransition(destStateMachine);
                }

                if (newTransition == null) continue;

                {
                    newTransition.isExit = transition.isExit;
                    newTransition.mute = transition.mute;
                    newTransition.name = transition.name;
                    newTransition.solo = transition.solo;
                    newTransition.hasExitTime = transition.hasExitTime;
                    newTransition.duration = transition.duration;
                    newTransition.canTransitionToSelf = transition.canTransitionToSelf;
                    newTransition.exitTime = transition.exitTime;
                    newTransition.hasFixedDuration = transition.hasFixedDuration;
                    newTransition.interruptionSource = transition.interruptionSource;
                    newTransition.offset = transition.offset;
                    newTransition.orderedInterruption = transition.orderedInterruption;
                }

                foreach (AnimatorCondition condition in transition.conditions)
                {
                    string parameter = condition.parameter;
                    AnimatorConditionMode mode = condition.mode;
                    float threshold = condition.threshold;

                    foreach (RenameDefinition rename in Renames)
                    {
                        if ((parameter == rename.oldName) & (tempType != rename.ignoreAnimatorType))
                        {
                            parameter = rename.newName;
                        }
                    }

                    newTransition.AddCondition(mode, threshold, parameter);
                }

                EditorUtility.SetDirty(newTransition);

                newState.AddTransition(newTransition);
            }

            newState.behaviours = ProcessBehaviors(state.behaviours);

            if (newState.behaviours.Length > 0)
            {
                foreach (var behaviour in newState.behaviours)
                {

                    string saveBehPath = workingFilePath + "states/" + newState.name + "/behaviours/" + behaviour.GetType().ToString() + ".asset";

                    if (DirectoryCreator.CreateDirectoryIfNotExists(saveBehPath))
                    {
                        try
                        {
                            AssetDatabase.CreateAsset(behaviour, AssetDatabase.GenerateUniqueAssetPath(saveBehPath));
                        }
                        catch { }
                    }

                }
            }

            EditorUtility.SetDirty(newState);

            string savePath = workingFilePath + "states/" + newState.name + ".asset";

            if (DirectoryCreator.CreateDirectoryIfNotExists(savePath))
            {
                try
                {
                    AssetDatabase.CreateAsset(newState, AssetDatabase.GenerateUniqueAssetPath(savePath));
                }
                catch { }
            }

            return newState;
        }

        private static StateMachineBehaviour[] ProcessBehaviors(StateMachineBehaviour[] behaviours)
        {

            if (mode == Mode.FromIA)
            {

#if CVR_CCK_EXISTS

                return Converter.FromIA.ChilloutVR.ProcessBehaviors(behaviours).ToArray();

#endif //CVR_CCK_EXISTS
            }

            if (mode == Mode.ToIA)
            {
#if VRC_SDK_VRCSDK3

                return Converter.ToIA.VRChat.ProcessBehaviours(behaviours).ToArray();

#endif // VRC_SDK_VRCSDK3

            }

            return new StateMachineBehaviour[] { };
        }

        private static AnimationClip ProcessAnimationClip(AnimationClip animationClip)
        {
            AnimationClip newAnimationClip = new AnimationClip()
            {
                events = animationClip.events,
                frameRate = animationClip.frameRate,
                legacy = animationClip.legacy,
                localBounds = animationClip.localBounds,
                name = animationClip.name,
                wrapMode = animationClip.wrapMode
            };

            return null;
        }

        private static BlendTree ProcessBlendTree(BlendTree blendTree)
        {
            BlendTree _blendTree = new BlendTree()
            {
                name = blendTree.name,
                blendParameter = blendTree.blendParameter,
                blendParameterY = blendTree.blendParameterY,
                blendType = blendTree.blendType,
                maxThreshold = blendTree.maxThreshold,
                minThreshold = blendTree.minThreshold,
                useAutomaticThresholds = blendTree.useAutomaticThresholds
            };

            foreach (RenameDefinition rename in Renames)
            {
                if ((_blendTree.blendParameter == rename.oldName) & (tempType != rename.ignoreAnimatorType))
                {
                    _blendTree.blendParameter = rename.newName;
                }
                if ((_blendTree.blendParameterY == rename.oldName) & (tempType != rename.ignoreAnimatorType))
                {
                    _blendTree.blendParameterY = rename.newName;
                }
            }

            List<ChildMotion> ChildMotions = new List<ChildMotion>();

            foreach (ChildMotion childMotion in blendTree.children)
            {
                ChildMotion newChildMotion = new()
                {
                    mirror = childMotion.mirror,
                    cycleOffset = childMotion.cycleOffset,
                    directBlendParameter = childMotion.directBlendParameter,
                    motion = childMotion.motion,
                    position = childMotion.position,
                    threshold = childMotion.threshold,
                    timeScale = childMotion.timeScale
                };

                if (childMotion.motion.GetType() == typeof(BlendTree))
                {
                    newChildMotion.motion = ProcessBlendTree((BlendTree)childMotion.motion);
                }

                if (childMotion.directBlendParameter != null | childMotion.directBlendParameter != "")
                {
                    foreach (RenameDefinition rename in Renames)
                    {
                        if ((childMotion.directBlendParameter == rename.oldName) & (tempType != rename.ignoreAnimatorType))
                        {
                            newChildMotion.directBlendParameter = rename.newName;
                        }
                    }
                }

                ChildMotions.Add(newChildMotion);
            }

            _blendTree.children = ChildMotions.ToArray();

            EditorUtility.SetDirty(_blendTree);

            string savePath = workingFilePath + "blendTrees/" + _blendTree.name + ".asset";

            if (DirectoryCreator.CreateDirectoryIfNotExists(savePath))
            {
                try
                {
                    AssetDatabase.CreateAsset(_blendTree, AssetDatabase.GenerateUniqueAssetPath(savePath));
                }
                catch { }
            }

            return _blendTree;

        }

        private static bool hasParameterOfName(List<AnimatorData> DataGroups, string name)
        {
            foreach (AnimatorData data in DataGroups)
            {
                if (data.hasParameterOfName(name))
                    return true;
            }

            return false;
        }

        private static AnimatorControllerParameter getParameterOfName(List<AnimatorData> DataGroups, string name)
        {
            foreach (AnimatorData data in DataGroups)
            {
                return data.getParameterOfName(name);
            }

            return null;
        }

    }


    public class AnimatorData
    {
        public List<AnimatorControllerLayer> layers = new List<AnimatorControllerLayer>();
        public List<AnimatorControllerParameter> parameters = new List<AnimatorControllerParameter>();

        public bool hasParameterOfName(string name)
        {
            if (parameters == null || parameters.Count <= 0) return false;

            bool result = false;
            foreach (AnimatorControllerParameter parameter in parameters)
            {
                if (parameter.name == name)
                    result = true;
                break;
            }

            return result;
        }

        public AnimatorControllerParameter getParameterOfName(string name)
        {
            if (parameters != null && parameters.Count > 0)
            {
                foreach (AnimatorControllerParameter parameter in parameters)
                {
                    if (parameter.name == name)
                        return parameter;
                }
            }

            return null;
        }
    }

    public class StateMachineAssociation
    {
        public int ReferenceInstanceID;
        public AnimatorStateMachine replacement = null;
    }
    public class StateAssociation
    {
        public int ReferenceInstanceID;
        public AnimatorState replacement = null;
    }

    public class RenameDefinition
    {
        public string oldName;
        public string newName;
        public AnimatorControllerParameterType type;
        public Components.AnimatorType ignoreAnimatorType = Components.AnimatorType.FX;

        public MenuSystem.Parameter.ParameterType GetIntermParameterType()
        {
            switch (type)
            {
                case AnimatorControllerParameterType.Float:
                    return MenuSystem.Parameter.ParameterType.Float;
                case AnimatorControllerParameterType.Int:
                    return MenuSystem.Parameter.ParameterType.Int;
                default:
                    return MenuSystem.Parameter.ParameterType.Bool;
            }
        }

        public void SetParameterTypeFromInterm(MenuSystem.Parameter.ParameterType iaType)
        {
            switch (iaType)
            {
                case MenuSystem.Parameter.ParameterType.Float:
                    type = AnimatorControllerParameterType.Float;
                    break;
                case MenuSystem.Parameter.ParameterType.Int:
                    type = AnimatorControllerParameterType.Int;
                    break;
                default:
                    type = AnimatorControllerParameterType.Bool;
                    break;
            }
        }

    }

}

#endif