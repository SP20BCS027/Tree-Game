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
	Moneyamount.Text = MONEY_AMOUNT_TEXT:gsub("AMOUNT", StateManager.GetData().Money).." / "..MONEY_CAPACITY_TEXT:gsub("CAPACITY", StateManager.GetData().EquippedBackpack.Capacity)
end

UpdateCurrency()

Remotes.UpdateMoney.OnClientEvent:Connect(function()
	task.delay(0, function()
		UpdateCurrency()
	end)
end)

Remotes.SellAllMoney.OnClientEvent:Connect(function()
	task.delay(0, function()
		UpdateCurrency()
	end)
end)

