local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes
local player = game.Players.LocalPlayer

local StateManager = require(ReplicatedStorage.Client.State)
local UI = player.PlayerGui:WaitForChild("Shops")
local WaterShop = UI.WaterShopButton
local BackpackShop = UI.BackpackShopButton

WaterShop.MouseButton1Down:Connect(function()
	Remotes.Bindables.WaterShopOpener:Fire()
end)

BackpackShop.MouseButton1Down:Connect(function()
	Remotes.Bindables.BackpackShopOpener:Fire()
end)