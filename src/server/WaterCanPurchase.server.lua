local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)

local Remotes = ReplicatedStorage.Remotes

local function PurchaseCan(player: Player, waterCan: string)
	Manager.PurchaseWaterCan(player, waterCan)
	Manager.EquipWaterCan(player, waterCan)
end

Remotes.UpdateOwnedWaterCans.OnServerEvent:Connect(PurchaseCan)
--Remotes.ChangeEquippedWateringCan.OnServerEvent:Connect(ChangeEquippedWaterCan)