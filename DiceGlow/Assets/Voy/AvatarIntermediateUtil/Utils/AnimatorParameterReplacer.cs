using System;
using System.Collections.Generic;
using UnityEngine;

#if UNITY_EDITOR
using UnityEditor;
using UnityEditor.Animations;


namespace Voy.IntermediateAvatar.Utils
{
    public static class AnimatorHelper
    {
        public static AnimatorController GetAnimator(RuntimeAnimatorController runtimeAnimatorController)
        {
            return AssetDatabase.LoadAssetAtPath<AnimatorController>(AssetDatabase.GetAssetPath(runtimeAnimatorController));
        }
    }

    public static class AnimatorParameterRenamer
    {
        public static void RenameParameter(AnimatorController animatorController, string oldParameterName, string newParameterName, List<string> reservedNames = default)
        {
            if (animatorController == null || string.IsNullOrEmpty(oldParameterName) || string.IsNullOrEmpty(newParameterName))
            {
                Debug.LogWarning("Please fill all fields.");
                return;
            }

            int i = -1;
            foreach (var parameter in animatorController.parameters)
            {
                i++;

                if (reservedNames.Contains(parameter.name))
                {
                    if (parameter.name == oldParameterName)
                    {
                        return;
                    }    
                        continue;
                }

                if (parameter.name == oldParameterName)
                {
                    if (!doesParameterAlreadyExist(animatorController, i, newParameterName))
                    {
                        parameter.name = newParameterName;
                        Debug.Log($"Parameter '{oldParameterName}' renamed to '{newParameterName}'.");
                        EditorUtility.SetDirty(animatorController);
                    }

                    AnimatorControllerLayer[] controllerLayers = animatorController.layers;

                    animatorController.layers = RenameParameterInLayers(controllerLayers, oldParameterName, newParameterName);

                    return; // No need to continue searching
                }
            }

            Debug.LogWarning($"Parameter '{oldParameterName}' not found in the Animator Controller.");
        }

        private static bool doesParameterAlreadyExist(AnimatorController animatorController, int ignoreIdx, string name)
        {
            int i = -1;

            foreach (var parameter in animatorController.parameters)
            {
                i++;

                if (i == ignoreIdx) continue;

                if (parameter.name == name) return true;
            }

            return false;

        }

        private static AnimatorControllerLayer[] RenameParameterInLayers(AnimatorControllerLayer[] layers, string oldName, string newName)
        {
            List<AnimatorControllerLayer> newLayers = new List<AnimatorControllerLayer>();
            for (int i = 0; i < layers.Length; i++)
            {
                layers[i].stateMachine.states = RenameParameterInStates(layers[i].stateMachine.states, oldName, newName);
                newLayers.Add(layers[i]);
            }
            return newLayers.ToArray();

        }

        private static ChildAnimatorState[] RenameParameterInStates(ChildAnimatorState[] states, string oldName, string newName)
        {
            List<ChildAnimatorState> newStates = new List<ChildAnimatorState>();

            // I had to convert all of this to for instead of foreach because I have to edit the array.

            // I think this is very ugly code... too bad

            //foreach ChildAnimatorState in states
            for (int chIdx = 0; chIdx < states.Length; chIdx++)
            {
                if (states[chIdx].state != null)
                {
                    if (states[chIdx].state.cycleOffsetParameter == oldName) states[chIdx].state.cycleOffsetParameter = newName;
                    if (states[chIdx].state.mirrorParameter == oldName) states[chIdx].state.mirrorParameter = newName;
                    if (states[chIdx].state.speedParameter == oldName) states[chIdx].state.speedParameter = newName;
                    if (states[chIdx].state.timeParameter == oldName) states[chIdx].state.timeParameter = newName;

                    //foreach AnimatorStateTransition in ChildAnimatorState.state.transitions
                    for (int transIdx = 0; transIdx < states[chIdx].state.transitions.Length; transIdx++)
                    {
                        //foreach AnimatorCondition in AnimatorStateTransition.conditions
                        for (int condIdx = 0; condIdx < states[chIdx].state.transitions[transIdx].conditions.Length; condIdx++)
                        {
                            AnimatorCondition condition = states[chIdx].state.transitions[transIdx].conditions[condIdx];

                            if (states[chIdx].state.transitions[transIdx].conditions[condIdx].parameter == oldName) states[chIdx].state.transitions[transIdx].conditions[condIdx].parameter = newName;

                        }

                    }

                }

                newStates.Add(states[chIdx]);
            }

            return newStates.ToArray();
        }
    }
}

#endif