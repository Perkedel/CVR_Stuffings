--[[
    Yes or no game. TebakDNB

    Fun party guessing game

    Sauce:
    - https://discord.com/channels/410126604237406209/1240763673346183279/1245066584066752625 thancc Shin for get spawnable value instead

    Inspiration Sauce:
    - LensError (OK). Yes or No Game, found in Purple Fox Social Spot.

    Sync Value Index:
    0. Select Quote
    1. Is delaying

    by JOELwindows7
    Perkedel Technologies
    Code: GNU GPL v3
    Assets: CC4.0-BY-SA
]]--
print('HALO TEBAK-TEBAKAN')
if IsValid() then
    print("VALID WRAPPER")
else
    print('WERROR! WRAPPER IS NOT VALID')
end
local UnityEngine = require("UnityEngine")
local CCK = require("ABI.CCK")
local CVRSpawnwable = require("ABI.CCK.Components.CVRSpawnable")
local UI = require("UnityEngine.UI") -- you must have this?
-- local TMP_Text = require("TMPro.TMP_Text")
-- local TMPro = require("TMPro")
local TMP = require("TextMeshPro")

local ownSelf --= BoundObjects.OwnSelf
local animCompo
local spawnableCompo
local fakeButton --= BoundObjects.GenerateFakeButton
local textNew = {nil}--= {BoundObjects.Titler} ---@class Array<Unity.GameObject>
local textNewCompo = {nil} -- ---@class Array<TMPro.TMP_Text>
local yesNoList = {
    'Had ever ticketed by police',
    'Had ever Drunk & floor foxed',
    'Had ever went to Disneyland',
    'Had ever went to any expo convention',
    'Had ever went to any furry convention',
    'Had ever went to any anime convention',
    'Had ever went to any tech convention',
    -- Lex, these are your ideas! okay thancc.
    'Had ever <i>Emergency Digestive Reverse Egress Protocol</i> while any VR',
    'Had ever <i>Emergency Digestive Reverse Egress Protocol</i> while any Chatting in VR',
    'Had ever <i>Emergency Digestive Reverse Egress Protocol</i> while any Job in VR',
    -- OK
    'Had ever tried any <b>Linux Distro</b>',
    'Had ever tried <b>Linux Distro: NixOS</b>',
    'Had ever tried <b>Linux Distro: SteamOS (Steam Deck)</b>',
    'Had ever tried <b>Linux Distro: Arch Linux</b>',
    'Had ever tried <b>Linux Distro: any Ubuntu</b>',
    'Had ever tried <b>Linux Distro: any Debian</b>',
    'Had atleast 1 pet',
    'Had atleast 1 car',
    'Had atleast 1 game console',
    'Had atleast 1 built PC (own buy parts-built or commisssioned / pre-built 1st or 3rd party)',
    'Had atleast 1 server rack (rent (Linode, Hetzner, etc., not including game machine such as Game Pass nor Geforce now) or personal)',
    'Had atleast 1 subcriptions (Netflix, Amazon Prime, Disney+, Apple tv+, Xbox Game Pass, Geforce Now, PlayStation Plus, Humble Bundle, etc.)',
    'Had atleast 1 smartphone',
    'Had atleast 1 smartwatch',
    'Had atleast 1 VR kit',
    'Had atleast 1 Laptop',
    'Had atleast 1 Tablet PC',
    'Had atleast 1 any computer based (PC, Tablet, Smartphone, IoT, Networking, etc.)',
    'Had atleast 1 any weapon',
    'Had atleast 1 any musical instrument',
    'Had atleast 1 any sport system (Fussball, Soccer, Rugby, Billiard, Basketball, Tennis, Badminton, etc.)',
    'Had atleast 1 any job',
    'Had atleast 1 tech job',
    'Had atleast 1 game development job',
    'Had atleast 1 descendant (child)',
    'Had spouse', -- This is quite sensitive offensive, pls discuss as necessary. So far, we only support max 1 spouse, complying with God's standard.
}
local initText = 'Click Generate to select quote.\nPress Play to start the game, & continue phase.'
local prefixText = 'Yes or no. This person...\n'
local postfixText = ''
local selectNhie = 'halo'
local selectNum = 0
local delaysButtonIn = 5
local delayRemains = 5
local isDelaying = false
local luaDisabledWarn = BoundObjects.LuaDisabledWarning
local refreshRate = .1
local refreshRemains = .1

