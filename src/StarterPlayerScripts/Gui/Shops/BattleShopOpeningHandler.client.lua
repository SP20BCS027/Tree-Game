local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local Remotes = ReplicatedStorage.Remotes

local BattleShopManager = require(player:WaitForChild("PlayerScripts").Gui.Shops.BattleShopManager)

-- Function to open a shop
local function ShopOpener(shopID, hideShop: boolean?)

    local currentWeapon = BattleShopManager.GetCurrentWeaponType()
    local currentPotion = BattleShopManager.GetCurrentPotionType()
    local currentElement = BattleShopManager.GetCurrentElementType()
    hideShop = if hideShop == false then hideShop else true
    BattleShopManager.GenerateShop(shopID, currentWeapon, currentElement, currentPotion, hideShop)
end

Remotes.OpenBattleShop.OnClientEvent:Connect(ShopOpener)
