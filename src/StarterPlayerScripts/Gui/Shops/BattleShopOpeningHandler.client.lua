local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local Remotes = ReplicatedStorage.Remotes

local BattleShopManager = require(player:WaitForChild("PlayerScripts").Gui.Shops.BattleShopManager)

-- Function to open a shop
local function ShopOpener(shopID, hideShop: boolean?)

    local currentWeapon = BattleShopManager.GetCurrentWeaponType()
    local currentPotion = BattleShopManager.GetCurrentPotionType()
    local currentElement = BattleShopManager.GetCurrentElementType()
    local currentArmor = BattleShopManager.GetCurrentArmorType()
    hideShop = if hideShop == false then hideShop else true
    BattleShopManager.GenerateShop(shopID, hideShop, currentWeapon, currentElement, currentPotion, currentArmor)
end

Remotes.OpenBattleShop.OnClientEvent:Connect(ShopOpener)
