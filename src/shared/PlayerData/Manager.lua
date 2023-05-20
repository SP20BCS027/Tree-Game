local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes

local Template = require(ReplicatedStorage.PlayerData.Template)
local TreeConfig = require(ReplicatedStorage.Configs.TreeConfig)
local WaterCanConfig = require(ReplicatedStorage.Configs.WaterCanConfig)
local BackpacksConfig = require(ReplicatedStorage.Configs.BackpacksConfig)
local AchievementInfoConfig = require(ReplicatedStorage.Configs.AchievementInfoConfig)

local Manager = {}

Manager.Profiles = {}

-- When this function is called the player's amount of coins get updated 

function Manager.AdjustCoins(player: Player, amount: number)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.Coins += amount
	player.leaderstats.Coins.Value = profile.Data.Coins
	Remotes.UpdateCoins:FireClient(player, profile.Data.Coins)
end

-- When this function gets called the player's amount of gems gets updated 

function Manager.AdjustGems(player: Player, amount: number)
	local profile = Manager.Profiles[player]
	if not profile then return end

	profile.Data.Gems += amount
	player.leaderstats.Gems.Value = profile.Data.Gems
	Remotes.UpdateGems:FireClient(player, profile.Data.Gems)
end

-- When this function gets called the chosen SeedType is updated

function Manager.AdjustSeeds(player: Player, amount: number, seedType: string)	
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.Seeds[seedType].Amount += amount 
	Remotes.UpdateOwnedSeeds:FireClient(player, profile.Data.Seeds[seedType].Amount, seedType)
end

--When this function gets called the chosen Fertilizer gets updated

