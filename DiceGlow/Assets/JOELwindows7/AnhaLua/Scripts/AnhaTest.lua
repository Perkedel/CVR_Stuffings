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
print('HALO ANHA')

if IsValid() then
    print("VALID WRAPPER")
else
    print('WERROR! WRAPPER IS NOT VALID')
end

print ('Pls work require wtf ' .. tostring(require('UnityEngine')))
UnityEngine = require("UnityEngine")
CVR = require('CVR')
CCK = require('ABI.CCK')
Network = require('CVR.Network')
UnityUI = require("UnityEngine.UI")
TMP = require("TextMeshPro")
RCC = require("RCC")
TM = require('UnityEngine.TextMesh')
AudioSource = require("UnityEngine.AudioSource")
-- UITextOld = UnityEngine.UI

local DEBUG_MODE = false
local perInit = false

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
local physInfluencerCompo
local angle = 0
local toMoveAt = 0
local isBacking = false
local velocity = 5
local title = 'Halo Lua from JOELwindows7\nAlso thancc LensError for example snippet how to UnityEngine.UI.Text (& inspiration lol!)'
local installSay = ''
local sayWelcomeHome = ''
local sayPlayersFuzzy = ''
local flyAllowed = ''
local ruleSays = ''
local playerCount = 0
local playersYouHave = {}
local memorizePlayer = {}
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
local luaStatusSay = ''
local runsOnSay = {
    '', -- 1 server
    '', -- 2 client
    '', -- 3 avatar
    '', -- 4 prop
    '', -- 5 world
    '', -- 6 worn by me
    '', -- 7 spawn by me
    '', -- 8 connection
}
local whoLeft = ''
local lastAvatarLoadEventSay = ''
local sdrawGravitySay = ''
local profilePictureQuad = nil -- BoundObjects Quad!!!!
local profilePictureQuadCompo = nil -- & the Mesh Renderer


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

function GetCVRGravityDirection(legacy)
    if legacy then
        -- SDraw. https://discord.com/channels/410126604237406209/1240763673346183279/1250438874082316329
        return (BoundObjects.gyroTarget.transform.position - BoundObjects.gyroRoot.transform.position).normalized
    else
        -- Fearless7, Kafeijao, https://discord.com/channels/410126604237406209/795882566968279091/1250898750264709242
        return gameObject:GetComponentInParent('ABI.CCK.Components.PhysicsInfluencer').GetAppliedGravityDirection()
    end
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

function OnInstanceConnected()
    runsOnSay[8] = "Connected"
end

function OnInstanceDisconnected()
    runsOnSay[8] = "Disconnected"
end

function OnInstanceConnectionLost()
    runsOnSay[8] = "ConnectionLost"
end

function OnInstanceConnectionRecovered()
    runsOnSay[8] = "ConnectionRecovered"
end

function OnPlayerJoined(remotePlayer)
    table.insert(memorizePlayer,remotePlayer)
end

function OnPlayerLeft(remotePlayer)
    whoLeft = ''
    -- for i=1,#memorizePlayer do
    --     for j=1,#playersYouHave do
    --         if memorizePlayer[i].UserID == playersYouHave[j].UserID then
    --             -- player still exist here
    --            break 
    --         end
    --         -- welp not found.
    --         whoLeft = whoLeft .. ', ' .. memorizePlayer[j].Username
    --     end
    --     -- if memorizePlayer[i].UserID == remotePlayer.UserID then
    --     --     whoLeft = whoLeft .. ', ' .. remotePlayer.Username
    --     -- end
    -- end
    -- whoLeft = whoLeft .. ', ' .. remotePlayer.Username
end

function OnLocalPlayerAvatarLoaded(avatar, localPlayer)
    -- https://documentation.abinteractive.net/cck/lua/recipes/listen-game-events/
    if (RunningInProp and not IsSpawnedByMe) or (RunningInAvatar and not IsWornByMe) then return end
    lastAvatarLoadEventSay = 'Local Player Avatar Loaded: ' .. localPlayer.Username .. ' wearing ' .. avatar.AvatarID
end

function OnLocalPlayerAvatarClear(avatar, localPlayer)
    if (RunningInProp and not IsSpawnedByMe) or (RunningInAvatar and not IsWornByMe) then return end
    lastAvatarLoadEventSay = 'Local Player Avatar Cleared: ' .. localPlayer.Username .. ' dropped ' .. avatar.AvatarID
end

function OnRemotePlayerAvatarLoaded(avatar, remotePlayer)
    if (RunningInProp and not IsSpawnedByMe) or (RunningInAvatar and not IsWornByMe) then return end
    lastAvatarLoadEventSay = 'Remote Player Avatar Loaded: ' .. remotePlayer.Username .. ' wearing ' .. avatar.AvatarID
end

function OnRemotePlayerAvatarClear(avatar, remotePlayer)
    if (RunningInProp and not IsSpawnedByMe) or (RunningInAvatar and not IsWornByMe) then return end
    lastAvatarLoadEventSay = 'Remote Player Avatar Cleared: ' .. remotePlayer.Username .. ' dropped ' .. avatar.AvatarID
end

function OnPlayerProfileImage(texture, player, playerMeshRenderer)
    -- https://documentation.abinteractive.net/cck/lua/examples/player-profile-picture/
    print("Received the Player Profile Image for user " .. player.UserID .. "! " .. tostring(texture))
    if texture == nil then
        print("Unfortunately it was nil :(")
        return
    end
    -- Get the current material on the meshrenderer and set the texture
    -- The material SetTexture requires a Texture instance, and not Texture2D
    -- which is why we called GetProfileImage with the second arg true, so the
    -- texture is returned as a Texture instead of Texture2D
    local materialInstance = playerMeshRenderer.material
    materialInstance.SetTexture("_MainTex", texture)
