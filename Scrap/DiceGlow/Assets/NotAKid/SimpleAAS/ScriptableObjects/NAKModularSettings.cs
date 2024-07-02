#if UNITY_EDITOR && CVR_CCK_EXISTS
using System.Collections.Generic;
using ABI.CCK.Scripts;
using UnityEngine;

[CreateAssetMenu(fileName = "SimpleAAS_Parameters", menuName = "NAKSimpleAAS/SimpleAAS_Parameters")]
public class NAKModularSettings : ScriptableObject
{
    //maybe we parse this on upload?
    public enum SimpleAAS_ParameterType
    {
        Float = 1,
        Int = 2,
        Bool = 3
    }

    public enum SimpleAAS_SettingsType
    {
        Toggle,
        Dropdown,
        Color,
        Slider,
        Joystick2D,
        Joystick3D,
        InputSingle,
        InputVector2,
        InputVector3
    }

    public List<CVRAdvancedSettingsEntry> settings = new List<CVRAdvancedSettingsEntry>();

    // JOELwindows7: from line below do the hacky ways for newer CCK since 3.10
    public static CVRAdvancesAvatarSettingBase.ParameterType GetDefaultType(
        CVRAdvancedSettingsEntry.SettingsType settingType)
    {
        switch (settingType)
        {
            // Toggles default to Bool
            case CVRAdvancedSettingsEntry.SettingsType.Toggle:
                return CVRAdvancesAvatarSettingBase.ParameterType.Bool;
            // Dropdowns default to Int
            case CVRAdvancedSettingsEntry.SettingsType.Dropdown:
                return CVRAdvancesAvatarSettingBase.ParameterType.Int;
            // Everything else is Float
            default:
                return CVRAdvancesAvatarSettingBase.ParameterType.Float;
        }
    }

    public static List<CVRAdvancesAvatarSettingBase.ParameterType> GetSupportedTypes(
        CVRAdvancedSettingsEntry.SettingsType settingType)
    {
        var supportedTypes = new List<CVRAdvancesAvatarSettingBase.ParameterType>();

        switch (settingType)
        {
            // Toggles can use all
            case CVRAdvancedSettingsEntry.SettingsType.Toggle:
                supportedTypes.Add(CVRAdvancesAvatarSettingBase.ParameterType.Bool);
                supportedTypes.Add(CVRAdvancesAvatarSettingBase.ParameterType.Int);
                supportedTypes.Add(CVRAdvancesAvatarSettingBase.ParameterType.Float);
                break;
            // Dropdowns can only use float, int
            case CVRAdvancedSettingsEntry.SettingsType.Dropdown:
                supportedTypes.Add(CVRAdvancesAvatarSettingBase.ParameterType.Int);
                supportedTypes.Add(CVRAdvancesAvatarSettingBase.ParameterType.Float);
                break;
            // Everything else is Float
            default:
                supportedTypes.Add(CVRAdvancesAvatarSettingBase.ParameterType.Float);
                break;
        }

        return supportedTypes;
    }
}
#endif