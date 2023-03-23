local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)

local Remotes = ReplicatedStorage.Remotes

local function UpdateTreeWaterTimer(player: Player, plotId: number)
	Manager.UpdateTreeWaterTimer(player, plotId)
end

local function UpdateTreeLevel(player: Player, plotId: number)
	Manager.UpdateTreeLevel(player, plotId)
end

local function RefillWater(player: Player)
	Manager.RefillWater(player)
end

local function DeductWater(player: Player)
	Manager.AdjustWater(player)
end

Remotes.UpdateTreeWaterTimer.OnServerEvent:Connect(UpdateTreeWaterTimer)
Remotes.UpdateTreeLevel.OnServerEvent:Connect(UpdateTreeLevel)
Remotes.RefillWater.OnServerEvent:Connect(RefillWater)
Remotes.UpdateWater.OnServerEvent:Connect(DeductWater)
