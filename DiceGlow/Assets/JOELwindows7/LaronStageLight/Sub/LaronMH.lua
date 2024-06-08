--[[ 
    Laron Stage Light P7-K Moving Head

    Script for this stage light thingy!

    whawawawawwawa

    by JOELwindows7  
    Perkedel Technologies  
    Code: GNU GPL v3
    Assets: CC4.0-BY-SA
]]--
CVR = require('CVR')
CCK = require('CVR.CCK')
Network = require('CVR.Network')
UnityEngine = require("UnityEngine")
UnityUI = require("UnityEngine.UI")
TMP = require("TextMeshPro")
System = require('System')
RCC = require("RCC")

local statusText = BoundObjects.StatusTexter
local statusTextCompo
local animCompo
local poseLabel = {
    'T-POSE',
    'SWING',
    'NGANGGUK',
    'GELENG',
    'MUTER',
}

local firmwareVersion = '2024.06'
local totalAboutSay = ''

function AdjustYaw(toAngle)

end

function AdjustPitch(toAngle)

end

function WriteAbout()
    totalAboutSay = ''

    
    if animCompo then
        -- @region Unit off
        if animCompo.GetFloat('isOn') < .5 then
            if animCompo.GetFloat('isReady') < .5 then
                -- totalAboutSay = totalAboutSay .. 'SHUTTING DOWN!\n'
                totalAboutSay = totalAboutSay .. '<color=red>POWER OFF!</color>\n'
            else
                -- totalAboutSay = totalAboutSay .. 'POWER OFF! \n'
            end
            
        else
            if animCompo.GetFloat('isReady') < .5 then
                totalAboutSay = totalAboutSay .. '<color=yellow>PLS WAIT!</color>\n'
            else
                if animCompo.GetFloat('selectPose') > .5 then
                    totalAboutSay = totalAboutSay .. '<color=green>POSE MODE: ' .. poseLabel[math.floor(animCompo.GetFloat('selectPose'))] .. '</color>\n'
                else
                    totalAboutSay = totalAboutSay .. '<color=green>OK!</color>\n'
                end
            end
        end
        -- @endregion

        totalAboutSay = totalAboutSay .. 'YAW (X DEG): ' .. tostring(animCompo.GetFloat('yaw')) .. '\nPITCH (Y DEG): ' .. tostring(animCompo.GetFloat('pitch')) .. '\nCOLOR (RGB): \n\t<color=red>R</color> = ' .. tostring(animCompo.GetFloat('red')) .. '\n\t<color=green>G</color> = ' .. tostring(animCompo.GetFloat('green')) .. '</color>\n\t<color=blue>B</color> = ' .. tostring(animCompo.GetFloat('blue')) .. '\n'
    end

    -- TODO: System DateTime Now
    -- TODO: Upside down UI mode

    -- random word
    if IsSpawnedByMe then
        totalAboutSay = totalAboutSay .. 'Use Chataigne to control! \n'
    else
        totalAboutSay = totalAboutSay .. 'Ask who spawned OR spawn this yourself! \n'
    end

    -- firmware
    totalAboutSay = totalAboutSay .. '\n\n\nFirmware: Ver ' .. firmwareVersion

    if statusTextCompo then
        statusTextCompo.text = totalAboutSay
    end
end

-- Start is called before the first frame update
function Start()
    if statusText then
        statusTextCompo = statusText.GetComponent("TMPro.TMP_Text")
    end
    animCompo = gameObject.GetComponentInParent("UnityEngine.Animator") -- Shin's technique
end

-- Update is called once per frame
function Update()
    
end

function LateUpdate()
    WriteAbout()
end