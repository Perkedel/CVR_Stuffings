# VoyVivika's Personal Shader
![Shader Preview](https://github.com/VoyVivika/VivikaShader/blob/main/README%20ASSETS/Unity_Xwahnfhmvv.gif?raw=true)

[3D  Model Showcased is my Personal Edit of Murdoc the Rat by Skully Hellfire](https://skullyhellfire.gumroad.com/l/skullysmurdoc)

The Vivika Shader (Formerly the "Divorce Shader" after an inside joke) is a Shader created by VoyVivika in Unity3D with the Amplify Shader Editor. I made these for my Personal ChilloutVR Avatars with some in-game encouragement from N3X15, ended up being a fun project for experimenting with Amplify Shaders Honestly, figured out how UV Discarding worked (and it's honestly a personal favorite feature despite not using it very much).

# Please Note:
This Shader only officially supports the Unity Built-in Render Pipeline, it does not support LWRP, URP, or HDRP at this time.

## Features
- AudioLink Support
	- AudioLink.cginc Included along with the Amplify Functions as permitted by the AudioLink License.
		- Using the [ChilloutVR Specific Fork by DomNomNom](https://github.com/DomNomNomVR/cvr-audio-link)
	- Emission Mask with 4 Colors that Represent each Band, the Colors Combine Together to Become White.
	- If AudioLink is Absent in the Enviornment, the Bass Band Emission will remain on.
	- UV Based Delay
		- Three Modes
			- Off (None at all)
			- UV Vertial (From the Top of the UV Map to the Bottom)
			- Distance (Distance out from a Position)
		- This uses UV Map 3 on your Model
- UV Based Vertex Discarding
	- Discards Verticies within Certain UV Coordinates
	- This uses UV Map 2 on your Model
	- Two Types
		- Vertex UV Tile Discard
			- This Treats UV Coordinates like Tiles (U 1.0 to 2.0, V 1.0 to 2.0 is considered Tile 1, 1)
		- Vertex UV Range Discard
			- This will Discard Verticies within a Specified UV Range.
			- This uses a Vector 4
				- X and Y are the Starting UVs (Example: 1.0, 1.0)
				- Z and W are the Ending UVs (Example: 2.0, 2.0)
- Video Player Decal
	- Supports both ChilloutVR & VRChat in Select Worlds
		- in VRChat, Worlds with Newer Versions of ProTV
			- in VRChat, to support this use newer versions of ProTV, Otherwise, please look for resources related to Udon. I am personally dedicated to creating content for ChilloutVR.
		- in ChilloutVR, my world the Viviklub Supports This.
			- to Support This in ChilloutVR:
				1. in your world, add a Component called `CVR Global Shader Updater`
				2. Enable "Update Texture"
				3. Drag and Drop the Render Texture being used by a `CVR Video Player` Components
				4. Set the Property Name to `_Udon_VideoTex`
- Rim Lighting
- 3 Lighting Types
	- Standard (Acts like Unity Standard Shader)
	- Toon (Stylized Lighting, may be buggy, deprecated, replaced by wrapped)
	- Wrapped (A Less Realistic Lighting Mode with the intent of having less harsh, smoother, flatter lighting.)
### MultiMap
MultiMap is a Texture which contains multiple maps in a Single RGB Texture intended for use with DXT1 Encoded Textures
Currently the Spec for the Divorce Shader Multi-Map is
- Red Channel = Metalic
- Green Channel = Smoothness
### Texture Ramp (Toon Lighting)
- Left is Darkest, Right is Lightest
- For best results on your Texture Ramp switch the Wrap Mode from "Repeat" to "Clamp"
## Amplify Functions
This Repo contains some Amplify Shader Editor Functions useful for Shader Creators, namely:
- Distance
	- A Basic Implementation of a Distance Function
- UV Range Discard
	- Returns NaN if the supplied UV is in the Supplied UV Range, otherwise Returns 0.
- UV Tile Discard
	- Returns NaN if the supplied UV is on the Supplied UV Tile, otherwise Returns 0.
- UV Range Check
	- Returns 1 if the supplied UV is in the Supplied UV Range, otherwise Returns 0.
- UV Tile Check
	- Returns 1 if the supplied UV is on the Supplied UV Tile, otherwise Returns 0.
- Decal
	- A Function to assist in the creation of Decals (Textures that get added on top of the existing Albedo map)
	- A variant also exists to create a variant that does not include rotation
# Third-Party Licenses
Please Note if these links are incorrect they will be corrected in a later commit after the mistake is corrected.
- Hue Shift - https://github.com/VoyVivika/VivikaShader/blob/main/Functions/ThirdParty/HueShift/LICENSE.txt
- AudioLink - https://github.com/VoyVivika/VivikaShader/blob/main/Libs/AudioLink/LICENSE.txt