local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer
local PlayerGUI = player.PlayerGui

local State = require(ReplicatedStorage.Client.State)
local Remotes = ReplicatedStorage.Remotes

local GUI = PlayerGUI:WaitForChild("Stats")
local HolderFrame = GUI.HolderFrame
local Moneyamount = HolderFrame.MoneyFrame.TextLabel

local MONEY = "Money: REPLACE"

-- Updates the currency amount text based on the player's money data.
local function UpdateCurrency()
    Moneyamount.Text = MONEY:gsub("REPLACE", State.GetData().Money .. "/" .. State.GetData().EquippedBackpack.Capacity)
end

-- Calls the UpdateCurrency function after a short delay to ensure the data is up to date.
local function CallingtheUpdate()
    task.delay(0, function()
        UpdateCurrency()
    end)
end

-- Connects the OnClientEvent of the UpdateMoney remote event to call the CallingtheUpdate function.
Remotes.UpdateMoney.OnClientEvent:Connect(function()
    CallingtheUpdate()
end)

-- Connects the OnClientEvent of the ChangeEquippedBackpack remote event to call the CallingtheUpdate function.
Remotes.ChangeEquippedBackpack.OnClientEvent:Connect(function()
    CallingtheUpdate()
end)

-- Connects the OnClientEvent of the SellAllMoney remote event to call the CallingtheUpdate function.
Remotes.SellAllMoney.OnClientEvent:Connect(function()
    CallingtheUpdate()
end)

-- Connects the OnClientEvent of the FillupBackpack remote event to call the CallingtheUpdate function.
Remotes.FillupBackpack.OnClientEvent:Connect(function()
    CallingtheUpdate()
end)

-- Connects the OnClientEvent of the ResetData remote event to call the CallingtheUpdate function.
Remotes.ResetData.OnClientEvent:Connect(function()
    CallingtheUpdate()
end)

-- Call the UpdateCurrency function initially to set the initial currency amount text.
UpdateCurrency()
