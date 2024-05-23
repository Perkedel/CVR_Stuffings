--[[
    VRC Billiard attempt to port horribly
    Original Source: https://github.com/VRCBilliards/vrcbce2


    by JOELwindows7
    Perkedel Technologies
    Code: GNU GPL v3
    Assets: CC4.0-BY-SA
]]--

-- Pocket trigger colliders!!!
local holes = {
    BoundObjects.Hole0,
    BoundObjects.Hole1,
    BoundObjects.Hole2,
    BoundObjects.Hole3,
    BoundObjects.Hole4,
    BoundObjects.Hole5,
}
-- then insert all of the components!
local holesCompo = {}

function BallEnters(whichHole)

end

-- Start is called before the first frame update
function Start()
    for i = 1, #holes do
        if holes[i] then
            holesCompo[i] = holes[i].GetComponent("UnityEngine.Collider")
        end
    end

    -- wait a minute, the callback is per object!
end

-- Update is called once per frame
function Update()

end