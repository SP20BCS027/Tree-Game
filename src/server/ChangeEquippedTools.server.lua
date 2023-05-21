local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local BackpackEquippingHandler = require(ServerScriptService.BackpackEquippingHandler)

local Remotes = ReplicatedStorage.Remotes

local function ChangeEquippedWateringCan(player: Player, waterCan: string)
    Manager.EquipWaterCan(player, waterCan)
end

local function ChangeEquippedBackpack(player: Player, backpack: string)
    local profile = Manager.Profiles[player]
	if not profile then return end

	if profile.Data.OwnedBackpacks[backpack] then 
		Manager.EquipBackpack(player, backpack)
		BackpackEquippingHandler.UpdatePlayerBackpackLabel(player)
	end
end

Remotes.ChangeEquippedBackpack.OnServerEvent:Connect(ChangeEquippedBackpack)
Remotes.ChangeEquippedWateringCan.OnServerEvent:Connect(ChangeEquippedWateringCan)