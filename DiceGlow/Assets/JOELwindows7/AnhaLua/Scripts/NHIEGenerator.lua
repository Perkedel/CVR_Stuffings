--[[
    Never have I ever generator

    Generate your NHIE thoughts for such game!

    Sauce:
    - https://discord.com/channels/410126604237406209/1240763673346183279/1245066584066752625 thancc Shin for get spawnable value instead

    Sync Value Index:
    0. Select Quote
    1. Is delaying

    by JOELwindows7
    Perkedel Technologies
    Code: GNU GPL v3
    Assets: CC4.0-BY-SA
]]--
print('HALO NHIE')
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
local textOut --= BoundObjects.TitlerOld
local textOutCompo = nil
local textNew --= BoundObjects.Titler
local textNewCompo = nil
local nhieList = {
    'Programmed `Hello, world!` in Rust',
    'Messed up settings causing PC unbootable',
    'successfully installing OG Arch Linux',
    'contributing voluntarily on someone else project atleast 1 commit',
    'Ticketed by the police only because the headlight broke',
    'Done a wheelie on a motorcycle',
    'fell from a tree',
    'got food poisoned due to unforseen circumstances',
    'failed driving license test',
    'fined by a service due to late paying subscription fee (water, power, etc.)',
    'rushed to a hospital due to certain injury',
    'remedial for a failed exam',
    'scammed by a merchant in any form (real & cyber)',
    'hit someone\'s glass window & broke it (e.g. baseball throw / batter accidentally went to window)',
    'acquired a losing lottery ticket',
    'won a video game tournament',
    'won a software development jam',
    'won a giveaway',
    'peaked any mountain',
    'reached the top floor of National Monument in Jakarta, Indonesia',
    'Stepped foot on IKN (New Capital of Indonesia at Eastern Borneo)',
    'Fell from stair',
    'broke a vase',
    'drank way too much coffee, losing control',
    'Connected to Starbuck WiFi',
    'subscribed to a VPN',
    'slept in a public facility (that is not meant for it such as hotel)',
    'vehicle got stolen',
    'paid & entered in-person exhibition / expo',
    'tasted spicy food',
    'fell asleep during class / lecture',
    'scratched someone\'s car or motorbike',
    'upload a video to any platform',
    'lost unsaved work to a power failure or crash',
    'corrupted a file',
    'own smartwatch',
    'own an Android',
    'fixed something yourself',
    'done Oreo tricks described in the packaging (Twist-Lick-Dunk)',
    'wrote story (fanfic or original)',
    'pressed every keys on this 118 keys keyboard',
    'cleaned house yourself instead your parent or maid',
    'spent on something that shouldn\'t ever cost that a.k.a. not worth it',
    'Did transaction on cheap shop platforms / markets (Temu, Jakarta Notebook, Wish, Poundland, etc.)',
    'Gave flower to your parent (mother or father or both)',
    'tried pure Lua (that\'s all base, not ones implemented on another software nor is a framework)',
    'encountered any player in this game, in-person',
    'encountered any player in this game, on other platform',
    'upset a Spirit of Ecstacy on a parked Rolls-Royce (fiddled the statue significantly on the car front causing it to immediately snuck back in) (including your own if you have one, or your relatives)',
    'Owned T9 keypadded feature phone (OG phone owners OR refugee)',
    'played modded Minecraft',
    'Graduated on college',
    'Dropped out of college',
    'ask to borrow money to someone (family or friend or bank)',
    'loan stuck for more than 3 months',
    'tried other OS platform than yours (e.g. Android user tries iOS, or vice versa)',
    'felt your own left chest pushing from inside (hand feel hearbeat)',
    'roleplayed manually (not video game RPG)',
    'yeeted correct impostor in Among Us',
    'got yeeted and you\'re impostor in Among Us',
    '100%ed Henry Stickmin Collection',
    'been the only one who obeyed school homework',
    'been the only one who disobeyed school homework',
    'been the only one at certain event',
    'forgot to turn on stream while you should\'ve',
    'forgot to turn off stream after finish & reunlock true character with it',
    'forgot to switch to supposed scene (you are streaming the game but selected scene still on break blind scene instead of your game capture)',
    'victim of draw UNO for total over 10 cards, while you\'re just being <= 2 left',
    'fatally drew this one opponent in UNO for 10 cards or more, while they\'re just being <= 2 left',
    'won UNO in less than 2 turns',
    'bio-clock flipped from standard (overnight people, did not sleep at night, work at night shift)',
    'still live with parent(s) / guardian(s), married or not',
    'live fully alone, not even pets',
    'own at least 1 Rolls-Royce',
    'own at least 1 supercar / hypercar',
    'own at least 1 ancient vehicle',
    'have best of the best VR kit (e.g. Valve Index)',
    'have no VR kit',
    'still on potato PC of this era',
    'has been on best of the best PC of this era',
    'own a Fairphone',
    'own a Framework laptop',
    'AFK for more than 12 hours',
    'AFK for more than 3 hours',
    'AFK for more than 30 minutes',
    'NHIE all move forward once',
    'NHIE all stays',
    'NHIE all go backward once',
    'NHIE all nearest to danger zone go back 2 step',
    'NHIE all nearest from start zone go forward 3 step',
    'NHIE all in start zone to 1st middle gray go forward 2 step, all 2nd middle gray to danger zone side go back 2 step',
}
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
    selectNum = math.random(#nhieList)
    if animCompo then
        animCompo.SetInteger('SelectQuote',selectNum)
    end
    -- unworking!!!?????!!!!????!!!!????
    -- if spawnableCompo then
    --     -- spawnableCompo.SetValue('SelectQuote',selectNum)
    --     -- spawnableCompo:SetValue(0,selectNum)
    --     spawnableCompo.SetValue(0,selectNum)
    -- end
    selectNhie = nhieList[selectNum]
    -- if textOutCompo then
    --     textOutCompo.text = selectNhie
    -- end
    if textOut then
        -- textOut.text = selectNhie
        -- textOutCompo = textOut.GetComponent("UnityEngine.UI.Text")
        -- textOut:GetComponent("UnityEngine.UI.Text").text = selectNhie
        -- if textOutCompo then
        --     textOutCompo.text = selectNhie
        -- end
        
    end
    
    if animCompo then
        animCompo.SetBool('IsDelaying',true)
    end
    -- if spawnableCompo then
    --     -- spawnableCompo.SetValue('IsDelaying',1)
    --     -- spawnableCompo:SetValue(1,1.0)
    --     spawnableCompo.SetValue(1,1.0)
    -- end
    isDelaying = true
    RefreshDisplay()
end

function OnMouseDown()
    if not isDelaying then
        Regenerate()
    end
end

function RefreshDisplay()
    if animCompo then
        isDelaying = animCompo.GetBool('IsDelaying')
        selectNum = animCompo.GetInteger('SelectQuote')
        selectNhie = nhieList[selectNum]
    end
    -- WHYN'T GET VALUE WORK??!??!
    -- `cannot access field GetValue of userdata<ABI.Scripting.CVRSTL.Common.CVR.CCK._LUAINSTANCE_ScriptedCVRSpawnable>`
    -- if spawnableCompo then
    --     -- isDelaying = NumBool(spawnableCompo.GetValue('IsDelaying'))
    --     -- isDelaying = NumBool(spawnableCompo:GetValue(1))
    --     isDelaying = NumBool(spawnableCompo.GetValue(1))
    --     -- selectNum = spawnableCompo.GetValue('SelectQuote')
    --     -- selectNum = spawnableCompo:GetValue(0)
    --     selectNum = spawnableCompo.GetValue(0)
    --     selectNhie = nhieList[selectNum]
    -- end
    
    if textOut then
        -- HOW COME THE TEXT REFERENCE UNRELIABLE!?!?!?
        --[[
            [Unity] /CVRSpawnable_7978dda3-291d-49d0-be01-29f50cff6106_58974140(Clone):Client Lua[CVRSpawnable_7978dda3-291d-49d0-be01-29f50cff6106_58974140(Clone)]: Script Runtime Exception: Assets/JOELwindows7/AnhaLua/Scripts/NHIEGenerator.lua:(149,8-66): cannot convert clr type ABI.Scripting.CVRSTL.Common.UnityEngine.UI._LUAINSTANCE_ScriptedText
        ]]--
        -- textOut:GetComponent("UnityEngine.UI.Text").text = selectNhie
        -- textOut.GameObject:GetComponent("UnityEngine.UI.Text").text = selectNhie
    end
    if textOutCompo then
        if selectNum > 0 then
            textOutCompo.text = selectNhie
        else
            textOutCompo.text = 'Click this prop to begin'
        end
    end
    -- local bugText = BoundObjects.Zaza.GetComponent('UnityEngine.UI.Text')
    -- if bugText then
    --     bugText.text = selectNhie
    -- end

    if textNewCompo then
        if selectNum > 0 then
            textNewCompo.text = selectNhie
        else
            textNewCompo.text = 'Click this prop to begin'
        end
    end
end

-- Start is called before the first frame update
function Start()
    -- helped by Codeium lol

    ownSelf = BoundObjects.OwnSelf
    textOut = BoundObjects.TitlerOld
    textNew = BoundObjects.Titler
    fakeButton = BoundObjects.GenerateFakeButton
    luaDisabledWarn = BoundObjects.LuaDisabledWarning

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

    -- wtf whyn't work????
    -- if textOut then
    --     -- textOutCompo = textOut.GameObject.GetComponent("UnityEngine.UI.Text")
    --     textOutCompo = textOut:GetComponent("UnityEngine.UI.Text")
    -- else
    --     print('Forgor textOut')
    -- end
    print('get text '..tostring(textOut))
    if not textOut then
        print('Forgor textOut')
    else
        -- UNRELIABLE! HOW COME THE TEXT REFERENCE UNRELIABLE!?!?!?
        -- print('PLS TEXT ' .. tostring(textOut:GetComponent('UnityEngine.UI.Text')))
        -- print('PLS TEXT ' .. tostring(BoundObjects.TitlerOld:GetComponent('UnityEngine.UI.Text')))
        -- textOutCompo = textOut.gameObject:GetComponent('UnityEngine.UI.text')
        -- textOutCompo = textOut.GetComponent('UnityEngine.UI.Text')
        -- textOutCompo = textOut.GetComponent('')
        -- textOutCompo = textOut:GetComponent('UnityEngine.UI.Text')
        textOutCompo = textOut:GetComponent('UnityEngine.UI.Text')
        -- textOutCompo = textOut
        
    end
    print('get text '..tostring(textOut))
    -- textOutCompo = textOut:GetComponent("UnityEngine.UI.Text")
    -- textOutCompo = BoundObjects.zaza:GetComponent('UnityEngine.UI.Text')
    -- trouble: if it's on a GameObject, it won't work! get it out of it!
    if textNew then
        textNewCompo = textNew:GetComponent("TMPro.TMP_Text")
        print('Get New Text ' .. tostring(textNewCompo))
    else
        print('Forgor textNew')
    end


    -- Regenerate()

    if luaDisabledWarn then
        luaDisabledWarn.SetActive(false)
    end

    if textOutCompo then
        textOutCompo.text = 'Click this prop to begin'
    end

    if textNewCompo then
        textNewCompo.text = 'Click this prop to begin'
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