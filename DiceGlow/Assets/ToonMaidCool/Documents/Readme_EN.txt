////////////////////////////////////////////////////////
Toon Maid Cool ver.1.03

Publisher and CopyRight Holder : "Virtet"
////////////////////////////////////////////////////////

This is the 3D toon character model of victorian maid which is cool girl version.
This package includes 3 animations, 2 facial animations, 2 blendshapes
and others.

This model can share their animations with "Toon Maid Asset" of the another one.

<Version>

-ver.1.00 First Release

-ver.1.02
 The shader files are fixed.

-ver.1.03
 separated head, hair, body and headdress into the each objects.
 optimized the scripts.
 applied normal map to the clothing.
 made the model to be recieve shadows.
 

========================================================
Points to note
========================================================
<Projest Settings - Quallity Settings>
In order to move animations naturally, set Blend Weights as "4 Bones".
if set as "2 Bones" or less, polygons are penetrated each other in some motions.


========================================================
Shaders
========================================================
Difference of shaders are as follows:

MaidSurfaceShader	
	
-RenderType" = "Opaque"
-Render Queue = Geometory = 2000

MaidSurfaceShader_Brow	
	
-RenderType" = "Transparent"
-Render Queue :transparent + 1 = 3001

MaidSurfaceShader_Hair

-RenderType" = "Transparent"
-Render Queue :transparent + 2 = 3002

MaidSurfaceShader_PettiCoat

-RenderType" = "Transparent"
-Render Queue :transparent + 3 = 3003	
	
<parameter>
-Shiness-
It adjust model's light intensity.

-LightDiffse-
It computes light attinuation by doing a dot between normal vector and light direction.

-ViewDiffse-
It computes light attinuation by doing a dot between normal vector and camera direction.

-EdgeSize-
It adjust the tickness of model's outline.

-EdgeColor-
It adjust the color of model's outline.
