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
-- TM = require("UnityEngine.UI.Text")

-- Variables
local playerCounts = PlayerAPI.PlayerCount
local worldName = InstancesAPI.InstanceName
local privacyType = ''
local dialogText = BoundObjects.DialogText
local dialogTextOld = BoundObjects.DialogTextOld
local dialogTextOldCompo
local dialogTextCompo
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
    if dialogTextOld then
        -- local textOld = dialogTextOld.GetComponent(TM)
        dialogTextOldCompo = dialogTextOld:GetComponent("UnityEngine.TextMesh")
    end
    if dialogText then
        dialogTextCompo = dialogText:GetComponent("TMPro.TMP_Text")
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

    if InstancesAPI.IsHomeInstance then
        welcomeHomeSay = "Welcome Home"
    else
        welcomeHomeSay = ""
    end

    -- Sorry, Codeium likes to help!
    -- assembleParagraph = worldName .. "\n" .. "Privacy" .. privacyType .. "\n" .. "Players: " .. playerCounts .. "\n" .. "Connected: " .. CVR.InstancesApi.IsConnected .. CVR.InstancesApi.Ping .. "\n"
    assembleParagraph = "<b>Welcome to:</b>\n" .. worldName .. "\n" .. "Privacy: " .. privacyType .. "\n" .. "Players: " .. playerCounts .. "\n" .. "Connected: " .. areWeOnline .. " (".. InstancesAPI.Ping .. " ms)\n" .. welcomeHomeSay .. "\n" .. lewdVerdict .. "\n"
    -- dialogTextOld.text = assembleParagraph
    if dialogTextOldCompo then
        dialogTextOldCompo.text = assembleParagraph
    end
    if dialogTextCompo then
        dialogTextCompo.text = assembleParagraph
    end
end