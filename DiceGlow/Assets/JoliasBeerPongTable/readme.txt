NOTICE: The Table needs it own layer named BeerPongTable for it to work, see images on github/ gumroad.

NOTICE: The Table needs it own layer named BeerPongTable for it to work, see images below for more info.

A WIP beer pong table for ChilloutVR, just import it into your project, make sure you have TextMeshPro as well.

You can also get this off Gumroad: https://joliavr.gumroad.com/l/joliacvrbeerpongtable
Find more assets on my website: https://jolia.xyz
Join my discord server: https://discord.gg/T8zYhgvcpF
Requirements:

Unity 2019.4.31f1
ChilloutVR CCK 3.3
Basic Unity and CVR knowledge.
TextMeshPro - You can get this via Unity's package manager, it is free. We use a font from there.
It's own layer called BeerPongTable (see images below).

Version 0.1 Features:

4 Row of cups and 5 row of cups choice of game.
Ball reset button for each side.
Decent physics, should work fine.

Version 0.2 Features (Current recomended):

4, 5, 6 and 7 Row of cups.
Better UI.
Ball reset button for each side.
Better physics to 0.1.
Optional floor collider so when the ball hits the floor it will reset, note there is no way yet to detect which players turn it is so it will just reset to the left hand side. You can also make you own collider and set it to the BeerPongTable layer instead.
That's about it for now.

Things I am working on, (note some features may not be released for a while unto CVR makes it easier to make these things).

Score board system.


Changelog: 0.2.1:
Fixed issue where ball went through cups.
All things are now networked buffered so late joiners can see latest version of the table if someone is playing.
Added optional floor collider which was missing from last version.
Add my credits to UI.
Made ball holder bigger in attempt to make the ball from falling out.


Known issues:
If the ball is traveling it will still jump out of cup holder on teleportation, I working on a way to freaze the ball in place when teleporting so this doesn't happen.


Changelog 0.2:

Added:
Two new rows, now there is 4, 5, 6 and 7 rows.

Changes: 
Remade the UI to look better.
Improved the look of the table further.
Made cups static, there don't move so there don't need to be not non-static.
Made beer pong table static, it doesn't move so it doesn't need to be non-static. 
Cups and ball Start off by default unto you press start, this is too have less things on screens in worlds.
Reset Button now resets table to default state.
Renamed all cups into a number order to avoid as possibility of a network conflict, this wasn't painful to do at all, I could of made a script to do it but I choose the pain route, oh btw there is 158 cups all togeather.


