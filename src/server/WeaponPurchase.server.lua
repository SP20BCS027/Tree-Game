local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local WeaponsConfig = require(ReplicatedStorage.Configs.WeaponsConfig)
local WeaponEquipping = require(ServerScriptService.WeaponEquippingHandler)

local Remotes = ReplicatedStorage.Remotes

-- This function is called when a player purchases a weapon.
-- The function then calls the appropriate manager functions to handle the purchase, adjust the player's coins, and equip the weapon if necessary.
local function PurchaseWeapon(player: Player, element, weapon: string)
    local profile = Manager.Profiles[player]
    if not profile then return end

    -- Server-side sanity checks
    if not WeaponsConfig[element][weapon] then 
        print("The Weapon " .. weapon .. " does not exist ~~ Server")
        return
    end
    if profile.Data.OwnedWeapons[element][weapon] then 
        print("The player " .. player.Name .. " already owns this weapon " .. weapon .. " ~~ Server")
        return
    end
    if profile.Data.Coins < WeaponsConfig[element][weapon].Price then 
        print("The player " .. player.Name .. " does not have enough coins ~~ Server")
        return
    end

    Manager.PurchaseWeapon(player, element, weapon)
    Manager.AdjustCoins(player, -WeaponsConfig[element][weapon].Price)

    if profile.Data.EquippedWeapon.Attack < WeaponsConfig[element][weapon].Attack then 
         Manager.EquipWeapon(player, element, weapon)
    end
end

Remotes.UpdateOwnedWeapons.OnServerEvent:Connect(PurchaseWeapon) 
