local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes

local Template = require(ReplicatedStorage.PlayerData.Template)
local TreeConfig = require(ReplicatedStorage.Configs.TreeConfig)
local WaterCanConfig = require(ReplicatedStorage.Configs.WaterCanConfig)
local BackpacksConfig = require(ReplicatedStorage.Configs.BackpacksConfig)
local WeaponsConfig = require(ReplicatedStorage.Configs.WeaponsConfig)
local AchievementInfoConfig = require(ReplicatedStorage.Configs.AchievementInfoConfig)

local Manager = {}

Manager.Profiles = {}

-- When this function is called, the player's amount of coins gets updated
function Manager.AdjustCoins(player: Player, amount: number)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.Coins += amount
	player.leaderstats.Coins.Value = profile.Data.Coins
	Remotes.UpdateCoins:FireClient(player, profile.Data.Coins)
end

-- When this function is called, the player's amount of gems gets updated
function Manager.AdjustGems(player: Player, amount: number)
	local profile = Manager.Profiles[player]
	if not profile then return end

	profile.Data.Gems += amount
	player.leaderstats.Gems.Value = profile.Data.Gems
	Remotes.UpdateGems:FireClient(player, profile.Data.Gems)
end

-- When this function is called, the chosen SeedType is updated
function Manager.AdjustSeeds(player: Player, amount: number, seedType: string)	
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.Seeds[seedType].Amount += amount 
	Remotes.UpdateOwnedSeeds:FireClient(player, profile.Data.Seeds[seedType].Amount, seedType)
end

