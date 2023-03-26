local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)

local Remotes = ReplicatedStorage.Remotes

local function purchasePack(player: Player, backpack: string)
	Manager.PurchaseBackpack(player, backpack)
	Manager.EquipBackpack(player, backpack)
end

local function changeEquippedBackpack(player: Player, backpack: string)
	Manager.EquipBackpack(player, backpack)
end

Remotes.UpdateOwnedBackpacks.OnServerEvent:Connect(purchasePack) 
Remotes.ChangeEquippedBackpack.OnServerEvent:Connect(changeEquippedBackpack)