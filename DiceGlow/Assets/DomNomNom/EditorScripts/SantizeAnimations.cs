#if UNITY_EDITOR

// Copyright DomNomNom 2020

using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEngine;
using UnityEngine.UIElements;
using UnityEditor.UIElements;
using UnityEngine.Animations;
using UnityEditor.Animations;

public class SanitizeAnimations : EditorWindow
{
    // private AnimatorController animatorController;
    private Animator animator;
    private bool instantTransitions = true;
    private bool setWriteDefaults = true;
    private bool setLayerWeightsTo1 = true;
    private bool setLoopTime = true;

    private bool writeDefaults = false;
    private bool loopTime = false;


    [MenuItem("Tools/DomNomNom/SanitizeAnimations")]
    public static void ShowMyEditor()
    {
      // This method is called when the user selects the menu item in the Editor
      EditorWindow wnd = GetWindow<SanitizeAnimations>();
      wnd.titleContent = new GUIContent("SanitizeAnimations");
    }

    public void OnGUI() {
        int total_height = 3;
        int margin_bottom = 2;
        int margin_left = 3;
        int margin_right = margin_left;
        void indent(int margin_left_change) {
            margin_left += margin_left_change;
        }
        Rect R(int height) {
            float y = total_height;
            total_height += height;
            total_height += margin_bottom;
            return new Rect(margin_left, y, position.width - margin_left - margin_right, height);
        }


        animator = EditorGUI.ObjectField(R(20), "Animator", animator, typeof(Animator), true) as Animator;
        // animatorController = EditorGUI.ObjectField(R(20), "AnimatorController", animatorController, typeof(AnimatorController), true) as AnimatorController;

        instantTransitions = EditorGUI.ToggleLeft(R(20), "instant transitions", instantTransitions);
        setLayerWeightsTo1 = EditorGUI.ToggleLeft(R(20), "set LayerWeights = 1", setLayerWeightsTo1);
        if (setWriteDefaults = EditorGUI.ToggleLeft(R(20), "set writeDefaults", setWriteDefaults)) {
            indent(10);
            writeDefaults = EditorGUI.ToggleLeft(R(20), "writeDefaults", writeDefaults);
            indent(-10);
        }
        if (setLoopTime = EditorGUI.ToggleLeft(R(20), "set loopTime", setLoopTime)) {
            indent(10);
            loopTime = EditorGUI.ToggleLeft(R(20), "loopTime", loopTime);
            indent(-10);
        }

        R(20);

        if (GUI.Button(R(40), "Go!")) {
            Go();
        }
    }

    private void makeTransitionsInstant(AnimatorStateMachine machine) {
        if (machine == null) return;
        ChildAnimatorState[] states = machine.states;
        if (states == null) return;
        foreach (ChildAnimatorState c in states) {
            AnimatorState state = c.state;
            AnimatorStateTransition[] transitions = state.transitions;
            state.speed = 1000; // shouldn't spend time waiting to get to the end of each animation
            foreach (AnimatorStateTransition t in transitions) {
                t.hasExitTime = true;
                t.exitTime = 0;
                t.hasFixedDuration = true;
                t.duration = 0;
            }
        }
    }

    private void applySetDefaults(AnimatorStateMachine machine) {
        if (machine == null) return;
        ChildAnimatorState[] states = machine.states;
        if (states == null) return;
        foreach (ChildAnimatorState c in states) {
            AnimatorState state = c.state;
            state.writeDefaultValues = writeDefaults;
        }

    }

    private void applyLoopTime(AnimatorStateMachine machine) {
        if (machine == null) return;
        ChildAnimatorState[] states = machine.states;
        if (states == null) return;
        foreach (ChildAnimatorState c in states) {
            AnimatorState state = c.state;
            if (state.motion is AnimationClip) {
                AnimationClip clip = (AnimationClip) state.motion;
                // clip.wrapMode = WrapMode.Once;
                var settings = AnimationUtility.GetAnimationClipSettings(clip);
                settings.loopTime = loopTime;
                AnimationUtility.SetAnimationClipSettings(clip, settings);
            }
        }

    }


    private void Go() {

        int total_tasks = 0;
        total_tasks++; // Gathering tasks
        if (setLayerWeightsTo1) {
            total_tasks++;
        };
        int completed_tasks = 0;
        void progress(string task_name) {
            EditorUtility.DisplayProgressBar("SanitizeAnimations", task_name, ((float)completed_tasks) / (total_tasks+1));
            completed_tasks += 1;
        }
        progress("Gathering tasks");

        try {
            AnimatorController animatorController = UnityEditor.AssetDatabase.LoadAssetAtPath<UnityEditor.Animations.AnimatorController>(UnityEditor.AssetDatabase.GetAssetPath(animator.runtimeAnimatorController));
            List<AnimatorStateTransition> tasks_instantTransitions = new List<AnimatorStateTransition>();
            List<AnimatorState> tasks_setWriteDefaults = new List<AnimatorState>();

            // AssetDatabase.StartAssetEditing();


            if (instantTransitions) {
                foreach (AnimatorControllerLayer layer in animatorController.layers) {
                    makeTransitionsInstant(layer.stateMachine);
                }
            }

            if (setWriteDefaults) {
                foreach (AnimatorControllerLayer layer in animatorController.layers) {
                    applySetDefaults(layer.stateMachine);
                }
            }

            if (setLoopTime) {
                foreach (AnimatorControllerLayer layer in animatorController.layers) {
                    applyLoopTime(layer.stateMachine);
                }
            }

            // All tasks gathered.

            // for (int i=0; i<tasks_setLayerWeightsTo1.Count; ++i) {
            //     progress($"tasks_setLayerWeightsTo1 ({i} / {tasks_setLayerWeightsTo1.Count})");

            //     Debug.Log($"ww [{animator.GetLayerIndex(tasks_setLayerWeightsTo1[i].name)}] {tasks_setLayerWeightsTo1[i].name} {tasks_setLayerWeightsTo1[i].defaultWeight} and {animator.GetLayerWeight(i)}");
            //     tasks_setLayerWeightsTo1[i].defaultWeight = 1;
            //     // EditorUtility.SetDirty(tasks_setLayerWeightsTo1[i]);

            //     Debug.Log($"ww2 {tasks_setLayerWeightsTo1[i].name} {tasks_setLayerWeightsTo1[i].defaultWeight} and {animator.GetLayerWeight(i)}");
            //     // animator.SetLayerWeight(i, 1f);
            // }
            if (setLayerWeightsTo1) {
                progress($"setLayerWeightsTo1");
                AnimatorControllerLayer[] layers = animatorController.layers;
                for (int i=0; i<layers.Length; ++i) {
                    layers[i].defaultWeight = 1;
                }
                animatorController.layers = layers;  // This seems to be necessary for things to propagate.
            }



            // progress("saving asset database");
            // AssetDatabase.StopAssetEditing();
            // EditorUtility.SetDirty(animator);
            // EditorUtility.SetDirty(animatorController);
            // AssetDatabase.SaveAssets();
            // AssetDatabase.Refresh();

            // foreach(AnimatorControllerLayer l in animatorController.layers) {
            //     progress(f"set LayerWeights = 1 (")
            // }
            // for(int i = 0; i < tools.Count; i++) {
            // }
            Debug.Log("Done! :D");
        } finally {
            EditorUtility.ClearProgressBar();
        }
    }

}

#else
 public class SanitizeAnimations{}
#endif
