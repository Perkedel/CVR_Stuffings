using System;
using UnityEngine;

namespace NAK.AASEmulator.Runtime.SubSystems
{
    public class AASInboundBuffer
    {
        public AASInboundBuffer(AvatarAnimator avatarAnimator)
        {
            _avatarAnimator = avatarAnimator;
            ResetBuffers();
        }
     
        private readonly AvatarAnimator _avatarAnimator;
        
        // Inbound AAS data
        private AASParameterInboundSyncData _aasParameterInboundSyncData;

        #region Public Methods
        
        public void ResetBuffers()
        {
            _aasParameterInboundSyncData.floats = Array.Empty<float>();
            _aasParameterInboundSyncData.ints = Array.Empty<int>();
            _aasParameterInboundSyncData.bools = Array.Empty<bool>();
        }
        
        public void ResizeBuffers(int floatCount, int intCount, int boolCount)
        {
            // Byte -> Bool for buffer size, so received bool count matches buffer size
            // EX: We have 21 bools, but will receive 24 bools from byte -> bool conversion
            //Array.Resize(ref _aasParameterInboundSyncData.bools, (boolCount + 7) / 8 * 8);
            Array.Resize(ref _aasParameterInboundSyncData.bools, boolCount); // we are sending bools directly without packing atm
            Array.Resize(ref _aasParameterInboundSyncData.floats, floatCount);
            Array.Resize(ref _aasParameterInboundSyncData.ints, intCount);
        }
        
        public void ApplyAASToBuffer(AASParameterOutboundSyncData syncData)
            => ApplyAASToBuffer(syncData.floats, syncData.ints, /*syncData.bytes*/ syncData.bools);

        private void ApplyAASToBuffer(float[] floatValues, int[] intValues, /*byte[] byteValues*/ bool[] boolValues)
        {
            if (floatValues.Length == _aasParameterInboundSyncData.floats.Length) floatValues.CopyTo(_aasParameterInboundSyncData.floats, 0);
            //else Debug.LogError("ApplyAASToBuffer: floatValues.Length != _aasParameterInboundSyncData.floats.Length");
            if (intValues.Length == _aasParameterInboundSyncData.ints.Length) intValues.CopyTo(_aasParameterInboundSyncData.ints, 0);
            //else Debug.LogError("ApplyAASToBuffer: intValues.Length != _aasParameterInboundSyncData.ints.Length");
            //if (byteValues.Length * 8 == _aasParameterInboundSyncData.bools.Length) Utilities.ByteToBoolArrayNoAlloc(byteValues, ref _aasParameterInboundSyncData.bools);
            if (boolValues.Length == _aasParameterInboundSyncData.bools.Length) boolValues.CopyTo(_aasParameterInboundSyncData.bools, 0);
            //else Debug.LogError("ApplyAASToBuffer: boolValues.Length != _aasParameterInboundSyncData.bools.Length");
        }

        public void ApplyAdvancedAvatarSettingsFromBuffer()
            => ApplyAASToAnimator(_aasParameterInboundSyncData);
        
        #endregion Public Methods

        #region Private Methods

        private void ApplyAASToAnimator(AASParameterInboundSyncData syncData)
        {
            if (!_avatarAnimator.Parameters.IsFilled)
                return;
            
            var countFloat = 0;
            var countInt = 0;
            var countBool = 0;

            foreach (ParameterDefinition parameter in _avatarAnimator.Parameters.GetParameters())
            {
                if (!parameter.IsSynced)
                    continue;

                switch (parameter.type)
                {
                    case AnimatorControllerParameterType.Float:
                        if (countFloat < syncData.floats.Length)
                            parameter.SetParameter(syncData.floats[countFloat]);
                        countFloat++;
                        break;
                    case AnimatorControllerParameterType.Int:
                        if (countInt < syncData.ints.Length)
                            parameter.SetParameter(syncData.ints[countInt]);
                        countInt++;
                        break;
                    case AnimatorControllerParameterType.Bool:
                        if (countBool < syncData.bools.Length)
                            parameter.SetParameter(syncData.bools[countBool]);
                        countBool++;
                        break;
                    case AnimatorControllerParameterType.Trigger:
                        break; // triggers are not synced
                }
            }
        }
        
        #endregion Private Methods
    }
}