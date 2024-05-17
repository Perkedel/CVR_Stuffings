> Please note that this is a temporary dirty patch just to make it work during experimental testing.

Okay, I've found one of the breaking changes here. This one is the, AAS Setting type enum. Before it was prefixed with `GameObject..` somethings, now it's just its name. no more e.g. `GameObjectToggle`, just `Toggle`. as well as, `ParameterType` enum
(`Assets/ABI.CCK/Scripts/CVRAvatarSettings.cs`, Class `CVRAvatarSettingsEntry`, around **line 99** down for `SettingsType`)
(`Assets/ABI.CCK/Scripts/CVRAvatarSettings.cs`, Class `CVRAdvancesAvatarSettingBase`, around **line 99** down for `ParameterType`. lmao `Advances`?! hah 🤣)
If anybody had a tool that depends on these enum you may wanna change it, but no rush tho, because again, it's experimental.

Ah, NotAKid. Okay, not to disturb you, **your SimpleAAS**. The `GetDefaultType` & `GetSupportedTypes` in `Assets/SimpleAAS/ScriptableObjects/NAKModularSettings.cs` from **line 32**. These static methods uses those, but now changed. idk should this be changed, but real quick, I'll just do temporary patch for now. if the stable one day kept be like that, well, you know what to do. I may as well escalate to Issue on SimpleAAS (of course not now, this is because for CCK experimental).

old
```cs
public static CVRAdvancesAvatarSettingBase.ParameterType GetDefaultType(
        CVRAdvancedSettingsEntry.SettingsType settingType)
    {
        switch (settingType)
        {
            // Toggles default to Bool
            case CVRAdvancedSettingsEntry.SettingsType.GameObjectToggle:
                return CVRAdvancesAvatarSettingBase.ParameterType.GenerateBool;
            // Dropdowns default to Int
            case CVRAdvancedSettingsEntry.SettingsType.GameObjectDropdown:
                return CVRAdvancesAvatarSettingBase.ParameterType.GenerateInt;
            // Everything else is Float
            default:
                return CVRAdvancesAvatarSettingBase.ParameterType.GenerateFloat;
        }
    }

    public static List<CVRAdvancesAvatarSettingBase.ParameterType> GetSupportedTypes(
        CVRAdvancedSettingsEntry.SettingsType settingType)
    {
        var supportedTypes = new List<CVRAdvancesAvatarSettingBase.ParameterType>();

        switch (settingType)
        {
            // Toggles can use all
            case CVRAdvancedSettingsEntry.SettingsType.GameObjectToggle:
                supportedTypes.Add(CVRAdvancesAvatarSettingBase.ParameterType.GenerateBool);
                supportedTypes.Add(CVRAdvancesAvatarSettingBase.ParameterType.GenerateInt);
                supportedTypes.Add(CVRAdvancesAvatarSettingBase.ParameterType.GenerateFloat);
                break;
            // Dropdowns can only use float, int
            case CVRAdvancedSettingsEntry.SettingsType.GameObjectDropdown:
                supportedTypes.Add(CVRAdvancesAvatarSettingBase.ParameterType.GenerateInt);
                supportedTypes.Add(CVRAdvancesAvatarSettingBase.ParameterType.GenerateFloat);
                break;
            // Everything else is Float
            default:
                supportedTypes.Add(CVRAdvancesAvatarSettingBase.ParameterType.GenerateFloat);
                break;
        }

        return supportedTypes;
    }
```

new
```cs
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
```

Ah I found the other one at `Assets/SimpleAAS/Components/NAKModularSettings.cs` since **line 135**. `ParameterType`! yes.
`Assets/SimpleAAS/Scripts/AASMenu.cs` from **line 75**; from **line 108** method `getOptionList()` is gone, and now replaced with getter as `optionsNames` in this `CVRAdvancesAvatarSettingGameObjectDropdown` class (`Assets/ABI.CCK/Scripts/CVRAvatarSettings.cs` **line 391**) 
oh man, I don't think this fits here, lemme move those next as a thread here.
I know, I broke rule, I can't help it, it's Lua update coming soon. idk man!

# thread

## 1
> Lines might be thrown off. showing line numbers around those. the commit (at DiceGlow, for now) for special patch will be linked promptly

Now for the AAS Emulator!
`Assets/NotAKid/AASEmulator/Editor/AASMenuEditor.cs` **line 72**, the `ParameterType`!

more on the SimpleAAS
`Assets/SimpleAAS/Editor/NAKModularSettingsEditor.cs` **line 56, 63 & 319 ish which are simply `if (!entity.setting.isCollapsed) return;`**, the `CVRAdvancesAvatarSettingBase` no longer has `isCollapsed` variable, instead now moved right away into the `CVRAdvancedSettingsEntry`. take off `.setting` to ask `Entry` instead!
**Line 94, 178, & 321**, `ParameterType` again!
**Line 188**, method `getOptionList()` is gone, and now replaced with getter as `optionsNames` in this `CVRAdvancesAvatarSettingGameObjectDropdown` class (`Assets/ABI.CCK/Scripts/CVRAdvancedAvatarSettings.cs` **line 391**) 
**Line 192**, method `GetReorderableList()` is gone, and is allegedly replaced with getter (?) as `reorderableList` in this `CVRAdvancesAvatarSettingGameObjectDropdown` class (`Assets/ABI.CCK/Scripts/CVRAdvancedAvatarSettings.cs` **line 409**) 

Further patches shall be made if neccessary when stable releases.
btw, the Avatars AAS I think gonna break here. Oh noes!

Commit https://github.com/Perkedel/CVR_Stuffings/commit/8a0035a9979b4a53af737190a5c150c8f10eb726