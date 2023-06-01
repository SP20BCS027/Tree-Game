local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer

local SoundsManager = require(player:WaitForChild("PlayerScripts").Gui.Sounds.SoundsManager)
local IndexManager = require(player:WaitForChild("PlayerScripts").Gui.Indexes.IndexManager)

local InventoryButtonUI = player.PlayerGui:WaitForChild("InventoryButton")
local IndexButton = InventoryButtonUI.Frame.Index

IndexButton.MouseButton1Down:Connect(function()
    IndexManager.ToggleSelectMenu()
    IndexManager.UpdateTreeIndexStats()
end)


