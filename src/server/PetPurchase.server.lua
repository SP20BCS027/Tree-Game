local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local PetsConfig = require(ReplicatedStorage.Configs.PetsConfig)

local Remotes = ReplicatedStorage.Remotes

-- This function is called when a player purchases a weapon.
-- The function then calls the appropriate manager functions to handle the purchase, adjust the player's coins, and equip the weapon if necessary.
local function PurchasePet(player: Player, element, pet)
    local profile = Manager.Profiles[player]
    if not profile then return end

    -- Server-side sanity checks
    if not PetsConfig[element][pet] then 
        print("The pet " .. pet .. " does not exist ~~ Server")
        return
    end
    if profile.Data.OwnedPets[element][pet] then 
        print("The player " .. player.Name .. " already owns this pet " .. pet .. " ~~ Server")
        return
    end
    if profile.Data.Coins < PetsConfig[element][pet].Price then 
        print("The player " .. player.Name .. " does not have enough coins ~~ Server")
        return
    end

    Manager.PurchasePet(player, element, pet)
    Manager.AdjustCoins(player, PetsConfig[element][pet].Price)

    -- if profile.Data.EquippedWeapon.Attack < PetsConfig[element][pet].Attack then 
    --      Manager.EquipWeapon(player, element, pet)
    -- end
end

Remotes.UpdateOwnedPets.OnServerEvent:Connect(PurchasePet) 
