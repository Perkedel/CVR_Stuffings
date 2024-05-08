Unused Bone Reference Cleaner
---

A simple utility that cleans up unused bone references on your Skinned Mesh Renderers, potentially providing a performance boost in ChilloutVR.

## How to Use:
- Import
- Upload

This is a non-destructive tool that automatically hooks the ChilloutVR CCK avatar build event. This will not modify your original source mesh- at the cost of potentially making upload slower.

You can alternatively manually run the tool directly on your source mesh using the utility found at ‘NotAKid/Unused Bone Ref Cleaner’.

## Why This Works:
ChilloutVR's specific head-hiding technique is used to avoid the need for a dedicated Mirror Clone. This involves activating a [specific flag](https://docs.unity3d.com/ScriptReference/SkinnedMeshRenderer-forceMatrixRecalculationPerRender.html) on the skinned mesh, triggering reskinning during each camera render while the avatar is worn. However, this approach can impact performance severely depending on environment and how many cameras can currently see your local avatar. To mitigate this, ChilloutVR filters out any mesh not needing this performance-intensive flag by checking against the ‘SkinnedMeshRender.bones’ array to determine if it has any bones actively being hidden.

Previously, older Unity versions automatically excluded bones without weights when importing a new model. Yet, modern avatars inexplicably reference all bones by default, even those irrelevant to the model. Basically- this makes ChilloutVR assume **every skinned mesh** is in need of head-hiding, which can kill the local performance of your avatar.

This tool preprocesses your avatar automatically on upload, eliminating unnecessary bone references and weights, on the copy of your avatar that is uploaded to ChilloutVR. This allows the head-hiding to only run where needed and as such can greatly improve the performance of your avatar by reducing unneeded overhead while skinning between cameras.

## Note:
This is not a magic bullet to increase your performance in-game. You are still likely to be bottlenecked elsewhere while in a populated instance, and as such, the performance improvement may not be as noticeable as expected.

The Visual Clone experimental option within ChilloutVR also provides a better solution than this, as it allows the head-hiding to function without the expensive reskinning flag enabled in the first place.

---

Here is the block of text where I tell you it's not my fault if you're bad at Unity.

> Use of this Unity Script is done so at the user's own risk and the creator cannot be held responsible for any issues arising from its use.
