local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes
local Template = require(ReplicatedStorage.PlayerData.Template)
local IsDataLoaded = false 

local PlayerData : Template.PlayerData

local function LoadData()
	if IsDataLoaded then return end 

	while not PlayerData do 
		PlayerData = Remotes.GetAllData:InvokeServer()
		task.wait(1)
	end
	
	IsDataLoaded = true
end

LoadData()

local State = {}

function State.GetData(): Template.PlayerData
	while not IsDataLoaded  do
		task.wait(0.5)
	end	
	return PlayerData
end

Remotes.UpdateOwnedSeeds.OnClientEvent:Connect(function(amount: number, seedType: string)
	PlayerData.Seeds[seedType].Amount = amount
end)

Remotes.UpdateOwnedFertilizers.OnClientEvent:Connect(function(amount: number, fertilizerType: string)
	PlayerData.Fertilizers[fertilizerType].Amount = amount 
end)

Remotes.UpdateCoins.OnClientEvent:Connect(function(amount: number)
	PlayerData.Coins = amount
end)

Remotes.UpdateGems.OnClientEvent:Connect(function(amount: number)
	PlayerData.Gems = amount
end)

Remotes.ResetData.OnClientEvent:Connect(function()
	PlayerData = Template
end)

Remotes.UpdateTree.OnClientEvent:Connect(function(Tree, plotID: number)
	PlayerData.Plots[plotID].Tree = Tree
end)

Remotes.UpdateTreeWaterTimer.OnClientEvent:Connect(function(timeUntilWater: number, plotID: number)
	PlayerData.Plots[plotID].Tree.TimeUntilWater = timeUntilWater
end)

Remotes.UpdateTreeMoneyTimer.OnClientEvent:Connect(function(timeUntilMoney: number, plotID: number)
	PlayerData.Plots[plotID].Tree.TimeUntilMoney = timeUntilMoney
end)

Remotes.UpdateWater.OnClientEvent:Connect(function(water: number)
	PlayerData.Water = water
end)

Remotes.RefillWater.OnClientEvent:Connect(function()
	PlayerData.Water = PlayerData.EquippedWaterCan.Capacity
end)

Remotes.UpdateTreeLevel.OnClientEvent:Connect(function(plotID: number, Tree)
	PlayerData.Plots[plotID].Tree = Tree 
end)

Remotes.UpdateOwnedWaterCans.OnClientEvent:Connect(function(OwnedWaterCans: {})
	PlayerData.OwnedWaterCans = OwnedWaterCans
end)

Remotes.UpdateOwnedBackpacks.OnClientEvent:Connect(function(OwnedBackpacks: {})
	PlayerData.OwnedBackpacks = OwnedBackpacks
end)

Remotes.DeleteTree.OnClientEvent:Connect(function(plotID: string)
	PlayerData.Plots[plotID].Tree = nil 
end)

Remotes.UpdateOwnedPlots.OnClientEvent:Connect(function(Plots: {})
	PlayerData.Plots = Plots
end)

Remotes.UpdateAchievements.OnClientEvent:Connect(function(Achievements: {})
	PlayerData.Achievements = Achievements
end)

Remotes.ChangeEquippedBackpack.OnClientEvent:Connect(function(EquippedBackpack: {})
	PlayerData.EquippedBackpack = EquippedBackpack
end)

Remotes.ChangeEquippedWateringCan.OnClientEvent:Connect(function(EquippedWaterCan: {})
	PlayerData.EquippedWaterCan = EquippedWaterCan
end)

Remotes.UpdateMoney.OnClientEvent:Connect(function(money: number)
	PlayerData.Money = money
end)

Remotes.BakriQuest.OnClientEvent:Connect(function(BakriQuest)
	PlayerData.ActiveQuests = BakriQuest
end)

Remotes.SellAllMoney.OnClientEvent:Connect(function()
	PlayerData.Money = 0 
end)

Remotes.UpdateSettings.OnClientEvent:Connect(function(Settings: {})
	PlayerData.Settings = Settings
end)

return State
