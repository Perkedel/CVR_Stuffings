## Notice:
This will not be receiving any updates until ChilloutVR's IKSystem is fixed. 

I do not want to release a locomotion prefab that has to mitigate animation bleeding into FBT IK.

# CCK.BaseAnimatorPatch

![image](https://user-images.githubusercontent.com/37721153/187007646-68e4b525-009d-4161-a16e-e2e6e84773e4.png)

# features
* Less use of anystate.
* Better jump/fall animations.
* Emotes don't get stuck first time for desktop keybind press.
* FBT disable locomotion toggle, forces TPose if enabled.
* Split logic for Desktop, VR, and FBT.
* Emotes can be changed mid-emote, allowing dance spam.
* Support for AvatarMotionTweaker using Upright parameter.
* Improved crawl animation from mixamo.
* Improved crouch idle to prevent feet clipping.
* Parameter to easily change Motion speed.
* Desktop smooth stand, crouch, and prone transitions.

# note
this animator makes heavy use of transition interupts and transition order, so messing with any built-in transitions may break functionality or make the animator feel more clunky

This is pretty much a from-scratch animator based on what I use personally for my models for CVR and VRC. Feel free to use this as a base for your avatars.

# preview

jumpin

https://user-images.githubusercontent.com/37721153/187008214-375416cd-e980-4aa7-868d-400e08f4689b.mp4

crawlin

https://user-images.githubusercontent.com/37721153/187008213-2edd0819-e61c-4995-b60e-bb7f3b57803e.mp4

emotin

https://user-images.githubusercontent.com/37721153/187008318-57a00f8a-78b4-401f-bf81-6fd11a5a0f21.mp4




# sources
Mixamo - low crawl animations [(link)](https://helpx.adobe.com/creative-cloud/faq/mixamo-faq.html)

ABI.CCK - original crouch animation [(link)](https://cck.cvr.gg/)

Xiexie - jump/fall animations [(link)](https://github.com/Xiexe/OldPatreonExclusiveThings)

Blender - constraints and bake action features that both drove me mad and made my shit actually not shit

---

Here is the block of text where I tell you it's not my fault if you're bad at Unity.

> Use of this Unity Script is done so at the user's own risk and the creator cannot be held responsible for any issues arising from its use.

