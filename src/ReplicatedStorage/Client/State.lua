local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes
local Template = require(ReplicatedStorage.PlayerData.Template)
local IsDataLoaded = false 

local PlayerData : Template.PlayerData

-- Load the player data from the server
local function LoadData()
	if IsDataLoaded then return end 

	while not PlayerData do 
		PlayerData = Remotes.GetAllData:InvokeServer()
		task.wait(1)
	end
	IsDataLoaded = true
end

LoadData()

-- State object to store and retrieve player data
local State = {}

-- Get the player data
function State.GetData(): Template.PlayerData
	while not IsDataLoaded  do
		task.wait(0.5)
	end	
	return PlayerData
end

-- Update the amount of owned seeds in the player data
Remotes.UpdateOwnedSeeds.OnClientEvent:Connect(function(amount: number, seedType: string)
	PlayerData.Seeds[seedType].Amount = amount
end)

Remotes.UpdateOwnedEggs.OnClientEvent:Connect(function(Eggs: {})
	PlayerData.Eggs = Eggs
end)

-- Update the amount of owned fertilizers in the player data
Remotes.UpdateOwnedFertilizers.OnClientEvent:Connect(function(amount: number, fertilizerType: string)
	PlayerData.Fertilizers[fertilizerType].Amount = amount 
end)

-- Update the amount of coins in the player data
Remotes.UpdateCoins.OnClientEvent:Connect(function(amount: number)
	PlayerData.Coins = amount
end)

-- Update the amount of gems in the player data
Remotes.UpdateGems.OnClientEvent:Connect(function(amount: number)
	PlayerData.Gems = amount
end)

-- Reset the player data to the template data
Remotes.ResetData.OnClientEvent:Connect(function()
	local templateClone = table.clone(Template)
	PlayerData = templateClone
end)

-- Update the tree in a specific plot of the player data
Remotes.UpdateTree.OnClientEvent:Connect(function(Tree, plotID: number)
	PlayerData.Plots[plotID].Tree = Tree
end)

-- Update the water timer of a tree in a specific plot of the player data
Remotes.UpdateTreeWaterTimer.OnClientEvent:Connect(function(timeUntilWater: number, plotID: number)
	PlayerData.Plots[plotID].Tree.TimeUntilWater = timeUntilWater
end)

-- Update the money timer of a tree in a specific plot of the player data
Remotes.UpdateTreeMoneyTimer.OnClientEvent:Connect(function(timeUntilMoney: number, plotID: number)
	PlayerData.Plots[plotID].Tree.TimeUntilMoney = timeUntilMoney
end)

-- Update the amount of water in the player data
Remotes.UpdateWater.OnClientEvent:Connect(function(water: number)
	PlayerData.Water = water
end)

-- Refill the water in the player data to the capacity of the equipped watering can
Remotes.RefillWater.OnClientEvent:Connect(function()
	PlayerData.Water = PlayerData.EquippedWaterCan.Capacity
end)

-- Update the unlocked state of a tree at a specific level in the player data's tree index
Remotes.UpdateTreeIndex.OnClientEvent:Connect(function(tree: string, treeLevel: number)
	PlayerData.Index["TreeIndex"][tree].Trees[treeLevel].Unlocked = true
end)

-- Update the tree in a specific plot of the player data
Remotes.UpdateTreeLevel.OnClientEvent:Connect(function(plotID: number, Tree)
	PlayerData.Plots[plotID].Tree = Tree 
end)

-- Update the owned water cans in the player data
Remotes.UpdateOwnedWaterCans.OnClientEvent:Connect(function(OwnedWaterCans: {})
	PlayerData.OwnedWaterCans = OwnedWaterCans
end)

-- Update the owned backpacks in the player data
Remotes.UpdateOwnedBackpacks.OnClientEvent:Connect(function(OwnedBackpacks: {})
	PlayerData.OwnedBackpacks = OwnedBackpacks
end)

Remotes.UpdateOwnedWeapons.OnClientEvent:Connect(function(OwnedWeapons: {})
	PlayerData.OwnedWeapons = OwnedWeapons
end)

Remotes.UpdateOwnedPotions.OnClientEvent:Connect(function(OwnedPotions: {})
	PlayerData.OwnedPotions = OwnedPotions
end)

Remotes.UpdateOwnedKeys.OnClientEvent:Connect(function(OwnedKeys: {})
	PlayerData.Keys = OwnedKeys
end)

Remotes.UpdateOwnedPets.OnClientEvent:Connect(function(OwnedPets: {})
	PlayerData.OwnedPets = OwnedPets
end)

-- Delete the tree in a specific plot of the player data
Remotes.DeleteTree.OnClientEvent:Connect(function(plotID: string)
	PlayerData.Plots[plotID].Tree = nil 
end)

-- Update the owned plots in the player data
Remotes.UpdateOwnedPlots.OnClientEvent:Connect(function(Plots: {})
	PlayerData.Plots = Plots
end)

-- Update the achievements in the player data
Remotes.UpdateAchievements.OnClientEvent:Connect(function(Achievements: {})
	PlayerData.Achievements = Achievements
end)

-- Change the equipped backpack in the player data
Remotes.ChangeEquippedBackpack.OnClientEvent:Connect(function(EquippedBackpack: {})
	PlayerData.EquippedBackpack = EquippedBackpack
end)

-- Change the equipped watering can in the player data
Remotes.ChangeEquippedWateringCan.OnClientEvent:Connect(function(EquippedWaterCan: {})
	PlayerData.EquippedWaterCan = EquippedWaterCan
end)

Remotes.ChangeEquippedWeapon.OnClientEvent:Connect(function(EquippedWeapon: {})
	PlayerData.EquippedWeapon = EquippedWeapon
end)

Remotes.ChangeEquippedPets.OnClientEvent:Connect(function(EquippedPets: {})
	PlayerData.EquippedPets = EquippedPets
end)

-- Update the amount of money in the player data
Remotes.UpdateMoney.OnClientEvent:Connect(function(money: number)
	PlayerData.Money = money
end)

-- Update the active quests in the player data
Remotes.BakriQuest.OnClientEvent:Connect(function(BakriQuest)
	PlayerData.ActiveQuests = BakriQuest
end)

-- Sell all money in the player data
Remotes.SellAllMoney.OnClientEvent:Connect(function()
	PlayerData.Money = 0 
end)

-- Update a specific setting in the player data's settings
Remotes.UpdateSettings.OnClientEvent:Connect(function(currentStatus: boolean, setting: string)
	PlayerData.Settings[setting] = currentStatus 
end)

return State
