--[[
    Pinball Agung Meeting Internal Script 2024-05-24
    Theoretical hypothesis.
    Context confidential to: close family of Kaorfa, DiceGlow members, & CEO of Pinball Agung
    Inquiry closed.

    by JOELwindows7  
    Perkedel Technologies
    Code: GNU GPL v3
    Assets: CC4.0-BY-SA
]]--

-- Profile keys in Blake2b
local prof0 = ''
local prof1 = {
    '',
}
local prof2 = {
    '',
}
local pState = 0 -- possible: -1, 0, 1, 2

-- Start is called before the first frame update
function Start()
    if(prof0 == blake2b.hash(string.byte({PlayerAPI.LocalPlayer.UserID},1,-1))) then
        pState = 2
    end

    -- if pState < 2 then
        for _, _p1 in ipairs(prof1) do
            -- if (_p1 == PlayerAPI.LocalPlayer.UserID) then
            if (_p1 == blake2b.hash(string.byte({PlayerAPI.LocalPlayer.UserID},1,-1))) then
                pState = 1
                break;
            end
        end
        for _, _p2 in ipairs(prof2) do
            -- if (_p1 == PlayerAPI.LocalPlayer.UserID) then
            if (_p2 == blake2b.hash(string.byte({PlayerAPI.LocalPlayer.UserID},1,-1))) then
                pState = -1
                break;
            end
        end
    -- end
end

-- Update is called once per frame
function Update()

end