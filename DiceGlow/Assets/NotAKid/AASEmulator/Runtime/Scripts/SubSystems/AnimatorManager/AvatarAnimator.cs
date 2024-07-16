using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using Debug = UnityEngine.Debug;

namespace NAK.AASEmulator.Runtime.SubSystems
{
    public class AvatarAnimator
    {
        public AvatarAnimator(bool isLocal)
        {
            if (isLocal)
                OutboundBuffer = new AASOutboundBuffer();
            else
                InboundBuffer = new AASInboundBuffer(this);
        }

        public Animator Animator { get; private set; }
        
        public bool IsHuman => Animator.isHuman;

        public ParameterAccess Parameters { get; } = new();

        #region Core Parameters
        
        private float _movementX;
        public float MovementX
        {
            get => _movementX;
            set
            {
                _movementX = value;
                Parameters.SetParameter("MovementX", value, true);
            }
        }
        
        private float _movementY;
        public float MovementY
        {
            get => _movementY;
            set
            {
                _movementY = value;
                Parameters.SetParameter("MovementY", value, true);
            }
        }
        
        private bool _grounded;
        public bool Grounded
        {
            get => _grounded;
            set
            {
                _grounded = value;
                Parameters.SetParameter("Grounded", value, true);
            }
        }
        
        private bool _crouching;
        public bool Crouching
        {
            get => _crouching;
            set
            {
                _crouching = value;
                Parameters.SetParameter("Crouching", value, true);
            }
        }
        
        private bool _prone;
        public bool Prone
        {
            get => _prone;
            set
            {
                _prone = value;
                Parameters.SetParameter("Prone", value, true);
            }
        }
        
        private bool _flying;
        public bool Flying
        {
            get => _flying;
            set
            {
                _flying = value;
                Parameters.SetParameter("Flying", value, true);
            }
        }
        
        private bool _sitting;
        public bool Sitting
        {
            get => _sitting;
            set
            {
                _sitting = value;
                Parameters.SetParameter("Sitting", value, true);
            }
        }
        
        private bool _swimming;
        public bool Swimming
        {
            get => _swimming;
            set
            {
                _swimming = value;
                Parameters.SetParameter("Swimming", value, true);
            }
        }
        
        private float _gestureRight;
        public float GestureRight
        {
            get => _gestureRight;
            set
            {
                _gestureRight = value;
                Parameters.SetParameter("GestureRight", value, true);
                Parameters.SetParameter("GestureRightIdx", Mathf.FloorToInt(value), true);
            }
        }
        
        private float _gestureLeft;
        public float GestureLeft
        {
            get => _gestureLeft;
            set
            {
                _gestureLeft = value;
                Parameters.SetParameter("GestureLeft", value, true);
                Parameters.SetParameter("GestureLeftIdx", Mathf.FloorToInt(value), true);
            }
        }
        
        private int _toggle;
        public int Toggle
        {
            get => _toggle;
            set
            {
                _toggle = value;
                Parameters.SetParameter("Toggle", value, true);
            }
        }
        
        private int _emote;
        public int Emote
        {
            get => _emote;
            set
            {
                _emote = value;
                Parameters.SetParameter("Emote", value, true);
            }
        }
        
        private bool _cancelEmote;
        public bool CancelEmote
        {
            get => _cancelEmote;
            set
            {
                _cancelEmote = value;
                Parameters.SetParameter("CancelEmote", value, true);
            }
        }
        
        private bool _isLocal;
        public bool IsLocal
        {
            get => _isLocal;
            set
            {
                _isLocal = value;
                Parameters.SetParameter("IsLocal", value, true);
            }
        }

        private float _distanceTo = -1f;
        public float DistanceTo
        {
            get => _distanceTo;
            set
            {
                _distanceTo = value;
                Parameters.SetParameter("DistanceTo", value, true);
            }
        }
        
        private int _visemeIdx;
        public int VisemeIdx
        {
            get => _visemeIdx;
            set
            {
                _visemeIdx = value;
                Parameters.SetParameter("VisemeIdx", value, true);
            }
        }
        
        private float _visemeLoudness;
        public float VisemeLoudness
        {
            get => _visemeLoudness;
            set
            {
                _visemeLoudness = value;
                Parameters.SetParameter("VisemeLoudness", value, true);
            }
        }
        
        #endregion Core Parameters
        
        #region AAS Syncing
        
        public AASOutboundBuffer OutboundBuffer { get; }
        public AASInboundBuffer InboundBuffer { get; }

        public int SyncedFloatUsage;
        public int SyncedIntUsage;
        public int SyncedByteUsage;
        public int SyncedTotalUsage;
        
        #endregion AAS Syncing

        #region Layers

        private readonly Dictionary<string, int> LayerIndices = new();
        private int _locomotionEmotesLayerIdx = -1;
        private int _leftHandLayerIdx = -1;
        private int _rightHandLayerIdx = -1;
        private int _toggleLayerIdx = -1;

        #endregion Layers

        #region Public Methods

        public void SetupManager(Animator animator, bool isLocal = false)
        {
            Animator = animator;
            Setup();
        }

        public void ResetManager()
        {
            Reset();
        }

        public void SetLayerWeight(string layerName, float weight)
        {
            if (string.IsNullOrEmpty(layerName))
                return;

            if (!LayerIndices.TryGetValue(layerName, out var layerIndex))
                return;

            Animator.SetLayerWeight(layerIndex, weight);
        }
        
