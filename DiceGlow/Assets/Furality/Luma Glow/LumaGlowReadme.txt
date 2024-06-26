	-Furality Luma Glow Avatar Shader-
		Thank you for choosing to use Luma Glow!

What it does:

	-This shader allows you glow with Luma!-

		While you are inside our supported Furality Luma worlds, your avatar's emissions will
		recieve special effects.  While inside our club, your emissions will pulse, change color,
		and flash with the beat of the music!  Outside of the club, our other worlds will have
		additional effects!

	-Optimized world-to-avatar control-

		This shader was designed to read data directly from our own sources.  This means you
		don't have to do any audio processing on your end!  Other effects are processed on 
		your GPU, saving you that precious CPU performance.

	-Faked Realtime Global Illumination-

		Because of CPU limitations we cannot use realtime lightmaps on our club world to show off
		all the amazing lighting effects. To get around this, we created a fake GI shader for the
		world that is fed the light data from our sources, bypassing your need to calculate it!
		The shader then picks this up using a realtime reflection probe that is then sampled by this
		shader in a special way that allows it to emulate the same GI but on your avatar!

How to apply:
		
	-Avatar Application-
	
		1. Open the "LumaGlow ExampleScene" to view examples of the shader already applied
		2. Import your avatar into the scene
		3. Duplicate one of the example materials ( CTRL + D )
		4. Drag it onto your avatar
		5. Apply your textures and adjust material settings as needed

Shader Properties:

	-Created with familiarity in mind-

		The shader was made to emulate Unity's own default standard shader.  This makes our
		shader quick and easy to understand for anyone already used to using Unity!
		Something is included for everyone.  There is included support for the metallic
		or specular setup, transparency, and cutout.  No matter your avatar needs, this shader
		should support it!

	-Shader Properties and what they do-
		
		Main:
			MainTexture - Your primary texture. The alpha channel of this affects material opacity (Only on transparent and cutout)
			Tiling - How much your primary texture tiles
			Offset - Offset your primary texture by this amount in direction x/y
			Color - This will tint your primary texture with the color you choose
			Opacity (Only on transparent) - How transparent your material is

		Normals:

		Q: What are Normals?
		A: Normals are a 2D texture used for faking the lighting of bumps and dents

			[empty square] - Your normal texture
			Normal Scale - The intensity of your normal texture
			Normal Tiling - Tiling value for your normal texture

		Metallic:
			
			[empty square] - Your metallic texture. The alpha channel of this affects material smoothness
			Metalness - How metallic the material is
			Smoothness - How smooth the material is

		Specular (Only on specular variants. Replaces Metallic):

			[empty square] - Your specular texture. The alpha channel of this affects material smoothness
			Smoothness - How smooth the material is
			Specular Color - Tints the specular texture by this color
		
		Emission:

			[empty square] - Your emission texture. This is the texture that is controlled by our worlds!
			Mask - This texture will mask the emission. Useful for scrolling emissions
			Emission Tint - Tints the emission texture by this color
			Min Emission - The minimum value that our worlds will reduce your emission. Additive (See F.A.Q)
			Emission Tiling - Tiling value for your emission
			Emission Pan Direction - Animated panning of the emission texture in the direction of X/Y

		Ambient Occlusion:
			
			[empty square] - Your AO texture
			Occlusion Power - AO intensity

		Misc:
			
			Mask Clip Value - Used in cutout. Alpha values below this will be clipped from your main texture
			Culling - Which faces of your mesh are visible. If you're seeing through parts of your model, set this to "off."
			Shading Style - Stylistic lighting modes available (See F.A.Q)

FAQ:

		Q: Metallic does not look very metallic?
		A: Because our worlds will be using baked lighting there are no specular highlights built into this shader.
		   This makes materials with this shader look slightly less metallic than standard.

		Q: What is "Min Emission"?
		A: This value was created for those of you who do not want our worlds turning your emissions off.
		   If you turn this value up to, for example, 0.5, our worlds will now only be able to reduce your emissions
		   by half. However, our worlds will now also brighten your emissions to a higher value than if the setting was
		   at 0. This ensures our world effects will always be visible!

		Q: What is "Shading Style"?
		A: Shading Style will stylistically change the way light affects the material.
		   "Lambert" is a traditional, realistic, lighting style with dark shadows.
		   "Half-Lambert" is a more toony version of Lambert, used prodominantly in TF2.
		   "Toon" is a highly toony lighting style with a hard line shadow transition.


		Q: How will the worlds affect my emission color?
		A: Our worlds will tint your emission color by the value they send.  If you want to recieve our world colors exactly
		   without tinting, use a white emission with the color below the emissions being black.