function Manager.AdjustFertilizer(player: Player, amount: number, fertilizerType: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	profile.Data.Fertilizers[fertilizerType].Amount += amount 
	Remotes.UpdateOwnedFertilizers:FireClient(player, profile.Data.Fertilizers[fertilizerType].Amount, fertilizerType)
end

-- When this function gets the water in Player's backpack gets deducted 

function Manager.AdjustWater(player: Player, amount: number?)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	amount = if amount then amount else 1

	profile.Data.Water -= amount
	Remotes.UpdateWater:FireClient(player, profile.Data.Water)
end

-- When this function gets called Player's Money in backpack gets updated

function Manager.AdjustPlayerMoney(player:Player, plotID: number): boolean
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

-- When this function gets Called the player's Watering Can gets refilled

function Manager.RefillWater(player: Player)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.Water = profile.Data.EquippedWaterCan.Capacity
	Remotes.RefillWater:FireClient(player)
end

-- When this function gets called the player's money in the backpack gets sold and converted into Coins

function Manager.SellAllMoney(player: Player)
	local profile = Manager.Profiles[player]
	if not profile then return end

	profile.Data.Money = 0 
	Remotes.SellAllMoney:FireClient(player)
end

-- When this function gets called the player's Plot Status gets updated and a Tree is assigned to the plots data 

function Manager.AdjustPlotOccupation(player: Player, PlotID: number, isOccupied: boolean, treeToPlant: string)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.Plots[PlotID].Occupied = isOccupied
	profile.Data.Plots[PlotID].Tree = TreeConfig[treeToPlant]
	profile.Data.Plots[PlotID].Tree.TimeUntilWater = os.time() + 20 
	
	Remotes.UpdateOccupied:FireClient(player, profile.Data.Plots[PlotID].Occupied, PlotID)
	Remotes.UpdateTree:FireClient(player, profile.Data.Plots[PlotID].Tree.TimeUntilWater, PlotID, treeToPlant)
end

-- When this function gets called the plot is added to the owned plots of the player. 

function Manager.PurchasePlot(player: Player, plot: directory)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.Plots[plot.Id] = plot
	Remotes.UpdateOwnedPlots:FireClient(player, profile.Data.Plots)
end

-- When this function gets called the player buys the watering can and their inventory gets updated

function Manager.PurchaseWaterCan(player: Player, waterCanID: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	profile.Data.OwnedWaterCans[waterCanID] =  WaterCanConfig[waterCanID]
	Remotes.UpdateOwnedWaterCans:FireClient(player, profile.Data.OwnedWaterCans)
end

-- When this function gets called the currently Equipped Watering Can is changed 

function Manager.EquipWaterCan(player: Player, waterCanID: string)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.EquippedWaterCan = WaterCanConfig[waterCanID]
	Remotes.ChangeEquippedWateringCan:FireClient(player, profile.Data.EquippedWaterCan)
end

-- When this function gets called the player buys the Backpack and their inventory gets updated

function Manager.PurchaseBackpack(player: Player, backpackID: string)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.OwnedBackpacks[backpackID] = BackpacksConfig[backpackID]
	Remotes.UpdateOwnedBackpacks:FireClient(player, profile.Data.OwnedBackpacks)	
end

-- When this function gets called the currently Equipped Backpack is changed 

function Manager.EquipBackpack(player: Player, backpackID: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	profile.Data.EquippedBackpack = BackpacksConfig[backpackID]
	Remotes.ChangeEquippedBackpack:FireClient(player, profile.Data.EquippedBackpack)
end

-- When this function gets called the Tree of the Plot gets Yeeted

function Manager.DeleteTree(player: Player, plotID: number)
	local profile = Manager.Profiles[player]
	if not profile then return end

	profile.Data.Plots[plotID].Occupied = false
	profile.Data.Plots[plotID].Tree = nil
	Remotes.DeleteTree:FireClient(player, profile.Data.Plots)
end

-- When this function gets called the Water Timer of the tree get updated 

function Manager.UpdateTreeWaterTimer(player: Player, plotID: number)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.Plots[plotID].Tree.TimeUntilWater = os.time() + 10
	Remotes.UpdateTreeWaterTimer:FireClient(player, profile.Data.Plots[plotID].Tree.TimeUntilWater, plotID)
end

-- When this function gets Called The Tree's Level or Cycle is Changed 

function Manager.UpdateTreeLevel(player: Player, plotID: number, cycle: number): string
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	if profile.Data.Plots[plotID].Tree.MaxCycle <= profile.Data.Plots[plotID].Tree.CurrentCycle + cycle then
		profile.Data.Plots[plotID].Tree.CurrentLevel = profile.Data.Plots[plotID].Tree.CurrentLevel + 1 
		profile.Data.Plots[plotID].Tree.MaxCycle = profile.Data.Plots[plotID].Tree.MaxCycle + 1 
		profile.Data.Plots[plotID].Tree.CurrentCycle = 0
		
		Remotes.UpdateTreeLevel:FireClient(player, "LEVEL", plotID, cycle)
		return "LEVEL"
	else
		profile.Data.Plots[plotID].Tree.CurrentCycle = profile.Data.Plots[plotID].Tree.CurrentCycle + cycle
		
		Remotes.UpdateTreeLevel:FireClient(player, "CYCLE", plotID, cycle)
		return "CYCLE"
	end
end

-- When this function gets called the Tree's Money timer gets reset 

function Manager.UpdateTreeMoneyTimer(player: Player, plotID: number)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.Plots[plotID].Tree.TimeUntilMoney = os.time() + 20

	Remotes.UpdateTreeMoneyTimer:FireClient(player, profile.Data.Plots[plotID].Tree.TimeUntilMoney, plotID)
end

function Manager.UpdateAchievements(player: Player, achievementType: string, amount: number)
	local profile = Manager.Profiles[player]
	if not profile then return end

	profile.Data.Achievements[achievementType].AmountAchieved += amount

	if profile.Data.Achievements[achievementType].AmountAchieved >= profile.Data.Achievements[achievementType].AmountToAchieve then
		profile.Data.Achievements[achievementType].CurrentAchievementNo += 1
		profile.Data.Achievements[achievementType].AmountToAchieve = AchievementInfoConfig[achievementType][profile.Data.Achievements[achievementType].CurrentAchievementNo]
	end

	Remotes.UpdateAchievements:FireClient(player, profile.Data.Achievements)
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- This function is used to get a specific directory of Data of the player 

local function GetData(player: Player, directory: string)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	return profile.Data[directory]	
end

-- This function is used to get all the Data of the player 

local function GetAllData(player: Player)
	local profile = Manager.Profiles[player]
	if not profile then return end

	return profile.Data
end

-- Client to Server Requests

Remotes.GetData.OnServerInvoke = GetData	
Remotes.GetAllData.OnServerInvoke = GetAllData

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Here are some functions for the Commands 

-- This function Resets all the player Data back to the Default Template  

function Manager.ResetAllData(player: Player)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	Manager.Profiles[player].Data = Template
	player.leaderstats.Coins.Value = profile.Data.Coins
	player.leaderstats.Gems.Value = profile.Data.Gems 
	Remotes.ResetData:FireClient(player)
end

function Manager.FillupBackpack(player: Player)
	local profile = Manager.Profiles[player]
	if not profile then return end

	profile.Data.Money = profile.Data.EquippedBackpack.Capacity	
	Remotes.FillupBackpack:FireClient(player)
end

return Manager
