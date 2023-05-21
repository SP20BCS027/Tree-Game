local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes

local template = require(ReplicatedStorage.PlayerData.Template)
local Trees = require(ReplicatedStorage.Configs.TreeConfig)
local WaterCans = require(ReplicatedStorage.Configs.WaterCanConfig)
local Backpacks = require(ReplicatedStorage.Configs.BackpacksConfig)

local Manager = {}

Manager.Profiles = {}

function Manager.AdjustCoins(player: Player, amount: number)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.Coins += amount
	player.leaderstats.Coins.Value = profile.Data.Coins
	Remotes.UpdateCoins:FireClient(player, profile.Data.Coins)
end

function Manager.AdjustGems(player: Player)
	local profile = Manager.Profiles[player]
	if not profile then return end
end

function Manager.AdjustSeeds(player: Player, amount: number, seedType: string)	
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.Seeds[seedType].Amount += amount 
	Remotes.UpdateOwnedSeeds:FireClient(player, profile.Data.Seeds[seedType].Amount, seedType)
end

function Manager.AdjustFertilizer(player: Player, amount: number, fertilizerType: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	profile.Data.Fertilizers[fertilizerType].Amount += amount 
	Remotes.UpdateOwnedFertilizers:FireClient(player, profile.Data.Fertilizers[fertilizerType].Amount, fertilizerType)

end

function Manager.AdjustWater(player: Player)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.Water -= 1
	Remotes.UpdateWater:FireClient(player, profile.Data.Water)
end

function Manager.AdjustPlayerMoney(player:Player, plotID: number)
	local profile = Manager.Profiles[player]
	if not profile then return end

	if profile.Data.Money < profile.Data.EquippedBackpack.Capacity then 

		if profile.Data.Money + (profile.Data.Plots[plotID].Tree.MoneyGenerated * profile.Data.Plots[plotID].Tree.CurrentLevel) > profile.Data.EquippedBackpack.Capacity then
			profile.Data.Money = profile.Data.EquippedBackpack.Capacity
		else
			profile.Data.Money += profile.Data.Plots[plotID].Tree.MoneyGenerated * profile.Data.Plots[plotID].Tree.CurrentLevel 
		end	
		Remotes.UpdateMoney:FireClient(player, profile.Data.Money)
		return false
	else
		print("Backpack is Full!")
		return true
	end
end

function Manager.RefillWater(player: Player)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.Water = profile.Data.EquippedWaterCan.Capacity
	Remotes.RefillWater:FireClient(player)
end

function Manager.SellAllMoney(player: Player)
	local profile = Manager.Profiles[player]
	if not profile then return end

	profile.Data.Money = 0 
	Remotes.SellAllMoney:FireClient(player)
end

function Manager.AdjustPlotOccupation(player: Player, PlotId: number, isOccupied: boolean, treeToPlant: string)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.Plots[PlotId].Occupied = isOccupied
	profile.Data.Plots[PlotId].Tree = Trees[treeToPlant]
	profile.Data.Plots[PlotId].Tree.TimeUntilWater = os.time() + 20 
	
	Remotes.UpdateOccupied:FireClient(player, profile.Data.Plots[PlotId].Occupied, PlotId)
	Remotes.UpdateTree:FireClient(player, profile.Data.Plots[PlotId].Tree.TimeUntilWater, PlotId, treeToPlant)
end

function Manager.PurchasePlot(player: Player, plot: directory)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.Plots[plot.Id] = plot
	Remotes.UpdateOwnedPlots:FireClient(player, profile.Data.Plots)
end

function Manager.PurchaseWaterCan(player: Player, waterCanId: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	profile.Data.OwnedWaterCans[waterCanId] =  WaterCans[waterCanId]
	Remotes.UpdateOwnedWaterCans:FireClient(player, profile.Data.OwnedWaterCans)
end

function Manager.EquipWaterCan(player: Player, waterCanId: string)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.EquippedWaterCan = WaterCans[waterCanId]
	Remotes.ChangeEquippedWateringCan:FireClient(player, profile.Data.EquippedWaterCan)
end

function Manager.PurchaseBackpack(player: Player, backpackId: string)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.OwnedBackpacks[backpackId] =  Backpacks[backpackId]
	Remotes.UpdateOwnedBackpacks:FireClient(player, profile.Data.OwnedBackpacks)	
end

function Manager.EquipBackpack(player: Player, backpackId: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	profile.Data.EquippedBackpack = Backpacks[backpackId]
	Remotes.ChangeEquippedBackpack:FireClient(player, profile.Data.EquippedBackpack)
end

function Manager.UpdateTreeWaterTimer(player: Player, PlotId: number)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
<<<<<<< Updated upstream
	profile.Data.Plots[PlotId].Tree.TimeUntilWater = os.time() + 10
	Remotes.UpdateTreeWaterTimer:FireClient(player, profile.Data.Plots[PlotId].Tree.TimeUntilWater, PlotId)
=======
	profile.Data.Plots[plotID].Tree.TimeUntilWater = os.time() + profile.Data.Plots[plotID].Tree.TimeBetweenWater

	Remotes.UpdateTreeWaterTimer:FireClient(player, profile.Data.Plots[plotID].Tree.TimeUntilWater, plotID)
>>>>>>> Stashed changes
end

function Manager.UpdateTreeLevel(player: Player, PlotId: number, cycle: number)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	if profile.Data.Plots[PlotId].Tree.MaxCycle <= profile.Data.Plots[PlotId].Tree.CurrentCycle + cycle then
		profile.Data.Plots[PlotId].Tree.CurrentLevel = profile.Data.Plots[PlotId].Tree.CurrentLevel + 1 
		profile.Data.Plots[PlotId].Tree.MaxCycle = profile.Data.Plots[PlotId].Tree.MaxCycle + 1 
		profile.Data.Plots[PlotId].Tree.CurrentCycle = 0
		
<<<<<<< Updated upstream
		Remotes.UpdateTreeLevel:FireClient(player, "LEVEL", PlotId, cycle)
=======
		Remotes.UpdateTreeLevel:FireClient(player, plotID)
>>>>>>> Stashed changes
		return "LEVEL"
	else
		profile.Data.Plots[PlotId].Tree.CurrentCycle = profile.Data.Plots[PlotId].Tree.CurrentCycle + cycle
		
<<<<<<< Updated upstream
		Remotes.UpdateTreeLevel:FireClient(player, "CYCLE", PlotId, cycle)
=======
		Remotes.UpdateTreeLevel:FireClient(player, plotID, profile.Data.Plots[plotID].Tree)
>>>>>>> Stashed changes
		return "CYCLE"
	end
end

function Manager.UpdateTreeMoneyTimer(player: Player, plotID: number)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.Plots[plotID].Tree.TimeUntilMoney = os.time() + profile.Data.Plots[plotID].Tree.TimeBetweenMoney

	Remotes.UpdateTreeMoneyTimer:FireClient(player, profile.Data.Plots[plotID].Tree.TimeUntilMoney, plotID)
end

local function GetData(player: Player, directory: string)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	return profile.Data[directory]	
end

local function GetAllData(player: Player)
	local profile = Manager.Profiles[player]
	if not profile then return end

	return profile.Data
end

-- Client to Server Requests

Remotes.GetData.OnServerInvoke = GetData	
Remotes.GetAllData.OnServerInvoke = GetAllData

-- Here are some functions for the Commands 

function Manager.ToggleFirstPlot(player: Player, Toggle: boolean)
	local profile = Manager.Profiles[player]
	if not profile then return end

	profile.Data.Plots[1].Occupied = Toggle
end

function Manager.ResetAllData(player: Player)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	Manager.Profiles[player].Data = template
	player.leaderstats.Coins.Value = profile.Data.Coins
	player.leaderstats.Gems.Value = profile.Data.Gems 
	Remotes.ResetData:FireClient(player)
end

return Manager
