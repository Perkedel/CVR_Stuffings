# Jill's Waterbed Shader

Standard Surface shader with vertex deformation from red channel of a (render) texture.

## To Use
Drop the prefab into your world.
Scale the bed to your liking.
Then set the camera size/viewport rect/clip planes so it fits the bed as snugly as possible
Size should be the largest length of the model.
viewport rect is just the aspect ratio of the largest length to the other length.
The clip planes are the distance from the camera the bed starts and ends. Adjust near till it hits the bootom and far till its slightly above the top.


## Custom Beds
Custom bed meshes need some setup to work well with this shader.
### UVs
Top of the bed needs to take the center of the uv map and should encompase the whole map pretty much.
Sides should be made small and placed around the edges of the top uvs, overlapping even.

Look at `waterbed_model.fbx` for an example.

### Vertexes
This shader moves individual vertexes and does not preform teselation.
This means you need a HIGH poly count for the bed to look good.
The bigger the bed, the higher the poly count.

`waterbed_model.fbx` contains 69,120 triangles and works pretty good up to 8x8m.

### Camera Setup
The Depth Camera should encompase the bed as closely as possible. 
It needs to be perspective and should face from the bottom, though from the top also works.
The camera needs to only caputre the layers that have what you want(probably just players). Do not capture the default layer as the bed will respond to iself.
The intermediate camera just needs to capture the destination view, just try not to touch it.


## For VRC use.
The bed is made for CVR and uses CVRs blitter component.
To recreate this functionality you need to make an udon script taking in the source and destination render textures as well as the blit material and call VRCGraphics.Blit() with them.
VRC's docs for this are [here](https://docs.vrchat.com/docs/vrcgraphics#vrcgraphicsblit).


## Configuration

### Waterbed
Power: How hard down(or up) the shader pulls vertexes.
Side Scale: How hard to pull in the sides compared to the top. Seems to work good a 0.25. Set to 0 to not pull in the sides and only modify the top.
Blur: From 0 to 5 how smoothed out the depth is from vertex to vertex.
Trail Blur Increase: From 0 to 5 how much to increase the blurring for the Trail.
Trail Blend: From 0 to 1, how present the trail is, 0 is not present, 1 is fully present.
Softness: A secondary blur added to the bed to make it bow out from the center. From 0 to 5, it like adding a second blur.
Softness: How tightly the bed wraps around objects.
Camera on top?: Check this if the camera is facing top down instead of bottom up. Also can fix issues where rotating the camera doesn't work to align deformation and model.
Model not from blender?: Blender uses z as the upward direction and so does this shader, if your model was made in a program using y as up then check this box.

### Blit Exponential(Default)
This uses an exponential function for the decay, which feels more natural.
Decay: How much to decay prior deformations. Lower means longer trails.
Threshold: What minimum and maximum to remove the trail at. Lower means trails last longer. Increase untill nothing gets stuck.

### Blit Linear
This uses a linear function for the decay, may be faster.
Decay: How much to decay prior deformations. Lower means longer trails.
Threshold: What minimum to remove the trail at. Lower means trails last longer. Increase untill nothing gets stuck.


## How it works
A render texture with color format DEPTH_AUTO captures the depth information from a camera. This is stored in the red channel from 0(far) to 1(near).
The source is mixed in the blit shader with an intermeidate texture that captures the last frame's version of the destination texure. This mix is output to the destination texture.
The sampling may be flipped if the camera is flipped so an option exists to fix that.
The destination is sampled in the waterbed shader, then that value is multiplied by the vertex normal to pull it in the normal direction then the offest is added to the current vertex position.
The x and y direction are scalable since the waterbed shouldn't cave in as deep as the detected depth.
All vertex positions are calculated in the models local space, so for models that are not using z as up(not from blender) there's an option for that.
After the vertex function is a pretty normal surface function.