# Spawn Mover  

This requires the CCK 3.4
  
This prefab is a basic but scalable spawn point changer that works for the player who triggered it (rather than setting spawn for everyone in the instance)  
  
No 'User' interaction is needed on the part of the player, they just have to step into the designated collision area and their spawn point will be moved  
  
If you need more than 2 spawn targets you will need to add extra animations to move/rotate the spawn target object and then link those to the animator and key them to a number for the variable `spawnpos`  

Note the `Spawn-Points` section of the hierarchy is purely cosmetic and is just to help visualise where the spawn point should be (its also useful for extracting position data for the animations)

The Sphere under the `spawn-point` object is optional and is included purely for visualisation of spawn movement/debugging  

Note, to use this system you need to ensure that you set the `spawn-point` object as the only spawn of your world under the `CVR World (script)` component  
