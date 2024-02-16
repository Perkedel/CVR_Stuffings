# Fake Glass

A glass shader for Unity/VRchat that (ab)uses some Unity features to get nice, clean looking glass without a heavy performance impact. Unlike many other glass shaders, it does not use a Grab Pass, saving a lot of performance.

![Preview](https://s2.booth.pm/da52898a-55fb-47ad-bd28-d1e52668811d/i/2336731/84974e34-b21e-40b2-bd8d-4a0a22d8f0b4_base_resized.jpg)

## Installation

Download the repository. Then place the Shader/ folder with the shader into your Assets/ directory.

## Usage (Normal)

Your scene must have reflection probes set up for the shader to look correct. [Take a look at my guide for more info.](https://gitlab.com/s-ilent/SCSS/-/wikis/Other/Reflection-Probes)

Diffuse Colour changes the surface colour of the glass. You can adjust the opacity of the glass through the alpha channel. Note that the alpha channel controls whether you can see through the glass or not.

Glow Strength will add a soft glow coming from the "inside" of the glass. It's multiplied by the Tint Texture.

Smoothness controls the smoothness of the exterior of the glass.

Metallic controls how much light the glass absorbs. When metallic is higher, the glass is more opaque.

IOR and Refraction Power control the refraction effect.

Interior Diffuse Strength controls the power of scattered diffuse light when the glass is viewed from glancing angles. The higher it is, the more the environment diffuse lighting is visible at glancing angles.

Surface Mask will define "foggy" areas of the glass, where the transparency of the glass is replaced by the blurred baked reflection. The intensity of the texture controls the level of blur. It uses the reflection probe for this, so players and other objects won't be seen in foggy glass.

If you're using this on a single glass object, it's recommended to place a reflection probe in the middle of the object, and assign it as the object's Anchor Override. 

## Usage (Rain)

When using the rain versions, make sure the Rain Mask, Droplet Normals, and Ripple Normals textures are assigned.

By default, the speed of the rain is 1 cycle/second. Depending on how hard you want the rain to look, you can lower this to make the rain's pattern less noticeable.

The different channels of the mask channel correspond to different aspects of the rain effect. If you want to change how the rain effect looks, here's what you need to know.
* Red channel controls the ripple effect on the ground.
* Green channel controls the droplet streak effect on walls.
* Blue channel controls the mask over the droplets to give them the appearance of motion.

## UI is weird!

Probably will be fixed later.

## License?

This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/)
