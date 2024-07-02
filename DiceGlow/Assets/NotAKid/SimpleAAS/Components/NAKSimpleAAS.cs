#if UNITY_EDITOR && CVR_CCK_EXISTS
using System;
using System.Collections.Generic;
using System.Linq;
using ABI.CCK.Components;
using ABI.CCK.Scripts;
using UnityEditor.Animations;
using UnityEngine;
using UnityEngine.Scripting.APIUpdating;
using UnityEngine.Serialization;

namespace NAK.SimpleAAS.Components
{
    [MovedFrom("NAK.SimpleAAS")]
    [HelpURL("https://github.com/NotAKidOnSteam/SimpleAAS")]
    public class NAKSimpleAAS : MonoBehaviour
    {
        #region Core Parameters

        private static readonly HashSet<string> coreParameters = new HashSet<string>()
        {
            "MovementX",
            "MovementY",
            "Grounded",
            "Emote",
            "GestureLeft",
            "GestureRight",
            "Toggle",
            "Sitting",
            "Crouching",
            "CancelEmote",
            "Prone",
            "Flying"
        };

        #endregion

        #region Unity Methods

        private void Reset()
        {
            if (avatar == null)
                avatar = GetComponentInParent<CVRAvatar>();
        }

        #endregion

        #region Variables

        public CVRAvatar avatar;

        [FormerlySerializedAs("baseOverrideController")]
        public AnimatorOverrideController overrideController;

        [FormerlySerializedAs("avatarControllers")]
        public AnimatorController[] customControllers = Array.Empty<AnimatorController>();

        #endregion

        #region Public Methods

        public int GetParameterSyncUsage()
        {
            if (avatar == null || customControllers == null)
                return 0;

            var animatorParameterNames = new HashSet<string>();
            var syncedValues = 0;
            var syncedBooleans = 0;

            foreach (AnimatorController controller in customControllers)
            {
                if (controller == null)
                    continue;

                foreach (AnimatorControllerParameter parameter in controller.parameters)
                {
                    if (animatorParameterNames.Contains(parameter.name))
                        continue;
                    
                    CountParameterTypes(parameter, ref syncedValues, ref syncedBooleans);
                    animatorParameterNames.Add(parameter.name);
                }
            }

            // ChilloutVR does not count these in-game. Idk why CCK does...
            // foreach (CVRAdvancedSettingsEntry entry in avatar.avatarSettings.settings)
            //     CountEntryTypes(entry, animatorParameterNames, ref syncedValues, ref syncedBooleans);

            return CalculateSyncUsage(syncedValues, syncedBooleans);
        }

        public bool IsInvalid()
        {
            return avatar == null ||
                   overrideController == null ||
                   customControllers.All(c => c == null);
        }

        #endregion

        #region Private Methods

        private int CalculateSyncUsage(int syncedValues, int syncedBooleans)
        {
            return syncedValues * 32 + Mathf.CeilToInt(syncedBooleans / 8f) * 8;
        }

        private bool IsValidParameter(string parameterName)
        {
            return !string.IsNullOrEmpty(parameterName) && !coreParameters.Contains(parameterName) &&
                   !parameterName.StartsWith("#");
        }

        private void CountParameterTypes(AnimatorControllerParameter parameter, ref int syncedValues,
            ref int syncedBooleans)
        {
            if (!IsValidParameter(parameter.name))
                return;

            if (parameter.type == AnimatorControllerParameterType.Bool)
                syncedBooleans++;
            else if (parameter.type != AnimatorControllerParameterType.Trigger)
                syncedValues++;
        }

        private void CountEntryTypes(CVRAdvancedSettingsEntry entry, HashSet<string> animatorParameters,
            ref int syncedValues, ref int syncedBooleans)
        {
            if (!IsValidParameter(entry.machineName))
                return;

            switch (entry.type)
            {
                case CVRAdvancedSettingsEntry.SettingsType.Toggle:
                    if (animatorParameters.Contains(entry.machineName))
                        break;
                    if (entry.setting.usedType == CVRAdvancesAvatarSettingBase.ParameterType.Bool)
                        syncedBooleans += 1;
                    else
                        syncedValues += 1;
                    break;
                case CVRAdvancedSettingsEntry.SettingsType.Color:
                    IncrementSyncValuesForEntry(entry, animatorParameters, ref syncedValues, "-r", "-g", "-b");
                    break;
                case CVRAdvancedSettingsEntry.SettingsType.Joystick2D:
                case CVRAdvancedSettingsEntry.SettingsType.InputVector2:
                    IncrementSyncValuesForEntry(entry, animatorParameters, ref syncedValues, "-x", "-y");
                    break;
                case CVRAdvancedSettingsEntry.SettingsType.Joystick3D:
                case CVRAdvancedSettingsEntry.SettingsType.InputVector3:
                    IncrementSyncValuesForEntry(entry, animatorParameters, ref syncedValues, "-x", "-y", "-z");
                    break;
                case CVRAdvancedSettingsEntry.SettingsType.Slider:
                case CVRAdvancedSettingsEntry.SettingsType.InputSingle:
                case CVRAdvancedSettingsEntry.SettingsType.Dropdown:
                default:
                    if (!animatorParameters.Contains(entry.machineName)) syncedValues += 1;
                    break;
            }
        }

        private void IncrementSyncValuesForEntry(CVRAdvancedSettingsEntry entry, HashSet<string> animatorParameters,
            ref int syncedValues, params string[] suffixes)
        {
            if (suffixes.Any(suffix => animatorParameters.Contains(entry.machineName + suffix)))
                return;

            syncedValues += suffixes.Length;
        }

        #endregion
    }
}
#endif