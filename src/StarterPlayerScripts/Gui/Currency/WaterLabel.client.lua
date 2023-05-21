local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer
local PlayerGUI = player.PlayerGui

local State = require(ReplicatedStorage.Client.State)
local Remotes = ReplicatedStorage.Remotes

local GUI = PlayerGUI:WaitForChild("Stats")
local HolderFrame = GUI.HolderFrame
local Wateramount = HolderFrame.WaterFrame.TextLabel

local WATER = "Water: REPLACE"

local function UpdateWater()
	Wateramount.Text = WATER:gsub("REPLACE", State.GetData().Water .. "/" .. State.GetData().EquippedWaterCan.Capacity)
end

UpdateWater()

local function CallingtheUpdate()
	task.delay(0, function()
		UpdateWater()
	end)
end

Remotes.UpdateWater.OnClientEvent:Connect(function()
	CallingtheUpdate()
end)

Remotes.ChangeEquippedWateringCan.OnClientEvent:Connect(function()
	CallingtheUpdate()
end)

Remotes.RefillWater.OnClientEvent:Connect(function()
	CallingtheUpdate()
end)

Remotes.Bindables.OnReset.ResetWater.Event:Connect(function()
	CallingtheUpdate()
end)
