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

Remotes.ResetData.OnClientEvent:Connect(function()
	PlayerData = Template
	
	Remotes.Bindables.OnReset.GenerateOwnedPlots:Fire()
	Remotes.Bindables.OnReset.ResetMoney:Fire()
	Remotes.Bindables.OnReset.ResetWater:Fire()
	Remotes.Bindables.OnReset.GenerateBackpackInventory:Fire()
	Remotes.Bindables.OnReset.GenerateWaterCanInventory:Fire()
end)

Remotes.UpdateOccupied.OnClientEvent:Connect(function(occupy: boolean, plotId: number)
	PlayerData.Plots[plotId].Occupied = occupy
end)

Remotes.UpdateTree.OnClientEvent:Connect(function(TimeTillThirst: number, plotId: number, tree)
	PlayerData.Plots[plotId].Tree = TreeConfig[tree]
	PlayerData.Plots[plotId].Tree.TimeUntilWater = TimeTillThirst
	Remotes.Bindables.UpdateTreeLevel:Fire(plotId)
	Remotes.Bindables.UpdateTreeCycle:Fire(plotId)
end)

Remotes.UpdateTreeWaterTimer.OnClientEvent:Connect(function(TimeTillThirst: number, plotId: number)
	PlayerData.Plots[plotId].Tree.TimeUntilWater = TimeTillThirst
end)

Remotes.UpdateTreeMoneyTimer.OnClientEvent:Connect(function(TimeTillMoney: number, plotId: number)
	PlayerData.Plots[plotId].Tree.TimeUntilMoney = TimeTillMoney
end)

Remotes.UpdateWater.OnClientEvent:Connect(function(water: number)
	PlayerData.Water = water
end)

Remotes.RefillWater.OnClientEvent:Connect(function()
	PlayerData.Water = PlayerData.EquippedWaterCan.Capacity
end)

Remotes.UpdateTreeLevel.OnClientEvent:Connect(function(Prompt: string, plotId: number, cycle: number)
	if Prompt == "LEVEL" then
		PlayerData.Plots[plotId].Tree.CurrentLevel = PlayerData.Plots[plotId].Tree.CurrentLevel + 1 
		PlayerData.Plots[plotId].Tree.MaxCycle = PlayerData.Plots[plotId].Tree.MaxCycle + 1
		PlayerData.Plots[plotId].Tree.CurrentCycle = 0 
		Remotes.Bindables.UpdateTreeLevel:Fire(plotId)
		Remotes.Bindables.UpdateTreeCycle:Fire(plotId)
	elseif Prompt == "CYCLE" then
		PlayerData.Plots[plotId].Tree.CurrentCycle = PlayerData.Plots[plotId].Tree.CurrentCycle + cycle
	end
end)

Remotes.UpdateOwnedWaterCans.OnClientEvent:Connect(function(ownedCans)
	PlayerData.OwnedWaterCans = ownedCans
	Remotes.Bindables.OnReset.GenerateWaterCanInventory:Fire()
end)

Remotes.UpdateOwnedBackpacks.OnClientEvent:Connect(function(ownedBackpacks)
	PlayerData.OwnedBackpacks = ownedBackpacks
	Remotes.Bindables.OnReset.GenerateBackpackInventory:Fire()
end)

Remotes.UpdateOwnedPlots.OnClientEvent:Connect(function(plots)
	PlayerData.Plots = plots
end)

Remotes.ChangeEquippedBackpack.OnClientEvent:Connect(function(equippedBackpack)
	PlayerData.EquippedBackpack = equippedBackpack
end)

Remotes.ChangeEquippedWateringCan.OnClientEvent:Connect(function(equippedCan)
	PlayerData.EquippedWaterCan = equippedCan
end)

Remotes.UpdateMoney.OnClientEvent:Connect(function(Money)
	PlayerData.Money = Money
end)

Remotes.SellAllMoney.OnClientEvent:Connect(function()
	PlayerData.Money = 0 
end)

return State