end

function OnAvatarImage(texture, avatar, avatarMeshRenderer)
    -- https://documentation.abinteractive.net/cck/lua/examples/player-profile-picture/
    print("Received the Avatar Profile Image for avatar " .. avatar.AvatarID .. "! " .. tostring(texture))
    if texture == nil then
        print("Unfortunately it was nil :(")
        return
    end
    -- Get the current material on the meshrenderer and set the texture
    -- The material SetTexture requires a Texture instance, and not Texture2D
    -- which is why we called GetProfileImage with the second arg true, so the
    -- texture is returned as a Texture instead of Texture2D
    local materialInstance = avatarMeshRenderer.material
    materialInstance.SetTexture("_MainTex", texture)
end

function InitedProfilePic()
    -- https://docs.unity3d.com/ScriptReference/Material.SetTexture.html
    -- https://discord.com/channels/410126604237406209/1240763673346183279/1267338517990871110 coconut capybara
    -- https://documentation.abinteractive.net/cck/lua/examples/player-profile-picture/
    local player = PlayerAPI.LocalPlayer

    if profilePictureQuadCompo then
        player.RequestProfileImage(function(texture)
            OnPlayerProfileImage(texture, player, profilePictureQuadCompo)
        end, true)
    else
    
    end
end

function UpdateInstallSay()
    sayPlayersFuzzy = ''
    luaStatusSay = ''

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
    -- if PlayerAPI.LocalPlayer.IsFlightAllowed then
    --     flyAllowed = ""
    -- else
    --     flyAllowed = "NoFlying"
    -- end

    -- statuses
    if RunningOnServer then
        runsOnSay[1] = "Server"
    else
        runsOnSay[1] = ""
    end
    if RunningOnClient then
        runsOnSay[2] = "Client"
    else
        runsOnSay[2] = ""
    end
    if RunningInAvatar then
        runsOnSay[3] = "Avatar"
    else
        runsOnSay[3] = ""
    end
    if RunningInProp then
        runsOnSay[4] = "Prop"
    else
        runsOnSay[4] = ""
    end
    if RunningInWorld then
        runsOnSay[5] = "World"
    else
        runsOnSay[5] = ""
    end

    if IsWornByMe then
        runsOnSay[6] = "WornByMe"
    else
        runsOnSay[6] = ""
    end
    if IsSpawnedByMe then
        runsOnSay[7] = "SpawnedByMe"
    else
        runsOnSay[7] = ""
    end

    -- assemble the say!
    for i = 1, #runsOnSay do
        luaStatusSay = luaStatusSay .. " " .. runsOnSay[i]
    end

    sdrawGravitySay = 'Gravity Pos SDraw: <color=red>X = ' .. GetCVRGravityDirection(true).x .. '</color>; <color=green>Y = ' .. GetCVRGravityDirection(true).y .. '</color>; <color=blue>Z = ' .. GetCVRGravityDirection(true).z .. '</color>\nGravity Pos PhysInfluencer: <color=red>X = ' .. GetCVRGravityDirection(false).x .. '</color>; <color=green>Y = ' .. GetCVRGravityDirection(false).y .. '</color>; <color=blue>Z = ' .. GetCVRGravityDirection(false).z .. '</color>'
    -- listen up codeium, are you oke? you forgot to `..`.

    ruleSays = ''
    ruleSays = ruleSays .. flyAllowed .. ' '

    installSay = title .. "\n" .. selectQuote .. "\n" .. "World: " .. InstancesAPI.InstanceName .. "(" .. InstancesAPI.InstancePrivacy .. ")\n" .. "Rules: " .. ruleSays .. "\n" .. "Status: " .. luaStatusSay .. "\n" .. "Connection: " .. areWeOnline .. " (" .. InstancesAPI.Ping .. " ms)\n" .. sayWelcomeHome .. "\n" .. sdrawGravitySay .. "\n" .. "Players (" .. playerCount .. "):\n" .. sayPlayersFuzzy .. "\n\nWho Left: " .. whoLeft .. "\n\nRandom Int Test: " .. randomIntSay .. "\n Avatar Last Event: " .. lastAvatarLoadEventSay .. "\n\n"
end

-- Start is called before the first frame update
function Start()
    print('Starta')
    -- UnityEngine = require("UnityEngine")
    -- firstly, init random seed! Documentation Funny Cube example!
    -- math.randomseed(UnityEngine.Time.time)


    print "Hello world!"
    -- ownSelf = BoundObjects.OwnSelf
    spounThingy = BoundObjects.Spoun
    yikYukThingy = BoundObjects.IyakYikYuk
    tmpThingy = BoundObjects.Titler
    profilePictureQuad = BoundObjects.ProfilePic
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
    if tmpTextItself then
        tmpTextItself.text = 'HEy Hey Hey'
    else
        print('AH PECK NECK NO TMP!')
    end
    print('huhu')

    -- profile pic
    if profilePictureQuad then
        -- profilePictureQuad.material.mainTexture = Network.GetAvatarTexture
        profilePictureQuadCompo = profilePictureQuad:GetComponent("UnityEngine.Renderer")
        print('Pls obtain profile pic')
        if profilePictureQuadCompo then
            print('profile pic compo ok')
            profilePictureQuadCompo.material.EnableKeyword("_MainTex")
        else
            print('profile pic compo faile')
        end
    else
        print('profile pic quad gone')
    end
    InitedProfilePic()

    RandomizeQuote()
end

-- Update is called once per frame
function Update()
    if not perInit then
        -- UnityEngine = require('UnityEngine')
        print(' latoid')
        perInit = true
    end

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

function LateUpdate()
    UpdateInstallSay()
end