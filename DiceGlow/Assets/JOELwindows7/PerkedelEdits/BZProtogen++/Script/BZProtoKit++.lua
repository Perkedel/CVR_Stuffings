--[[
    BZProtoKit++

    That Protogen from Triwave BZ iyey! JOELwindows7 edit

    base from TriwaveBZ
    edit by JOELwindows7  
    Perkedel Technologies
    Code: GNU GPL v3
    Assets: CC4.0-BY-SA
]]--
print('HALO PROTOGEN')

System = require('System')
UnityEngine = require('UnityEngine')
AI = require('UnityEngine.AI')
UI = require('UnityEngine.UI')
CVR = require('CVR')
Network = require('CVR.Network')
CCK = require('ABI.CCK')
TMP = require('TextMeshPro')
-- RCC = require('RCC')

-- Constants
local slowUpdatesInterval = 5

-- Variables
local slowUpdateTimer = 5
local slowLateUpdateTimer = 5
local slowFixedUpdateTimer = 5

-- Functions

function DetectFriends()
    -- NAK's Detect Friend
    -- https://discord.com/channels/410126604237406209/1240763673346183279/1254075162974883987
    local isFriend = PlayerAPI:IsFriendsWith(Avatar.Wearer.UserID) or IsWornByMe
    Avatar:SetParameter("#isFriend", isFriend)
    return isFriend
end

function _ManageSlowUpdate()
    slowUpdateTimer = slowUpdateTimer - UnityEngine.Time.deltaTime
    if slowUpdateTimer <= 0 then
        SlowUpdate()
        slowUpdateTimer = slowUpdatesInterval
    end
end

function _ManageSlowLateUpdate()
    slowLateUpdateTimer = slowLateUpdateTimer - UnityEngine.Time.deltaTime
    if slowLateUpdateTimer <= 0 then
        SlowLateUpdate()
        slowLateUpdateTimer = slowUpdatesInterval
    end
end

function _ManageSlowFixedUpdate()
    slowFixedUpdateTimer = slowFixedUpdateTimer - UnityEngine.Time.fixedDeltaTime
    if slowFixedUpdateTimer <= 0 then
        SlowFixedUpdate()
        slowFixedUpdateTimer = slowUpdatesInterval
    end
end

-- Start is called before the first frame update
function Start()
    
end

-- Update is called once per frame
function Update()
    _ManageSlowUpdate()
end

function LateUpdate()
    _ManageSlowLateUpdate()
end

function FixedUpdate()
    _ManageSlowFixedUpdate()
end

function SlowUpdate()

end

function SlowLateUpdate()
    DetectFriends()
end

function SlowFixedUpdate()

end