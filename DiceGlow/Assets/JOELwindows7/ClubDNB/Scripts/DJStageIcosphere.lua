--[[
    DJ Stage Icosphere Icoverse

    DJ Stage for Icoverse world.

    Inspiration Sauce:
    - theparkbench. Gravity Club

    by JOELwindows7  
    Perkedel Technoologies  
    Code: GNU GPL v3
    Assets: CC4.0-BY-SA
]]--

print('HALO DJSTAGEICOVERSE')

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

local spinThis
local consectoInno
local consectoOutto

function BananasRotatE()
    if spinThis then
        spinThis.transform.Rotate(UnityEngine.NewVector3(0.0,1*UnityEngine.Time.deltaTime,0.0))
    end
    if consectoInno then
        consectoInno.transform.Rotate(-1.5*UnityEngine.Time.deltaTime,0,0.0)
    end
    if consectoOutto then
        consectoOutto.transform.Rotate(1.5*UnityEngine.Time.deltaTime,0,0.0)
    end
end

-- Start is called before the first frame update
function Start()
    spinThis = BoundObjects.ToSpin
    consectoInno = BoundObjects.ConsectoInno
    consectoOutto = BoundObjects.ConsectoOutto
    print('HAIAIAIAIAI')
end

-- Update is called once per frame
function Update()
    
end

function LateUpdate()
    --BananasRotatE()
end