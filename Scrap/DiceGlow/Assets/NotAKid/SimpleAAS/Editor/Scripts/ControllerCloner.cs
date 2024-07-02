// MIT License

// Copyright (c) 2022 VRLabs

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

//https://github.com/VRLabs/Avatars-3.0-Manager

#if UNITY_EDITOR && CVR_CCK_EXISTS
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using ABI.CCK.Components;
using UnityEditor;
using UnityEditor.Animations;
using UnityEngine;

namespace NAK.SimpleAAS
{
    public static class ControllerCloner
    {
        public const string STANDARD_NEW_CONTROLLER_FOLDER = "Assets/NotAKid/SimpleAAS.Generated/Controllers/";
        private static Dictionary<string, string> _parametersNewName;
        private static string _assetPath;
        private static string _fileName;

        public static AnimatorController MergeMultipleControllers(AnimatorController[] controllersToMerge,
            Dictionary<string, string> paramNameSwap = null, bool saveToNew = true, bool useUnique = false,
            string newName = null)
        {
            AnimatorController mainController = controllersToMerge[0];
            if (mainController == null) return null;

            _parametersNewName = paramNameSwap ?? new Dictionary<string, string>();
            _assetPath = AssetDatabase.GetAssetPath(mainController);
            _fileName = newName == null ? Path.GetFileName(_assetPath) : $"{newName}{Path.GetExtension(_assetPath)}";

            if (saveToNew)
            {
                Directory.CreateDirectory(STANDARD_NEW_CONTROLLER_FOLDER);
                var uniquePath = useUnique
                    ? AssetDatabase.GenerateUniqueAssetPath($"{STANDARD_NEW_CONTROLLER_FOLDER}{_fileName}")
                    : $"{STANDARD_NEW_CONTROLLER_FOLDER}{_fileName}";
                AssetDatabase.CopyAsset(_assetPath, uniquePath);
                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
                _assetPath = uniquePath;
                mainController = AssetDatabase.LoadAssetAtPath<AnimatorController>(_assetPath);
            }

            if (controllersToMerge.Length > 1)
                for (var c = 1; c < controllersToMerge.Length; c++)
                {
                    AnimatorController controllerToMerge = controllersToMerge[c];
                    AddNewParameters(mainController, controllerToMerge);
                    MergeControllerLayers(mainController, controllerToMerge);
                }

            // Remove comment parameters from final controller
            RemoveCommentParameters(mainController);
            EditorUtility.SetDirty(mainController);
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            return mainController;
        }

        private static void AddNewParameters(AnimatorController mainController, AnimatorController controllerToMerge)
        {
            foreach (AnimatorControllerParameter p in controllerToMerge.parameters)
            {
                AnimatorControllerParameter newP = new AnimatorControllerParameter()
                {
                    name = GetNewParameterNameIfSwapped(p.name),
                    type = p.type,
                    defaultBool = p.defaultBool,
                    defaultFloat = p.defaultFloat,
                    defaultInt = p.defaultInt
                };
                if (!mainController.parameters.Any(x => x.name.Equals(newP.name))) mainController.AddParameter(newP);
            }
        }

        private static void MergeControllerLayers(AnimatorController mainController,
            AnimatorController controllerToMerge)
        {
            for (var i = 0; i < controllerToMerge.layers.Length; i++)
            {
                AnimatorControllerLayer newL = CloneLayer(controllerToMerge.layers[i], i == 0);
                newL.name = mainController.MakeUniqueLayerName(newL.name);
                newL.stateMachine.name = newL.name;
                mainController.AddLayer(newL);
            }
        }

        private static void RemoveCommentParameters(AnimatorController mainController)
        {
            var parametersToRemove = mainController.parameters
                .Where(p => p.name.StartsWith("#--") && p.type == AnimatorControllerParameterType.Trigger)
                .ToList();

            foreach (AnimatorControllerParameter p in parametersToRemove) mainController.RemoveParameter(p);
        }

        private static string GetNewParameterNameIfSwapped(string parameterName)
        {
            return !string.IsNullOrWhiteSpace(parameterName) &&
                   _parametersNewName.TryGetValue(parameterName, out var parameterNewName)
                ? parameterNewName
                : parameterName;
        }

