local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local WeaponsConfig = require(ReplicatedStorage.Configs.WeaponsConfig)
local WeaponEquippingHandler = require(ServerScriptService.WeaponEquippingHandler)

local Remotes = ReplicatedStorage.Remotes

-- This function is called when a player purchases a weapon.
-- The function then calls the appropriate manager functions to handle the purchase, adjust the player's coins, and equip the weapon if necessary.
local function PurchaseWeapon(player: Player, weapon: string)
    local profile = Manager.Profiles[player]
    if not profile then return end

    -- Server-side sanity checks
    if not WeaponsConfig[weapon] then 
        print("The Backpack " .. weapon .. " does not exist ~~ Server")
        return
    end
    if profile.Data.OwnedBackpacks[weapon] then 
        print("The player " .. player.Name .. " already owns this weapon " .. weapon .. " ~~ Server")
        return
    end
    if profile.Data.Coins < WeaponsConfig[weapon].Price then 
        print("The player " .. player.Name .. " does not have enough coins ~~ Server")
        return
    end

    Manager.PurchaseWeapon(player, weapon)
    Manager.AdjustCoins(player, -WeaponsConfig[weapon].Price)

    if profile.Data.EquippedBackpack.Capacity < WeaponsConfig[weapon].Capacity then 
        Manager.EquipBackpack(player, weapon)
        WeaponEquippingHandler.UpdatePlayerBackpackLabel(player)
    end
end

Remotes.UpdateOwnedWeapons.OnServerEvent:Connect(PurchaseWeapon) 
