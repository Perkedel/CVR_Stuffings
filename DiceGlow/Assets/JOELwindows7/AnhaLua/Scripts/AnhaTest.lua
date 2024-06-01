-- help
--[[
    https://documentation.abinteractive.net/cck/lua/hello-world/
    https://github.com/NotAKidOnSteam/NAK_CVR_Prefabs/blob/main/LuaExamples/CubeFactory/Script/CubeFactory.lua
    https://discord.com/channels/410126604237406209/1240763673346183279/1241233382487228478 to get component according to DDAkebono: `GetComponent("[full class name]")` like `gameObject.GetComponent("UnityEngine.RigidBody")`
    https://github.com/NotAKidOnSteam/NAK_CVR_Prefabs/blob/c7d1ce6c5925f2375e7b37f29c4d86be521f8b57/LuaExamples/PlayerWall/PlayerWall.lua#L34
    https://forum.unity.com/threads/get-parameter-from-the-animator.202938/
    https://docs.unity3d.com/ScriptReference/Animator.GetInteger.html
    I got sample snippet from LensError
    ```
    PlrCount.GetComponent("UnityEngine.UI.Text").text = "Player Count:".. playerCount
    ```

    and...
    ```
    PlrCount = BoundObjects.PlrCount
    if not PlrCount then
        print("Error! PlrCount not bound in ChilloutVR inspector.")
        return
    end 
    ```

    cool and good thancc.
    it should work ther....

    final snippet
    ```lua
    local textUI
    local textUIComponent

    function start()
    -- Obtain from a bound object
    textUI = BoundObjects.TextUIObject
    -- Obtain its component
    if not textUI then
        print('You forgot to bind TextUI into the BoundObjects!')
    else
        textUIComponent = textUI.GetComponent('UnityEngine.UI.Text')
    end
    
    -- Start interacting
    if textUIComponent then
        textUIComponent.text = 'Hello world iyeay bwah!'
    else
        print('The Text component is missing!')
    end
    end
    ```
]]--
-- JOELwindows7
UnityEngine = require("UnityEngine")
UnityUI = require("UnityEngine.UI")
TMP = require("TextMeshPro")
TM = UnityEngine.TextMesh
-- UITextOld = UnityEngine.UI
AudioSource = require("UnityEngine.AudioSource")

local DEBUG_MODE = false

local ownSelf
local isSpun = false
local spounThingy
local yikYukThingy
local tmpThingy
local tmpTextItself
local tmThingy
local tmTextItself
local animCompo
local aSpeaker
local aSpeakerCompo
local brokSpeaker
local brokSpeakerCompo
local aAudioStream
local aSteppedOnStream
local angle = 0
local toMoveAt = 0
local isBacking = false
local velocity = 5
local title = 'Halo Lua from JOELwindows7\nAlso thancc LensError for example snippet how to UnityEngine.UI.Text (& inspiration lol!)'
local installSay = ''
local sayWelcomeHome = ''
local sayPlayersFuzzy = ''
local flyAllowed = 'no'
local ruleSays = ''
local playerCount = 0
local playersYouHave = {}
local areWeOnline = 'No'
local quotes = {
    'Haha hihi',
    'Huhu hehe',
    'Press & hold Alt to move only your head',
    'While menu opens (small or big), you can Alt aim-click a player to view their profile',
    'Retro Gadget game scripting system uses Luaou, a Lua fork that originates from Roblox which allows giving variables types.',
    'bill wurtz is a surreal jazz musician, and also makes random surreal videos. Currently, the format has already been evolved into Blender (allegedly)',
    'Indonesia for the one last another time is moving capital to western Borneo so it is centered between all archipelagos in Indonesia',
    'Countries that drives on left (Right steering wheel) are: Indonesia, Japan, some southeast asian countries, UK, Dasandim, etc.',
    'Windows mobile series has always been based on Windows CE, until Phone 8 where now moved to NT',
    'Google during this AI craze has concepted Live Gemini Assistant introduced during last Google I/O, an AI Jarvis that can analyze and responds accordingly, obviously way better than Rabbit R1.',
    'Floppy disk appears to be the most long lived format despite most home consumers forgot about it. Critically, some governments still uses it.',
    'The QWERTY layout comes because it was meant to slow down typing for typewriters, to avoid jams caused by overspeeding.',
    'Nokia was one of the biggest player in phone game, until their blunder (allegedly) of refusing Android for Windows Phone instead, which becomes their demise. Nowadays, they only plays other background innovations.',
    'NestDNB was named after `rats nest`, that Joel likes rodent animal since his young time, also that because inspired from VoyVivika\'s Viviklub, which Voy himself is also a rodent based form. Quite the connection.',
    'You can now reach from Jakarta to Bandung (arrive to Padalarang) in just about 20 minutes with Whoosh, the new fast train recently established.',
    'ahei',
    'Lua is the oldest most implemented language across many softwares that uses scripting',
    'Kaorfa (Joel) first time started on Lua game in a Swedish engineering creative game, Principia. Alas though, due to insufficient funding, it\'s now defunct and left only the preservers.',
    'https://perkedel.netlify.app/@JOELwindows7',
    'Kaorfa (Joel) is a graduate at Binus University. during his time there, he learnt various game frameworks, including Unity Engine.',
    'Zuuljedus, Panfesir, Malore, and all DiceGlow team members, were the first ever people that migrate away from X0p1r4t3 Eenvreenmnt. They are now settled in Realizer Realm (Godot game development division at Perkedel).',
    'They\'re right! Many games have hidden lores, including Perkedel!!',
    'Plug-in Hybrids are still an impostor among us!',
    'sussy baka',
    '3 Pillar backups: Redundancy, Cloud, Offsite. It also still matter even if you cannot buy those.',
    'AI evolution has become the most debated topic since its movement step of their evolution. Most debates were about conflict of workforce substitutions',
    'Soul detruster',
    '',
}
local selectQuote = 'haha hihi'
local selectQuoteNum = 0
local quoteMovesIn = 10
local quoteTimeRemaining = 10
local randomIntSay = '999999999999'
local refreshRate = .1
local refreshRemains = .1

