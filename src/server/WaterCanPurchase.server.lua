local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)

local Remotes = ReplicatedStorage.Remotes

local function purchaseCan(player: Player, WaterCan: string)
	Manager.PurchaseWaterCan(player, WaterCan)
	Manager.EquipWaterCan(player, WaterCan)
end

local function changeEquippedWaterCan(player: Player, WaterCan: string)
	Manager.EquipWaterCan(player, WaterCan)
end

Remotes.UpdateOwnedWaterCans.OnServerEvent:Connect(purchaseCan)
Remotes.ChangeEquippedWateringCan.OnServerEvent:Connect(changeEquippedWaterCan)