function NumBool(num)
    return num > .5
end

function Regenerate()
    selectNum = math.random(#yesNoList)
    if animCompo then
        animCompo.SetInteger('SelectQuote',selectNum)
    end
    -- unworking!!!?????!!!!????!!!!????
    -- if spawnableCompo then
    --     -- spawnableCompo.SetValue('SelectQuote',selectNum)
    --     -- spawnableCompo:SetValue(0,selectNum)
    --     spawnableCompo.SetValue(0,selectNum)
    -- end
    selectNhie = yesNoList[selectNum]
    -- if textOutCompo then
    --     textOutCompo.text = selectNhie
    -- end
    
    -- if animCompo then
    --     animCompo.SetBool('IsDelaying',true)
    -- end
    -- if spawnableCompo then
    --     -- spawnableCompo.SetValue('IsDelaying',1)
    --     -- spawnableCompo:SetValue(1,1.0)
    --     spawnableCompo.SetValue(1,1.0)
    -- end
    -- isDelaying = true
    RefreshDisplay()
end

function PressGenerate()
    print('Press Generate')
    Regenerate()
end

function OnMouseDown()
    -- if not isDelaying then
    --     Regenerate()
    -- end
end

function RefreshDisplay()
    if animCompo then
        isDelaying = animCompo.GetBool('IsDelaying')
        selectNum = animCompo.GetInteger('SelectQuote')
        if selectNum > 0 then
            selectNhie = yesNoList[selectNum]
        else
            selectNhie = initText
        end
    end
    
    for i=1,#textNewCompo do
        if textNewCompo[i] then
            if selectNum > 0 then
                textNewCompo[i].text = prefixText .. selectNhie
            else
                textNewCompo.text = initText
            end
        end
    end
end

-- Start is called before the first frame update
function Start()
    -- helped by Codeium lol

    ownSelf = BoundObjects.OwnSelf
    fakeButton = BoundObjects.GenerateFakeButton
    luaDisabledWarn = BoundObjects.LuaDisabledWarning
    textNew = {
        BoundObjects.Text1,
        BoundObjects.Text2,
        BoundObjects.Text3,
    }
    -- firstly, init random seed! Documentation Funny Cube example!
    math.randomseed(UnityEngine.Time.time)

    if ownSelf then
        print('obtain self')
        animCompo = ownSelf:GetComponent("UnityEngine.Animator")
        -- textOut = ownSelf.transform.GetChild(0).GetChild(0).GetChild(0).gameObject
        -- spawnableCompo = ownSelf.GetComponent("ABI.CCK.Components.CVRSpawnable")
        -- or from Shin's:
        -- @type UnityEngine.Animator
        -- animCompo = gameObject.GetComponentInParent("UnityEngine.Animator")
        
        print(tostring(spawnableCompo))
    else
        print('forgor assign this self')
    end
    spawnableCompo = gameObject:GetComponentInParent("ABI.CCK.Components.CVRSpawnable")

    for i = 1, #textNew do
        if textNew[i] then
            print('Get New Text No. ' .. tostring(i) .. ': ' .. tostring(textNew[i]))
            textNewCompo[i] = textNew[i]:GetComponent("TMPro.TMP_Text")
        end
    end


    -- Regenerate()

    if luaDisabledWarn then
        luaDisabledWarn.SetActive(false)
    end

    for i=1,#textNewCompo do
        if textNewCompo[i] then
            textNewCompo[i].text = initText 
        end
    end
end

-- Update is called once per frame
function Update()
    if isDelaying then
        delayRemains = delayRemains - UnityEngine.Time.deltaTime
        if delayRemains <= 0 then
            delayRemains = delaysButtonIn
            if animCompo then
                animCompo.SetBool('IsDelaying',false)
            end
            -- if spawnableCompo then
            --     -- spawnableCompo.SetValue('IsDelaying',0)
            --     -- spawnableCompo:SetValue(1,0.0)
            --     spawnableCompo.SetValue(1,0.0)
            -- end
            isDelaying = false
        end
    else
        -- if fakeButton then
        --     fakeButton.SetActive(true)
        -- end    
    end

    if fakeButton then
        fakeButton:SetActive(not isDelaying)
    end

end

function LateUpdate()
    refreshRemains = refreshRemains - UnityEngine.Time.deltaTime
    if refreshRemains <= 0 then
        refreshRemains = refreshRate
        RefreshDisplay()
    end
end