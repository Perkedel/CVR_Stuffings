--[[
    Dare Drink Game NSFW generator

    Generate Dare actions for such game! with cum!
    Drink is SDEXM tea. This tea cause horniness & enough dosage cause you instant cum. Who cums last wins.
    Typically, Homo sapiens cums by about 2 tea cups.
    Use small shot cup instead!
    If the prompt caused you to cum, then you still lose

    Replacable with regular alcohol, where last drunk OR last with BAC under threshold, wins.

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
local drinkCupCounter = 0
local maximumDrinkCup = 100
local initText = 'Click this prop to begin.\nMake sure all players are consent that there will be strong sexual plays with this game.'
local sdexmDareList = {
    -- Prompt, Cup
    {'Feel your heartbeat in your chest for at least 5 seconds',1},
    {'stimulate both of your nipples for 10 seconds',1},
    {'dance in the pole! if you don\'t see any cylinder erecting around, pretend the pole is there!',1},
    {'Ponder at your own genitalia for 30 seconds. Uncover your pants!',2},
    {'Guess other player genitalia size (either length or diameter). \nWrong answer drinks 1 cup.',2},
    {'Guess other player chest size (pecs included). \nWrong answer drinks 1 cup.',2},
    {'Listen to other player heartbeat (act like you\'re earstething or stethoscope their chest) for 12 seconds. \n5 ATTEMPT ONLY! Asked player refused drinks how many cups below. Ultimate fail (all 5 refused), drinks 0 cup.\nBONUS: Target Player avatar that contains heartbeat sound gives 10 cups from that target. Each players whose their heartbeat sound rate linked to their IRL heart rate gives additional 20 cups.',2},
    {'Attempt bend yourself so you can lick your own genitalia. Attempt in 60 seconds. \ntimeout failure drinks 0 cup.',3},
    {'Act the regular genitalia to genitalia sex. \n5 ATTEMPT ONLY! Asked player refused drinks how many cups below. Ultimate fail (all 5 refused), drinks 0 cup.\nNOT IN REAL LIFE! YOUR AVATARS!! IN THE GAME.',3},
    {'Act the regular genitalia to oral sex (blow job). \n5 ATTEMPT ONLY! Asked player refused drinks how many cups below. Ultimate fail (all 5 refused), drinks 0 cup.\nNOT IN REAL LIFE! YOUR AVATARS!! IN THE GAME.',3},
    {'Act the regular genitalia to back sex (anal). \n5 ATTEMPT ONLY! Asked player refused drinks how many cups below. Ultimate fail (all 5 refused), drinks 0 cup.\nNOT IN REAL LIFE! YOUR AVATARS!! IN THE GAME.',3},
    {'Act the regular oral to back sex (anal lick). \n5 ATTEMPT ONLY! Asked player refused drinks how many cups below. Ultimate fail (all 5 refused), drinks 0 cup.\nNOT IN REAL LIFE! YOUR AVATARS!! IN THE GAME.',3},
    {'Act the regular oral to oral sex (kissing EXtended). \n5 ATTEMPT ONLY! Asked player refused drinks how many cups below. Ultimate fail (all 5 refused), drinks 0 cup.\nNOT IN REAL LIFE! YOUR AVATARS!! IN THE GAME.',3},
    {'Act the regular chest to chest sex (boob slide). \n5 ATTEMPT ONLY! Asked player refused drinks how many cups below. Ultimate fail (all 5 refused), drinks 0 cup.\nNOT IN REAL LIFE! YOUR AVATARS!! IN THE GAME.',3},
    {'Act the regular genitalia to chest sex (paizuri). \n5 ATTEMPT ONLY! Asked player refused drinks how many cups below. Ultimate fail (all 5 refused), drinks 0 cup.\nNOT IN REAL LIFE! YOUR AVATARS!! IN THE GAME.',3},
    {'Act the regular back to chest sex (sit on you). \n5 ATTEMPT ONLY! Asked player refused drinks how many cups below. Ultimate fail (all 5 refused), drinks 0 cup.\nNOT IN REAL LIFE! YOUR AVATARS!! IN THE GAME.',3},
    {'Interconnect sex yin-yang! your genitalia insert to other player oral, and other player genitalia goes to your oral. \n5 ATTEMPT ONLY! Asked player refused drinks how many cups below. Ultimate fail (all 5 refused), drinks 0 cup.\nNOT IN REAL LIFE! YOUR AVATARS!! IN THE GAME.',3},
    {'Fondle & Squeeze your own chest for at least 15 seconds. \nNOT IN REAL LIFE! YOUR AVATARS!! IN THE GAME',4},
    {'Fondle & Squeeze other player chest for at least 15 seconds. \nNOT IN REAL LIFE! YOUR AVATARS!! IN THE GAME',4},
    {'Fondle & Squeeze your own genitalia for at least 15 seconds. \nNOT IN REAL LIFE! YOUR AVATARS!! IN THE GAME',4},
    {'Fondle & Squeeze other player genitalia for at least 15 seconds. \nNOT IN REAL LIFE! YOUR AVATARS!! IN THE GAME',4},
    {'Fondle & Squeeze other player back hole for at least 15 seconds. \nNOT IN REAL LIFE! YOUR AVATARS!! IN THE GAME',4},
    {'Fondle & Squeeze your own back hole for at least 15 seconds. \nNOT IN REAL LIFE! YOUR AVATARS!! IN THE GAME',4},
    {'(TotallyWholesome) Leash 5 other players who has TotallyWholesome mod. \nNOT IN REAL LIFE! YOUR AVATARS!! IN THE GAME',4},
    {'(TotallyWholesome) Leash & Hack 5 other players Avatar Parameter, each get 1 parameter changed. \nNOT IN REAL LIFE! YOUR AVATARS!! IN THE GAME',4},
    {'(TotallyWholesome) Leash & Pull 5 other players around this room or this play scene, 1 lap. \nNOT IN REAL LIFE! YOUR AVATARS!! IN THE GAME',4},
    {'(TotallyWholesome) Leash & trigger Shockers or Vibrators of 5 players. Target players who did have their shocker / vibrator system setup properly & received that shocks or vibrations gives 2 cup. Each of those players that cum because of it (& lost) gives additional 5 cups. \nNOT IN REAL LIFE! YOUR AVATARS!! IN THE GAME',4},
    {'Assemble threesome (minimum you and 2 others) and sex with that for 15 seconds',4},
    {'Assemble quadsome (minimum you and 3 others) and sex with that for 15 seconds',4},
    {'Assemble pentasome (minimum you and 4 others) and sex with that for 15 seconds',4},
    {'Assemble sexosome (minimum you and 5 others) and sex with that for 15 seconds',4},
    {'Assemble septosome (minimum you and 6 others) and sex with that for 15 seconds',4},
    {'Assemble octasome (minimum you and 7 others) and sex with that for 15 seconds',4},
    {'Assemble octasome (minimum you and 7 others) and sex with that for 15 seconds',4},
    {'Assemble nonasome (minimum you and 8 others) and sex with that for 15 seconds',4},
    {'Assemble decasome (minimum you and 9 others) and sex with that for 15 seconds',4},
    {'Assemble trikaidecasome (minimum you and 12 others) and sex with that for 15 seconds',4},
    {'Assemble all players and sex with that for 15 seconds',4},
    {'Assemble all players to worm (oral anal train chaining) atleast 3 players. Other offered players refused takes how many cups below. Ultimate fail (less than 3 players) drinks 0 cup. \nNOT IN REAL LIFE! YOUR AVATARS!! IN THE GAME.',5},
    {'Headpat 5 players. Each players avatar that reacts to the headpat gives 5 cups. Other offered players refused takes how many cups below. Ultimate fail (less than 5 players) drinks 0 cup.',5},
    {'Ragdoll yourself and let others do something to you for maximum 60 seconds. If you cum by any mean (& lost), give 25 cups',5},
    {'Ragdoll other player and let yourself & rest do something to them for maximum 60 seconds. If they cum by any mean (& lost), that player gives 25 cups',5},
    {'(for VR) Do stretching arc bend outward OR (for desktop) Do crazy mouse CS:GO swinging. Do for 20 seconds',5},
    {'(for VR) Push up 20 times OR (for desktop) Rapid `X` & `C` repeatedly for 20 seconds accumulatively.',5},
    {'(for VR) Jumping Jack 20 times OR (for desktop) Hold Space for 20 seconds accumulatively.',5},
    {'(for VR) Body bend twist left right 20 times OR (for desktop) 360 No scope (jump, spin 360 once before landing) left right 20 times.',5},
    {'(for VR) Open Close eye face stretching 20 times OR (for desktop) Hold Middle click 1 second, release 1 second, repeat till 20 times.',5},
    {'(for VR) Rope waving (hand slam rope to make wave alternat between ropes pair) 20 second OR (for desktop) Rapid `Q` & `E` 20 seconds.',5},
    {'(for VR) Rapid Strafe left right 20 second OR (for desktop) Rapid `A` & `D` 20 seconds.',5},
    {'(for VR) Rapid Walk forward back repeat 20 second OR (for desktop) Rapid `W` & `S` 20 seconds. \nMaju mundur maju mundur cantik',5},
}
local selectSdexmPrompt = ''
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
    selectNum = math.random(#sdexmDareList)
    if animCompo then
        animCompo.SetInteger('SelectQuote',selectNum)
    end
    -- unworking!!!?????!!!!????!!!!????
    -- if spawnableCompo then
    --     -- spawnableCompo.SetValue('SelectQuote',selectNum)
    --     -- spawnableCompo:SetValue(0,selectNum)
    --     spawnableCompo.SetValue(0,selectNum)
    -- end
    selectSdexmPrompt = sdexmDareList[selectNum][1]
    drinkCupCounter = sdexmDareList[selectNum][2]
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
        selectSdexmPrompt = sdexmDareList[selectNum][1]
        drinkCupCounter = sdexmDareList[selectNum][2]
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
            textOutCompo.text = selectSdexmPrompt + '\n\n' + 'Or drink: ' + tostring(drinkCupCounter) + ' cups'
        else
            textOutCompo.text = initText
        end
    end
    -- local bugText = BoundObjects.Zaza.GetComponent('UnityEngine.UI.Text')
    -- if bugText then
    --     bugText.text = selectNhie
    -- end

    if textNewCompo then
        if selectNum > 0 then
            textNewCompo.text = selectSdexmPrompt + '\n\n' + 'Or drink: ' + tostring(drinkCupCounter) + ' cups'
        else
            textNewCompo.text = initText
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
        textOutCompo.text = initText
    end

    if textNewCompo then
        textNewCompo.text = initText
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