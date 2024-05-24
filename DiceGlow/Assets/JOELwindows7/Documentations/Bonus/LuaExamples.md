# Lua Assorted Examples

Here are some cool example snippets of Lua Script for your reference scripting in ChilloutVR

## Play an audio file simple

Sauce: [JOELwindows7](https://discord.com/channels/410126604237406209/1240763673346183279/1243523877536141312)

```lua
local ac
local acCompo
local sound

function Start()
  -- obtain AudioSource object
  ac = BoundObjects.Speaker
  -- then its component
  if ac then
    acCompo = ac.GetComponent('UnityEngine.AudioSource')
  else
    print('you forgor dragging the AudioSource to this Speaker bound')
  end
  -- don't forget the audio clip file
  sound = BoundObjects.SoundFile
end

function OnMouseDown()
  -- Let's say, you want to play the audio when you click on this prop / world object
  -- This built-in callback works by having a collider, on root itself.
  if acCompo then
    -- argument: the variable inserted with the file which is `sound`, the volume float from 0.0 to 1.0
    acCompo.PlayOneShot(sound,1)
  else
    print('acCompo is nil')
  end
end
```

[Full test script](https://github.com/Perkedel/CVR_Stuffings/blob/main/DiceGlow/Assets/JOELwindows7/AnhaLua/Scripts/AnhaTest.lua)

## Acquire Properties of an object
e.g., getting **UI Slider value**. Simply read the `value` of this `UnityEngine.UI.Slider` component of that Canvas GameObject

Sauce: [Lolatron & Kafeijao](https://discord.com/channels/410126604237406209/1240763673346183279/1242874106798538792)

```lua
UnityEngine = require "UnityEngine"
UnityEngineUI = require "UnityEngine.UI"
-- Start is called before the first frame update
function Start()
    --Slider from the bound objects
    local sliderGameObject = BoundObjects.Slider
    --Get the slider component from the bound object
    Slider = sliderGameObject.GetComponent("UnityEngine.UI.Slider")
    --Print it as a test
    print(tostring(Slider.value))
    --Setup for not spamming the slider value 
    SliderPrev = 0

end

-- Update is called once per frame
function Update()
    --Slider value is put into varible SliderValue as to not call .value again
    SliderValue = Slider.value
    --check if the slider value changed
    if SliderValue ~= SliderPrev then
    --test print
    print("Slider 1 = " .. tostring(SliderValue))
    --Makes it so when the loop comes back arround if nothing happenes it doesnt print again.
    SliderPrev = SliderValue
    end
```

## Change Text (Legacy UI Text)

Sauce: [JOELwindows7](https://discord.com/channels/410126604237406209/1240763673346183279/1242857103270482014), [EmmyHeart](https://discord.com/channels/410126604237406209/1240763673346183279/1241009800045789224)

(JOELwindows7)
```lua
local textUI
local textUIComponent

function start()
  -- Obtain from a bound object
  textUI = BoundObjects.TextUIObject
  -- Obtain its component
  if not textUI then
    print('You forgot to bind TextUI into the BoundObjects!')
  else
    textUIComponent = textUI.GetComponent('UnityEngine.UI.Text')
  end
  
  -- Start interacting
  if textUIComponent then
    textUIComponent.text = 'Hello world iyeay bwah!'
  else
    print('The Text component is missing!')
  end
end
```

(EmmyHeart (**Corrected**))  
Please drag & drop the Legacy UI Text itself to the bound again. Our testing works by **drag & droping the object itself** onto the `TextTest` titled bound, **not** the component.  
You can even drag itself as the bound, if itself has that `UnityEngine.UI.Text` (*Text* in inspector) component next to this our `CVRLuaClientBehaviour`
```lua
-- Start is called before the first frame update
local textObj
local textObjCompo -- JOELwindows7: new!
local i = 2

UnityEngineUI = require("UnityEngine.UI")
function Start()
    textObj = BoundObjects.TextTest

    -- JOELwindows7: also, since now we're drag & dropping the object itself,
    if textObj then
        textObjCompo = textObj.GetComponent('UnityEngine.UI.Text') -- And now get the component.
    else
        print('You forgot to drag & drop the target Legacy Text UI')
    end
end

-- Update is called once per frame
function Update()
    i = i * 2
    -- textObj.text = i -- STRIKE
    -- JOELwindows7: Ensure to have safety before accessing!
    if textObjCompo then
        textObjCompo.text = i -- NEW!
    else
        -- the component failed to acquire!
    end
end
```

[Full test script](https://github.com/Perkedel/CVR_Stuffings/blob/main/DiceGlow/Assets/JOELwindows7/AnhaLua/Scripts/AnhaTest.lua)

## Change Text (TextMesh)

Sauce: [NotAKidOnSteam's PlayerWall edit TextMesh](https://github.com/NotAKidOnSteam/NAK_CVR_Prefabs/blob/c7d1ce6c5925f2375e7b37f29c4d86be521f8b57/LuaExamples/PlayerWall/PlayerWall.lua#L103). [JOELwindows7's Instance Info](https://github.com/Perkedel/CVR_Stuffings/blob/main/DiceGlow/Assets/JOELwindows7/AnhaLua/Scripts/HardText.lua)

It is same as above with legacy text UI, only this time, the component class you'll drag & drop to is is `UnityEngine.TextMesh`. Let's title this bound `TextMeshObject`.
```lua
local textMesh
local textMeshComponent

function start()
  -- Obtain from a bound object
  textMesh = BoundObjects.TextMeshObject
  -- Obtain its component
  if not textMesh then
    print('You forgot to bind legacy TextMesh into the BoundObjects!')
  else
    textMeshComponent = textMesh.GetComponent('UnityEngine.TextMesh')
  end
  
  -- Start interacting
  if textMeshComponent then
    textMeshComponent.text = 'Hello world iyeay bwah!'
  else
    print('The Text component is missing!')
  end
end
```

> Note, currently as of 2024r176ex1, the `UnityEngine.TextMesh` component is **NOT whitelisted** for props, only for world object. Therefore you will get error if you attempted to access your legacy TextMesh, in the prop, since it is automatically removed upon spawning. 

## Change Text (TextMeshPro)

> WERROR BROKEN! PLS FIX

Sauce: [Forum thread started by Ch33ri0s](https://forum.unity.com/threads/access-textmeshpro-text-through-script.527992/), [Unity's TMPro Package docs](https://docs.unity3d.com/Packages/com.unity.textmeshpro@1.3/api/TMPro.TextMeshPro.html), [Forum thread started by Guich](https://forum.unity.com/threads/from-unity-ui-to-textmeshpro.463619/)

```lua
local textMeshPro
local textMeshProComponent

function start()
  -- Obtain from a bound object
  textMeshPro = BoundObjects.TextMeshProObject
  -- Obtain its component
  if not textMeshPro then
    print('You forgot to bind TextMeshPro into the BoundObjects!')
  else
    textMeshProComponent = textMeshPro.GetComponent('TMPro.TMP_Text')
  end
  
  -- Start interacting
  if textMeshProComponent then
    textMeshProComponent.text = 'Hello world iyeay bwah!'
  else
    print('The Text component is missing!')
  end
end
```

> Tips: According to Stephan_B, the `TMPro.TMP_Text` is the base for 3D Object version (`TMPro.TextMeshPro`) & the Unity GUI version (`TMPro.TextMeshProUGUI`). Therefore you can simply ask just their abstract / interface `TMP_Text` to conveniently acquire the TextMeshPro component for both types.

## Instantiate Prefab
Drag & Drop your prefab file into the BoundObjects list. Let's title this `ItemPlacementPrefab`.

Sauce: [NotAKidOnSteam, SketchFoxsky](https://discord.com/channels/410126604237406209/1240763673346183279/1242250968813535247), [Simple ]

```lua
UnityEngine = require("UnityEngine")

local myNewObject = UnityEngine.GameObject.Instantiate(BoundObjects.ItemPlacementPrefab)
```

([SketchFoxsky](https://discord.com/channels/410126604237406209/1240763673346183279/1242242417399431238))
```lua
-- Define the Inventory Prefab
local ItemPlacementPrefab = UnityEngine.GameObject.Instantiate(prefab)

-- Get the LocalPlayer's AvatarID 
-- this will need a function to check if the player changed avatars to redo the check.
LocalAvatarID = PlayerAPI.LocalPlayer.Avatar.AvatarID

-- Get the _PlayerLocal gameobject
PlayerObject = GameObject.FindGameObjectWithTag("Player")
```

([NotAKidOnSteam PlayerWall snippet](https://discord.com/channels/410126604237406209/1240763673346183279/1242250968813535247))
```lua
UnityEngine = require("UnityEngine")

local myNewObject = UnityEngine.GameObject.Instantiate(BoundObjects.ItemPlacementPrefab)
```
[Full Script](https://github.com/NotAKidOnSteam/NAK_CVR_Prefabs/blob/c7d1ce6c5925f2375e7b37f29c4d86be521f8b57/LuaExamples/PlayerWall/PlayerWall.lua#L34)

> Note, [you cannot instantiate from a prop](https://discord.com/channels/410126604237406209/1240763673346183279/1242245348320215080).

## CoolObject

Sauce: [SDraw](https://discord.com/channels/410126604237406209/1240763673346183279/1242106194525425805)

```lua
function thatStupidFunction(...)
    print(...)
    return "fish"
end

CoolObject_mt = {}
CoolObject_mt.__call = function(t,...)
    return thatStupidFunction(...)
end
CoolObject_mt.__index = function(t,k) end
CoolObject_mt.__newindex = function(t,k,v) end
CoolObject_mt.__metatable = false
CoolObject = setmetatable({},CoolObject_mt)
CoolObject_mt = nil

print("You got:",CoolObject(5,6,7))
```

## Whitelist system
Give special action if the player that runs the script is included in the *whitelist*.

Sauce: [Shin](https://discord.com/channels/410126604237406209/1240763673346183279/1241155392944341063)

```lua
-- Local Whitelisted UserIDs
local WL = {
    "aeae3ecf-9826-4e03-830f-96e8240c19e3", --Shin
    "32bc279d-15f1-155e-5fa0-cbe1cd686500", -- Okami
    }
    Whitelisted = false

function Start()
    for _, _wl in ipairs(WL) do
        if(_wl == PlayerAPI.LocalPlayer.UserID) then
            Whitelisted = true
            break
        end
    end
        if(Whitelisted == true) then
                print("You are whitelisted.")
                end
            end
```

> simple whitelist if you wanna use it for any world/prop/avatar
> just add the things u need after `if(Whitelisted == true) then`

> Pro-tips: To avoid controvercy, it is best to follow the [`Word on security`](https://documentation.abinteractive.net/cck/lua/security/) advise, in which to encrypt the `UserID`s & insert them as encrypted. Then query by comparing its hashing. Additionally, it is recommended to also obfuscate the variable names.

## MOAR!!!

More Lua Examples
- [NotAKidOnSteam's](https://github.com/NotAKidOnSteam/NAK_CVR_Prefabs/tree/main/LuaExamples)
- [Shin's](https://github.com/DjShinter/CVRLuaScripts)