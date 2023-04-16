local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local Houses = require(ServerScriptService.Houses)
local Remotes = ReplicatedStorage.Remotes

local function UpdateTreeWaterTimer(player: Player, plotId: number)
	Manager.UpdateTreeWaterTimer(player, plotId)
end

local function UpdateTreeLevel(player: Player, plotId: number)
	local Evaluation = Manager.UpdateTreeLevel(player, plotId, 1)
	if Evaluation == "LEVEL" then 
		local plotObject = Houses.GetPlayerPlot(player, plotId)
		Houses.ChangeTreeModel(plotObject)
	end
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
