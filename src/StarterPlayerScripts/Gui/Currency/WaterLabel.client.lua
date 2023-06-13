local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer
local PlayerGUI = player.PlayerGui

local State = require(ReplicatedStorage.Client.State)
local Remotes = ReplicatedStorage.Remotes

local GUI = PlayerGUI:WaitForChild("Stats")
local HolderFrame = GUI.HolderFrame
local Wateramount = HolderFrame.WaterFrame.TextLabel

local WATER = "Water: REPLACE"
-- Updates the water amount text based on the player's water data.
local function UpdateWater()
    Wateramount.Text = WATER:gsub("REPLACE", State.GetData().Water .. "/" .. State.GetData().EquippedWaterCan.Capacity)
end

-- Calls the UpdateWater function after a short delay to ensure the data is up to date.
local function CallingtheUpdate()
    task.delay(0, function()
        UpdateWater()
    end)
end

-- Connects the OnClientEvent of the UpdateWater remote event to call the CallingtheUpdate function.
Remotes.UpdateWater.OnClientEvent:Connect(function()
    CallingtheUpdate()
end)

-- Connects the OnClientEvent of the ChangeEquippedWateringCan remote event to call the CallingtheUpdate function.
Remotes.ChangeEquippedWateringCan.OnClientEvent:Connect(function()
    CallingtheUpdate()
end)

-- Connects the OnClientEvent of the RefillWater remote event to call the CallingtheUpdate function.
Remotes.RefillWater.OnClientEvent:Connect(function()
    CallingtheUpdate()
end)

-- Connects the OnClientEvent of the ResetData remote event to call the CallingtheUpdate function.
Remotes.ResetData.OnClientEvent:Connect(function()
    CallingtheUpdate()
end)

-- Call the UpdateWater function initially to set the initial water amount text.
UpdateWater()
