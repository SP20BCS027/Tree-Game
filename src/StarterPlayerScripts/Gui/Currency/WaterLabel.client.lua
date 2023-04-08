local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer
local PlayerGUI = player.PlayerGui

local StateManager = require(ReplicatedStorage.Client.State)
local Remotes = ReplicatedStorage.Remotes

local GUI = PlayerGUI:WaitForChild("Stats")
local Outline = GUI.Frame
local Moneyamount = Outline.WaterFrame.Amount

local WATER_AMOUNT = "AMOUNT"
local WATER_CAPACITY = "CAPACITY"

local function UpdateWater()
	Moneyamount.Text = WATER_AMOUNT:gsub("AMOUNT", StateManager.GetData().Water).." / "..WATER_CAPACITY:gsub("CAPACITY", StateManager.GetData().EquippedWaterCan.Capacity)
end

UpdateWater()

Remotes.UpdateWater.OnClientEvent:Connect(function()
	task.delay(0, function()
		UpdateWater()
	end)
end)

Remotes.RefillWater.OnClientEvent:Connect(function()
	task.delay(0, function()
		UpdateWater()
	end)
end)

