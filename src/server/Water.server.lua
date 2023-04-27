local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local Houses = require(ServerScriptService.Houses)
local Remotes = ReplicatedStorage.Remotes

local function UpdateTreeWaterTimer(player: Player, plotID: number)
	Manager.UpdateTreeWaterTimer(player, plotID)
end

local function UpdateTreeLevel(player: Player, plotID: number)
	local Evaluation = Manager.UpdateTreeLevel(player, plotID, 1)
	if Evaluation == "LEVEL" then 
		local plotObject = Houses.GetPlayerPlot(player, plotID)
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