        private static string MakeLayerNameUnique(string name, AnimatorController controller)
        {
            var st = "";
            var c = 0;
            var combinedNameDuplicate = controller.layers.Count(x => x.name.Equals(name)) > 0;
            while (combinedNameDuplicate)
            {
                c++;
                combinedNameDuplicate = controller.layers.Count(x => x.name.Equals(name + st + c)) > 0;
            }

            if (c != 0) st += c;

            return name + st;
        }

        private static AnimatorControllerLayer CloneLayer(AnimatorControllerLayer old, bool isFirstLayer = false)
        {
            AnimatorControllerLayer n = new AnimatorControllerLayer()
            {
                avatarMask = old.avatarMask,
                blendingMode = old.blendingMode,
                defaultWeight = isFirstLayer ? 1f : old.defaultWeight,
                iKPass = old.iKPass,
                name = old.name,
                syncedLayerAffectsTiming = old.syncedLayerAffectsTiming,
                stateMachine = CloneStateMachine(old.stateMachine)
            };
            CloneTransitions(old.stateMachine, n.stateMachine);
            return n;
        }

        private static AnimatorStateMachine CloneStateMachine(AnimatorStateMachine old)
        {
            AnimatorStateMachine n = new AnimatorStateMachine()
            {
                anyStatePosition = old.anyStatePosition,
                entryPosition = old.entryPosition,
                exitPosition = old.exitPosition,
                hideFlags = old.hideFlags,
                name = old.name,
                parentStateMachinePosition = old.parentStateMachinePosition,
                stateMachines = old.stateMachines.Select(x => CloneChildStateMachine(x)).ToArray(),
                states = old.states.Select(x => CloneChildAnimatorState(x)).ToArray()
            };

            AssetDatabase.AddObjectToAsset(n, _assetPath);
            n.defaultState = FindState(old.defaultState, old, n);

            foreach (StateMachineBehaviour oldb in old.behaviours)
            {
                StateMachineBehaviour behaviour = n.AddStateMachineBehaviour(oldb.GetType());
                CloneBehaviourParameters(oldb, behaviour);
            }

            return n;
        }

        private static ChildAnimatorStateMachine CloneChildStateMachine(ChildAnimatorStateMachine old)
        {
            ChildAnimatorStateMachine n = new ChildAnimatorStateMachine()
            {
                position = old.position,
                stateMachine = CloneStateMachine(old.stateMachine)
            };
            return n;
        }

        private static ChildAnimatorState CloneChildAnimatorState(ChildAnimatorState old)
        {
            ChildAnimatorState n = new ChildAnimatorState()
            {
                position = old.position,
                state = CloneAnimatorState(old.state)
            };
            foreach (StateMachineBehaviour oldb in old.state.behaviours)
            {
                StateMachineBehaviour behaviour = n.state.AddStateMachineBehaviour(oldb.GetType());
                CloneBehaviourParameters(oldb, behaviour);
            }

            return n;
        }

        private static AnimatorState CloneAnimatorState(AnimatorState old)
        {
            // Checks if the motion is a blend tree, to avoid accidental blend tree sharing between animator assets
            Motion motion = old.motion;
            if (motion is BlendTree oldTree)
            {
                BlendTree tree = CloneBlendTree(null, oldTree);
                motion = tree;
                // need to save the blend tree into the animator
                tree.hideFlags = HideFlags.HideInHierarchy;
                AssetDatabase.AddObjectToAsset(motion, _assetPath);
            }

            AnimatorState n = new AnimatorState()
            {
                cycleOffset = old.cycleOffset,
                cycleOffsetParameter = GetNewParameterNameIfSwapped(old.cycleOffsetParameter),
                cycleOffsetParameterActive = old.cycleOffsetParameterActive,
                hideFlags = old.hideFlags,
                iKOnFeet = old.iKOnFeet,
                mirror = old.mirror,
                mirrorParameter = GetNewParameterNameIfSwapped(old.mirrorParameter),
                mirrorParameterActive = old.mirrorParameterActive,
                motion = motion,
                name = old.name,
                speed = old.speed,
                speedParameter = GetNewParameterNameIfSwapped(old.speedParameter),
                speedParameterActive = old.speedParameterActive,
                tag = old.tag,
                timeParameter = GetNewParameterNameIfSwapped(old.timeParameter),
                timeParameterActive = old.timeParameterActive,
                writeDefaultValues = old.writeDefaultValues
            };
            AssetDatabase.AddObjectToAsset(n, _assetPath);
            return n;
        }

