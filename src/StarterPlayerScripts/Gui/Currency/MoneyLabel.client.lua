local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer
local PlayerGUI = player.PlayerGui

local StateManager = require(ReplicatedStorage.Client.State)
local Remotes = ReplicatedStorage.Remotes

local GUI = PlayerGUI:WaitForChild("Stats")
local Outline = GUI.Frame
local Moneyamount = Outline.MoneyFrame.Amount

local MONEY_AMOUNT_TEXT = "AMOUNT"
local MONEY_CAPACITY_TEXT = "CAPACITY"

local function UpdateCurrency()
	Moneyamount.Text = StateManager.GetData().Money .. "/" .. StateManager.GetData().EquippedBackpack.Capacity
end

UpdateCurrency()

local function callingtheUpdate()
	task.delay(0, function()
		UpdateCurrency()
	end)
end

Remotes.UpdateMoney.OnClientEvent:Connect(function()
	callingtheUpdate()
end)

Remotes.ChangeEquippedBackpack.OnClientEvent:Connect(function()
	callingtheUpdate()
end)

Remotes.SellAllMoney.OnClientEvent:Connect(function()
	callingtheUpdate()
end)

Remotes.Bindables.OnReset.ResetMoney.Event:Connect(function()
	callingtheUpdate()
end)