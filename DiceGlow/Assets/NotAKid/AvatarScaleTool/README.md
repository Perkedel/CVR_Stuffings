# AvatarScaleTool

Avatar Scale Tool is an editor script that generates avatar scaling animations for ChilloutVR based on target viewpoint heights. 

The tool is located under `NotAKid/Avatar Scale Tool`.

![image](https://user-images.githubusercontent.com/37721153/235814026-253c4d63-5660-47f2-8a3a-3d5b7da93435.png)

## How to Use
* Select the target avatar.
* Input the desired minimum and maximum heights in meters. The viewpoint position is assumed to be the initial height.
* Select which components/properties you want to have scaled under Optional Settings.

* Click `Add To AAS` if you want it to automatically add the slider & animation clips to your Avatar Advanced Settings.
  * This will place the generated clips into your `AdvancedSettings.Generated` folder and add the AAS Slider entry.
  * Make sure to click **CreateAnimator** in your CVRAvatar component!

* Click `Export` if you want only the generated animation clip. 
  * `Split Animation Clip` will determine if it exports two clips for a blendtree or one clip for motion time.
  * This is meant for creators making their controllers manually outside of the CVRAvatar AAS autogeneration GUI.

Use the **Initial Height Percentage** value to set your *default* slider value in your controller & Avatar Advanced Settings (AAS).

A local float parameter, `#MotionScale`, is animated alongside the root of the avatar. Add this parameter to your controller and use it as the speed modifier for your locomotion animations if you want your walking, crouch, and prone speeds to match your avatar's scaled height.
 
---

Here is the block of text where I tell you it's not my fault if you're bad at Unity.

> Use of this Unity Script is done so at the user's own risk and the creator cannot be held responsible for any issues arising from its use.

