-- help
--[[
    https://documentation.abinteractive.net/cck/lua/hello-world/
    https://github.com/NotAKidOnSteam/NAK_CVR_Prefabs/blob/main/LuaExamples/CubeFactory/Script/CubeFactory.lua
    https://discord.com/channels/410126604237406209/1240763673346183279/1241233382487228478 to get component according to DDAkebono: `GetComponent("[full class name]")` like `gameObject.GetComponent("UnityEngine.RigidBody")`
    https://github.com/NotAKidOnSteam/NAK_CVR_Prefabs/blob/c7d1ce6c5925f2375e7b37f29c4d86be521f8b57/LuaExamples/PlayerWall/PlayerWall.lua#L34
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

local DEBUG_MODE = false

local isSpun = false
local spounThingy
local yikYukThingy
local tmpThingy
local tmpTextItself
local tmThingy
local tmTextItself
local aSpeaker
local aSpeakerCompo
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
local quoteMovesIn = 10
local quoteTimeRemaining = 10

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
    if aSpeakerCompo then
        -- https://docs.unity3d.com/ScriptReference/AudioSource.PlayOneShot.html
        aSpeakerCompo.PlayOneShot(aAudioStream,1)
    end
end

function OnCollisionEnter(collision)
    if aSpeakerCompo then
        -- https://docs.unity3d.com/ScriptReference/AudioSource.PlayOneShot.html
        aSpeakerCompo.PlayOneShot(aSteppedOnStream,1)
    end
end

function UpdateInstallSay()
    installSay = title .. "\n" .. selectQuote .. "\n" .. "World: " .. InstancesAPI.InstanceName .. "(" .. InstancesAPI.InstancePrivacy .. ")\n" .. "Rules: " .. ruleSays .. "\n" .. "Connection: " .. areWeOnline .. " (" .. InstancesAPI.Ping .. " ms)\n" .. sayWelcomeHome .. "\n" .. "Players (" .. playerCount .. "):\n" .. sayPlayersFuzzy
end

-- Start is called before the first frame update
function Start()
    print "Hello world!"
    spounThingy = BoundObjects.Spoun
    yikYukThingy = BoundObjects.IyakYikYuk
    tmpThingy = BoundObjects.Titler
    -- tmpTextItself = tmpThingy.GetComponent(TMP)
    -- tmpTextItself = tmpThingy:GetComponent("TextMeshPro.TMP")
    tmThingy = BoundObjects.TitlerOld
    aSpeaker = BoundObjects.Speaker
    aAudioStream = BoundObjects.PlayThisAudio
    aSteppedOnStream = BoundObjects.PlayBeingSteppedOn
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

    sayPlayersFuzzy = ''
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

    if InstancesAPI.IsHomeInstance then
        sayWelcomeHome = "Welcome Home"
    else
        sayWelcomeHome = ""
    end

    -- let us write player list
    for i = 1, #playersYouHave do
        sayPlayersFuzzy = sayPlayersFuzzy .. playersYouHave[i].Username .. ", "
    end

    -- fly check
    if PlayerAPI.LocalPlayer.IsFlightAllowed then
        flyAllowed = ""
    else
        flyAllowed = "NoFlying"
    end

    ruleSays = ''
    ruleSays = ruleSays .. flyAllowed .. ' '

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

    -- spounThingy.transform.Rotate(0,angle,0)
    spounThingy.transform.localRotation = UnityEngine.Quaternion.Euler(UnityEngine.NewVector3(0,angle,0))
    yikYukThingy.transform.localPosition = UnityEngine.NewVector3(.75,toMoveAt,0)
end