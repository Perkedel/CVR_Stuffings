--[[
    Sigma Prism Car Controller

    Not RCC car controller script from YouTube Tutorial

    Sauce:
    - https://youtu.be/DU-yminXEX0?si=UDNW6FLV9YDvB8KH THERE YOU ARE!!
    - https://github.com/PrismYoutube/Unity-Car-Controller here.

    Ported by JOELwindows7
]]--
print('WHAT THE SIGMA')
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

-- Float
local horizontalInput
local verticalInput
local currentSteerAngle
local currentBreakForce -- brake force

-- Bool
local isBreaking -- is braking

-- BoundObjects
-- Settings
local motorForce = 50
local breakForce = 300
local maxSteerAngle = 40
local isAudioEnabled = true -- Codeium bonus

-- WheelColliders. Get components directly!
local frontLeftWheelCollider
local frontRightWheelCollider
local rearLeftWheelCollider
local rearRightWheelCollider
-- Wheels
local frontLeftWheelTransform
local frontRightWheelTransform
local rearLeftWheelTransform
local rearRightWheelTransform

function GetInput()

end

function HandleMotor()

end

function ApplyBreaking()

end

function HandleSteering()

end

-- Start is called before the first frame update
function Start()
    
end

-- Update is called once per frame
function Update()

end

function FixedUpdate()
    GetInput()
    HandleMotor()
    HandleSteering()
    UpdateWheels()
end