        public bool IsEmotePlaying()
        {
            if (_locomotionEmotesLayerIdx == -1) 
                return false;
            
            var clipInfo = Animator.GetCurrentAnimatorClipInfo(_locomotionEmotesLayerIdx);
            return clipInfo.Any(clip => clip.clip.name.Contains("Emote"));
        }

        #endregion Public Methods

        #region Private Methods

        private void Setup()
        {
            SetupLayers();
            SetupParameters();
        }

        private void Reset()
        {
            Animator = null;
            
            LayerIndices.Clear();
            _locomotionEmotesLayerIdx = -1;
            _leftHandLayerIdx = -1;
            _rightHandLayerIdx = -1;
            _toggleLayerIdx = -1;
            
            Parameters.Clear();
            //CoreParameters.Clear();
            SyncedFloatUsage = SyncedIntUsage = SyncedByteUsage = SyncedTotalUsage = 0;
            
            InboundBuffer?.ResetBuffers();
            OutboundBuffer?.ResetBuffers();
        }

        private void SetupLayers()
        {
            int layerCount = Animator.layerCount;
            for (int i = 0; i < layerCount; i++) LayerIndices[Animator.GetLayerName(i)] = i;
            
            // Check for default CVR layers
            _locomotionEmotesLayerIdx = Animator.GetLayerIndex(AvatarDefinitions.LOCOMOTION_EMOTES_LAYER_NAME);
            _leftHandLayerIdx = Animator.GetLayerIndex(AvatarDefinitions.HAND_LEFT_LAYER_NAME);
            _rightHandLayerIdx = Animator.GetLayerIndex(AvatarDefinitions.HAND_RIGHT_LAYER_NAME);
            _toggleLayerIdx = Animator.GetLayerIndex(AvatarDefinitions.TOGGLES_LAYER_NAME);
        }
        
        private void SetupParameters()
        {
            int floatCount = 0, intCount = 0, boolCount = 0, currentBitUsage = 0;

            foreach (AnimatorControllerParameter parameter in Animator.parameters)
            {
                ParameterDefinition param = new(Animator, parameter);
                Parameters.Add(parameter.name, param);
                
                var additionalBitUsage = CalculateAdditionalBitUsage(param.type, boolCount);
                var newTotalUsage = currentBitUsage + additionalBitUsage;
                if (param.IsSynced && CanParameterBeSynced(newTotalUsage, parameter.name))
                {
                    currentBitUsage = newTotalUsage;
                    UpdateCounts(ref boolCount, ref floatCount, ref intCount, param.type);
                    OutboundBuffer?.OnAddParameter(param);
                }
            }

            SyncedFloatUsage = floatCount * AvatarDefinitions.AAS_FLOAT_BIT_USAGE;
            SyncedIntUsage = intCount * AvatarDefinitions.AAS_INT_BIT_USAGE;
            SyncedByteUsage = (boolCount + 7) / 8 * 8; // Rounded to nearest byte for bools
            SyncedTotalUsage = SyncedByteUsage + SyncedFloatUsage + SyncedIntUsage;

            InboundBuffer?.ResizeBuffers(floatCount, intCount, boolCount);
            OutboundBuffer?.ResizeBuffers(floatCount, intCount, boolCount);

            if (OutboundBuffer != null)
            {
                // update initial values from controller (CVR BUG: does not pull from AAS default)
                foreach (ParameterDefinition parameter in Parameters.GetParameters())
                    parameter.UpdateValue();
            }

            //Debug.Log(
            //    $"Float Usage: {SyncedFloatUsage}, Int Usage: {SyncedIntUsage}, Byte Usage: {SyncedByteUsage}, Total Usage: {SyncedTotalUsage}");
            
            return;
            
            #region Local Methods

            static int CalculateAdditionalBitUsage(AnimatorControllerParameterType type, int boolCount)
            {
                switch (type)
                {
                    case AnimatorControllerParameterType.Bool:
                        // Calculate bit usage increase if a new boolean is added
                        var nextByteCount = (boolCount + 1 + 7) / 8;
                        var currentByteCount = (boolCount + 7) / 8;
                        return (nextByteCount - currentByteCount) * 8;
                    case AnimatorControllerParameterType.Float:
                        return AvatarDefinitions.AAS_FLOAT_BIT_USAGE;
                    case AnimatorControllerParameterType.Int:
                        return AvatarDefinitions.AAS_INT_BIT_USAGE;
                    default:
                        return 0;
                }
            }

            static bool CanParameterBeSynced(int newTotalUsage, string paramName)
            {
                if (newTotalUsage <= AvatarDefinitions.AAS_MAX_SYNCED_BITS)
                    return true;

                Debug.LogWarning(
                    $"Parameter {paramName} exceeds the maximum usage limit of {AvatarDefinitions.AAS_MAX_SYNCED_BITS} bits.");
                return false;
            }

            static void UpdateCounts(ref int boolCount, ref int floatCount, ref int intCount,
                AnimatorControllerParameterType type)
            {
                switch (type)
                {
                    case AnimatorControllerParameterType.Bool:
                        boolCount++;
                        break;
                    case AnimatorControllerParameterType.Float:
                        floatCount++;
                        break;
                    case AnimatorControllerParameterType.Int:
                        intCount++;
                        break;
                }
            }

            #endregion Local Methods
        }

        #endregion Private Methods
    }
}