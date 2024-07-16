using System;
using UnityEngine;

namespace NAK.AASEmulator.Runtime.SubSystems
{
    public class ParameterDefinition
    {
        public readonly string name;
        public readonly int hash;
        public readonly AnimatorControllerParameterType type;

        public readonly bool isLocal;
        public readonly bool isControlledByCurve;

        private readonly Animator _animator;

        public bool IsCoreParameter { get; }
        public bool IsReadOnly => isControlledByCurve || IsCoreParameter;
        public bool IsSynced => !isLocal && !IsReadOnly;

        private float _value; // cvr syncs full 32 bits :3

        private Action<ParameterDefinition> _onValueChanged;

        public ParameterDefinition(Animator animator, AnimatorControllerParameter parameter)
        {
            _animator = animator;

            name = parameter.name;
            hash = parameter.nameHash;
            type = parameter.type;

            IsCoreParameter = AvatarDefinitions.IsCoreParameter(name);
            isControlledByCurve = _animator.IsParameterControlledByCurve(hash);
            if (IsCoreParameter) return; // core parameters are always synced (+ CancelEmote is trigger)
            
            isLocal = AvatarDefinitions.IsLocalParameter(name);
            isLocal |= type == AnimatorControllerParameterType.Trigger;
        }

        #region Value Update

        public void UpdateValue()
        {
            if (_animator == null)
                return;

            if (IsReadOnly)
                return;

            GetParameterDirect(out _value);
            _onValueChanged?.Invoke(this);
        }

        #endregion

        #region Listeners

        public void AddListener(Action<ParameterDefinition> listener)
            => _onValueChanged += listener;

        public void RemoveListener(Action<ParameterDefinition> listener)
            => _onValueChanged -= listener;

        #endregion

        #region Getters

        public AnimatorControllerParameterType GetParameterType()
            => type;

        public bool GetBool()
        {
            GetParameter(out bool value);
            return value;
        }

        public float GetFloat()
        {
            GetParameter(out float value);
            return value;
        }

        public int GetInt()
        {
            GetParameter(out int value);
            return value;
        }

        public void GetParameter(out bool value)
            => value = _value > 0;

        public void GetParameter(out float value)
            => value = _value;

        public void GetParameter(out int value)
            => value = Mathf.RoundToInt(_value);

        #endregion

        #region Setters

        public void SetParameter(bool value, bool force = false)
        {
            if (IsCoreParameter && !force) return;
            SetParameter_Internal(value ? 1f : 0f);
        }

        public void SetParameter(float value, bool force = false)
        {
            if (IsCoreParameter && !force) return;
            SetParameter_Internal(value);
        }

        public void SetParameter(int value, bool force = false)
        {
            if (IsCoreParameter && !force) return;
            SetParameter_Internal(value);
        }

        private void SetParameter_Internal(float value)
        {
            if (_animator == null)
                return;

            if (isControlledByCurve)
                return;

            _value = value;
            _onValueChanged?.Invoke(this);

            switch (type)
            {
                case AnimatorControllerParameterType.Trigger:
                case AnimatorControllerParameterType.Bool:
                    _animator.SetBool(hash, value > 0.5f);
                    break;
                case AnimatorControllerParameterType.Float:
                    _animator.SetFloat(hash, value);
                    break;
                case AnimatorControllerParameterType.Int:
                    _animator.SetInteger(hash, Mathf.RoundToInt(value));
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }
        }

        #endregion

        #region Direct Getters

        public void GetParameterDirect(out float value)
        {
            switch (type)
            {
                case AnimatorControllerParameterType.Trigger:
                case AnimatorControllerParameterType.Bool:
                    value = _animator.GetBool(hash) ? 1f : 0f;
                    return;
                case AnimatorControllerParameterType.Float:
                    value = _animator.GetFloat(hash);
                    return;
                case AnimatorControllerParameterType.Int:
                    value = _animator.GetInteger(hash);
                    return;
                default:
                    value = 0f;
                    return;
            }
        }

        public void GetParameterDirect(out int value)
        {
            switch (type)
            {
                case AnimatorControllerParameterType.Trigger:
                case AnimatorControllerParameterType.Bool:
                    value = _animator.GetBool(hash) ? 1 : 0;
                    return;
                case AnimatorControllerParameterType.Float:
                    value = Mathf.RoundToInt(_animator.GetFloat(hash));
                    return;
                case AnimatorControllerParameterType.Int:
                    value = _animator.GetInteger(hash);
                    return;
                default:
                    value = 0;
                    return;
            }
        }
        
        public void GetParameterDirect(out bool value)
        {
            switch (type)
            {
                case AnimatorControllerParameterType.Trigger:
                case AnimatorControllerParameterType.Bool:
                    value = _animator.GetBool(hash);
                    return;
                case AnimatorControllerParameterType.Float:
                    value = _animator.GetFloat(hash) > 0.5f;
                    return;
                case AnimatorControllerParameterType.Int:
                    value = _animator.GetInteger(hash) > 0;
                    return;
                default:
                    value = false;
                    return;
            }
        }

        #endregion Direct Getters
    }
}