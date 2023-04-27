local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes
local player = game.Players.LocalPlayer

local AllShops = player.PlayerGui:WaitForChild("Shops")
local WaterShop = AllShops.WaterShopButton
local BackpackShop = AllShops.BackpackShopButton

WaterShop.MouseButton1Down:Connect(function()
	Remotes.Bindables.WaterShopOpener:Fire()
end)

BackpackShop.MouseButton1Down:Connect(function()
	Remotes.Bindables.BackpackShopOpener:Fire()
end)