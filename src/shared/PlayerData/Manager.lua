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
	Remotes.UpdateSeeds:FireClient(player, profile.Data.Seeds[seedType].Amount, seedType)
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
	
	print(treeToPlant)

	profile.Data.Plots[PlotId].Occupied = isOccupied
	profile.Data.Plots[PlotId].Tree = Trees[treeToPlant]
	profile.Data.Plots[PlotId].Tree.TimeUntilWater = os.time() + 20 
	
	Remotes.UpdateOccupied:FireClient(player, profile.Data.Plots[PlotId].Occupied, PlotId)
	Remotes.UpdateTree:FireClient(player, profile.Data.Plots[PlotId].Tree.TimeUntilWater, PlotId, treeToPlant)
end

function Manager.AdjustPlayerOwnership(player: Player, ownerShipStatus: boolean)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.IsOwner = ownerShipStatus
	
	Remotes.UpdateOwnership:FireClient(player, ownerShipStatus)
end

function Manager.PurchaseWaterCan(player: Player, waterCanId: string)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	table.insert(profile.Data.OwnedWaterCans, WaterCans[waterCanId])
	Remotes.UpdateOwnedWaterCans:FireClient(player, profile.Data.OwnedWaterCans)
end

function Manager.EquipWaterCan(player: Player, waterCanId: string)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.EquippedWaterCan = WaterCans[waterCanId]
	Remotes.ChangeEquippedWaterCan:FireClient(player, profile.Data.EquippedWaterCan)
end

function Manager.PurchaseBackpack(player: Player, backpackId: string)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	table.insert(profile.Data.OwnedBackpacks, Backpacks[backpackId])
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
	
	profile.Data.Plots[PlotId].Tree.TimeUntilWater = os.time() + 10
	Remotes.UpdateTreeWaterTimer:FireClient(player, profile.Data.Plots[PlotId].Tree.TimeUntilWater, PlotId)
end

function Manager.UpdateTreeLevel(player: Player, PlotId: number)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	if profile.Data.Plots[PlotId].Tree.MaxCycle == profile.Data.Plots[PlotId].Tree.CurrentCycle + 1  then
		profile.Data.Plots[PlotId].Tree.CurrentLevel = profile.Data.Plots[PlotId].Tree.CurrentLevel + 1 
		profile.Data.Plots[PlotId].Tree.MaxCycle = profile.Data.Plots[PlotId].Tree.MaxCycle + 1 
		profile.Data.Plots[PlotId].Tree.CurrentCycle = 0
		
		Remotes.UpdateTreeLevel:FireClient(player, "LEVEL", PlotId)
	else
		profile.Data.Plots[PlotId].Tree.CurrentCycle = profile.Data.Plots[PlotId].Tree.CurrentCycle + 1
		
		Remotes.UpdateTreeLevel:FireClient(player, "CYCLE", PlotId)
	end
end

function Manager.UpdateTreeMoneyTimer(player: Player, plotID: number)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.Plots[plotID].Tree.TimeUntilMoney = os.time() + 20

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

-- Client to Server Communication 

Remotes.UpdateOwnership.OnServerEvent:Connect(Manager.AdjustPlayerOwnership)

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
	
	Remotes.ResetData:FireClient(player, profile.Data)
end

return Manager
