# Intermediate Avatar System
This Project Exists to provide a System to relatively easily port Avatars Between Games.

The End Goal is to be a Utility that permits easy Cross-Platform Avatar Creation with Minimal Loss in Features.

I often abbereviate the project as IA and will refer to it as such in this Readme.

## It may not be 100% Stable
- This utility only operates when you initiate a Conversion, so outside of that it is safe, It's highly recommended to enable "make duplicate" whenever you attempt to convert.
- There may be bugs, please report them on the Github Issues page.
- Pull Requests appreciated, just please provide a description of what your Pull-Request attempts to accomplish.
- This may push a lot of Errors into the Console Related to the Unity Animator. These are all related to how Animator Rebuilding is Handled in `AnimatorRebuilder.cs`, if anyone would like to have a crack at fixing up my mess please be my guest.

## What is the Goal of this Project?
To be a Unity Version/Platform Agnostic Utility to make conversion of an Avatar from a Social VR Platform's SDK to Another.
A secondary, more lofty goal, is to be an Avatar Creation Utility in-it-of-itself. Provide creators with Utilities that'll handle most if not all of what creators want. This is a lofty goal and I'd rather focus on trying to get this thing to be a lot more stable.

## Currently Supported Games

A platform will be listed here if it is not planned or support is being worked on.

No = ❌
Yes = ✅
Will Not = ⛔

IA = Intermediate Avatar, this System

| Platform/Game | Import (Into IA) | Export (From IA) | Minimum Known Supported SDK/CCK Version     |
|:-------------:|:----------------:|:----------------:|:-------------------------------------------:|
| VRChat        |       ✅         |        ❌        | SDK 3.5.0 (2022.3.6f1)                      |
| ChilloutVR    |       ❌         |        ✅        | CCK 3.9 (2021.3.23f1)                       |

Resonite/Neos do not have Unity Editor SDKs, it will not be supported because it cannot be supported.

## How do I convert an Avatar from One of the Supported Platforms to Another?

Open the "Intermediate Avatar" Panel at the Top of Unity and open the Intermediate Avatar Converter Panel.

The Utility will attempt to Convert your Avatar for an SDK into an "Intermediate Avatar" so that you can transfer to a different Unity Versions & Game SDKs more easily.

This Utility *DOES NOT* Convert PhysBones to DynamicBones or Magica Cloth 1/2, you will need to do this Manually or use another Script.

***Converting PhysBones The Easy Way***
to Convert PhysBones to DynamicBones I recommend using [PhysBone-to-DynamicBone by FACS01-01](https://github.com/FACS01-01/PhysBone-to-DynamicBone)

if you do not own Dynamic Bones you can purchase it from the [Unity Asset Store](https://assetstore.unity.com/packages/tools/animation/dynamic-bone-16743)
...or you can use [Dynamic-Bones-Stub by VRLabs](https://github.com/VRLabs/Dynamic-Bones-Stub) (you won't be able to test your Bone Dynamics in the Unity Editor though)

***Converting PhysBones The Manual Way***
If you're ok with Converting to Another Bone System and don't mind buying one, some games (like ChilloutVR) support [Magica Cloth 2 by Magica Soft on the Unity Asset Store](https://assetstore.unity.com/packages/tools/physics/magica-cloth-2-242307) (It also supports Optimized Cloth Simulation!)
You can also use [Dynamic Bones by Will Hong]((https://assetstore.unity.com/packages/tools/animation/dynamic-bone-16743)). More games may support that.

***Export as Unity Package to Another Unity Project***
All Platforms are going to use Different Unity Versions, it's best to separate our Projects.
1. Look for "Project" in Unity (it's at the bottom, it's where all your files are located inside Unity)
2. Look on the left of "Project" for that sidebar that looks like folders, find the "Assets" folder
3. Right click on the Assets Folder and click "Export Package"
4. Save this file somewhere on your PC, anywhere will do as long as you remember where it is
5. once this is done, close Unity.
6. ***Now we Create a New Project in the Unity Hub!***
7. In the Unity Hub, Create a New Project.
8. At the top of the "New Project" Screen, select the correct Unity Version for the Game SDK you want to use.
9. (if you're creating for CVR, use the version of Unity [Listed Here.](https://docs.abinteractive.net/cck/setup/)
10. Wait for Unity to Open.
11. Once Unity is Open, Import the SDK for the game we are going to Convert to and the Unity Package we created.
12. Click on our Converted Avatar, there should be a button to convert our Avatar to the Game we are trying to Convert to (if supported by the tool.)
13. Your Avatar should now be Converted! Try Uploading!

## Does this work for All VRC Avatars?
It'll do it's best, but both games are built pretty differently despite what some may say or think. Neither VRChat nor ChilloutVR are "Just Unity" it's never that simple.
The Utility also has known issues with it's Animator Rebuilding System, so some things that Unity does by Default may not Convert Properly.

*To Ensure the Utility works it's best, please* ***DO NOT USE Sub-State Machines on your Avatars!*** *the support/code for this may be dodgy and I'd really suggest just avoiding it*

from IA to CVR the Utility will Convert:
- Avatar Descriptor to CVR Avatar
- Avatar Menus to CVR Advanced Avatar Settings
- Parameter Driver Animator State Behaviour to CVR Animator Drivers Behaviour
- Tracking Control Animator State Behaviour to CVR Body Control Behaviour
- LipSync (Viseme, Jaw-Flap, Jaw-Bone (sort of))

If you're converting from VRChat to ChilloutVR I can guarantee that this WILL mostly work if:
- Your Avatar isn't too Reliant on VRChat Specific Implementations of Features
	- "Button" Mode in Expressions Menu (your Avatar Toggles don't use this, I guarantee that)
	- Velocity on VRC Contacts
	- Grabbing Physbones
	- Animator State Behaviours other than:
		- Avatar Parameter Driver
		- Tracking State Thingy IDK I forget what it's called
- Your Avatar is not using VRCFury
	- Fury is a VRChat Specific Tool that makes it very simple to create an Avatar, it also makes it very difficult to migrate your avatar to any platform other than VRChat.
	- No, SPS likely won't work.
- Your Shaders are using SPS-I Compatible Shaders
	- I have a separate CVR Specific Utility for Checking this.

VRCFury and SPS will NOT be directly supported by this utility. That is entirely out of the scope of this project.
Fury is also not under a very permissive license so trying to make a variant of the utility isn't legally possible.
Hey if you created Fury and think I'm wrong, if your repo lacks a license it's Source Available (look don't touch), add a License to your repo we're not gonna discuss this.