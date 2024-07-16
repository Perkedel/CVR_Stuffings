using System;
using System.Collections.Generic;
using UnityEngine;

namespace NAK.AASEmulator.Runtime.SubSystems
{
    public class AASOutboundBuffer
    {
        private AASParameterOutboundSyncData _aasParamOutboundSyncData;

        private readonly Dictionary<int, int> _aasOutboundIndicesBool = new();
        private readonly Dictionary<int, int> _aasOutboundIndicesFloat = new();
        private readonly Dictionary<int, int> _aasOutboundIndicesInt = new();

        public AASOutboundBuffer()
        {
            ResetBuffers();
        }

        public bool AASParameterChangedSinceLastSync { get; set; }
        
        public AASParameterOutboundSyncData GetSyncData() 
            => _aasParamOutboundSyncData;
        
        public void ResetBuffers()
        {
            _aasOutboundIndicesInt.Clear();
            _aasOutboundIndicesBool.Clear();
            _aasOutboundIndicesFloat.Clear();
            _aasParamOutboundSyncData.floats = Array.Empty<float>();
            _aasParamOutboundSyncData.ints = Array.Empty<int>();
            //_aasParamOutboundSyncData.bytes = Array.Empty<byte>();
            _aasParamOutboundSyncData.bools = Array.Empty<bool>();
        }
        
        public void ResizeBuffers(int floatCount, int intCount, int boolCount)
        {
            // Bool -> Byte, calculate byte buffer to contain all bools
            //Array.Resize(ref _aasParamOutboundSyncData.bytes, (boolCount + 7) / 8);
            Array.Resize(ref _aasParamOutboundSyncData.floats, floatCount);
            Array.Resize(ref _aasParamOutboundSyncData.ints, intCount);
            Array.Resize(ref _aasParamOutboundSyncData.bools, boolCount);
        }
        
        public void OnAddParameter(ParameterDefinition parameterDefinition)
        {
            switch (parameterDefinition.type)
            {
                case AnimatorControllerParameterType.Bool:
                    _aasOutboundIndicesBool.Add(parameterDefinition.hash, _aasOutboundIndicesBool.Count);
                    break;
                case AnimatorControllerParameterType.Float:
                    _aasOutboundIndicesFloat.Add(parameterDefinition.hash, _aasOutboundIndicesFloat.Count);
                    break;
                case AnimatorControllerParameterType.Int:
                    _aasOutboundIndicesInt.Add(parameterDefinition.hash, _aasOutboundIndicesInt.Count);
                    break;
            }
            parameterDefinition.AddListener(OnParameterChanged);
        }

        private void OnParameterChanged(ParameterDefinition parameterDefinition)
        {
            AASParameterChangedSinceLastSync = true;
            switch (parameterDefinition.type)
            {
                case AnimatorControllerParameterType.Bool:
                    OnBoolParameterChanged(parameterDefinition.hash, parameterDefinition.GetBool());
                    break;
                case AnimatorControllerParameterType.Float:
                    OnFloatParameterChanged(parameterDefinition.hash, parameterDefinition.GetFloat());
                    break;
                case AnimatorControllerParameterType.Int:
                    OnIntParameterChanged(parameterDefinition.hash, parameterDefinition.GetInt());
                    break;
            }
        }

        #region Private Methods
        
        private void OnBoolParameterChanged(int hash, bool value)
        {
            if (!_aasOutboundIndicesBool.TryGetValue(hash, out var index))
                return;
            
            //int byteIndex = index / 8;
            //int bitIndex = index % 8;
            //if (value) _aasParamOutboundSyncData.bytes[byteIndex] |= (byte)(1 << bitIndex);
            //else _aasParamOutboundSyncData.bytes[byteIndex] &= (byte)~(1 << bitIndex);
            
            _aasParamOutboundSyncData.bools[index] = value;
        }

        private void OnFloatParameterChanged(int hash, float value)
        {
            if (!_aasOutboundIndicesFloat.TryGetValue(hash, out var index))
                return;
            
            _aasParamOutboundSyncData.floats[index] = value;
        }

        private void OnIntParameterChanged(int hash, int value)
        {
            if (!_aasOutboundIndicesInt.TryGetValue(hash, out var index))
                return;

            _aasParamOutboundSyncData.ints[index] = value;
        }
        
        #endregion Private Methods
    }
}