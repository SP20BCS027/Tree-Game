local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local BackpackEquippingHandler = require(ServerScriptService.BackpackEquippingHandler)

local Remotes = ReplicatedStorage.Remotes

-- Changes the equipped watering can for the specified player.
local function ChangeEquippedWateringCan(player: Player, waterCan: string)
    Manager.EquipWaterCan(player, waterCan)
end

-- Changes the equipped backpack for the specified player.
local function ChangeEquippedBackpack(player: Player, backpack: string)
    local profile = Manager.Profiles[player]
    if not profile then return end

    if profile.Data.OwnedBackpacks[backpack] then 
        Manager.EquipBackpack(player, backpack)
        BackpackEquippingHandler.UpdatePlayerBackpackLabel(player)
    end
end

local function ChangeEquippedWeapon(player: Player, weapon: string)
    print("Weapon Changed in Data")
    local profile = Manager.Profiles[player]
    if not profile then return end 

    if profile.Data.OwnedWeapons[weapon] then 
        Manager.EquipWeapon(player, weapon)
    end
end

Remotes.ChangeEquippedWeapon.OnServerEvent:Connect(ChangeEquippedWeapon)
Remotes.ChangeEquippedBackpack.OnServerEvent:Connect(ChangeEquippedBackpack)
Remotes.ChangeEquippedWateringCan.OnServerEvent:Connect(ChangeEquippedWateringCan)