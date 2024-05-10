# KeepSceneFocus
Ever get annoyed that you have to click Scene view every time you press play?  
Me too!  
  
### GENERAL INFO
This script sends you back to the Scene view window whenever you press the play button, therefore preventing Unity from forcing you onto the Game window instead.  
It also has a feature that lets the VRC SDK and the CVR CCK bypass the script whenever the "Build & Publish for Windows" button is pressed (default ON).  
If you want to let unity do it's thing, you can always hold Shift and press Play to bypass this script.
  
-------------------------------------------
### INSTALLATION:
1) Download the Unitypackage or the "KeepSceneFocus.cs" file.
2) Put it anywhere in your Assets folder.
3) Find and Open KSF from the Menu bar at the top left of Unity (next to "File" "Edit" etc).
4) Press the big "Create GameObject/Reload" button.
5) Enjoy :)  
  
Image of the window:  
![Capture](https://github.com/SurprisinglySuspicious/KeepSceneFocus/assets/100347264/575a23d8-8d7e-4793-bb16-042f6af1c355)
  
### HOW TO USE:
Once you follow the steps above, you're all set and you can close the KSF window.  
Simply press Play and the script will automatically send you back to the scene window when it's ready.  
Like said above, you can always Shift+Play to bypass the script and let Unity force you onto the Game window.

For quick access to the settings or if you don't like to use the window, the script settings are also located in the GameObject named "Keep Scene Focus" at the top of your hierarchy after it's been created.

You can move the Gameobject anywhere and into any scene as long as the scene stays loaded.  
Please avoid renaming the GameObject as it confuses the KSF window (but will still function).

The VRC SDK Bypass and CVR CCK Bypass are ON by default Because after pressing "Build & Publish for Windows" on the SDK, you will need to access the game window to upload the avatar.  
If for example you plan to only upload to VRC, you can disable CVR bypass and vice versa. Or you can leave them both on as is by default.

-------------------------------------------
  
This is the fist script I've made for Unity 2019.4.31f1, so don't judge me.  
  
Licence is MIT so do whatever you want. If you want to credit or not, it's your choice, I don't mind.  