        // Taken from here: https://gist.github.com/phosphoer/93ca8dcbf925fc006e4e9f6b799c13b0
        private static BlendTree CloneBlendTree(BlendTree parentTree, BlendTree oldTree)
        {
            // Create a child tree in the destination parent, this seems to be the only way to correctly 
            // add a child tree as opposed to AddChild(motion)
            BlendTree pastedTree = new BlendTree();
            pastedTree.name = oldTree.name;
            pastedTree.blendType = oldTree.blendType;
            pastedTree.blendParameter = GetNewParameterNameIfSwapped(oldTree.blendParameter);
            pastedTree.blendParameterY = GetNewParameterNameIfSwapped(oldTree.blendParameterY);
            pastedTree.minThreshold = oldTree.minThreshold;
            pastedTree.maxThreshold = oldTree.maxThreshold;
            pastedTree.useAutomaticThresholds = oldTree.useAutomaticThresholds;

            // Recursively duplicate the tree structure
            // Motions can be directly added as references while trees must be recursively to avoid accidental sharing
            foreach (ChildMotion child in oldTree.children)
            {
                var children = pastedTree.children;

                ChildMotion childMotion = new ChildMotion()
                {
                    timeScale = child.timeScale,
                    position = child.position,
                    cycleOffset = child.cycleOffset,
                    mirror = child.mirror,
                    threshold = child.threshold,
                    directBlendParameter = GetNewParameterNameIfSwapped(child.directBlendParameter)
                };

                if (child.motion is BlendTree tree)
                {
                    BlendTree childTree = CloneBlendTree(pastedTree, tree);
                    childMotion.motion = childTree;
                    // need to save the blend tree into the animator
                    childTree.hideFlags = HideFlags.HideInHierarchy;
                    AssetDatabase.AddObjectToAsset(childTree, _assetPath);
                }
                else
                {
                    childMotion.motion = child.motion;
                }

                ArrayUtility.Add(ref children, childMotion);
                pastedTree.children = children;
            }

            return pastedTree;
        }

        private static void CloneBehaviourParameters(StateMachineBehaviour old, StateMachineBehaviour n)
        {
            if (old.GetType() != n.GetType())
                throw new ArgumentException("2 state machine behaviours that should be of the same type are not.");

            switch (n)
            {
                case AnimatorDriver l:
                {
                    AnimatorDriver o = old as AnimatorDriver;
                    l.EnterTasks = o.EnterTasks.ConvertAll(task => new AnimatorDriverTask
                    {
                        aName = GetNewParameterNameIfSwapped(task.aName),
                        aType = task.aType,
                        aValue = task.aValue,
                        aMax = task.aMax,
                        aParamType = task.aParamType,
                        bName = GetNewParameterNameIfSwapped(task.bName),
                        bType = task.bType,
                        bValue = task.bValue,
                        bMax = task.bMax,
                        bParamType = task.bParamType,
                        targetType = task.targetType,
                        targetName = GetNewParameterNameIfSwapped(task.targetName),
                        op = task.op
                    });
                    l.ExitTasks = o.ExitTasks.ConvertAll(task => new AnimatorDriverTask
                    {
                        aName = GetNewParameterNameIfSwapped(task.aName),
                        aType = task.aType,
                        aValue = task.aValue,
                        aMax = task.aMax,
                        aParamType = task.aParamType,
                        bName = GetNewParameterNameIfSwapped(task.bName),
                        bType = task.bType,
                        bValue = task.bValue,
                        bMax = task.bMax,
                        bParamType = task.bParamType,
                        targetType = task.targetType,
                        targetName = GetNewParameterNameIfSwapped(task.targetName),
                        op = task.op
                    });
                    break;
                }
            }
        }

        private static AnimatorState FindState(AnimatorState original, AnimatorStateMachine old, AnimatorStateMachine n)
        {
            var oldStates = GetStatesRecursive(old).ToArray();
            var newStates = GetStatesRecursive(n).ToArray();
            for (var i = 0; i < oldStates.Length; i++)
                if (oldStates[i] == original)
                    return newStates[i];

            return null;
        }