function DebugPrint(message)
    if DEBUG_MODE then
        print(message)
    end
end

function DebugLog(message)
    DebugPrint(message)
end

function RandomizeQuote()
    selectQuote = quotes[math.random(#quotes)]
end

function OnMouseDown()
    DebugPrint('Click!!!')

    -- Play one shot broke in ex2
    -- if aSpeakerCompo then
    --     -- https://docs.unity3d.com/ScriptReference/AudioSource.PlayOneShot.html
    --     aSpeakerCompo.PlayOneShot(aAudioStream,1.0)
    -- end

    if brokSpeakerCompo then
        brokSpeakerCompo:Play()
    end
end

function OnCollisionEnter(collision)
    -- if aSpeakerCompo then
    --     -- https://docs.unity3d.com/ScriptReference/AudioSource.PlayOneShot.html
    --     aSpeakerCompo.PlayOneShot(aSteppedOnStream,1.0)
    -- end

    if brokSpeakerCompo then
        brokSpeakerCompo:Play()
    end
end

function UpdateInstallSay()
    sayPlayersFuzzy = ''

    if InstancesAPI.IsHomeInstance then
        sayWelcomeHome = "Welcome Home"
    else
        sayWelcomeHome = ""
    end

    -- let us write player list
    for i = 1, #playersYouHave do
        local isFriendSay = ''
        if PlayerAPI.IsFriendsWith(playersYouHave[i].UserID) then
            isFriendSay = ">>"
        end
        sayPlayersFuzzy = sayPlayersFuzzy .. playersYouHave[i].Username .. " " .. isFriendSay .. ", "
    end

    -- fly check
    if PlayerAPI.LocalPlayer.IsFlightAllowed then
        flyAllowed = ""
    else
        flyAllowed = "NoFlying"
    end

    ruleSays = ''
    ruleSays = ruleSays .. flyAllowed .. ' '

    installSay = title .. "\n" .. selectQuote .. "\n" .. "World: " .. InstancesAPI.InstanceName .. "(" .. InstancesAPI.InstancePrivacy .. ")\n" .. "Rules: " .. ruleSays .. "\n" .. "Connection: " .. areWeOnline .. " (" .. InstancesAPI.Ping .. " ms)\n" .. sayWelcomeHome .. "\n" .. "Players (" .. playerCount .. "):\n" .. sayPlayersFuzzy .. "\n\nRandom Int Test: " .. randomIntSay
end

-- Start is called before the first frame update
function Start()
    -- firstly, init random seed! Documentation Funny Cube example!
    math.randomseed(UnityEngine.Time.time)


    print "Hello world!"
    -- ownSelf = BoundObjects.OwnSelf
    spounThingy = BoundObjects.Spoun
    yikYukThingy = BoundObjects.IyakYikYuk
    tmpThingy = BoundObjects.Titler
    if tmpThingy then
        -- tmpTextItself = tmpThingy.GetComponent(TMP)
        -- tmpTextItself = tmpThingy:GetComponent("TextMeshPro.TMP")
        tmpTextItself = tmpThingy:GetComponent("TMPro.TMP_Text")
    end
    tmThingy = BoundObjects.TitlerOld
    aSpeaker = BoundObjects.Speaker
    brokSpeaker = BoundObjects.SpeakerTemp
    aAudioStream = BoundObjects.PlayThisAudio
    aSteppedOnStream = BoundObjects.PlayBeingSteppedOn

    print('Sounds are: '.. tostring(aAudioStream) .. ' and ' .. tostring(aSteppedOnStream))

    -- if ownSelf then
    --     print('obtain self')
    --     animCompo = ownSelf.GetComponent("UnityEngine.Animator")
    -- else
    --     print('forgor assign this self')
    -- end
    animCompo = gameObject:GetComponentInParent("UnityEngine.Animator")

    if not tmThingy then
        print('WERROR! tmThingy not bounded!!!')
    else
        print('Obtain component')
        -- tmTextItself = tmThingy.GetComponent(TM)
        -- tmTextItself = tmThingy:GetComponent("UnityEngine.TextMesh")
        tmTextItself = tmThingy.GetComponent("UnityEngine.UI.Text")
    end

    if aSpeaker then
        aSpeakerCompo = aSpeaker.GetComponent("UnityEngine.AudioSource")
        print('Speaker is ' .. tostring(aSpeakerCompo))
    end

    if brokSpeaker then
        brokSpeakerCompo = brokSpeaker.GetComponent("UnityEngine.AudioSource")
        print('temp Speaker is ' .. tostring(brokSpeakerCompo))
    else
        print('forgot temp speaker')
    end

    -- installSay = title .. "\n" .. "Ping: " .. InstancesAPI.Ping .. "\n" .. sayWelcomeHome .. "\n"
    UpdateInstallSay()

    if not tmTextItself then
        print "compo nil"
    else
        print "compo ok"
    end

    print('haha')
    print(installSay)
    if tmTextItself then
        -- tmThingy:GetComponent("UnityEngine.TextMesh").text = 'HEy Hey Hey'
        -- tmThingy:GetComponent("UnityEngine.UI.Text").text = 'HEy Hey Hey'
        tmTextItself.text = 'HEy Hey Hey'
    else
        print('AH PECK NECK NO TEXT!')
    end
    print('huhu')

    RandomizeQuote()
end

-- Update is called once per frame
function Update()
    -- Sorry, Codeium is also here.
    if InstancesAPI.IsConnected then
        areWeOnline = "yes"
    else
        areWeOnline = "no"
    end

    -- Quote
    quoteTimeRemaining = quoteTimeRemaining - UnityEngine.Time.deltaTime
    if quoteTimeRemaining < 0 then
        RandomizeQuote()
        quoteTimeRemaining = quoteMovesIn
    end

    playerCount = PlayerAPI.PlayerCount
    playersYouHave = PlayerAPI.AllPlayers
    
    angle = angle + UnityEngine.Time.deltaTime * velocity
    -- Codeium intervenes!
    if angle > 360 then
        angle = 0
    end
    if not isBacking then
        toMoveAt = toMoveAt + UnityEngine.Time.deltaTime * velocity
        if toMoveAt > 1 then
            isBacking = true
        end
    else
        toMoveAt = toMoveAt - UnityEngine.Time.deltaTime * velocity
        if toMoveAt < -1 then
            isBacking = false
        end
    end

    

    UpdateInstallSay()
    -- installSay = 'test'
    -- tmpThingy.gameObject.TMP_Text.text = installSay
    -- tmpTextItself.text = installSay
    -- tmTextItself.text = installSay
    -- tmThingy.GetComponent(UnityEngine.TextMesh).text = installSay
    -- tmThingy.GetComponent("UnityEngine.TextMesh").text = installSay
    -- tmThingy.text = installSay

    

    if tmTextItself then
        tmTextItself.text = installSay
    else
        -- print('AH PECK NECK NO TEXT!')
    end

    if tmpTextItself then
        tmpTextItself.text = installSay
    else
        -- print('AH PECK NECK NO TEXT!')
    end

    -- spounThingy.transform.Rotate(0,angle,0)
    spounThingy.transform.localRotation = UnityEngine.Quaternion.Euler(UnityEngine.NewVector3(0,angle,0))
    yikYukThingy.transform.localPosition = UnityEngine.NewVector3(.75,toMoveAt,0)

    if animCompo then
        randomIntSay = tostring(animCompo.GetInteger('randIntTest'))
    end
end