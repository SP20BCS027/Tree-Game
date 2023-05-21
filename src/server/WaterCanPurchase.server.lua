local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local WaterCanConfig = require(ReplicatedStorage.Configs.WaterCanConfig)

local Remotes = ReplicatedStorage.Remotes

<<<<<<< Updated upstream
local function purchaseCan(player: Player, WaterCan: string)
	Manager.PurchaseWaterCan(player, WaterCan)
	Manager.EquipWaterCan(player, WaterCan)
=======
local function PurchaseCan(player: Player, waterCan: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	-- Server Side Sanity Checks
	if not WaterCanConfig[waterCan] then 
		print("The Backpack " .. waterCan .. " does not exist ~~ Server")
		return
	end
	if profile.Data.OwnedBackpacks[waterCan] then 
		print("The player " .. player.Name .. " already owns this backpack " .. waterCan .. " ~~ Server")
		return
	end
	if profile.Data.Coins < WaterCanConfig[waterCan].Price then 
		print("The player " .. player.Name .. " does not have enough coins ~~ Server")
		return
	end

	Manager.PurchaseWaterCan(player, waterCan)
	Manager.AdjustCoins(player, -WaterCanConfig[waterCan].Price)
	Manager.EquipWaterCan(player, waterCan)
>>>>>>> Stashed changes
end

local function changeEquippedWaterCan(player: Player, WaterCan: string)
	Manager.EquipWaterCan(player, WaterCan)
end

Remotes.UpdateOwnedWaterCans.OnServerEvent:Connect(purchaseCan)
Remotes.ChangeEquippedWateringCan.OnServerEvent:Connect(changeEquippedWaterCan)