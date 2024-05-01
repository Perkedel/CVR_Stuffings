using System.Collections.Generic;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
using UnityEditor.Animations;
#endif

public class GenerateMidiAnimator : MonoBehaviour {
    [Range(1, 40)] public int paramCount = 10;
    public AnimationClip notPlayingClip;
    public List<AnimationClip> animationClips;
}

#if UNITY_EDITOR
[CustomEditor(typeof(GenerateMidiAnimator))]
public class AnimatorGeneratorEditor : Editor {

    private const string AnimatorPath = "Assets/kafeijao/Scripts/GenerateMidiAnimator/GeneratedMidiAnimator.controller";

    public override void OnInspectorGUI() {

        if (Application.isPlaying) {
            EditorGUILayout.HelpBox("Script doesn't work in play mode...", MessageType.Error);
            return;
        }

        DrawDefaultInspector();

        var generateMidiAnimator = (GenerateMidiAnimator)target;
        if (GUILayout.Button("Generate Animator")) {
            GenerateAnimator(generateMidiAnimator);
        }

        EditorGUILayout.HelpBox($"The animation names you going to add to Animation Clips, need to contain midi_X_, " +
                                $"where X is the midi note id (goes from 0 to 127), for example: midi_38_C.anim. If a " +
                                $"certain node matches no node, it will use the empty animation.", MessageType.Info);
        EditorGUILayout.HelpBox($"After pressing Generate Unity will freeze for like 30 seconds, so wait patiently...", MessageType.Info);
        EditorGUILayout.HelpBox($"This will generate an animator on {AnimatorPath}! If a file already exists " +
                                $"in this path, the animator won't be generated...", MessageType.Warning);
    }

    private static void GenerateAnimator(GenerateMidiAnimator generateMidiAnimator) {
        // Create a new animator controller asset
        var animatorController = AnimatorController.CreateAnimatorControllerAtPath(AnimatorPath);

        // Iterate through the parameter count and create parameters and layers
        for (var i = 1; i <= generateMidiAnimator.paramCount; i++) {
            var paramName = $"Key_{i}";

            // Create a new float parameter with a default value of -1
            var parameter = new AnimatorControllerParameter {
                name = paramName,
                type = AnimatorControllerParameterType.Float,
                defaultFloat = -1f
            };
            animatorController.AddParameter(parameter);

            // Create a new layer with the same name as the parameter
            var layer = new AnimatorControllerLayer {
                stateMachine = new AnimatorStateMachine(),
                name = paramName,
                defaultWeight = 1f,
            };

            // Add the layer to the controller
            animatorController.AddLayer(layer);

            // Create the state machine for the layer
            var stateMachine = layer.stateMachine;

            // Create the Not_Playing_Node and set its animation clip
            var notPlayingNode = stateMachine.AddState("Not_Playing");
            notPlayingNode.motion = generateMidiAnimator.notPlayingClip;

            // Create the 128 nodes and set their animation clips
            for (var nodeIdx = 0; nodeIdx < 128; nodeIdx++) {
                var nodeName = $"Node_{nodeIdx}_Empty";
                var node = stateMachine.AddState(nodeName);

                // Assign the animation clip matching the midi_X pattern
                var clip = generateMidiAnimator.animationClips.Find(c => c != null && c.name.Contains($"midi_{nodeIdx}_"));
                node.motion = clip != null ? clip : generateMidiAnimator.notPlayingClip;
                if (clip != null) {
                    node.name = clip.name;
                }

                // Set transition conditions
                var nodeValue = nodeIdx / 127f;
                const float threshold = 1f / (127f * 2f);

                var toNodeTransition = stateMachine.AddAnyStateTransition(node);
                toNodeTransition.AddCondition(AnimatorConditionMode.Greater, nodeValue - threshold, paramName);
                toNodeTransition.AddCondition(AnimatorConditionMode.Less, nodeValue + threshold, paramName);
                toNodeTransition.hasExitTime = false;
                toNodeTransition.canTransitionToSelf = false;
                toNodeTransition.duration = 0f;
                toNodeTransition.exitTime = 0f;

                var toNotPlayingNodeTransitionLess = node.AddTransition(notPlayingNode);
                toNotPlayingNodeTransitionLess.AddCondition(AnimatorConditionMode.Less, nodeValue - threshold, paramName);
                toNotPlayingNodeTransitionLess.hasExitTime = false;
                toNotPlayingNodeTransitionLess.canTransitionToSelf = false;
                toNotPlayingNodeTransitionLess.duration = 0f;
                toNotPlayingNodeTransitionLess.exitTime = 0f;

                var toNotPlayingNodeTransitionGreater = node.AddTransition(notPlayingNode);
                toNotPlayingNodeTransitionGreater.AddCondition(AnimatorConditionMode.Greater, nodeValue + threshold, paramName);
                toNotPlayingNodeTransitionGreater.hasExitTime = false;
                toNotPlayingNodeTransitionGreater.canTransitionToSelf = false;
                toNotPlayingNodeTransitionGreater.duration = 0f;
                toNotPlayingNodeTransitionGreater.exitTime = 0f;
            }
        }

        // Save the changes to the animator controller asset
        EditorUtility.SetDirty(animatorController);
        AssetDatabase.SaveAssets();

        Debug.Log($"Finished generating the animator, saving to {AnimatorPath}");
    }
}
#endif
