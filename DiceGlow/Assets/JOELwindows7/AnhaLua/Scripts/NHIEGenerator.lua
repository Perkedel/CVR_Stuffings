--[[
    Never have I ever generator

    Generate your NHIE thoughts for such game!

    by JOELwindows7
    Perkedel Technologies
    Code: GNU GPL v3
    Assets: CC4.0-BY-SA
]]--
local UnityEngine = require("UnityEngine")

local ownSelf
local fakeButton
local textOut
local textOutCompo
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
}
local selectNhie = 'halo'
local selectNum = 0
local delaysButtonIn = 5
local delayRemains = 5
local isDelaying = false
local luaDisabledWarn
local refreshRate = .1
local refreshRemains = .1

function Regenerate()
    selectNhie = nhieList[math.random(#nhieList)]
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
    local bugText = BoundObjects.zaza:GetComponent('UnityEngine.UI.Text')
    if bugText then
        bugText.text = selectNhie
    end
    isDelaying = true
end

function OnMouseDown()
    if not isDelaying then
        Regenerate()
    end
end

-- Start is called before the first frame update
function Start()
    ownSelf = BoundObjects.OwnSelf
    fakeButton = BoundObjects.GenerateFakeButton
    luaDisabledWarn = BoundObjects.LuaDisabledWarning
    textOut = BoundObjects.zaza

    -- wtf whyn't work????
    -- if textOut then
    --     -- textOutCompo = textOut.GameObject.GetComponent("UnityEngine.UI.Text")
    --     textOutCompo = textOut:GetComponent("UnityEngine.UI.Text")
    -- else
    --     print('Forgor textOut')
    -- end
    if not textOut then
        print('Forgor textOut')
    else
        -- textOutCompo = textOut:GetComponent('UnityEngine.UI.Text')
    end
    -- textOutCompo = textOut:GetComponent("UnityEngine.UI.Text")
    -- textOutCompo = BoundObjects.zaza:GetComponent('UnityEngine.UI.Text')
    -- trouble: if it's on a GameObject, it won't work! get it out of it!

    Regenerate()

    if luaDisabledWarn then
        luaDisabledWarn.SetActive(false)
    end
end

-- Update is called once per frame
function Update()
    refreshRemains = refreshRemains - UnityEngine.Time.deltaTime
    if refreshRemains <= 0 then
        refreshRemains = refreshRate
    end

    if isDelaying then
        delayRemains = delayRemains - UnityEngine.Time.deltaTime
        if delayRemains <= 0 then
            delayRemains = delaysButtonIn
            isDelaying = false
        end
    else
        -- if fakeButton then
        --     fakeButton.SetActive(true)
        -- end    
    end
    if fakeButton then
        fakeButton.SetActive(not isDelaying)
    end
end