        private static AnimatorStateMachine FindStateMachine(AnimatorStateTransition transition,
            AnimatorStateMachine sm)
        {
            var childrenSm = sm.stateMachines.Select(x => x.stateMachine).ToArray();
            AnimatorStateMachine dstSm = Array.Find(childrenSm, x => x.name == transition.destinationStateMachine.name);
            if (dstSm != null)
                return dstSm;

            foreach (AnimatorStateMachine childSm in childrenSm)
            {
                dstSm = FindStateMachine(transition, childSm);
                if (dstSm != null)
                    return dstSm;
            }

            return null;
        }

        private static List<AnimatorState> GetStatesRecursive(AnimatorStateMachine sm)
        {
            var childrenStates = sm.states.Select(x => x.state).ToList();
            foreach (AnimatorStateMachine child in sm.stateMachines.Select(x => x.stateMachine))
                childrenStates.AddRange(GetStatesRecursive(child));

            return childrenStates;
        }

        private static List<AnimatorStateMachine> GetStateMachinesRecursive(AnimatorStateMachine sm,
            IDictionary<AnimatorStateMachine, AnimatorStateMachine> newAnimatorsByChildren = null)
        {
            var childrenSm = sm.stateMachines.Select(x => x.stateMachine).ToList();

            var gcsm = new List<AnimatorStateMachine>();
            gcsm.Add(sm);
            foreach (AnimatorStateMachine child in childrenSm)
            {
                newAnimatorsByChildren?.Add(child, sm);
                gcsm.AddRange(GetStateMachinesRecursive(child, newAnimatorsByChildren));
            }

            return gcsm;
        }

        private static AnimatorState FindMatchingState(List<AnimatorState> old, List<AnimatorState> n,
            AnimatorTransitionBase transition)
        {
            for (var i = 0; i < old.Count; i++)
                if (transition.destinationState == old[i])
                    return n[i];

            return null;
        }

        private static AnimatorStateMachine FindMatchingStateMachine(List<AnimatorStateMachine> old,
            List<AnimatorStateMachine> n, AnimatorTransitionBase transition)
        {
            for (var i = 0; i < old.Count; i++)
                if (transition.destinationStateMachine == old[i])
                    return n[i];

            return null;
        }

        private static void CloneTransitions(AnimatorStateMachine old, AnimatorStateMachine n)
        {
            var oldStates = GetStatesRecursive(old);
            var newStates = GetStatesRecursive(n);
            var newAnimatorsByChildren = new Dictionary<AnimatorStateMachine, AnimatorStateMachine>();
            var oldAnimatorsByChildren = new Dictionary<AnimatorStateMachine, AnimatorStateMachine>();
            var oldStateMachines = GetStateMachinesRecursive(old, oldAnimatorsByChildren);
            var newStateMachines = GetStateMachinesRecursive(n, newAnimatorsByChildren);
            // Generate state transitions
            for (var i = 0; i < oldStates.Count; i++)
                foreach (AnimatorStateTransition transition in oldStates[i].transitions)
                {
                    AnimatorStateTransition newTransition = null;
                    if (transition.isExit && transition.destinationState == null &&
                        transition.destinationStateMachine == null)
                    {
                        newTransition = newStates[i].AddExitTransition();
                    }
                    else if (transition.destinationState != null)
                    {
                        AnimatorState dstState = FindMatchingState(oldStates, newStates, transition);
                        if (dstState != null)
                            newTransition = newStates[i].AddTransition(dstState);
                    }
                    else if (transition.destinationStateMachine != null)
                    {
                        AnimatorStateMachine dstState =
                            FindMatchingStateMachine(oldStateMachines, newStateMachines, transition);
                        if (dstState != null)
                            newTransition = newStates[i].AddTransition(dstState);
                    }

                    if (newTransition != null)
                        ApplyTransitionSettings(transition, newTransition);
                }

            for (var i = 0; i < oldStateMachines.Count; i++)
            {
                if (oldAnimatorsByChildren.ContainsKey(oldStateMachines[i]) &&
                    newAnimatorsByChildren.ContainsKey(newStateMachines[i]))
                    foreach (AnimatorTransition transition in oldAnimatorsByChildren[oldStateMachines[i]]
                                 .GetStateMachineTransitions(oldStateMachines[i]))
                    {
                        AnimatorTransition newTransition = null;
                        if (transition.isExit && transition.destinationState == null &&
                            transition.destinationStateMachine == null)
                        {
                            newTransition = newAnimatorsByChildren[newStateMachines[i]]
                                .AddStateMachineExitTransition(newStateMachines[i]);
                        }
                        else if (transition.destinationState != null)
                        {
                            AnimatorState dstState = FindMatchingState(oldStates, newStates, transition);
                            if (dstState != null)
                                newTransition = newAnimatorsByChildren[newStateMachines[i]]
                                    .AddStateMachineTransition(newStateMachines[i], dstState);
                        }
                        else if (transition.destinationStateMachine != null)
                        {
                            AnimatorStateMachine dstState =
                                FindMatchingStateMachine(oldStateMachines, newStateMachines, transition);
                            if (dstState != null)
                                newTransition = newAnimatorsByChildren[newStateMachines[i]]
                                    .AddStateMachineTransition(newStateMachines[i], dstState);
                        }

                        if (newTransition != null)
                            ApplyTransitionSettings(transition, newTransition);
                    }

                // Generate AnyState transitions
                GenerateStateMachineBaseTransitions(oldStateMachines[i], newStateMachines[i], oldStates, newStates,
                    oldStateMachines, newStateMachines);
            }
        }

