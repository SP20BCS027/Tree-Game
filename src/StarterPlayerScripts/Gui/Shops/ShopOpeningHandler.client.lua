local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local Remotes = ReplicatedStorage.Remotes

local ShopsManager = require(player:WaitForChild("PlayerScripts").Gui.Shops.ShopsManager)

-- Function to open a shop
local function ShopOpener(shopID, hideShop: boolean?)
    hideShop = if hideShop == false then hideShop else true
    ShopsManager.GenerateShop(shopID, hideShop)
end

Remotes.OpenBackpackShop.OnClientEvent:Connect(ShopOpener)
Remotes.OpenFertilizerShop.OnClientEvent:Connect(ShopOpener)
Remotes.OpenSeedsShop.OnClientEvent:Connect(ShopOpener)
Remotes.OpenWaterCanShop.OnClientEvent:Connect(ShopOpener)
Remotes.OpenPlotsShop.OnClientEvent:Connect(ShopOpener)

-- Connect client event for updating owned plots
Remotes.UpdateOwnedPlots.OnClientEvent:Connect(function()
    task.delay(0, function()
        ShopOpener("Plots", false)
    end)
end)

-- Connect client event for updating owned backpacks
Remotes.UpdateOwnedBackpacks.OnClientEvent:Connect(function()
    task.delay(0, function()
        ShopOpener("Backpacks", false)
    end)
end)

-- Connect client event for updating owned water cans
Remotes.UpdateOwnedWaterCans.OnClientEvent:Connect(function()
    task.delay(0, function()
        ShopOpener("WaterCans", false)
    end)
end)