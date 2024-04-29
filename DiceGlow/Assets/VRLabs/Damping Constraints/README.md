<div align="center">

# Damping Constraints

[![Generic badge](https://img.shields.io/github/downloads/VRLabs/Damping-Constraints/total?label=Downloads)](https://github.com/VRLabs/Damping-Constraints/releases/latest)
[![Generic badge](https://img.shields.io/badge/License-MIT-informational.svg)](https://github.com/VRLabs/Damping-Constraints/blob/main/LICENSE)
[![Generic badge](https://img.shields.io/badge/Unity-2019.4.31f1-lightblue.svg)](https://unity3d.com/unity/whats-new/2019.4.31)
[![Generic badge](https://img.shields.io/badge/SDK-AvatarSDK3-lightblue.svg)](https://vrchat.com/home/download)

[![Generic badge](https://img.shields.io/discord/706913824607043605?color=%237289da&label=DISCORD&logo=Discord&style=for-the-badge)](https://discord.vrlabs.dev/)
[![Generic badge](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Fshieldsio-patreon.vercel.app%2Fapi%3Fusername%3Dvrlabs%26type%3Dpatrons&style=for-the-badge)](https://patreon.vrlabs.dev/)

Constraints with adjustable damping effects

![DampingConstraint](https://github.com/VRLabs/Damping-Constraints/assets/76777936/5582d63d-691e-40f1-bb4f-4fb45f471dc7)

### ⬇️ [Download Latest Version](https://github.com/VRLabs/Damping-Constraints/releases/latest)


### 📦 [Add to VRChat Creator Companion](https://vrlabs.dev/packages?package=dev.vrlabs.damping-constraints)

</div>

---

## How it works

* The constraint targets itself at full weight and another source at a weight lower than one.
* This causes a feedback loop where every frame the constraint moves a relative distance towards the target, creating a damping effect.

## Install guide

https://github.com/VRLabs/Damping-Constraints/assets/76777936/98ad4d8a-1e70-4c49-bccc-69b6fc566bf4

Position Damping Constraint

* Drag & Drop the ``Position Damping Constraint`` prefab into the base of your Hierarchy.
* Right click and unpack the prefab, then drag & drop it onto your avatar.
* Expand the prefab hierarchy and find ``Position Target``.
* Move ``Position Target`` outside of ``Position Damping Constraint`` and place it anywhere in your avatars hierarchy as needed.

Rotation Damping Constraint

* Drag & Drop the ``Rotation Damping Constraint`` prefab into the base of your Hierarchy.
* Right click and unpack the prefab, then drag & drop it onto your avatar.
* Expand the prefab hierarchy and find ``Rotation Target``.
* Move ``Rotation Target`` outside of ``Rotation Damping Constraint`` and place it anywhere in your avatars hierarchy as needed.

## How to use

* Place the objects you want to dampen inside ``Container``.
  * Alternatively you can constrain the objects to ``Container``.
* Changing the weight of the second source in the constraint will change the strength of the damping effect.

## Performance stats

```c++
Constraints:        1
```

## Hierarchy layout

Position Damping Constraint:

```html
Position Damping Constraint
|-Container
|  |-Cube
|-Position Target
```

Rotation Damping Constraint:

```html
Rotation Damping Constraint
|-Container
|  |-Cube
|-Rotation Target
```

## Contributors

* [lin](https://github.com/oofdesu)
* [PF_Cactus](https://github.com/brandonvdongen)

## License

Damping Constraints is available as-is under MIT. For more information see [LICENSE](https://github.com/VRLabs/Damping-Constraints/blob/main/LICENSE).

​

<div align="center">

[<img src="https://github.com/VRLabs/Resources/raw/main/Icons/VRLabs.png" width="50" height="50">](https://vrlabs.dev "VRLabs")
<img src="https://github.com/VRLabs/Resources/raw/main/Icons/Empty.png" width="10">
[<img src="https://github.com/VRLabs/Resources/raw/main/Icons/Discord.png" width="50" height="50">](https://discord.vrlabs.dev/ "VRLabs")
<img src="https://github.com/VRLabs/Resources/raw/main/Icons/Empty.png" width="10">
[<img src="https://github.com/VRLabs/Resources/raw/main/Icons/Patreon.png" width="50" height="50">](https://patreon.vrlabs.dev/ "VRLabs")
<img src="https://github.com/VRLabs/Resources/raw/main/Icons/Empty.png" width="10">
[<img src="https://github.com/VRLabs/Resources/raw/main/Icons/Twitter.png" width="50" height="50">](https://twitter.com/vrlabsdev "VRLabs")

</div>