        private static void GenerateStateMachineBaseTransitions(AnimatorStateMachine old, AnimatorStateMachine n,
            List<AnimatorState> oldStates,
            List<AnimatorState> newStates, List<AnimatorStateMachine> oldStateMachines,
            List<AnimatorStateMachine> newStateMachines)
        {
            foreach (AnimatorStateTransition transition in old.anyStateTransitions)
            {
                AnimatorStateTransition newTransition = null;
                if (transition.destinationState != null)
                {
                    AnimatorState dstState = FindMatchingState(oldStates, newStates, transition);
                    if (dstState != null)
                        newTransition = n.AddAnyStateTransition(dstState);
                }
                else if (transition.destinationStateMachine != null)
                {
                    AnimatorStateMachine dstState =
                        FindMatchingStateMachine(oldStateMachines, newStateMachines, transition);
                    if (dstState != null)
                        newTransition = n.AddAnyStateTransition(dstState);
                }

                if (newTransition != null)
                    ApplyTransitionSettings(transition, newTransition);
            }

            // Generate EntryState transitions
            foreach (AnimatorTransition transition in old.entryTransitions)
            {
                AnimatorTransition newTransition = null;
                if (transition.destinationState != null)
                {
                    AnimatorState dstState = FindMatchingState(oldStates, newStates, transition);
                    if (dstState != null)
                        newTransition = n.AddEntryTransition(dstState);
                }
                else if (transition.destinationStateMachine != null)
                {
                    AnimatorStateMachine dstState =
                        FindMatchingStateMachine(oldStateMachines, newStateMachines, transition);
                    if (dstState != null)
                        newTransition = n.AddEntryTransition(dstState);
                }

                if (newTransition != null)
                    ApplyTransitionSettings(transition, newTransition);
            }
        }

        private static void ApplyTransitionSettings(AnimatorStateTransition transition,
            AnimatorStateTransition newTransition)
        {
            newTransition.canTransitionToSelf = transition.canTransitionToSelf;
            newTransition.duration = transition.duration;
            newTransition.exitTime = transition.exitTime;
            newTransition.hasExitTime = transition.hasExitTime;
            newTransition.hasFixedDuration = transition.hasFixedDuration;
            newTransition.hideFlags = transition.hideFlags;
            newTransition.isExit = transition.isExit;
            newTransition.mute = transition.mute;
            newTransition.name = transition.name;
            newTransition.offset = transition.offset;
            newTransition.interruptionSource = transition.interruptionSource;
            newTransition.orderedInterruption = transition.orderedInterruption;
            newTransition.solo = transition.solo;
            foreach (AnimatorCondition condition in transition.conditions)
                newTransition.AddCondition(condition.mode, condition.threshold,
                    GetNewParameterNameIfSwapped(condition.parameter));
        }

        private static void ApplyTransitionSettings(AnimatorTransition transition, AnimatorTransition newTransition)
        {
            newTransition.hideFlags = transition.hideFlags;
            newTransition.isExit = transition.isExit;
            newTransition.mute = transition.mute;
            newTransition.name = transition.name;
            newTransition.solo = transition.solo;
            foreach (AnimatorCondition condition in transition.conditions)
                newTransition.AddCondition(condition.mode, condition.threshold,
                    GetNewParameterNameIfSwapped(condition.parameter));
        }
    }
}
#endif