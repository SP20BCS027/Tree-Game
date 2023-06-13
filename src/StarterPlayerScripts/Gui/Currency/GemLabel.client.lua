local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer
local PlayerGUI = player.PlayerGui

local State = require(ReplicatedStorage.Client.State)
local Remotes = ReplicatedStorage.Remotes

local GUI = PlayerGUI:WaitForChild("Stats")
local HolderFrame = GUI.HolderFrame
local GemAmount = HolderFrame.GemFrame.TextLabel
local GEMS = "Gems: REPLACE"

-- Function to update the Gem amount displayed in the GUI
local function UpdateGem()
	GemAmount.Text = GEMS:gsub("REPLACE", State.GetData().Gems)
end

-- Function to call the UpdateGem function with a delay
local function CallingtheUpdate()
	task.delay(0, function()
		UpdateGem()
	end)
end

CallingtheUpdate()

-- Event handler for when the Gems are updated on the client
Remotes.UpdateGems.OnClientEvent:Connect(function()
	CallingtheUpdate()
end)

-- Event handler for when the data is reset on the client
Remotes.ResetData.OnClientEvent:Connect(function()
	CallingtheUpdate()
end)
