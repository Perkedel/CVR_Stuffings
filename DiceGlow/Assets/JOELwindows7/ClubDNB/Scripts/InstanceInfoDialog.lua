--[[
    Instance Info Dialog

    Dialog to display instance information

    Sauce:
    - https://documentation.abinteractive.net/cck/lua/recipes/getting-users/
    - https://documentation.abinteractive.net/cck/lua/api/globals/

    by JOELwindows7
    Perkedel Technologies
    Code: GNU GPL v3
    Assets: CC4.0-BY-SA
]]--
-- CVR = require "CVR"
CCK = require("CVR.CCK")
UnityEngine = require("UnityEngine")
TMP = require("TextMeshPro")
TM = UnityEngine.TextMesh

-- Variables
local playerCounts = PlayerAPI.PlayerCount
local worldName = InstancesAPI.InstanceName
local privacyType = ''
local dialogText = BoundObjects.DialogText
local dialogTextOld = BoundObjects.DialogTextOld
local dialogTextOldCompo
local assembleParagraph = ''
local welcomeHomeSay = ''
local areWeOnline = "no"
local lewdVerdict = "..."

-- Functions

-- Start is called before the first frame update
function Start()
    playerCounts = PlayerAPI.PlayerCount
    worldName = InstancesAPI.InstanceName
    privacyType = InstancesAPI.InstancePrivacy
    -- local textOld = dialogTextOld.GetComponent(TM)
    dialogTextOldCompo = dialogTextOld:GetComponent("UnityEngine.TextMesh")

    if InstancesAPI.IsHomeInstance then
        welcomeHomeSay = "Welcome Home"
    else
        welcomeHomeSay = ""
    end

    if InstancesAPI.IsConnected then
        areWeOnline = "yes"
    else
        areWeOnline = "no"
    end

    if InstancesAPI.InstancePrivacy == "Public" or InstancesAPI.InstancePrivacy == "FriendOfFriends" then
        lewdVerdict = 'Public instance, no NSFW allowed'
    elseif InstancesAPI.InstancePrivacy == "OwnerMustInvite" then
        lewdVerdict = 'Private instance, NSFW allowed'
    else
        lewdVerdict = '...'
    end
end

-- Update is called once per frame
function Update()
    playerCounts = PlayerAPI.PlayerCount
    if InstancesAPI.IsConnected then
        areWeOnline = "yes"
    else
        areWeOnline = "no"
    end

    -- Sorry, Codeium likes to help!
    -- assembleParagraph = worldName .. "\n" .. "Privacy" .. privacyType .. "\n" .. "Players: " .. playerCounts .. "\n" .. "Connected: " .. CVR.InstancesApi.IsConnected .. CVR.InstancesApi.Ping .. "\n"
    assembleParagraph = worldName .. "\n" .. "Privacy: " .. privacyType .. "\n" .. "Players: " .. playerCounts .. "\n" .. "Connected: " .. areWeOnline .. " (".. InstancesAPI.Ping .. " ms)\n" .. welcomeHomeSay .. "\n" .. lewdVerdict .. "\n"
    -- dialogTextOld.text = assembleParagraph
    dialogTextOldCompo.text = assembleParagraph
end