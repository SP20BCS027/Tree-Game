local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local PotionsConfig = require(ReplicatedStorage.Configs.PotionsConfig)

local Remotes = ReplicatedStorage.Remotes

-- This function is called when a player purchases a weapon.
-- The function then calls the appropriate manager functions to handle the purchase, adjust the player's coins, and equip the weapon if necessary.
local function PurchasePotion(player: Player, amount: number, potionType: string, potionID: string)
    local profile = Manager.Profiles[player]
    if not profile then return end

    -- Server-side sanity checks
    if not PotionsConfig[potionType][potionID] then 
        print("The Potion" .. potionID .. " does not exist ~~ Server")
        return
    end

    if profile.Data.Coins < PotionsConfig[potionType][potionID].Price then 
        print("The player " .. player.Name .. " does not have enough coins ~~ Server")
        return
    end

    Manager.PurchasePotion(player, amount, potionType, potionID)
    Manager.AdjustCoins(player, -(PotionsConfig[potionType][potionID].Price * amount))
end

Remotes.UpdateOwnedPotions.OnServerEvent:Connect(PurchasePotion) 
