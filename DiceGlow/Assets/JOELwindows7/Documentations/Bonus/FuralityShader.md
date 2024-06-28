# How to install Furality Shader

Revision 2024.06

You can install every Furality Shaders provided from the bootstrapper which you can download from the website https://furality.org. Every event, there maybe new evolution of the shader, which features are compatible hence you can simply upgrade to that newer evolution if you desire.

## **IMPORTANT**: VRChat AudioLink

All Shaders that expects llealloo's AudioLink explicitly depends the include based on the new filepath of this AudioLink, as shown:

`#include "Packages/com.llealloo.audiolink/Runtime/Shaders/AudioLink.cginc"` instead of ~~`Assets/AudioLink/Shaders/AudioLink.cginc`~~

Ensure that you have atleast copied above include (`AudioLink.cginc`) to its new designated location at `UNITY_PROJECT/Packages/com.llealloo.audiolink/Runtime/Shaders/AudioLink.cginc`.  
**DO NOT CUT!!!**, copy the file instead, since you may have other shaders that still expects older filepath. As far as we concern, it is safe to have double `AudioLink.cginc` each on their respective location.

> Note: If you forgot to do this OR did not select `Yes` when offered AudioLink filepath conversion, those shader that still expects those files in `Packages` will error missing dependency.
> Do not panic if it also says the built-in shader missing (`failed to open source file: UnityCG.cginc` etc.). That error is misleading as said by [this](https://forum.unity.com/threads/all-shaders-fails-to-open-source-file-custom-cginc.523184/#post-7461139), this, and [that](https://dkrevel.com/failed-to-open-source-file/).
> You simply have to take a look at the rest of the error, which in this case the AudioLink (`failed to open source file: Packages/com.llealloo.audiolink/Runtime/Shaders/AudioLink.cginc`), then ameliorate it as above.

## **NOTICE**: VRChat account is required

Unfortunately, the only way available to download Furality Shader evolution after Aqua is to **have a valid VRChat account**, since those newer shaders & assets are only available through the Bootstrapper.

You can simply register OR re-login your VRChat Account, & link that to `Furality.org`.

Additionally, per [Furality Asset License](https://furality.org/asset-license), developers are **forbidden** to share these files individually to another person. However re-packing non-restricted files along with developed Avatars, Props, and/or Worlds are permitted.

## Download Furality Shader

- Go to [website](https://furality.org)
- Click on `EVENT_NAME Assets` on top right nav selection bar
- Scroll down & look for box like `Assets` or related. You should find the Download `Furality Asset Manager` button.
- Click that to download the packages.
- You may also download additional packages around this page.
- Once done, open your CCK Unity Project, wait for loading until the editor opens, then open up the `Furality_Asset_Manager-Bootstrapper.unitypackage` file.
- Check & confirm this pop-up subwindow of your Editor for what files about to be imported.
- `Import`.
- A new `Furality Asset Manager` tab window will open.
- Click `Login` to open a website to login with your VRChat account. No SDK needed as it will open the login website.
- `Accept` linking `Furality.org` with your VRChat account
- You should see the success result if everything goes correctly. You can safely close this window & return to the Editor.
- You can now **Download everything** you have available alongside your rewards if you attended the event, or paid extra tier of the event.
- You may also explore other older shaders through the Furality Archive https://past.furality.org/. Each event may contains assets of that event you can download also.

## Documentations

Near the download of the assets, you can also find the `Documentation` buttons to visit the page & learn the information about those assets.

Example: [Umbra shader documentation](https://furality.org/umbra/shader-guide)

## Luma Glow

Luma Glow is a special Emission control feature introduced since Furality Luma. Unlike AudioLink, Luma glow can be controlled programatically instead of only Audio level as in AudioLink.

You can install the driver for CVR with this [prefab from Thorinair](https://github.com/Thorinair/LumaDriver-for-ChilloutVR).

## Which Shader I have to use!?

Latest: `Umbra`

We recommend to stick with the latest evolution of the shader. If the next event contains a new Shader, It is also recommended to upgrade all of your Furality Shaders to that evolution. **Make sure to make backup first!!!**  
Every evolution of the shader may contains additional features or bugfixes of the previous evolution.