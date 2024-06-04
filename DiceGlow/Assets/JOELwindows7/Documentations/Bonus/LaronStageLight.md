# Laron Stage Light

![Four Laron P7-K moving head stage lights mounted on ceiling shining bright in teal at Garrin's Nardorian Underground](https://raw.githubusercontent.com/Perkedel/CVR_Stuffings/main/DiceGlow/Assets/JOELwindows7/_CORE/Sprites/Screenshots/attempted_laron_nardorian.jpg)

Laron is a sub-brand of Perkedel focusing on lighting for stages. In this version, these lights are controlled by OSC.

Thanks to Chataigne (yes, *chestnut*) from Benjamin Kuper, it is now possible to create control schemes that runs in realtime against ChilloutVR, through specially crafted actions & sequences which will send out values via OSC.

## Getting Started

To get started, follow below instruction.

### Ingredients

Acquire the following ingredients:

- [Benjamin Kuper's Chataigne](https://benjamin.kuperberg.fr/chataigne)
- [Kafeijao's OSC Mod](https://github.com/kafeijao/Kafe_CVR_Mods/tree/master/OSC). You can install this with [Knah's Melon Assistant](https://github.com/knah/CVRMelonAssistant), which fetches mods from [CVRMG](https://discord.gg/dKwnNZeWff), main source of CVR Mods.
- [Bluescream's Prop Spawner Mod](https://github.com/Bluscream/cvr-mods/tree/master/PropSpawner). Optional, we use this to make prop pre-spawning per instance seamless
- [Sinai's Unity Explorer](https://github.com/sinai-dev/UnityExplorer). Choose Mono release!
- [MelonLoader](https://melonwiki.xyz). Choose Mono version!
- [Our DJ Chataigne file](https://github.com/Perkedel/After-Church/blob/master/RAW%20files/Chataigne/DNB_DJ_Set.noisette)
- [Kaorfa's Prop Spawner Config file](https://github.com/Perkedel/CVR_Stuffings/blob/main/DiceGlow/Assets/JOELwindows7/_CORE/Misc/Bluscream/PropConfigs/JOELwindows7.json). We have assigned few worlds to have specific prop spawns there at respective locations.

Mods above are to be placed in `C:\Program Files (x86)\Steam\steamapps\common\ChilloutVR\Mods`

### Setup

Follow this step to configure your Chataigne session against CVR

1. Download & Install above ingredients
1. Download Our DJ Chataigne file. Open this file with Chataigne you've just installed.
1. Get onto a world instance
1. Spawn at least 1 `Laron P7-K` & related prop into the world instance.
1. You will need to copy its instance ID of each Lighting props per [Kafeijao's instruction](https://github.com/kafeijao/Kafe_CVR_Mods/tree/master/OSC#osc-props-parameters).
    1. Open Unity Explorer (`F7`)
    1. Look at another scene added called `AdditiveContentScene` in `Object Explorer` sub-window
    1. Look up & confirm which GameObject that pertains to your lighting prop.
    1. Acquire its instance ID from the root GameObject's last name (which is after the `~` followed with random hex numbers)  ![Image shown](https://raw.githubusercontent.com/Perkedel/CVR_Stuffings/main/DiceGlow/Assets/JOELwindows7/_CORE/Sprites/Screenshots/Get_Instance_ID_Of_Prop.png). Copy that.
1. Return to the Chataigne window, then paste the Instance ID you've just copied into the Custom variable
    1. In the `Custom Variable` sub-window on the left, enter the group `Moving Head`.
    1. On the right, paste this ID into whichever `Variable`, such as `Lamp0`. Please **DO NOT CHANGE Variable `MovingHeadGUID`!**, that's our `Laron P7-K` Prop GUID needed for 1st OSC Argument of `prop/parameter`.  ![Image shown](https://raw.githubusercontent.com/Perkedel/CVR_Stuffings/main/DiceGlow/Assets/JOELwindows7/_CORE/Sprites/Screenshots/Install_Instance_ID_to_Chataigne.png)
1. You can now test various things. All test actions are available inside this `Home` state box at your `State Machine` sub-window on the center.

> NOTE: Everytime you spawned the new prop, Instance ID will also change. Therefore you must repeat above steps to re-acquire new Instance ID of that prop & then paste it into the Custom Variable on the Chataigne.

To install Prop-prespawn per instance, you may also install Bluescream's Prop Spawner mod.
- Install our config file into `C:\Program Files (x86)\Steam\steamapps\common\ChilloutVR\UserData\PropConfigs\`
- Edit the files to your liking. The file format is in `json`.