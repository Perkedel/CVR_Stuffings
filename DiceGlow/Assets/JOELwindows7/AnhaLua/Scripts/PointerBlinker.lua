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

function Refresh()
    if animCompo then
        animCompo.SetBool('Blink',not animCompo.GetBool('Blink'))
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