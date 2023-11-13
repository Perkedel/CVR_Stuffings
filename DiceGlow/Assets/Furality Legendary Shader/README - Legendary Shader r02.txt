

Download link and online Readme located at: https://furality.org/legendaryshader	
	
	
	-The Furality Legendary Shader-
		Thank you for using the Legendary Shader!

What it does:

	-This shader stylizes lighting effects to match our world's artstyle-
	
		The Furality Legendary Shader allows you to pick between a selection of stylized lighting
		effects.  These effects are designed to help you match your avatar to our world's artstyle.
		The shader was also designed to be highly customizable with a large selection of combinations
		to create your own unique effects.

	-Luma Glow V2!-
		
		Luma Glow has been expanded and improved to include additional effects and control.
		You can now manually pick between glow zones on your material and there are now
		zones dedicated to gradients!  Another new feature is audio reactivity.  This
		will cause your emissions to blink or pulse with the beat of the music as well as
		be controlled by our colors.

	-What is Luma Glow?-

		While you are inside our supported Furality Legends worlds, your avatar's emissions will
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

	-How will the worlds affect my emission colors?-

		Our worlds will tint your emission color by another color they send.
		If you want to recieve our world colors exactly without tinting, use a white and black emission.

How to apply:
		
	-Avatar Application-
	
		1. Open the "Legendary Shader Example Scene" to view examples of the shader pre-applied
		2. Import your avatar into the scene
		3. Duplicate one of the example materials ( CTRL + D )
		4. Drag it onto your avatar
		5. Apply your textures and adjust material settings as needed