-- When this function is called, the chosen Fertilizer gets updated
function Manager.AdjustFertilizer(player: Player, amount: number, fertilizerType: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	profile.Data.Fertilizers[fertilizerType].Amount += amount 
	Remotes.UpdateOwnedFertilizers:FireClient(player, profile.Data.Fertilizers[fertilizerType].Amount, fertilizerType)
end

-- When this function is called, the water in the player's backpack gets deducted
function Manager.AdjustWater(player: Player, amount: number?)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	amount = amount or 1

	profile.Data.Water -= amount
	Remotes.UpdateWater:FireClient(player, profile.Data.Water)
end

-- When this function is called, the player's money in the backpack gets updated
function Manager.AdjustPlayerMoney(player: Player, plotID: number): boolean
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

-- When this function is called, the player's Watering Can gets refilled
function Manager.RefillWater(player: Player)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.Water = profile.Data.EquippedWaterCan.Capacity
	Remotes.RefillWater:FireClient(player)
end

-- When this function is called, the player's money in the backpack gets sold and converted into Coins
function Manager.SellAllMoney(player: Player)
	local profile = Manager.Profiles[player]
	if not profile then return end

	profile.Data.Money = 0 
	Remotes.SellAllMoney:FireClient(player)
end

-- When this function is called, the player's tree index is adjusted
function Manager.AdjustTreeIndex(player: Player, tree: string, treeLevel: number)
	local profile = Manager.Profiles[player]
	if not profile then return end
	profile.Data.Index["TreeIndex"][tree].Trees[treeLevel].Unlocked = true

	Remotes.UpdateTreeIndex:FireClient(player, tree, treeLevel)
end

-- When this function is called, the player's plot status gets updated and a tree is assigned to the plot's data
function Manager.AdjustPlotOccupation(player: Player, PlotID: number, treeToPlant: string)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.Plots[PlotID].Tree = table.clone(TreeConfig[treeToPlant])
	profile.Data.Plots[PlotID].Tree.TimeUntilWater = os.time() + 20 
	
	Remotes.UpdateTree:FireClient(player, profile.Data.Plots[PlotID].Tree, PlotID)
end

-- When this function is called, the plot is added to the owned plots of the player
function Manager.PurchasePlot(player: Player, plot: directory)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.Plots[plot.Id] = plot
	Remotes.UpdateOwnedPlots:FireClient(player, profile.Data.Plots)
end

-- When this function is called, the player buys the watering can and their inventory gets updated
function Manager.PurchaseWaterCan(player: Player, waterCanID: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	profile.Data.OwnedWaterCans[waterCanID] = WaterCanConfig[waterCanID]
	Remotes.UpdateOwnedWaterCans:FireClient(player, profile.Data.OwnedWaterCans)
end

-- When this function is called, the currently equipped Watering Can is changed
function Manager.EquipWaterCan(player: Player, waterCanID: string)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.EquippedWaterCan = WaterCanConfig[waterCanID]
	Remotes.ChangeEquippedWateringCan:FireClient(player, profile.Data.EquippedWaterCan)
end

-- When this function is called, the player buys the backpack and their inventory gets updated
function Manager.PurchaseBackpack(player: Player, backpackID: string)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.OwnedBackpacks[backpackID] = BackpacksConfig[backpackID]
	Remotes.UpdateOwnedBackpacks:FireClient(player, profile.Data.OwnedBackpacks)	
end

-- When this function is called, the currently equipped Backpack is changed
function Manager.EquipBackpack(player: Player, backpackID: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	profile.Data.EquippedBackpack = BackpacksConfig[backpackID]
	Remotes.ChangeEquippedBackpack:FireClient(player, profile.Data.EquippedBackpack)
end

function Manager.PurchaseWeapon(player: Player, weaponID: string)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.OwnedWeapons[weaponID] = BackpacksConfig[weaponID]
	Remotes.UpdateOwnedWeapons:FireClient(player, profile.Data.OwnedWeapons)	
end

function Manager.EquipWeapon(player: Player, weaponID: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	profile.Data.EquippedWeapon = WeaponsConfig[weaponID]
	Remotes.ChangeEquippedWeapon:FireClient(player, profile.Data.EquippedWeapon)

end

-- When this function is called, the tree of the plot gets removed
function Manager.DeleteTree(player: Player, plotID: number)
	local profile = Manager.Profiles[player]
	if not profile then return end

	profile.Data.Plots[plotID].Tree = nil
	Remotes.DeleteTree:FireClient(player, plotID)
end

-- When this function is called, the water timer of the tree gets updated
function Manager.UpdateTreeWaterTimer(player: Player, plotID: number)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.Plots[plotID].Tree.TimeUntilWater = os.time() + profile.Data.Plots[plotID].Tree.TimeBetweenWater

	Remotes.UpdateTreeWaterTimer:FireClient(player, profile.Data.Plots[plotID].Tree.TimeUntilWater, plotID)
end

-- When this function is called, the tree's level or cycle is changed
function Manager.UpdateTreeLevel(player: Player, plotID: number, cycle: number): string
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	if profile.Data.Plots[plotID].Tree.MaxCycle <= profile.Data.Plots[plotID].Tree.CurrentCycle + cycle then
		profile.Data.Plots[plotID].Tree.CurrentLevel = profile.Data.Plots[plotID].Tree.CurrentLevel + 1 
		profile.Data.Plots[plotID].Tree.MaxCycle = profile.Data.Plots[plotID].Tree.MaxCycle + 1 
		profile.Data.Plots[plotID].Tree.CurrentCycle = 0
		
		Remotes.UpdateTreeLevel:FireClient(player, plotID, profile.Data.Plots[plotID].Tree)
		return "LEVEL"
	else
		profile.Data.Plots[plotID].Tree.CurrentCycle = profile.Data.Plots[plotID].Tree.CurrentCycle + cycle
		
		Remotes.UpdateTreeLevel:FireClient(player, plotID, profile.Data.Plots[plotID].Tree)
		return "CYCLE"
	end
end

-- When this function is called, the tree's money timer gets reset
function Manager.UpdateTreeMoneyTimer(player: Player, plotID: number)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.Plots[plotID].Tree.TimeUntilMoney = os.time() + profile.Data.Plots[plotID].Tree.TimeBetweenMoney

	Remotes.UpdateTreeMoneyTimer:FireClient(player, profile.Data.Plots[plotID].Tree.TimeUntilMoney, plotID)
end

-- Helper function: Give achievement rewards to the player
local function GiveAchievementRewards(player: Player, achievementType: string, achievementNo: number)
	local profile = Manager.Profiles[player]
	if not profile then return end

	if AchievementInfoConfig[achievementType][achievementNo]["Reward"]["Coins"] then 
		local value = AchievementInfoConfig[achievementType][achievementNo]["Reward"]["Coins"]
		print("Player has been rewarded coins!")
		Manager.AdjustCoins(player, value)
	end

	if AchievementInfoConfig[achievementType][achievementNo]["Reward"]["Gems"] then 
		local value = AchievementInfoConfig[achievementType][achievementNo]["Reward"]["Gems"]
		print("Player has been rewarded Gems!")
		Manager.AdjustGems(player, value)
	end
end

-- Update the achievements of the player
function Manager.UpdateAchievements(player: Player, achievementType: string, amount: number)
	local profile = Manager.Profiles[player]
	if not profile then return end

	profile.Data.Achievements[achievementType].AmountAchieved += amount

	if profile.Data.Achievements[achievementType].CurrentAchievementNo == nil then 
		return
	end

	while profile.Data.Achievements[achievementType].AmountAchieved >= profile.Data.Achievements[achievementType].AmountToAchieve do
		local currentAchievementNumber = profile.Data.Achievements[achievementType].CurrentAchievementNo
		GiveAchievementRewards(player, achievementType, currentAchievementNumber)

		profile.Data.Achievements[achievementType].CurrentAchievementNo += 1

		if profile.Data.Achievements[achievementType].CurrentAchievementNo == nil then 
			break 
		end

		profile.Data.Achievements[achievementType].AmountToAchieve = AchievementInfoConfig[achievementType][profile.Data.Achievements[achievementType].CurrentAchievementNo].Amount
	end

	Remotes.UpdateAchievements:FireClient(player, profile.Data.Achievements)
end

-- Update the settings of the player
function Manager.UpdateSettings(player: Player, setting: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	profile.Data.Settings[setting] = not profile.Data.Settings[setting]
	Remotes.UpdateSettings:FireClient(player, profile.Data.Settings[setting], setting)
end

-- Get specific data from the player's directory
local function GetData(player: Player, directory: string)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	return profile.Data[directory]	
end

-- Get all the data of the player
local function GetAllData(player: Player)
	local profile = Manager.Profiles[player]
	if not profile then return end

	return profile.Data
end

-- Server to client requests
Remotes.GetData.OnServerInvoke = GetData	
Remotes.GetAllData.OnServerInvoke = GetAllData

-- Reset all player data to default template
function Manager.ResetAllData(player: Player)
	local profile = Manager.Profiles[player]
	if not profile then return end

	print("Reset Manager function got called")
	local templateClone = table.clone(Template)
	Manager.Profiles[player].Data = templateClone
	print(templateClone)
	player.leaderstats.Coins.Value = profile.Data.Coins
	player.leaderstats.Gems.Value = profile.Data.Gems 
	Remotes.ResetData:FireClient(player)
end

-- Fill up the player's backpack to maximum capacity
function Manager.FillupBackpack(player: Player)
	local profile = Manager.Profiles[player]
	if not profile then return end

	profile.Data.Money = profile.Data.EquippedBackpack.Capacity	
	Remotes.FillupBackpack:FireClient(player)
end

return Manager
