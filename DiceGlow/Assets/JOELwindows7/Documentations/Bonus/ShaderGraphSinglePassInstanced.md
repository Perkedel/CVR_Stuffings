# ShaderGraph Single Pass Instanced

![Overview image showing comparisons between treated & untreated shadergraphs](https://raw.githubusercontent.com/Perkedel/CVR_Stuffings/main/DiceGlow/Assets/JOELwindows7/_CORE/Sprites/Screenshots/overview_z3y_shadergraph.png)

It is possible to make your ShaderGraph automatically support & generate the SPS-I directive onto the shader code result, to ensure this shader renders for both eyes.

## Before you begin

- Ensure your VR debugger render mode is set to something like `Single Pass Instanced`  ![as shown](https://raw.githubusercontent.com/Perkedel/CVR_Stuffings/main/DiceGlow/Assets/JOELwindows7/_CORE/Sprites/Screenshots/make_sure_mockHMD_spsi.png)
- Know how to install Package out of GitHub / GitLab / GitIdk repo (basically repository that has `package.json` file in its root directory)
    - Open sub-window tab `Package Manager` (Top menu `Window`, `Package Manager`)
    - Click top left `➕🔻` icon
    - Choose `Add package from git URL`
    - insert your git URL (that ends with `.git`, add if haven't already ; or according to instruction down below) into the pop up.
    - `Add`  ![as shown](https://raw.githubusercontent.com/Perkedel/CVR_Stuffings/main/DiceGlow/Assets/JOELwindows7/_CORE/Sprites/Screenshots/add_git_url_package.png)![and the popup](https://raw.githubusercontent.com/Perkedel/CVR_Stuffings/main/DiceGlow/Assets/JOELwindows7/_CORE/Sprites/Screenshots/now_insert_git_url.png)

## 2021.3

For Unity 2021.3 series, you can use z3y's extension at https://github.com/z3y/ShaderGraph.

Install this package via Git URL: `https://github.com/z3y/ShaderGraph.git`.

Don't worry about the `2022`, it should work here.

Now, all you have to do, if you'd like to make new ShaderGraph, pick `Builtin (z3y)`. You can choose the same out of 3 types, such as `Lit Shader Graph`.  
![image shown](https://raw.githubusercontent.com/Perkedel/CVR_Stuffings/main/DiceGlow/Assets/JOELwindows7/_CORE/Sprites/Screenshots/right_click_create_z3y_shadergraph.png)  
For existing ShaderGraph:
- open up the graph file (your shader graph file in `.shadergraph` here in Unity). A new sub-window tab of the file will open.
- In `Graph Inspector`, open up tab `Graph Settings`. 
- Delete internal `Built-in` active target & replace with `Built-In (z3y)`.  ![image shown](https://raw.githubusercontent.com/Perkedel/CVR_Stuffings/main/DiceGlow/Assets/JOELwindows7/_CORE/Sprites/Screenshots/replace_with_z3y.png)

> **WARNING!**: Do not mix & match active target between z3y's & internal! You will corrupt the entire graph! If you already closed tab of this file with this condition & unable to open your `.shadergraph` anymmore, you must temporarily disable or uninstall the extension, re-open the `.shadergraph` file, & remove the unecessary active target (just the internal `Built-In`).

## 2019

> Thancc V-TOL for the way you did for your avatar iyey!

For Unity 2019 series, you can use following ShaderGraph packages which versions have been caught & locked by z3y, including the extension

Take a look at [this `2019` tree of the same repo](https://github.com/z3y/ShaderGraph/tree/2019)

Assuming your 2019 project haven't had ShaderGraph, Install the following in order:
- `https://github.com/z3y/ShaderGraph.git?path=/com.unity.render-pipelines.core#2019` The Rendering pipeline core
- `https://github.com/z3y/ShaderGraph.git?path=/com.unity.shadergraph#2019` The ShaderGraph itself
- `https://github.com/z3y/ShaderGraph.git?path=/com.z3y.shadergraphex#2019` The Extension

> PLS CONTINUE & CONFIRM BELOW

You can now create ShaderGraph using z3y's modified built-in target (`Builtin (z3y)` options which are set to `Built-In (z3y)` active target)

## Different color per eye??

You can set which color to render for each different eyes, following [this Unity's documentation about Stereo rendering](https://docs.unity3d.com/2021.3/Documentation/Manual/SinglePassInstancing.html), at the last section of the ShaderGraph debuggin.

Basically: 
- you need to have a `Custom Node` (right click on field, `Add Node`, search `Custom` & pick `Custom Node`).
- Ensuring that `Custom Node` still selected, in its `Graph Inspector`, scroll down & change the type to `String`.
- `Name` the function properly & insert the content field beneath with `Out = lerp(LeftColor, RightColor, unity_StereoEyeIndex);`. This will lerp the color from one to another between 2 different eyes per `unity_StereoEyeIndex` indexing.
- Add Input of Vector4 `LeftColor` & `RightColor`. as in the function content
- Add Output of Vector `Out`. as in the function content
- **`Save Asset`**
- Right click this `.shadergraph`, `Create`, `Material` to create new material using this new `.shadergraph` shader.
- You can now drag & drop this `.material` onto any mesh you'd like. You can even adjust each of the 2 colors to your desire on this `.material`.
- Test now by pressing top `Play`. If you upload this object to CVR, your object should looks like this, where each of your eyes render different color.