local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local Remotes = ReplicatedStorage.Remotes

local BattleShopManager = require(player:WaitForChild("PlayerScripts").Gui.Shops.BattleShopManager)

-- Function to open a shop
local function ShopOpener(shopID, hideShop: boolean?)
    print("Battle Shop Triggered")
    hideShop = if hideShop == false then hideShop else true
    BattleShopManager.GenerateShop(shopID, hideShop)
end

Remotes.OpenBattleShop.OnClientEvent:Connect(ShopOpener)
