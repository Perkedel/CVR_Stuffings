-- help
--[[
    https://documentation.abinteractive.net/cck/lua/hello-world/
    https://github.com/NotAKidOnSteam/NAK_CVR_Prefabs/blob/main/LuaExamples/CubeFactory/Script/CubeFactory.lua
]]--
-- JOELwindows7
UnityEngine = require("UnityEngine")
TMP = require("TextMeshPro")

local isSpun = false
local spounThingy
local yikYukThingy
local tmpThingy
local angle = 0
local toMoveAt = 0
local isBacking = false
local velocity = 5
local title = 'Halo Lua from JOELwindows7'
local installSay = ''
local sayWelcomeHome = ''

-- Start is called before the first frame update
function Start()
    spounThingy = BoundObjects.Spoun
    yikYukThingy = BoundObjects.IyakYikYuk
    tmpThingy = BoundObjects.Titler
    print "Hello world!"
end

-- Update is called once per frame
function Update()
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

    installSay = title .. "\n" .. "Ping: " .. InstancesAPI.Ping .. "\n" .. sayWelcomeHome .. "\n"
    -- tmpThingy.gameObject.TMP_Text.text = installSay

    -- spounThingy.transform.Rotate(0,angle,0)
    spounThingy.transform.localRotation = UnityEngine.Quaternion.Euler(UnityEngine.NewVector3(0,angle,0))
    yikYukThingy.transform.localPosition = UnityEngine.NewVector3(.75,toMoveAt,0)
end