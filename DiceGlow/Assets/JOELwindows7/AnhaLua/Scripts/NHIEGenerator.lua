--[[
    Never have I ever generator

    Generate your NHIE thoughts for such game!

    by JOELwindows7
    Perkedel Technologies
    Code: GNU GPL v3
    Assets: CC4.0-BY-SA
]]--
local UnityEngine = require("UnityEngine")

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
    'fined by a service due to late paying monthly fee',
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
}
local selectNhie = 'halo'
local delaysButtonIn = 5
local delayRemains = 5
local isDelaying = false
local luaDisabledWarn

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

    Regenerate()

    if luaDisabledWarn then
        luaDisabledWarn.SetActive(false)
    end
end

-- Update is called once per frame
function Update()
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