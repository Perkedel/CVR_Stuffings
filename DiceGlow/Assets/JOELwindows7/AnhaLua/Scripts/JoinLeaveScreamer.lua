
--[[
    Scream everytime a player join & leave

    Sauce:
    - https://documentation.abinteractive.net/cck/lua/recipes/getting-users/
    - https://documentation.abinteractive.net/cck/lua/api/globals/
    - https://github.com/NotAKidOnSteam/NAK_CVR_Prefabs/blob/c7d1ce6c5925f2375e7b37f29c4d86be521f8b57/LuaExamples/PlayerWall/PlayerWall.lua
    - https://github.com/NotAKidOnSteam/NAK_CVR_Prefabs/blob/main/LuaExamples/PlayerWall/PlayerWall.lua

    by JOELwindows7
    Perkedel Technologies
    Code: GNU GPL v3
    Assets: CC4.0-BY-SA
]]--
-- CVR = require("CVR")
-- CCK = require("CVR.CCK")
UnityEngine = require("UnityEngine")
-- TMP = require("TextMeshPro")
-- TM = UnityEngine.TextMesh

local joinSp = BoundObjects.JoinSpeaker
local leaveSp = BoundObjects.LeaveSpeaker
local joinCompo
local leaveCompo
local currentPlayerCount = 0
local nowPlayerCount = 0

function CheckPlayers()
    nowPlayerCount = PlayerAPI.PlayerCount

    if nowPlayerCount < currentPlayerCount then
        -- player leave
        if joinCompo then
            joinCompo:Play()
        end
    elseif nowPlayerCount > currentPlayerCount then
        -- player join
        if leaveCompo then
            leaveCompo:Play()
        end
    end

    currentPlayerCount = nowPlayerCount
end

-- Start is called before the first frame update
function Start()
    joinCompo = joinSp.GetComponent("UnityEngine.AudioSource")
    leaveCompo = leaveSp.GetComponent("UnityEngine.AudioSource")
end

-- Update is called once per frame
function Update()
    CheckPlayers()
end