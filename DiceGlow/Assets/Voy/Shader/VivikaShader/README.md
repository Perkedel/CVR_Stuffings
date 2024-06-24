# VoyVivika's Personal Shader
![Shader Preview](https://github.com/VoyVivika/VivikaShader/blob/main/README%20ASSETS/Unity_Xwahnfhmvv.gif?raw=true)

[3D  Model Showcased is my Personal Edit of Murdoc the Rat by Skully Hellfire](https://skullyhellfire.gumroad.com/l/skullysmurdoc)

The Vivika Shader is a Shader created by VoyVivika in Unity3D with the Amplify Shader Editor. I made these for my Personal ChilloutVR Avatars with some in-game encouragement from N3X15, ended up being a fun project for experimenting with Amplify Shaders.

# Please Note:
This Shader only officially supports the Unity Built-in Render Pipeline, it does not support LWRP, URP, or HDRP at this time.

## Features
- Single-Pass Stereo Instancing Compatible
	- Rendering Mode used in Unity 2020+ by Default for VR/XR Enabled Projects.
		- This Rendering Mode is not Required by VRChat, as their version of Unity is Customized to retain Backwards Compatibility for Older Shaders.
		- This Rendering Mode is Required by ChilloutVR, as they use SPS-I.
- AudioLink Support
	- AudioLink.cginc Included along with the Amplify Functions as permitted by the AudioLink License.
		- Using the [ChilloutVR Specific Fork by DomNomNom](https://github.com/DomNomNomVR/cvr-audio-link)
	- 4 Colors that Represent each Band, the Colors Combine Together to Become White.
	- Setting to Keep Emission of the Bass Band on if AudioLink is Absent from the Enviornment.
	- AudioLink Delay Feature
		- Delay done using Grayscale Texture (Black = No Delay, White = Maximum Delay)
			- Recommended to Disable SRGB on Texture, Leave Mipmaps on!!!
		- Setting to Increase Maximum Delay (0 - 127)
- Vertex UV Tile Discard
	- Discards Verticies within Certain UV Coordinates
	- This Treats UV Coordinates like Tiles (U 1.0 to 2.0, V 1.0 to 2.0 is considered Tile 1, 1)
- Rim Lighting
- Toon Style Lighting
- Support for [Raliv's Dynamic Penetration System](https://raliv.gumroad.com/l/lwthuB)
	- This is supported via a Custom Variant of the Vivika Shader which looks for the DPS .cginc files.
	- This Variant of the Vivika Shader Requires DPS to be present in your Unity Project.
## Legacy (Deprecated/Removed Features)
These Features can be found in Older Versions of the Vivika Shader.
- Video Player Decal
	- This was supported in older versions of the Shader
	- Used the `_Udon_VideoTex` Global Texture (to retain VRChat Support. Personally I would've called it `_VideoTex` or `_GlobalVideoTex`)
	- Removed to save on Texture Samplers
- MultiMap
	- This stood in place of Unity's Metalic Glossiness Map. Support for this was cut after it became a priority to retain Standard Shader Compatibility.
	- Red Channel = Metalic
	- Green Channel = Smoothness
	- Removed to save on Texture Samplers and Texture Memory.
## Amplify Functions
This Repo contains some Amplify Shader Editor Functions useful for Shader Creators, namely:
- Distance
	- A Basic Implementation of a Distance Function
- UV Range Discard
	- Returns NaN if the supplied UV is in the Supplied UV Range, otherwise Returns 0.
- UV Tile Discard
	- Returns NaN if the supplied UV is on the Supplied UV Tile, otherwise Returns 0.
	- (for those using this in ASE) If using multiple, consider using "UV Tile Checker" instead, adding the results, step(1, CheckerResults) and then compare the results of the step to 1, true should be division by zero (NaN), false should just be zero (0).
- UV Range Check
	- Returns 1 if the supplied UV is in the Supplied UV Range, otherwise Returns 0.
- UV Tile Checker
	- Returns 1 if the supplied UV is on the Supplied UV Tile, otherwise Returns 0.
		- In older versions of this shader package there is an ASE Function called "UV Tile Check" which is functionally similar but is less optimized.
		- Basically, Remember to use "UV Tile Checker" and not "UV Tile Check" if upgrading from older versions.
- Decal
	- A Function to assist in the creation of Decals (Textures that get added on top of the existing Albedo map)
	- A variant also exists to create a variant that does not include rotation
- If Float Equals
	- Optimized way to check if Two Values are Equal, if yes the input of true is returned, if no the input of false is returned.
		- Uses Step Functions to check if Equal and Lerp Function to return either based on the result of the step functions.
# Third-Party Licenses
Please Note if these links are incorrect they will be corrected in a later commit after the mistake is corrected.
- Hue Shift - https://github.com/VoyVivika/VivikaShader/blob/main/Functions/ThirdParty/HueShift/LICENSE.txt
- AudioLink - https://github.com/VoyVivika/VivikaShader/blob/main/Libs/AudioLink/LICENSE.txt