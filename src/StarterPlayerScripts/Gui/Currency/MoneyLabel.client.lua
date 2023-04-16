local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer
local PlayerGUI = player.PlayerGui

local StateManager = require(ReplicatedStorage.Client.State)
local Remotes = ReplicatedStorage.Remotes

local GUI = PlayerGUI:WaitForChild("Stats")
local Outline = GUI.Frame
local Moneyamount = Outline.MoneyFrame.Amount

local function UpdateCurrency()
	Moneyamount.Text = StateManager.GetData().Money
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

