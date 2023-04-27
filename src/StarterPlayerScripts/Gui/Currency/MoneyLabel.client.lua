local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer
local PlayerGUI = player.PlayerGui

local State = require(ReplicatedStorage.Client.State)
local Remotes = ReplicatedStorage.Remotes

local GUI = PlayerGUI:WaitForChild("Stats")
local Outline = GUI.Frame
local Moneyamount = Outline.MoneyFrame.Amount

local function UpdateCurrency()
	Moneyamount.Text = State.GetData().Money .. "/" .. State.GetData().EquippedBackpack.Capacity
end

UpdateCurrency()

local function CallingtheUpdate()
	task.delay(0, function()
		UpdateCurrency()
	end)
end

Remotes.UpdateMoney.OnClientEvent:Connect(function()
	CallingtheUpdate()
end)

Remotes.ChangeEquippedBackpack.OnClientEvent:Connect(function()
	CallingtheUpdate()
end)

Remotes.SellAllMoney.OnClientEvent:Connect(function()
	CallingtheUpdate()
end)

Remotes.Bindables.OnReset.ResetMoney.Event:Connect(function()
	CallingtheUpdate()
end)