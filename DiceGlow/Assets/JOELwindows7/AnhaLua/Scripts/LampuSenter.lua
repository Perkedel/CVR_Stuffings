--[[
    Lampu Senter

    Just a Lua script toggling flash light

    by JOELwindows7
    Perkedel Technologies
    Code: GNU GPL v3
    Assets: CC4.0-BY-SA
]]--
UnityEngine = require("UnityEngine")
CCK = require("ABI.CCK")

local ownSelf = BoundObjects.OwnSelf
local lamp = BoundObjects.Lampu
local visualLamp = BoundObjects.VisualIndicate
local buttonVisualize = {
    BoundObjects.ButtonOff,
    BoundObjects.ButtonOn,
}
local luaDisableWarn = BoundObjects.LuaDisableWarn
local animCompo = nil
local refreshRate = .1
local refreshRemains = .1

function Refresh()
    -- TODO: PLS USE SPAWNABLE VALUE INSTEAD! PLS GET VALUE WHYN'T WORK?!?!??!?!?!??!
    if animCompo then
        -- Codeium tries to be smart!
        if visualLamp then
            visualLamp:SetActive(animCompo.GetBool('Toggle'))
        end
        if lamp then
            lamp:SetActive(animCompo.GetBool('Toggle'))
        end
        if buttonVisualize[1] then
            buttonVisualize[1]:SetActive(not animCompo.GetBool('Toggle'))
        end
        if buttonVisualize[2] then
            buttonVisualize[2]:SetActive(animCompo.GetBool('Toggle'))
        end
    end
end

function OnMouseDown()
    if animCompo then
        animCompo.SetBool('Toggle', not animCompo.GetBool('Toggle'))
    end
end

-- Start is called before the first frame update
function Start()
    math.randomseed(UnityEngine.Time.time)

    -- @type UnityEngine.Animator
    animCompo = gameObject.GetComponentInParent("UnityEngine.Animator")

    if ownSelf then
        print('obtain self')
        -- animCompo = ownSelf:GetComponent("UnityEngine.Animator")
    end

    if luaDisableWarn then
        luaDisableWarn:SetActive(false)
    end
end

-- Update is called once per frame
function Update()

end

function LateUpdate()
    refreshRemains = refreshRemains - UnityEngine.Time.deltaTime
    if refreshRemains <= 0 then
        refreshRemains = refreshRate
        Refresh()
    end
end