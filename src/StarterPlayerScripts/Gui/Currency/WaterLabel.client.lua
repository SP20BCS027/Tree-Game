local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer
local PlayerGUI = player.PlayerGui

local StateManager = require(ReplicatedStorage.Client.State)
local Remotes = ReplicatedStorage.Remotes

local GUI = PlayerGUI:WaitForChild("Stats")
local Outline = GUI.Frame
local Moneyamount = Outline.WaterFrame.Amount


local function UpdateWater()
	Moneyamount.Text = StateManager.GetData().Water .. "/" .. StateManager.GetData().EquippedWaterCan.Capacity
end

UpdateWater()

local function callingtheUpdate()
	task.delay(0, function()
		UpdateWater()
	end)
end

Remotes.UpdateWater.OnClientEvent:Connect(function()
	callingtheUpdate()
end)

Remotes.ChangeEquippedWateringCan.OnClientEvent:Connect(function()
	callingtheUpdate()
end)

Remotes.RefillWater.OnClientEvent:Connect(function()
	callingtheUpdate()
end)

Remotes.Bindables.OnReset.ResetWater.Event:Connect(function()
	callingtheUpdate()
end)
