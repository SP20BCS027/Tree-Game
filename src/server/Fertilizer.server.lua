local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local Houses = require(ServerScriptService.Houses)

local Remotes = ReplicatedStorage.Remotes

local function UpdateFertilizers(player: Player, amount: number, fertilizerType: string)
	Manager.AdjustFertilizer(player, amount, fertilizerType)
end

local function FertlizeTree(player: Player, plotID: string, amount: number)
	local Evaluation = Manager.UpdateTreeLevel(player, plotID, amount)
	if Evaluation == "LEVEL" then 
		local plotObject = Houses.GetPlayerPlot(player, plotID)
		Houses.ChangeTreeModel(plotObject)
	end
end 

Remotes.FertilizeTree.OnServerEvent:Connect(FertlizeTree)
Remotes.UpdateOwnedFertilizers.OnServerEvent:Connect(UpdateFertilizers)
