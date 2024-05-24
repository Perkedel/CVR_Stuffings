UnityEngine = require("UnityEngine")

-- Debug --

DEBUG_MODE = false

local function DebugPrint(message)
    if DEBUG_MODE then
        print(message)
    end
end

-- ObjectPool --

local ObjectPool = {
    pool = {},
    prefab = nil,
    parent = nil
}

function ObjectPool:Initialize(prefab, parent, initialSize)

    DebugPrint("Initializing ObjectPool")

    self.prefab = prefab
    self.parent = parent or nil

    for i = 1, initialSize do
        local obj = self:CreateNewObject()
        table.insert(self.pool, obj)
    end

    DebugPrint("ObjectPool initialized with " .. initialSize .. " objects")
end

function ObjectPool:CreateNewObject()

    DebugPrint("Creating new object")

    local obj = UnityEngine.GameObject.Instantiate(self.prefab, self.parent) -- BUG: Instantiation parent is not functioning, will just dirty scene
    -- obj.transform.parent = self.parent -- fuck
    -- obj.transform.SetParent(self.parent) -- fuck 2
    -- obj.transform.SetParent(transform) -- function call doesn't match any overload
    -- obj.transform.parent = transform --  cannot convert a userdata to a clr type UnityEngine.Transform
    -- obj.transform.SetParent(transform, true) -- function call doesn't match any overload
    -- BUG: literally anything to do with parent is busted -_-
    obj:SetActive(false)
    return obj
end

function ObjectPool:GetCube()

    if #self.pool > 0 then
        DebugPrint("Getting cube from pool")
        return table.remove(self.pool)
    else
        DebugPrint("Pool is empty, creating new cube")
        return self:CreateNewObject()
    end
end

function ObjectPool:ReturnCube(obj)

    DebugPrint("Returning cube to pool")

    obj:SetActive(false)
    table.insert(self.pool, obj)
end

-- PlayerManager --

local PlayerManager = {
    currentCount = 0,
    playerCubes = {},
    playerEntries = {}
}

function PlayerManager:CheckForPlayerChanges()

    DebugPrint("Checking for player changes")

    local currentCount = PlayerAPI.PlayerCount

    -- check for player joins
    if currentCount > self.currentCount then
        local currentPlayers = PlayerAPI.AllPlayers
        for _, player in ipairs(currentPlayers) do
            if not self.playerCubes[player.UserID] then
                DebugPrint("New player detected: " .. player.Username)
                self:HandlePlayerJoin(player)
            end
        end
    -- check for player leaves
    elseif currentCount < self.currentCount then
        local currentPlayers = PlayerAPI.AllPlayers
        for userId, cube in pairs(self.playerCubes) do
            local playerExists = false
            for _, player in ipairs(currentPlayers) do
                if player.UserID == userId then
                    playerExists = true
                    break
                end
            end
            if not playerExists then
                DebugPrint("Player left: " .. userId)
                self:HandlePlayerLeave(userId)
            end
        end
    end

    self.currentCount = currentCount
end

function PlayerManager:HandlePlayerJoin(player)

    DebugPrint("Handling player join: " .. player.Username)

    local cube = ObjectPool:GetCube()
    cube:SetActive(true)

    self.playerCubes[player.UserID] = cube
    self.playerEntries[player.UserID] = player
    DebugPrint("Cube associated with player: " .. player.Username)
end

function PlayerManager:HandlePlayerLeave(userId)

    DebugPrint("Handling player leave: " .. userId)

    local cube = self.playerCubes[userId]
    if cube then
        cube:SetActive(false)
        ObjectPool:ReturnCube(cube)
        self.playerCubes[userId] = nil
        self.playerEntries[userId] = nil
        DebugPrint("Cube returned to pool for player: " .. userId)
    end
end

-- Unity Events --

function Start()

    local prefab = BoundObjects.CubePrefab
    local factoryParent = BoundObjects.CubeFactory
    if not prefab or factoryParent then
        print("Error! You have not bound CubePrefab and/or CubeFactory.")
    end

    DebugPrint("Start function called")
    ObjectPool:Initialize(prefab, factoryParent, 4) -- instantiate 4 cubes by default
    PlayerManager:CheckForPlayerChanges() -- manually checking player count changes because exposed actions are fucked atm
end

function Update() -- we need a callback for after netik & local ik -_-

    PlayerManager:CheckForPlayerChanges()

    for userId, cube in pairs(PlayerManager.playerCubes) do
        local player = PlayerManager.playerEntries[userId]
        if player then
            local nameplatePos = player:GetViewPointPosition()
            local nameplateRot = player:GetRotation()
            local nameplateMod = player.Avatar.Height / 1.6 -- default avatar height

            -- offset plate locally upward (accounting for gravity)
            local offset = nameplateRot * UnityEngine.NewVector3(0, 1 * nameplateMod, 0)

            cube.transform.SetPositionAndRotation(nameplatePos + offset, nameplateRot)
            DebugPrint("Updated cube position for player: " .. player.Username)
        end
    end
end