using ABI.CCK.Scripts;
using NAK.AASEmulator.Runtime.SubSystems;
using System.Collections.Generic;
using UnityEngine;
using static ABI.CCK.Scripts.CVRAdvancedSettingsEntry;

namespace NAK.AASEmulator.Runtime
{
    [AddComponentMenu("")]
    public class AASMenu : EditorOnlyMonoBehaviour
    {
        #region Static Initialization

        [RuntimeInitializeOnLoadMethod]
        private static void Initialize()
        {
            AASEmulator.runtimeInitializedDelegate = runtime =>
            {
                if (AASEmulator.Instance != null && !AASEmulator.Instance.EmulateAASMenu)
                    return;

                AASMenu menu = runtime.gameObject.AddComponent<AASMenu>();
                menu.isInitializedExternally = true;
                menu.runtime = runtime;
                AASEmulator.addTopComponentDelegate?.Invoke(menu);
            };
        }

        #endregion Static Initialization

        #region Variables

        public List<AASMenuEntry> entries = new List<AASMenuEntry>();
        public AnimatorManager AnimatorManager => runtime.AnimatorManager;
        private AASEmulatorRuntime runtime;

        #endregion Variables

        #region Menu Setup

        private void Start() => SetupAASMenus();

        private void SetupAASMenus()
        {
            entries.Clear();

            if (runtime == null)
            {
                SimpleLogger.LogError("Unable to setup AAS Menus: AASEmulatorRuntime is missing", this);
                return;
            }

            if (runtime.m_avatar == null)
            {
                SimpleLogger.LogError("Unable to setup AAS Menus: CVRAvatar is missing", this);
                return;
            }

            if (runtime.m_avatar.avatarSettings?.settings == null)
            {
                SimpleLogger.LogError("Unable to setup AAS Menus: AvatarAdvancedSettings is missing", this);
                return;
            }

            var avatarSettings = runtime.m_avatar.avatarSettings.settings;

            foreach (CVRAdvancedSettingsEntry setting in avatarSettings)
            {
                string[] postfixes;
                switch (setting.type)
                {
                    case SettingsType.Joystick2D:
                    case SettingsType.InputVector2:
                        postfixes = new[] { "-x", "-y" };
                        break;

                    case SettingsType.Joystick3D:
                    case SettingsType.InputVector3:
                        postfixes = new[] { "-x", "-y", "-z" };
                        break;

                    case SettingsType.MaterialColor:
                        postfixes = new[] { "-r", "-g", "-b" };
                        break;

                    case SettingsType.GameObjectDropdown:
                    case SettingsType.GameObjectToggle:
                    case SettingsType.Slider:
                    case SettingsType.InputSingle:
                    default:
                        postfixes = new[] { "" };
                        break;
                }

                AASMenuEntry menuEntry = new AASMenuEntry
                {
                    menuName = setting.name,
                    machineName = setting.machineName,
                    settingType = setting.type,
                };

                if (setting.setting is CVRAdvancesAvatarSettingGameObjectDropdown dropdown)
                    menuEntry.menuOptions = dropdown.getOptionsList();

                for (int i = 0; i < postfixes.Length; i++)
                {
                    if (AnimatorManager.Parameters.TryGetValue(setting.machineName + postfixes[i],
                            out AnimatorManager.BaseParam param))
                    {
                        float value;
                        switch (param)
                        {
                            case AnimatorManager.FloatParam floatParam:
                                value = floatParam.defaultValue;
                                break;

                            case AnimatorManager.IntParam intParam:
                                value = intParam.defaultValue;
                                break;

                            case AnimatorManager.BoolParam boolParam:
                                value = boolParam.defaultValue ? 1f : 0f;
                                break;

                            default:
                                value = 0f;
                                break;
                        }

                        switch (i)
                        {
                            case 0:
                                menuEntry.valueX = value;
                                break;

                            case 1:
                                menuEntry.valueY = value;
                                break;

                            case 2:
                                menuEntry.valueZ = value;
                                break;
                        }
                    }
                }

                entries.Add(menuEntry);
            }

            SimpleLogger.Log($"Successfully created {entries.Count} menu entries for {runtime.m_avatar.name}!", this);
        }

        #endregion Menu Setup

        #region Menu Entry Class

        public class AASMenuEntry
        {
            public string menuName;
            public string machineName;
            public SettingsType settingType;
            public float valueX, valueY, valueZ;
            public string[] menuOptions;
        }

        #endregion Menu Entry Class
    }
}