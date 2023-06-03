local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local Houses = require(ServerScriptService.Houses)
local FertilizerConfig = require(ReplicatedStorage.Configs.FertilizerConfig)

local Remotes = ReplicatedStorage.Remotes

local FERTLIZEAMOUNT = 1 

local function UpdateFertilizers(player: Player, amount: number, fertilizerType: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	if not profile.Data.Seeds[fertilizerType] then 
		print("The Seed " .. fertilizerType .. " does not exist ~~ Server")
		return 
	end

	if profile.Data.Coins < FertilizerConfig[fertilizerType].Price then 
		print("The player " .. player.Name .. " does not have enough coins ~~ Server")
		return 
	end

	Manager.AdjustCoins(player, -(amount * FertilizerConfig[fertilizerType].Price))
	Manager.AdjustFertilizer(player, amount, fertilizerType)
end

local function FertilizeTree(player: Player, plotID: string, fertilizerType: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	-- Server Side Sanity Checks
	if not profile.Data.Plots[plotID] then 
		print("This Plot " .. plotID .. " does not exist for player " .. player.Name .. " ~~ Server")
		return
	end

	if not profile.Data.Plots[plotID].Tree then 
		print("The Tree does not exist in this plot " .. plotID .. " ~~ Server")
		return
	end

	if not profile.Data.Fertilizers[fertilizerType] then 
		print("This fertlizer " .. fertilizerType .. " is Invalid")
		return
	end

	if profile.Data.Fertilizers[fertilizerType].Amount <= 0 then 
		print("This player ".. player.Name .. " does not have the Fertilizer " .. fertilizerType .. " ~~ Server" )
		return
	end

	Manager.AdjustFertilizer(player, -FERTLIZEAMOUNT, fertilizerType)
	local Evaluation = Manager.UpdateTreeLevel(player, plotID, profile.Data.Fertilizers[fertilizerType].Cycles)
	if Evaluation == "LEVEL" then 
		local plotObject = Houses.GetPlayerPlot(player, plotID)
		local tree = profile.Data.Plots[plotID].Tree.Name
		local treeLevel = profile.Data.Plots[plotID].Tree.CurrentLevel
		Manager.AdjustTreeIndex(player, tree, treeLevel)
		Houses.ChangeTreeModel(plotObject)
	end
end 

Remotes.FertilizeTree.OnServerEvent:Connect(FertilizeTree)
Remotes.UpdateOwnedFertilizers.OnServerEvent:Connect(UpdateFertilizers)