Shader Properties:

	-New custom GUI for ease of use-

		The Furality Legendary Shader has its own custom inspector GUI that was designed now to
		overwhelm new users with a large list of properties all on one page.  All properties
		are sorted between their respective pages and an "advanced toggle" is included for those
		who wish for expanded features.

	-Shader Properties and what they do-

		Top of inspector:

			Page - Changes the settings page.  Changes the properties that are shown
			Workflow - Switches between metallic and specular workflows
			Rendering Mode - Switches to cutout or transparent rendering modes
	
	Page: Main Settings

		Main:

			MainText - Your primary texture. The alpha channel of this affects material opacity (Only on transparent and cutout rendering modes)
			Tiling - How much your primary texture tiles
			Offset - Offset your primary texture by this amount in direction x/y
			Color - This will tint your primary texture with the color you choose - The alpha channel of this controls transparency (Only on transparent and cutout rendering modes)

		Metallic:
			
			[empty square] - Your metallic texture. The alpha channel of this affects material smoothness
			Metalness - How metallic the material is
			Smoothness - How smooth the material is

		Specular (Only on specular workflow. Replaces Metallic):

			[empty square] - Your specular texture. The alpha channel of this affects material smoothness
			Smoothness - How smooth the material is
			Specular Color - Tints the specular texture by this color

		Normals:

		Q: What are Normals?
		A: Normals are a 2D texture used for faking the lighting of bumps and dents

			[empty square] - Your normal texture
			Normal Scale - The intensity of your normal texture
			Tiling - Tiling value for your normal texture
			Offset - Offset for your normal map

		Ambient Occlusion:
			
			[empty square] - Your AO texture
			Occlusion Power - AO intensity

		Emission:

			[empty square] - Your emission texture. This is the texture that is controlled by our worlds!
			Emission Tint - Tints the emission texture by this color
			Tiling - Tiling value for your emission
			Offset - Offset for your emission

		Emission Mask: (Only exposed in advanced mode)
			
			[empty square] - This texture will mask the emission. Red channel value will control the mask. Useful for scrolling emissions
			Tiling - Tiling value for emission mask
			Offset - Offset value for emission mask

		Emission Panning:

			Enable Emission Panning: Checkbox that will enable the movement of your emission
			Emission Pan Speed: X - Y: Controls direction and speed of emission movement

		Outline Settings:

			Enable Outlines: Checkbox to enable outlines
			Outline Color: Changes the color of the outlines
			Outline Width: Changes outline size
			Outline Depth Fade: Helps hide sharp edges of outlines by fading them with depth

		Misc:
			
			Mask Clip Value - Used in cutout blend modes. Alpha values below this will be clipped from your main texture
			Culling - Which faces of your mesh are visible. If you're seeing through parts of your model, set this to "off."
			Debug Mode - Enables testing mode for Luma Glow

	Page: Lighting Settings

		Lighting Styles:

			Shadow Style: Changes the style of the lighting ramp and realtime shadows
			Specular Style: Changes the style of the specular highlights
			Rimlight Style: Changes the style of rimlighting

		Distance Bleding: These settings help blend stylized effects with distance to look better on the eyes

			Blend Offset: Offsets the start point of the blend
			Blend Lengeth: The distance the blend takes palce over

		Shadow Settings: (Only exposed in advanced mode)

			Offset: Moves the shadow ramp forward/back
			Length: The falloff of the shadow ramp

			Shadow Style Settings:
				
				Halftone Scale: Changes the tiling of stylized effects for shadows
				Halftone Rotation: Rotates stylized effects for shadows

		Specular Settings: (Simple)

			Specular Tint: Tints specular effects by this color

		Specular Settings: (Advanced - Doesn't work on default specular style)

			Offset: Offsets specular highlights
			Length: Falloff of specular highlights

			Specular Style Settings:

				Halftone Scale: Changes the tiling of stylized effects for specular highlights
				Halftone Rotation: Rotate stylized effects for specular highlights

		Rimlight Settings: (Simple)

			Rimlight Tint: Tints rimlighting effects by this color

		Rimlight Settings: (Advanced)

			Offset: Offsets rimlighting forward/back
			Length: Falloff of rimlighting effects
			Rotation Angle: How rotated along the rotation axis for rimlight
			Rotation Axis: Rotation axis to rotate around

			Rimlight Style:

				Halftone Scale: Changes the tiling of stylized effects for rimlighting
				Halftone Rotation: Rotate stylized effects for rimlighting

	Page: Luma Glow Settings

		Emission:

			[empty square] - Your emission texture. This is the texture that is controlled by our worlds!
			Emission Tint - Tints the emission texture by this color
			Tiling - Tiling value for your emission
			Offset - Offset for your emission

		Emission Mask: (Only exposed in advanced mode)
			
			[empty square] - This texture will mask the emission. Red channel value will control the mask. Useful for scrolling emissions
			Tiling - Tiling value for emission mask
			Offset - Offset value for emission mask

		Emission Glow:

			Tint: Tints the emission texture by this color
			Enable Zones: Enables selection of Luma Glow color control zones for the Emission
			Zone: Allows selection of zones
			Audio Reactivity: Selects the audio reactivity mode. This can be activated while zones are disabled.

		Glow Mask Settings: (Only exposed in advanced mode)
			
			Glow Mask: (Only exposed in advanced mode. This is an RGB mask where each channel is mapped to a different selected zone)

				[empty square] - Texture for the glow mask
				Tiling - Tiling value for glow mask
				Offset - Offset value for glow mask

			Red Channel Glow:(Only exposed in advanced mode)

				Tint: Tints the red channel glow colors of the glow mask
				Enable Zones: Enables selection of Luma Glow color control zones for the red channel of the glow mask
				Zone: Allows selection of zones
				Audio Reactivity: Selects the audio reactivity mode. This can be activated while zones are disabled.

			Green Channel Glow:(Only exposed in advanced mode)

				Tint: Tints the green channel glow colors of the glow mask
				Enable Zones: Enables selection of Luma Glow color control zones for the green channel of the glow mask
				Zone: Allows selection of zones
				Audio Reactivity: Selects the audio reactivity mode. This can be activated while zones are disabled.

			Blue Channel Glow:(Only exposed in advanced mode)

				Tint: Tints the blue channel glow colors of the glow mask
				Enable Zones: Enables selection of Luma Glow color control zones for the blue channel of the glow mask
				Zone: Allows selection of zones
				Audio Reactivity: Selects the audio reactivity mode. This can be activated while zones are disabled.

		Additional Properties: (Exposed contextually)

			Gradient Direction: Changes the direction of all gradient zones
			Lows Pulse Direction: Changes the direction of all audio reactive lows pulses
			Highs Pulse Direction: Changes the direction of all auido reactive highs pulses


Credits:
Shader created by Naito Ookami

X-Bot model: 
https://sketchfab.com/3d-models/character-x-bot-479fc4feccba4ee1b3746b829aa26f0b

	