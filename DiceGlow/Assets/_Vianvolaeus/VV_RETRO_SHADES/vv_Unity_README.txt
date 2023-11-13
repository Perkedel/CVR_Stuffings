hi !

If you're looking to just grab a pair of shades, you can go to the `_Shades_prefabs` folder and pick what one you want, drag it into your scene with your avatar, and onto the head bone in your Armature. 

There is a chance that the way the alpha transparency is set up will ignore grabpass transparency or other alpha settings if viewed through the lenses of the glasses. 
I've tested / fixed this best I can, but there may be some visual errors / unintended behaviour (cancelling out other alpha effects, causing 'xray' through meshes...) 

Feel free to change the material's transparency settings, or set it to Opaque if you want to be certain it will not affect anything and just be solid. (These are just meant to be costume props) 


By default the textures are set at 1024 x 512, and compressed. You can adjust these for higher resolution (up to 4096 x 2048), but it is likely overkill in most cases. 



V