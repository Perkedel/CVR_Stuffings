# ChilloutVR AudioLink

## Linking audio to effects on ChilloutVR avatars and worlds

AudioLink is a system that analyzes and processes in-world audio into many different highly reactive data streams and exposes the data to ChilloutVR world shaders, and avatar shaders.

Technical overview:
The audio amplitude data is read into shader parameters via the `CVRAudioMaterialParser` component. It is then sent to the GPU for signal processing and buffered into a CustomRenderTexture. Then, the CustomRenderTexture is broadcast globally (called `_AudioTexture`) which can be picked up by shaders both in-world and across all avatars. 

For the original VRChat version see [llealloo/vrc-udon-audio-link](https://github.com/llealloo/vrc-udon-audio-link).

### [Documentation for shader creators](https://github.com/llealloo/vrc-udon-audio-link/tree/master/Docs)

## 0.2.8 - May 14th, 2022
### New features
- AudioLink theme colors are now configurable via the AudioLink controller with a slick color-picker GUI. (Thanks, DomNomNom)
- Added the ability to get the time since Unix epoch in days, and milliseconds since 12:00 AM UTC. Additionally, a helper function, `AudioLinkGetTimeOfDay()` has been added, which lets you easily get the current hours, minutes and seconds of the time of day in UTC.
- An editor scripting define, `AUDIOLINK`, which will be automatically added when AudioLink is included. (Thanks, Float3)
- AudioLink can now compile without VRCSDK and UDON, for use outside of VRChat. This kind of usecase is still experimental at best, though. (Thanks, Float3)
- Added a few new helper methods to sample various notes of the DFT. (Thanks, Float3)
### Changes
- AudioLink theme colors have been cleaned up, including a new demo in the example scene, and the ability to change the colors in realtime in the editor. (Thanks, DomNomNom)
- Changed a few default settings on the AudioLink controller to be more responsive. (Thanks, DomNomNom)
- Changed folder structure to put less clutter into user projects.
### Bugfixes
- Fix vertical UV flip of the AudioLink texture on Quest. (Thanks, Shadowriver)
- Fix error when using "Link all sound reactive objects to this AudioLink" button. (Thanks, Nestorboy)
- Add a header guard to `AudioLink.cginc` to prevent duplicate includes. (Thanks, PiMaker)
- Fix various warnings in shader code. (Thanks, Float3)
- Fix NaN-propagation issue in the included video player. (Thanks, Texelsaur)
- Add a player validity check to the included video player. (Thanks, Texelsaur)
- Use `Networking.LocalPlayer.isInstanceOwner` instead of `Networking.IsInstanceOwner`, which is broken. (Thanks, techanon)
- The logos on the AudioLink controller were using point filtering, which was changed to bilinear. (Thanks, DomNomNom)

## First time setup

### Requirements
- [ChilloutVR CCK](https://docs.abinteractive.net/cck/setup/)
- The latest release: https://github.com/DomNomNomVR/cvr-audio-link/releases/latest

### Installation
1. Install the requirements above
2. Have a look at the example scene, "AudioLink_ExampleScene". It contains a lot of visual documentation of what is going on and includes several example setups. Or cut to the chase:

### Getting started
1. Drag AudioLinkController into scene
2. Link audio source by dragging the AudioSource gameobject into the audio source parameter of the CVRAudioMaterialParser component on the controller.

### Installing to test Avatar projects
TODO. Currently you will need to test in-game.

## Compatible tools / assets
- [Poiyomi Shader](https://poiyomi.com/) by Poiyomi
- [Silent Cel Shading Shader](https://gitlab.com/s-ilent/SCSS) by Silent
- [Mochies Unity Shaders](https://github.com/MochiesCode/Mochies-Unity-Shaders/releases) by Mochie
- [Fire Lite](https://discord.gg/24W435s) by Rollthered
- [orels1 AudioLink Shader](https://github.com/orels1/orels1-AudioLink-Shader) by orels1

## Thank you
- Khodrin for the initial connection to ChilloutVR
- phosphenolic for the math wizardry, conceptual programming, debugging, design help and emotional support!!!
- cnlohr for the help with the new DFT spectrogram and helping to port AudioLink to 100% shader code
- lox9973 for autocorrelator functionality and the inspirational & tangential math help with signal processing
- Texelsaur for the AudioLinkMiniPlayer and support!
- Pema for the help with strengthening the codebase and inspiration!
- Merlin for making UdonSharp and offering many many pointers along the way. Thank you Merlin!
- Orels1 for all of the great help with MaterialPropertyBlocks & shaders and the auto configurator script for easy AV3 local testing
- Xiexe for the help developing and testing
- Thryrallo for the help setting up local AV3 testing functionality
- CyanLaser for making CyanEmu
- Lyuma for helping in many ways and being super nice!
- ACIIL for the named texture check in AudioLink.cginc
- fuopy for being awesome and reflecting great vibes back into this project
- Colonel Cthulu for incepting the idea to make the audio data visible to avatars
- jackiepi for math wizardry, emotional support and inspiration
- Barry, OM3, GRIMECRAFT for stoking my fire!
- Lamp for the awesome example music and inspiration. Follow them!! https://soundcloud.com/lampdx
- Shelter, Loner, Rizumu, and all of the other dance communities in VRChat for making this

## Developer Notes

### `reup.bat` for auto syncing a developer branch

First, fork this repo into your personal github account using the github GUI, then make a new unity project called `AudioLinkWork` then, check out your copy of of this repo, and move its contents, `.git` included into the `Assets` folder of the project you made.  Once done, place the following .bat file in that Assets folder.

I recommend executing this following `reup.bat` from the command line to address merge conflicts and other errors.

```bat
rem be sure you're on the `dev` branch!
git remote set-url origin https://github.com/DomNomNom/cvr-audio-link
git pull
git remote set-url origin https://github.com/YOUR_GITHUB_USERNAME_HERE/cvr-audio-link
```

### Version update processes

 * Update readme in both places (root and AudioLink folder)
    * Check section on how to update
    * Copy over changelog for the new version to readme 
 * Update documentation where necessary
 * Update changelog
 * Bump version number in AudioLink.cs
 * Clean up assets in wrong folders
 * Test it
 * Make release GitHub release with new relevant changelog attached
 * Update the live world
