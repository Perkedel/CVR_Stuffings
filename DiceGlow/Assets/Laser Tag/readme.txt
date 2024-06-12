-- ChilloutVR Laser Tag Props --
by Beckadam

Package contains two upload-ready laser tag props for ChilloutVR.

"Laser Vest" -- a wearable prop that must be worn by each player for the game to work.
"Laser Gun" -- a holdable prop that is used to shoot other players wearing a vest.

Vest setup:
-	On the CVRSpawnableTrigger component of the RespawnColliderBody GameObject, (see fig.1)
	set the desired pointer types that you want the vest to be damaged by. (see fig.2)

-	If you would like to require multiple hits for the vest to respawn,
	within the VestController animator controller, (see fig.3)
	in the Base Layer,
	on the indicated animator transition, (see fig.4)
	set the transition condition to the desired number of hits to respawn the player, minus 1. (see fig.5)
	Example:
		1 hit kill: 0
		2 hit kill: 1
		5 hit kill: 4


Gun setup:
-	On the CVRPointer component of the Bullet Emitter GameObject, (see fig.6)
	set the pointer type that this gun fires. (see fig.7)

-	On the CVRPointer component of the Pointer GameObject, (see fig.8)
	set the pointer type that this gun will melee with. Remove the Melee GameObject if you do not want melee.

-	If you would like to modify the fire rate,
	within the LaserGunController animator controller,
	on the Base Layer,
	on the indicated animator transition, (see fig.9)
	set the Transition Duration to the desired delay between shots. (see fig.10)

