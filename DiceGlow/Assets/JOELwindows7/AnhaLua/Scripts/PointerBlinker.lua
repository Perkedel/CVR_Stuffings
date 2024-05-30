--[[
    Pointer Blinker

    Just an index finger pointer but it blinks rapidly

    by JOELwindows7
    Perkedel Technologies
    Code: GNU GPL v3
    Assets: CC4.0-BY-SA
]]--
UnityEngine = require("UnityEngine")
CCK = require("ABI.CCK")

local ownSelf = BoundObjects.OwnSelf
local pointer = BoundObjects.PointerBeBlink
local animCompo
-- local blinkMode = false

function OnMouseDown()
    -- blinkMode = not blinkMode
    if animCompo then
        animCompo.SetBool('BlinkMode', not animCompo.GetBool('BlinkMode'))
    end
end

function Refresh()
    if animCompo then
        if animCompo.GetBool('BlinkMode') then
            animCompo.SetBool('Blink',not animCompo.GetBool('Blink'))
        else
            animCompo.SetBool('Blink',true)
        end
        if pointer then
            pointer:SetActive(animCompo.GetBool('Blink'))
        end
    end
end

-- Start is called before the first frame update
function Start()
    animCompo = gameObject.GetComponentInParent("UnityEngine.Animator")
end

-- Update is called once per frame
function Update()
    Refresh() -- This time, realtime refresh!
end