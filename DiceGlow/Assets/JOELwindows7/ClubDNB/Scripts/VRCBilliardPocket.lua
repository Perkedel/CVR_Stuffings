--[[
    VRC Billiard attempt to port horribly
    Original Source: https://github.com/VRCBilliards/vrcbce2
    This is for the pocket


    by JOELwindows7
    Perkedel Technologies
    Code: GNU GPL v3
    Assets: CC4.0-BY-SA
]]--

local ownPocket
local ownPocketCompo

function OnTriggerEnter(other)
    -- pls detect ball enter & call the master lua about it!
    -- BallEnters(other)
end

-- Start is called before the first frame update
function Start()
    -- pls assign this itself as bound
    ownPocket = BoundObjects.Pocket

    -- then insert self component
    if ownPocket then
        ownPocketCompo = ownPocket.GetComponent("UnityEngine.Collider")
    end
end

-- Update is called once per frame
function Update()

end