# AASEmulator

A debug tool that makes it a bit nicer to test your ChilloutVR avatars in the Unity Editor.

It is mostly fluff. What you see is what you get:

![image](https://github.com/NotAKidOnSteam/AASEmulator/assets/37721153/00fbd576-a1c6-4b03-819b-52f26ad1ad9d)

## GUI Features
* Scrolling on dropdowns to advance sliders.
* Funni joystick, can test normalized movement values.

## Emulator "Features"
* Info display for Emote, Eye, Blink, and Lipsync status.
* Core parameters take priority from Emulator, but user-added parameters can be set in Animator and displayed in Emulator just fine.

## Emulated Quirks
* Emote parameter is only set for one frame.
* Emote is reset while running.
* Emote status is based on Locomotion/Emotes animation clip names.

That's really it as of now. Possible goal is to get CVRParameterStream, CVRAdvancedAvatarSettingTrigger, and CVRPointer emulated i guess.

To be honest though, it is unlikely I will personally continue this project or any other CCK tool until the following is done:
https://feedback.abinteractive.net/p/add-a-assembly-definition-to-the-cck

------

# Credit:

[Av3Emulator](https://github.com/lyuma/Av3Emulator) - [MIT License](https://github.com/lyuma/Av3Emulator/blob/master/LICENSE.txt)

Some utility functions as well as the main inspiration for the "Emulator" part & structure. Not much is applicable to ChilloutVR or its CCK.

---

Here is the block of text where I tell you it's not my fault if you're bad at Unity.

> Use of this Unity Script is done so at the user's own risk and the creator cannot be held responsible for any issues arising from its use.
