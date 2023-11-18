local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WorkSpace = game:GetService("Workspace")

local Remotes = ReplicatedStorage.Remotes

local PhysicalDungeons = WorkSpace:WaitForChild("PhysicalDungeons")
local Dungeons = {
    TutorialDungeon = PhysicalDungeons:WaitForChild("TutorialDungeon"),
    Fire = PhysicalDungeons:WaitForChild("Fire"),
    Water = PhysicalDungeons:WaitForChild("Water"),
    Air = PhysicalDungeons:WaitForChild("Air"),
    Geo = PhysicalDungeons:WaitForChild("Geo"),
    Neutral = PhysicalDungeons:WaitForChild("Neutral")
}


local function MovePlayer(player: Player, dungeonID: string)
    local playerModel = player.Character
    playerModel.HumanoidRootPart.CFrame = Dungeons[dungeonID].SpawnPoint.CFrame + Vector3.new(0, 3, 0)
end

Remotes.MovePlayerToDungeon.OnServerEvent:Connect(MovePlayer)