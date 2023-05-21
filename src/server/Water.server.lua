local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local Houses = require(ServerScriptService.Houses)
local Remotes = ReplicatedStorage.Remotes

local WATERCYCLE = 1

local function UpdateTreeWaterTimerAndTreeLevel(player: Player, plotID: number)
	local profile = Manager.Profiles[player]
	if not profile then return end

	if profile.Data.Water <= 0 then 
		print("The Player " .. player .. " does not have water ~~ Server")
		return
	end 

	if profile.Data.Plots[plotID].Tree.TimeUntilWater < os.time() then 
		Manager.UpdateTreeWaterTimer(player, plotID)

		local Evaluation = Manager.UpdateTreeLevel(player, plotID, WATERCYCLE)
		if Evaluation == "LEVEL" then 
			local plotObject = Houses.GetPlayerPlot(player, plotID)
			Houses.ChangeTreeModel(plotObject)
		end
		Manager.AdjustWater(player)
	end
end

local function RefillWater(player: Player)
	Manager.RefillWater(player)
end

Remotes.UpdateTreeWaterTimer.OnServerEvent:Connect(UpdateTreeWaterTimerAndTreeLevel)
Remotes.RefillWater.OnServerEvent:Connect(RefillWater)
