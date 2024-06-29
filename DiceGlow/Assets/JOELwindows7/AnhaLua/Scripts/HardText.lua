--[[
    How tf I text?!

    Sauce:
    - https://documentation.abinteractive.net/cck/lua/recipes/getting-users/
    - https://documentation.abinteractive.net/cck/lua/api/globals/
    - https://github.com/NotAKidOnSteam/NAK_CVR_Prefabs/blob/c7d1ce6c5925f2375e7b37f29c4d86be521f8b57/LuaExamples/PlayerWall/PlayerWall.lua
    - https://github.com/NotAKidOnSteam/NAK_CVR_Prefabs/blob/main/LuaExamples/PlayerWall/PlayerWall.lua

    pls put NAK's Player list inside DNB's cashier booth!

    by JOELwindows7
    Perkedel Technologies
    Code: GNU GPL v3
    Assets: CC4.0-BY-SA
]]--
-- CVR = require("CVR")
-- CCK = require("CVR.CCK")
UnityEngine = require("UnityEngine")
TMP = require("TextMeshPro")
-- TM = UnityEngine.TextMesh

local aTextThing
local textCompo
local aTMPThing
local tmpCompo
local installSay = ''
local title = 'Halo Lua from JOELwindows7'
local sayWelcomeHome = ''
local areWeOnline = 'No'

-- Start is called before the first frame update
function Start()
    -- Codeium incoming!
    aTextThing = BoundObjects.haText
    aTMPThing = BoundObjects.hiText
    if aTextThing then
        textCompo = aTextThing.GetComponent("UnityEngine.TextMesh")
    end
    if aTMPThing then
        tmpCompo = aTMPThing.GetComponent("TMPro.TMP_Text")
    end

    if textCompo then
        textCompo.text = "hello world! askdjhflkjashdkljghajkrhgkjlhadsfjklhjkalsd"
    end

    if InstancesAPI.IsHomeInstance then
        sayWelcomeHome = "Welcome Home"
    else
        sayWelcomeHome = ""
    end

    if InstancesAPI.IsConnected then
        areWeOnline = "Yes"
    else
        areWeOnline = "No"
    end
end

-- Update is called once per frame
function Update()
    if InstancesAPI.IsConnected then
        areWeOnline = "yes"
    else
        areWeOnline = "no"
    end

    installSay = title .. "\n" .. "World: " .. InstancesAPI.InstanceName .. "\n" .. "\n" .. "Privacy: ".. InstancesAPI.InstancePrivacy .. "\n" .. "Players: " .. PlayerAPI.PlayerCount .. "\n" .. "Conntected: " .. areWeOnline .. " (" .. InstancesAPI.Ping .. " ms)\n" .. sayWelcomeHome .. "\n"

    if textCompo then
        textCompo.text = installSay
    end
    if tmpCompo then
        tmpCompo.text = installSay
    end
end