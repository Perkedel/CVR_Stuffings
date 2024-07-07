A complete rewrite of my older shaders.  More efficient and with more features than before!  This shader also fixes all the lighting issues from my previous one.

I'll try to explain some of the features here.  Some features will need their own explanation separately.

Mask Clip Value - The cutoff value an alpha mask
Diffuse Tint - Base color
Specular Color - Color of gloss
Specular Mask - Explained more below
Specular Tinting - Takes the color of your diffuse and uses it for glossy reflections
Specular Tint Intensity - Intensity of your diffuse color tint
Detail Contrast - Explained below
Specularity - Explained below
Normal Intensity - How intense your normal map is ( this will mostly just mess up your shadows but can look nice with specularity if used correctly.  Keep it to low values )
Specular Mask to Texture detail - Explained below
Specular Brightness - Brightness of your glossy reflections
Detail Brightness - Explained Below
Cutout - Your texture to use for alpha cutouts, if any
Max light intensity - Maximum intensity for all light to affect you
Darken Shadow - Will clamp the maximum shadow brightness down
Shadow Contrast - It's all in the name.  But for those of you who need it.  This controls shadow contrast.
Lighten Shadow - This will clamp the minimum shadow brightness up
Shadow steps - How many slices your toon lighting will have
Inverted tinting - Inverted outline tinting
Outline tint brightness - The brightness of the outline tint
Outline Tinting - Uses your diffuse colors to tint the outline
Outline Color - If not using tinting, this will color your outline
Normal Mask - A mask for your normal map if using a repeating texture.  Where you don't want it colored black, where you do colored white.
Outline Width - Width of your outline
Normal Map - Where you put a normal map if you have one
Glow color - The color of any emissions
Glow Steps - The glow on this shader is stylized.  Just like on your shadow this will control the slices of your glow
Diffuse intensity - The emission intensity of your diffuse color beneath the glow
Darken Glow - Clamps max glow brightness down
Outer Glow - Controls outer glow brightness
Inner Glow - Controls inner glow brightness
Glow distance - How far the glow effect will reach towards the center
Brighten Glow - Clamps minimum glow brightness up
Glow Contrast - ...Glow Contrast
Edge Intensity - The intensity of the emission for the edges of the glow
Glow Mask - Transparent where you do not want to glow.  Black where you DO want to glow

Advanced: Specular Highlights
So as you can see in the picture the scales on the model shine.  But they only shine on part of the scales.  This is because I am using the "Specular Mask" feature.

Specular Mask - Input a black and white (black being the pits and white being the peaks) or even a normal map into this and it will mask the gloss on your character to the shape of it.  If you're using a normal mask this effect will not appear anywhere where your normal map does not.  It's recommended you just stick your normal map into the specular mask slot.  It will work.  After adding a specular mask there are some things you can do to tune it.
Specularity - This is essentially just another contrast value but what it will do here is make it so whiter parts, or higher parts if using a normal, of your mask will be more defined.  If I use it on my scales it will only light up the very tip of each scale.
Using these settings can do more than just make scales shine.  If you use it on the fabric of a skirt, for example, and use it along with a normal map of silk or other fabric texture. This will result in a shiny silk like fabric on your avatar.

After you have a specular mask there's some things you can do with it.  The scales on my avatar are not actually in my texture.  They're added detail straight from the specular mask.  You can tick this option on with "Specular Mask to Detail"  After that there's some options you can use to modify how it appears.
Detail Contrast - The contrast of the specular details
Detail Brightness - The brightness of the specular details
Playing with these settings can achieve drastically different effects at different numbers

Enjoy the shader everyone.  Have fun being shiny