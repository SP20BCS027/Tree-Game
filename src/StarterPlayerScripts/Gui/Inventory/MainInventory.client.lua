local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer

local MainInventoryManager = require(player:WaitForChild("PlayerScripts").Gui.Inventory.MainInventoryManager)

local MainInventoryUI = player.PlayerGui:WaitForChild("MainInventory")
local InventoryButtonUI = player.PlayerGui:WaitForChild("InventoryButton")

local InventoryButton = InventoryButtonUI.Frame.Inventory

local MainFrame = MainInventoryUI.MainFrame
local ButtonsFrame = MainFrame.ButtonsFrame

local BackpackButton = ButtonsFrame.BackpackButtonFrame.TextButton
local FertilizerButton = ButtonsFrame.FertilizerButtonFrame.TextButton
local SeedButton = ButtonsFrame.SeedButtonFrame.TextButton
--local ToolButton = ButtonsFrame.ToolButtonFrame.TextButton
local WaterCanButton = ButtonsFrame.WaterCanButtonFrame.TextButton

BackpackButton.MouseButton1Down:Connect(function()
    MainInventoryManager.GenerateInventory("Backpacks")
end)

FertilizerButton.MouseButton1Down:Connect(function()
    MainInventoryManager.GenerateInventory("Fertilizers")
end)

SeedButton.MouseButton1Down:Connect(function()
    MainInventoryManager.GenerateInventory("Seeds")
end)

WaterCanButton.MouseButton1Down:Connect(function()
    MainInventoryManager.GenerateInventory("WaterCans")
end)

InventoryButton.MouseButton1Down:Connect(function()
    local currentInventory = MainInventoryManager.GetCurrentInventory()
    if currentInventory then 
        MainInventoryManager.GenerateInventory(currentInventory)
    end 
    MainInventoryUI.Enabled = not MainInventoryUI.Enabled
end)

ReplicatedStorage.Remotes.Bindables.OnReset.GenerateMainInventory.Event:Connect(function()
    local currentInventory = MainInventoryManager.GetCurrentInventory()
    if currentInventory then 
        MainInventoryManager.GenerateInventory(currentInventory)
    end 
end) 