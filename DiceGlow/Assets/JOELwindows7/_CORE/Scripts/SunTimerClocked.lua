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
    - https://forum.rainmeter.net/viewtopic.php?t=27625
    - https://forum.rainmeter.net/viewtopic.php?t=23486
    - https://computercraft.info/wiki/Os.time

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
local totalSec = 0
local animCompo
local currentUTCTime = os.time(os.date("!*t"))

-- Start is called before the first frame update
function Start()
    -- anSelf = BoundObjects.self
    animCompo = gameObject.GetComponentInParent('UnityEngine.Animator') -- Shin's technique
    -- currentUTCTime = math.fmod(os.time(os.date("!*t")), 86400)
    currentUTCTime = os.time(os.date("!*t"))

    -- totalSec = currentUTCTime
    print('Total Sec ' .. tostring(totalSec) .. '\nOS time sec ' .. tostring(os.time(os.date("!*t"))))
end

-- Update is called once per frame
function Update()
    -- totalSec = Sys.DateTime.UtcNow.TotalSecond
    gameObject.transform.Rotate(UnityEngine.NewVector3(0.0,0.0,UnityEngine.Time.deltaTime * 0.01))

    totalSec = totalSec + UnityEngine.Time.deltaTime
    if totalSec > 81400 then
        totalSec = 0
    end
    if totalSec < 0 then
        totalSec = 0
    end

    if animCompo then
        -- animCompo.SetFloat('Seconding',totalSec)
    end
end