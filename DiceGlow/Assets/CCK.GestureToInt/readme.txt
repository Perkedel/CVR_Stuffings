--=CCK.GestureToInt=--

This package allows for easy GestureLR Float to Int conversion.

--=Details:
0 synced bit usage.
One animator layer.
Uses CVRAnimatorDriver.


--=Setup:

1. Copy your selected layer into your avatars override controller. (find in layers folder)

2. Add the GestureToInt prefab to the root of your avatar.

3. Use #GestureLeftInt and #GestureRightInt where needed.


--=Notes:

"#FloatToInt" parameter must be set to 0.51, otherwise the Direct Blendtree will die.
This was tested with a WD Off setup, so it is unknown if it works with WD On.


--=Layers:
There are two different layers included. 

CVRGestureToInt:
Direct cast from Float to Int following ChilloutVR's GestureLR scheme.
-1f = -1
0f = 0
1f = 1
2f = 2
3f = 3
ect...

VRCGestureToInt:
This casts from ChilloutVR's Gesture Float scheme to VRChat's GestureLR Int scheme.
-1f = 0
0f = 0
1f = 1
2f = 7
3f = 6
ect...


--=Reference:

Gesture Conversion 
VRC     CVR

Idle	        
0	0
Fist	        
1	1
Open Hand	    
2	-1
Point	        
3	4
Peace	        
4	5
Rock'n'Roll      
5	6
Gun                    
6	3
Thumbs Up       
7	2