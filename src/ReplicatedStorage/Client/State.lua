local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes
local Template = require(ReplicatedStorage.PlayerData.Template)
local TreeConfig = require(ReplicatedStorage.Configs.TreeConfig)
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
	
	Remotes.Bindables.OnReset.GenerateOwnedPlots:Fire()
	Remotes.Bindables.OnReset.ResetMoney:Fire()
	Remotes.Bindables.OnReset.ResetWater:Fire()
	Remotes.Bindables.OnReset.GenerateBackpackInventory:Fire()
	Remotes.Bindables.OnReset.GenerateWaterCanInventory:Fire()
	Remotes.Bindables.OnReset.GenerateMainInventory:Fire()
end)

Remotes.UpdateOccupied.OnClientEvent:Connect(function(occupy: boolean, plotID: number)
	PlayerData.Plots[plotID].Occupied = occupy
end)

Remotes.UpdateTree.OnClientEvent:Connect(function(timeTillThirst: number, plotID: number, tree: string)
	PlayerData.Plots[plotID].Tree = TreeConfig[tree]
	PlayerData.Plots[plotID].Tree.TimeUntilWater = timeTillThirst
	Remotes.Bindables.UpdateTreeLevel:Fire(plotID)
	Remotes.Bindables.UpdateTreeCycle:Fire(plotID)
end)

Remotes.UpdateTreeWaterTimer.OnClientEvent:Connect(function(timeTillThirst: number, plotID: number)
	PlayerData.Plots[plotID].Tree.TimeUntilWater = timeTillThirst
end)

Remotes.UpdateTreeMoneyTimer.OnClientEvent:Connect(function(timeTillMoney: number, plotID: number)
	PlayerData.Plots[plotID].Tree.TimeUntilMoney = timeTillMoney
end)

Remotes.UpdateWater.OnClientEvent:Connect(function(water: number)
	PlayerData.Water = water
end)

Remotes.RefillWater.OnClientEvent:Connect(function()
	PlayerData.Water = PlayerData.EquippedWaterCan.Capacity
end)

Remotes.FillupBackpack.OnClientEvent:Connect(function()
	PlayerData.Money = PlayerData.EquippedBackpack.Capacity
end)

Remotes.UpdateTreeLevel.OnClientEvent:Connect(function(prompt: string, plotID: number, cycle: number)
	if prompt == "LEVEL" then
		PlayerData.Plots[plotID].Tree.CurrentLevel = PlayerData.Plots[plotID].Tree.CurrentLevel + 1 
		PlayerData.Plots[plotID].Tree.MaxCycle = PlayerData.Plots[plotID].Tree.MaxCycle + 1
		PlayerData.Plots[plotID].Tree.CurrentCycle = 0 
		Remotes.Bindables.UpdateTreeLevel:Fire(plotID)
		Remotes.Bindables.UpdateTreeCycle:Fire(plotID)
	elseif prompt == "CYCLE" then
		PlayerData.Plots[plotID].Tree.CurrentCycle = PlayerData.Plots[plotID].Tree.CurrentCycle + cycle
	end
end)

Remotes.UpdateOwnedWaterCans.OnClientEvent:Connect(function(OwnedWaterCans: {})
	PlayerData.OwnedWaterCans = OwnedWaterCans
	Remotes.Bindables.OnReset.GenerateWaterCanInventory:Fire()
end)

Remotes.UpdateOwnedBackpacks.OnClientEvent:Connect(function(OwnedBackpacks: {})
	PlayerData.OwnedBackpacks = OwnedBackpacks
	Remotes.Bindables.OnReset.GenerateBackpackInventory:Fire()
end)

Remotes.UpdateOwnedPlots.OnClientEvent:Connect(function(Plots: {})
	PlayerData.Plots = Plots
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

Remotes.SellAllMoney.OnClientEvent:Connect(function()
	PlayerData.Money = 0 
end)

return State
