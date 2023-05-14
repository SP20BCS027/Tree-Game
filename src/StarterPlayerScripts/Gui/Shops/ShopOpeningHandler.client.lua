local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local Remotes = ReplicatedStorage.Remotes

local ShopsManager = require(player:WaitForChild("PlayerScripts").Gui.Shops.ShopsManager)

local function ShopOpener(shopID)
    ShopsManager.GenerateShop(shopID)
end

Remotes.OpenBackpackShop.OnClientEvent:Connect(ShopOpener)
Remotes.OpenFertilizerShop.OnClientEvent:Connect(ShopOpener)
Remotes.OpenSeedsShop.OnClientEvent:Connect(ShopOpener)
Remotes.OpenWaterCanShop.OnClientEvent:Connect(ShopOpener)
Remotes.OpenPlotsShop.OnClientEvent:Connect(ShopOpener)

Remotes.UpdateOwnedPlots.OnClientEvent:Connect(function()
    task.delay(0, function()
        ShopOpener("Plot")
    end)
end)