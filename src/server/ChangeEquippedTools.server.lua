local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)

local Remotes = ReplicatedStorage.Remotes

local function ChangeEquippedWateringCan(player: Player, WaterCan: string)
    Manager.EquipWaterCan(player, WaterCan)
end

local function ChangeEquippedBackpack(player: Player, Backpack: string)
    Manager.EquipBackpack(player, Backpack)
end

Remotes.ChangeEquippedBackpack.OnServerEvent:Connect(ChangeEquippedBackpack)
Remotes.ChangeEquippedWateringCan.OnServerEvent:Connect(ChangeEquippedWateringCan)