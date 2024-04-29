Preview
---

![preview](https://github.com/NotAKidOnSteam/NAK_CVR_Prefabs/assets/37721153/47e07b2a-b5fe-4066-adc8-054a01a4ce32)

Description
---

Automatically aligns the local player to any surface they walk on using a Gravity Zone.

This prefab can be used as a Spawnable and as a World gimmick.

Technical Details
---
- Final IK Grounder to track the floor below the player and a damping constraint on the following Gravity Zone to smooth out tracking terrain.
- CVRAttachment to instantly attach to the local player when the IsMine condition is fulfilled by an Animator Driver.
- CVRParameterStream monitoring for local avatar reload to initiate re-attachment once avatar switch has completed, as well as feeds Movement controls to rotate the Final IK grounder target in the desired movement direction to aid in climbing walls.

Requirements
---
- [Final IK v1.9](https://assetstore.unity.com/packages/tools/animation/final-ik-14290) or [VRLabs Final IK Stub](https://github.com/VRLabs/Final-IK-Stub)

Credit
---
- [VRLabs Raycast Prefab](https://github.com/VRLabs/Raycast-Prefab) - [MIT License](https://github.com/VRLabs/Raycast-Prefab/blob/main/LICENSE)
- [VRLabs Damping Constraints](https://github.com/VRLabs/Damping-Constraints) - [MIT License](https://github.com/VRLabs/Damping-Constraints/blob/main/LICENSE)