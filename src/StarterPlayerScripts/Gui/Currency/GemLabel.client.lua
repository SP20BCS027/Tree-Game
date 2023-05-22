local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer
local PlayerGUI = player.PlayerGui

local State = require(ReplicatedStorage.Client.State)
local Remotes = ReplicatedStorage.Remotes

local GUI = PlayerGUI:WaitForChild("Stats")
local HolderFrame = GUI.HolderFrame
local GemAmount = HolderFrame.GemFrame.TextLabel
local GEMS = "Gems: REPLACE"

local function UpdateGem()
	GemAmount.Text = GEMS:gsub("REPLACE", State.GetData().Gems)
end

local function CallingtheUpdate()
	task.delay(0, function()
		UpdateGem()
	end)
end

CallingtheUpdate()

Remotes.ResetData.OnClientEvent:Connect(function()
	CallingtheUpdate()
end)