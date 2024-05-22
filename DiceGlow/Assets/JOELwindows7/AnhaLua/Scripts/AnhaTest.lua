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

local isSpun = false
local spounThingy
local yikYukThingy
local tmpThingy
local tmpTextItself
local tmThingy
local tmTextItself
local angle = 0
local toMoveAt = 0
local isBacking = false
local velocity = 5
local title = 'Halo Lua from JOELwindows7\nAlso thancc LensError for example snippet how to UnityEngine.UI.Text'
local installSay = ''
local sayWelcomeHome = ''
local sayPlayersFuzzy = ''
local playerCount = 0
local playersYouHave = {}
local areWeOnline = 'No'

-- Start is called before the first frame update
function Start()
    print "Hello world!"
    spounThingy = BoundObjects.Spoun
    yikYukThingy = BoundObjects.IyakYikYuk
    tmpThingy = BoundObjects.Titler
    -- tmpTextItself = tmpThingy.GetComponent(TMP)
    -- tmpTextItself = tmpThingy:GetComponent("TextMeshPro.TMP")
    tmThingy = BoundObjects.TitlerOld
    if not tmThingy then
        print('WERROR! tmThingy not bounded!!!')
    else
        print('Obtain component')
        -- tmTextItself = tmThingy.GetComponent(TM)
        -- tmTextItself = tmThingy:GetComponent("UnityEngine.TextMesh")
        tmTextItself = tmThingy.GetComponent("UnityEngine.UI.Text")
    end

    installSay = title .. "\n" .. "Ping: " .. InstancesAPI.Ping .. "\n" .. sayWelcomeHome .. "\n"

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
end

-- Update is called once per frame
function Update()
    -- Sorry, Codeium is also here.
    if InstancesAPI.IsConnected then
        areWeOnline = "yes"
    else
        areWeOnline = "no"
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

    installSay = title .. "\n" .. "World: " .. InstancesAPI.InstanceName .. "(" .. InstancesAPI.InstancePrivacy .. ")\n" .. "Connection: " .. areWeOnline .. "(" .. InstancesAPI.Ping .. " ms)\n" .. sayWelcomeHome .. "\n" .. "Players (" .. playerCount .. "):\n" .. sayPlayersFuzzy
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