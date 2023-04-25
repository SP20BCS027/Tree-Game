local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes
local player = game.Players.LocalPlayer

local UI = player.PlayerGui:WaitForChild("WaterRefill")
local RefillIcon = UI.IconHolder

local function RefillWater()
	Remotes.RefillWater:FireServer()
end

local function AdorneeUI(object)
	RefillIcon.Enabled = true
	RefillIcon.Adornee = object
end

RefillIcon.Holder.WaterButton.MouseButton1Down:Connect(function()
	RefillWater()
end)

Remotes.EstablishWaterRefillUI.OnClientEvent:Connect(AdorneeUI)