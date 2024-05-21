--[[
    Sun! get UTC time! and up to this offset sets timezone. Now rotate Z!

    Sauce:
    - https://documentation.abinteractive.net/cck/lua/recipes/getting-users/
    - https://documentation.abinteractive.net/cck/lua/api/globals/
    - https://github.com/NotAKidOnSteam/NAK_CVR_Prefabs/blob/c7d1ce6c5925f2375e7b37f29c4d86be521f8b57/LuaExamples/PlayerWall/PlayerWall.lua
    - https://github.com/NotAKidOnSteam/NAK_CVR_Prefabs/blob/main/LuaExamples/PlayerWall/PlayerWall.lua
    - https://forum.unity.com/threads/system-timezone-depreciated.770618/
    - https://learn.microsoft.com/en-us/dotnet/api/system.datetime.utcnow?view=netframework-4.8
    - https://learn.microsoft.com/en-us/dotnet/api/system.datetimeoffset.utcnow?view=netframework-4.8#system-datetimeoffset-utcnow

    by JOELwindows7
    Perkedel Technologies
    Code: GNU GPL v3
    Assets: CC4.0-BY-SA
]]--
-- CVR = require "CVR"
-- CCK = require("CVR.CCK")
UnityEngine = require("UnityEngine")
-- TMP = require("TextMeshPro")
-- TM = UnityEngine.TextMesh
-- Sys = require('System')

local anSelf
local totalSec

-- Start is called before the first frame update
function Start()
    -- anSelf = BoundObjects.self
end

-- Update is called once per frame
function Update()
    -- totalSec = Sys.DateTime.UtcNow.TotalSecond
end