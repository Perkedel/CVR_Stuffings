# How to Avatar

> Sources:
> - https://documentation.abinteractive.net/cck/avatar/
> - https://wiki.chilloutvr.eu/en/avatar/avatar
> - https://wiki.chilloutvr.eu/en/avatar/getting-started

You can upload an avatar to ChilloutVR. Avatar is a virtual body you wear in the game for other players to see you.

## Pre-requisite

In order to upload your own avatar, you will need:
- Compatible Humanoid 3D Models. a 3D Model file that's compatible with Unity, e.g.
    - FBX **(NATIVE) (RECOMMENDED)**
    - Blend **(NATIVE)**
    - VRM using [UniVRM](https://github.com/vrm-c/UniVRM)
    - GLB / GLTF using [UniVRM](https://github.com/vrm-c/UniVRM)
- Inside this 3D Model, it should has:
    - Root Bone. looks like an Empty GameObject with lots of more Empty GameObjects inside
    - atleast 1 Models itself, typically `SkinnedMeshRenderer`. It can be more than 1 of them.
    - Humanoid Avatar. Usually is included. Check in the Root of the 3D Model GameObject, and in inspector, Animator component should has the Humanoid avatar attached to it.
        - For VRM 1.0, in Component `Humanoid`, Please press `Create UnityEngine.avatar` if you haven't already.
- a

## Quick Start

1. Open up empty scene, & add your 3D Model to the scene.
    - PROTIPS: It is recommended to create prefab (or variant of this 3D Model file package), then edit all things from there.
1. In the Root of this 3D Model, add new component `CVRAvatar`
1. In this newly added CVRAvatar, insert field `Face Mesh` with the `SkinnedMeshRenderer` that represents your 3D Model's face.
    - Usually a GameObject named `Face` & it's that face
    - Or if it's just 1 single SkinnedMeshRenderer named `Body` / `Root`, you can just insert it there.
    - Most importantly any SkinnedMeshRenderer that contains **Eyes & Mouth**.
1. Adjust its `View Position` & `Voice Position` accordingly.
    - Ideally, `View Position` could be between eyes, either just behind or a bit protrudes off the nose bridge.
    - Ideally, `Voice Position` could be just between the front teeths top & bottom, or behind between the lips.
1. Keep the `Voice Parent` in `Head`, unless your avatar is novelty shape. There are serveral parent types this dot will stick to in the game:
    - `Head`, to head **(RECOMMENDED)**
    - `Left Hand`, to port hand
    - `Right Hand`, to starboard hand
    - `Hips`, to hip
1. (Optional) If your Avatar has movable eyes, in category `Eye Look Settings`, check `Use Eye Movement`
1. (Optional) If your Avatar has movable mouth of any kind, do the following in the `Lip Sync Settings`. Read below section for advanced
    - Check `Use Lip Sync` if you'd like your avatar to speak as you speak.
    - 3 types of lip movements:
        - Visemes. Using serveral standard defined syllables that relates to each of those onto the Blendshapes in your 3D model. The Game will use voice scan algorithm AI to define which mouth movement pose / viseme accodingly
        - Single Blendshape. same as Visemes, but only controls 1 selected Blendshape. The game with control this slider according to your voice loudness
        - Jawbone. control a Jaw bone as defined in the Humanoid avatar. The game with control this rig bone according to your voice loudness
    - Adjust its smoothing as you desire
    - (Viseme) Assign each Visemes to correct or similar blendshape accordingly.
    - (Single Blendshape) Select the blendshape you'd like it to be controlled in the game.
    - (Jawbone) Transform selection cannot be changed. To change which Jaw rig bone, please reconfigure this 3D Model Humanoid avatar file.
        - Open up the `.avatar` file of this 3D Model, and pay attention to category `Head`, an optional field `Jaw`. Insert this with Jaw rig bone if it exist in your `Avatar Configuration` Hierarchy.
        - Once you're done, press `Apply` in Inspector, and return configuring your avatar.
1. Advanced Tagging, Advanced Settings, & more in below advanced sections.
    - If you made your AAS / Advanced Avatar Settings controller, **always pay attention these steps!!!**, because there is a bug with CCK here.
    - Create an empty GameObject in the Root of this 3D Model. Everytime you added &/or edited the AAS cells, **Toggle the `Enabled` top left of the Inspector ON/OFF to trigger Prefab saving**. If you forgot, your AAS in the inspector may corrupt (missing cell, value, etc.) when you get out of prefab editing, but not the created controller.
    - `Create Controller`
    - `Attach Created Controller to the Avatar`
    - **DO NOT FORGET!!!**, in category `Avatar Customization`, check if the field `Animation Overides` is properly filled.
        - Click the field. Unity should point to the Animation Overide file at the Project sub-window.
        - If you are unsure / did not went pointing to the file, click the Circle with dot on that `Animation Overides` field. Pick the correct overides. e.g. your Avatar name is `Zuuljedus`, then it's `Zuuljedus_aas_overides`.
    - **DO NOT FORGET BEFORE GOING OFF THE PREFAB!!!**, Always retoggle your dummy GameObject or whatever around or anything that triggers Prefab saving.
1. Open up your CCK Control panel through:
    - Top menu bar `Alpha Blend Interactive`
    - `Control Panel`
    - You should see your avatar listed. You may also be offered some buttons and informations regarding this Avatar.
        - Material Slot count info, warns, & errors. Appears when your 3D Model utilized more than numbers of threshold. Only Info & Warn does not prevent uploading. And if your 3D models had too many slots exceeding beyond info & warn substantially, you will get error & unable to upload.
        - Import Fix. It is highly recommended to press this button, to fix certain things when e.g. exported the 3D Model from Blender to FBX.
    - Simply Click `Upload Avatar`
1. Please wait while the CCK is packing everything to be uploaded.
1. You will be presented with the Upload menu in Play mode.
    - Tag your avatar properly for safety
    - Name & write description.
    - Optionally, write what have you changed
    - Read carefully & check all the legalese checkboxes.
    - Submit

## Advanced

## Troubleshooting

### Avatar disappearing when people got close OR view angle at certain point

> - Hanz https://discord.com/channels/410126604237406209/588350726841827358/1221612696588390400 Bounding box. Avatar disappear when close issue.

We have experienced a mysterious quirk / bug like this where if people got close, sometimes part of the SkinnedMeshRenderers got occluded for no clear reason. You can work around this by doing the following steps:

- Simply edit your 3D Model / enter Prefab in the scene. 
- Select all `SkinnedMeshRenderer` & all other Mesh renderers.
- Set those bounding boxes:
    - Position dead center `0,0,0`.
    - Size `1,1,1` or more if your avatar is bigger than this box. Basically cover all parts your avatar 
- Upload again.
- If you are in the game session & currently wearing this Avatar, simply open up avatar menu in the game & re-`Apply` the same Avatar you are wearing to update.

## FAQ

### Is my Avatar safe? I'm afraid this could be ripped!

> https://documentation.abinteractive.net/chilloutvr/faq/what-is-chilloutvr/#is-my-content-safe-in-chilloutvr

**Yes, it's completely safe** & there no possibility of ripping as far as we concern.

When you started submitting your Avatar, the package will first be encrypted. Then sent to ABI's CDN, for later be downloaded by the game, & decrypted for sole purpose of the gameplay.

Only the game itself can decrypt these contents.

And even in the CCK, **it does not provide any option whatsoever to download what had just been uploaded to the ABI**. Say if somehow made, you still need the decryptor, which is never available.

### I want that avatar tho, but it's private 😢

Since ripping is technically impossible, there are serveral ways to get over this:

1. Note its SauceURL / Source in the Avatar description & hunt down the file.
    - You can visit what avatar the player is wearing by opening up their user page in the game. On bottom left is the avatar being worn.
    - Once you've noted it, use Search to query where's that avatar or open up its URL if available. There you can Download / Buy, and make one your own upload.
    - Ensure to follow its license.
2. __(EXTREMELY DANGEROUS, HIGHLY NOT RECOMMENDED)__ Ask the player whether or not they could provide the `.unitypackage` or the project of this Avatar they are wearing. Results may varies, **including permanent hatred / blocked**.
    - For Perkedel affiliated members however, you should be brought to our entire project files, all the sources involved, including the 3D model as well (if it's gratis, free to use of course). Please report to Joel immediately if you got hated / blocked for this and they are our affiliated members.
3. a
1. a

## End

by JOELwindows7  
Perkedel Technologies  
CC4.0-BY-SA