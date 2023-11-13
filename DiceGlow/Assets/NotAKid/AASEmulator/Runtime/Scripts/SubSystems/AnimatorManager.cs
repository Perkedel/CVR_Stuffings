using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace NAK.AASEmulator.Runtime.SubSystems
{
    public class AnimatorManager
    {
        #region CVR_DEFAULT_CONSTANTS

        public const string LOCAL_PARAMETER_PREFIX = "#";

        public const string LOCOMOTION_EMOTES_LAYER_NAME = "Locomotion/Emotes";
        public const string HAND_LEFT_LAYER_NAME = "LeftHand";
        public const string HAND_RIGHT_LAYER_NAME = "RightHand";
        public const string TOGGLES_LAYER_NAME = "Toggles";

        public static Dictionary<string, AnimatorControllerParameterType> CVR_DEFAULT_PARAMETERS = new Dictionary<string, AnimatorControllerParameterType>
        {
            // Floats
            { "GestureLeft", AnimatorControllerParameterType.Float },
            { "GestureRight", AnimatorControllerParameterType.Float },
            { "MovementX", AnimatorControllerParameterType.Float },
            { "MovementY", AnimatorControllerParameterType.Float },
            { "Toggle", AnimatorControllerParameterType.Float },
            { "Emote", AnimatorControllerParameterType.Float },
            // Bools
            { "Grounded", AnimatorControllerParameterType.Bool },
            { "Crouching", AnimatorControllerParameterType.Bool },
            { "Prone", AnimatorControllerParameterType.Bool },
            { "Sitting", AnimatorControllerParameterType.Bool },
            { "Flying", AnimatorControllerParameterType.Bool },
            { "Swimming", AnimatorControllerParameterType.Bool },
            // Triggers
            { "CancelEmote", AnimatorControllerParameterType.Trigger },
        };

        #endregion CVR_DEFAULT_CONSTANTS

        #region Parameter Definitions

        [Serializable]
        public class CoreParam
        {
            public string name;
            public AnimatorControllerParameterType type;
            public int nameHash;
            public bool hasParameter;

            // TODO: dont be lazy?
            public float valueFloat;

            public int valueInt;
            public bool valueBool;

            public CoreParam(string name, AnimatorControllerParameterType type, bool hasParameter)
            {
                this.name = name;
                this.type = type;
                this.hasParameter = hasParameter;
                this.nameHash = Animator.StringToHash(name);
            }
        }

        [Serializable]
        public abstract class BaseParam
        {
            public string name;
            public int nameHash;
            public bool isLocal;
            public bool isControlledByCurve;

            protected BaseParam(string name, int nameHash, bool isLocal, bool isControlledByCurve)
            {
                this.name = name;
                this.nameHash = nameHash;
                this.isLocal = isLocal;
                this.isControlledByCurve = isControlledByCurve;
            }
        }

        [Serializable]
        public class FloatParam : BaseParam
        {
            public float value;
            public float defaultValue;

            public FloatParam(string name, int nameHash, bool isLocal, bool isControlledByCurve, float value)
                : base(name, nameHash, isLocal, isControlledByCurve)
            {
                this.value = value;
                this.defaultValue = value;
            }
        }

        [Serializable]
        public class IntParam : BaseParam
        {
            public int value;
            public int defaultValue;

            public IntParam(string name, int nameHash, bool isLocal, bool isControlledByCurve, int value)
                : base(name, nameHash, isLocal, isControlledByCurve)
            {
                this.value = value;
                this.defaultValue = value;
            }
        }

        [Serializable]
        public class BoolParam : BaseParam
        {
            public bool value;
            public bool defaultValue;

            public BoolParam(string name, int nameHash, bool isLocal, bool isControlledByCurve, bool value)
                : base(name, nameHash, isLocal, isControlledByCurve)
            {
                this.value = value;
                this.defaultValue = value;
            }
        }

        [Serializable]
        public class TriggerParam : BaseParam
        {
            public bool value;
            public bool defaultValue;

            public TriggerParam(string name, int nameHash, bool isLocal, bool isControlledByCurve, bool value)
                : base(name, nameHash, isLocal, isControlledByCurve)
            {
                this.value = value;
                this.defaultValue = value;
            }
        }

        #endregion Parameter Definitions

        #region Animator Info

        public Animator animator;

        public readonly Dictionary<string, CoreParam> CoreParameters = new Dictionary<string, CoreParam>();

        // TODO: Figure this shit out
        public readonly Dictionary<string, BaseParam> Parameters = new Dictionary<string, BaseParam>();

        // Temp- only used for GUI
        public readonly List<FloatParam> FloatParameters = new List<FloatParam>();

        public readonly List<IntParam> IntParameters = new List<IntParam>();
        public readonly List<BoolParam> BoolParameters = new List<BoolParam>();
        public readonly List<TriggerParam> TriggerParameters = new List<TriggerParam>();

        public readonly Dictionary<string, int> LayerIndices = new Dictionary<string, int>();

        private int _locomotionEmotesLayerIdx = -1;
        private int _gestureLeftLayerIdx = -1;
        private int _gestureRightLayerIdx = -1;
        private int _toggleLayerIdx = -1;

        #endregion Animator Info

        public AnimatorManager(Animator animator)
        {
            this.animator = animator;
            AnalyzeAnimator();
        }

        #region Public Methods

        public void SetLayerWeight(string layerName, float weight)
        {
            if (string.IsNullOrEmpty(layerName))
                return;

            if (!LayerIndices.TryGetValue(layerName, out var layerIndex))
                return;

            animator.SetLayerWeight(layerIndex, weight);
        }

        public bool SetParameter(string name, object value)
        {
            if (string.IsNullOrEmpty(name))
                return false;

            if (!Parameters.TryGetValue(name, out BaseParam param))
                return false;

            switch (param)
            {
                case BoolParam boolParam:
                    boolParam.value = Convert.ToBoolean(value);
                    animator.SetBool(name, boolParam.value);
                    break;

                case IntParam intParam:
                    intParam.value = Convert.ToInt32(value);
                    animator.SetInteger(name, intParam.value);
                    break;

                case FloatParam floatParam:
                    floatParam.value = Convert.ToSingle(value);
                    animator.SetFloat(name, floatParam.value);
                    break;

                case TriggerParam triggerParam:
                    animator.SetTrigger(name);
                    break;

                default:
                    return false;
            }

            return true;
        }

        public bool SetCoreParameter(string name, object value)
        {
            if (string.IsNullOrEmpty(name))
                return false;

            if (!CoreParameters.TryGetValue(name, out CoreParam param))
                return false;

            switch (param.type)
            {
                case AnimatorControllerParameterType.Bool:
                    param.valueBool = Convert.ToBoolean(value);
                    if (param.hasParameter)
                        animator.SetBool(param.nameHash, param.valueBool);
                    break;

                case AnimatorControllerParameterType.Int:
                    param.valueInt = Convert.ToInt32(value);
                    if (param.hasParameter)
                        animator.SetInteger(param.nameHash, param.valueInt);
                    break;

                case AnimatorControllerParameterType.Float:
                    param.valueFloat = Convert.ToSingle(value);
                    if (param.hasParameter)
                        animator.SetFloat(param.nameHash, param.valueFloat);
                    break;

                case AnimatorControllerParameterType.Trigger:
                    param.valueBool = Convert.ToBoolean(value);
                    if (param.hasParameter)
                        animator.SetTrigger(param.nameHash); // TODO: uhhh x2
                    break;

                default:
                    return false;
            }

            return true;
        }

        public object GetParameter(string name)
        {
            if (string.IsNullOrEmpty(name))
                return null;

            if (!Parameters.TryGetValue(name, out BaseParam param))
                return null;

            switch (param)
            {
                case BoolParam boolParam:
                    return boolParam.value;

                case IntParam intParam:
                    return intParam.value;

                case FloatParam floatParam:
                    return floatParam.value;

                case TriggerParam triggerParam:
                    return triggerParam.value; // UH

                default:
                    return null;
            }
        }

        public object GetParameterFromAnimator(string name)
        {
            if (string.IsNullOrEmpty(name))
                return null;

            if (!Parameters.TryGetValue(name, out BaseParam param))
                return null;

            switch (param)
            {
                case TriggerParam triggerParam:
                case BoolParam boolParam:
                    return animator.GetBool(param.nameHash);

                case IntParam intParam:
                    return animator.GetInteger(param.nameHash);

                case FloatParam floatParam:
                    return animator.GetFloat(param.nameHash);

                default:
                    return null;
            }
        }

        public object GetCoreParameter(string name)
        {
            if (string.IsNullOrEmpty(name))
                return null;

            if (!CoreParameters.TryGetValue(name, out CoreParam param))
                return null;

            //if (!param.hasParameter)
            //    return null;

            switch (param.type)
            {
                case AnimatorControllerParameterType.Bool:
                    return param.valueBool;

                case AnimatorControllerParameterType.Int:
                    return param.valueInt;

                case AnimatorControllerParameterType.Float:
                    return param.valueFloat;

                case AnimatorControllerParameterType.Trigger:
                    return param.valueBool; // TODO: uhhhh
                default:
                    return null;
            }
        }

        public object GetCoreParameterFromAnimator(string name)
        {
            if (string.IsNullOrEmpty(name))
                return null;

            if (!CoreParameters.TryGetValue(name, out CoreParam param))
                return null;

            if (!param.hasParameter)
                return null;

            switch (param.type)
            {
                case AnimatorControllerParameterType.Bool:
                    return animator.GetBool(param.nameHash);

                case AnimatorControllerParameterType.Int:
                    return animator.GetInteger(param.nameHash);

                case AnimatorControllerParameterType.Float:
                    return animator.GetFloat(param.nameHash);

                case AnimatorControllerParameterType.Trigger:
                    return animator.GetBool(param.nameHash);

                default:
                    return null;
            }
        }

        public bool IsEmotePlaying()
        {
            if (_locomotionEmotesLayerIdx == -1) 
                return false;
            
            var clipInfo = animator.GetCurrentAnimatorClipInfo(_locomotionEmotesLayerIdx);
            return clipInfo.Any(clip => clip.clip.name.Contains("Emote"));
        }

        #endregion Public Methods

        #region Private Methods

        private void AnalyzeAnimator()
        {
            if (animator == null)
                return;

            if (animator.runtimeAnimatorController == null)
            {
                Debug.Log("No runtime animator controller found.");
                return;
            }

            int layerCount = animator.layerCount;
            for (int i = 0; i < layerCount; i++)
            {
                string layerName = animator.GetLayerName(i);
                LayerIndices[layerName] = i;
            }

            // Check for default CVR layers
            _locomotionEmotesLayerIdx = animator.GetLayerIndex(LOCOMOTION_EMOTES_LAYER_NAME);
            _gestureLeftLayerIdx = animator.GetLayerIndex(HAND_LEFT_LAYER_NAME);
            _gestureRightLayerIdx = animator.GetLayerIndex(HAND_RIGHT_LAYER_NAME);
            _toggleLayerIdx = animator.GetLayerIndex(TOGGLES_LAYER_NAME);

            AnimatorControllerParameter[] parameters = animator.parameters;

            Parameters.Clear();
            CoreParameters.Clear();
            foreach (var parameter in CVR_DEFAULT_PARAMETERS)
                CoreParameters[parameter.Key] = new CoreParam(parameter.Key, parameter.Value, false);

            foreach (AnimatorControllerParameter param in parameters)
            {
                string paramName = param.name;
                bool isLocal = paramName.StartsWith(LOCAL_PARAMETER_PREFIX);
                bool isControlledByCurve = animator.IsParameterControlledByCurve(paramName);

                // Core Parameters sadly do not support type-mismatch...
                if (CoreParameters.TryGetValue(paramName, out CoreParam coreParam))
                {
                    if (coreParam.type == param.type)
                        coreParam.hasParameter = true;
                    continue;
                }

                switch (param.type)
                {
                    case AnimatorControllerParameterType.Bool:
                        BoolParam boolParam = new BoolParam(paramName, param.nameHash, isLocal, isControlledByCurve, param.defaultBool);
                        Parameters[paramName] = boolParam;
                        BoolParameters.Add(boolParam);
                        break;

                    case AnimatorControllerParameterType.Int:
                        IntParam intParam = new IntParam(paramName, param.nameHash, isLocal, isControlledByCurve, param.defaultInt);
                        Parameters[paramName] = intParam;
                        IntParameters.Add(intParam);
                        break;

                    case AnimatorControllerParameterType.Float:
                        FloatParam floatParam = new FloatParam(paramName, param.nameHash, isLocal, isControlledByCurve, param.defaultFloat);
                        Parameters[paramName] = floatParam;
                        FloatParameters.Add(floatParam);
                        break;

                    case AnimatorControllerParameterType.Trigger:
                        TriggerParam triggerParam = new TriggerParam(paramName, param.nameHash, isLocal, isControlledByCurve, param.defaultBool);
                        Parameters[paramName] = triggerParam;
                        TriggerParameters.Add(triggerParam);
                        break;

                    default:
                        break;
                }
            }
        }

        #endregion Private Methods
    }
}