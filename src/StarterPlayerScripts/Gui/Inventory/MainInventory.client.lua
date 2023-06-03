local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer

local MainInventoryManager = require(player:WaitForChild("PlayerScripts").Gui.Inventory.MainInventoryManager)
local SoundsManager = require(player:WaitForChild("PlayerScripts").Gui.Sounds.SoundsManager)
local UISettings = require(player:WaitForChild("PlayerScripts").Gui.UISettings.UISettings)

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
    SoundsManager.PlayPressSound()
    MainInventoryManager.GenerateInventory("Backpacks")
end)

FertilizerButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    MainInventoryManager.GenerateInventory("Fertilizers")
end)

SeedButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    MainInventoryManager.GenerateInventory("Seeds")
end)

WaterCanButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    MainInventoryManager.GenerateInventory("WaterCans")
end)

InventoryButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    local currentInventory = MainInventoryManager.GetCurrentInventory()
    currentInventory = if currentInventory then currentInventory else "Backpacks"
    MainInventoryManager.GenerateInventory(currentInventory)
    UISettings.DisableAll("MainInventory")
    MainInventoryUI.Enabled = not MainInventoryUI.Enabled
end)

ReplicatedStorage.Remotes.UpdateOwnedBackpacks.OnClientEvent:Connect(function() 
    local currentInventory = MainInventoryManager.GetCurrentInventory()
    if currentInventory then 
        task.delay(0, function()
            MainInventoryManager.GenerateInventory(currentInventory)
        end)
    end 
end)

ReplicatedStorage.Remotes.UpdateOwnedWaterCans.OnClientEvent:Connect(function()
    local currentInventory = MainInventoryManager.GetCurrentInventory()
    if currentInventory then 
        task.delay(0, function()
            MainInventoryManager.GenerateInventory(currentInventory)
        end)    
    end
end)

ReplicatedStorage.Remotes.ResetData.OnClientEvent:Connect(function()
    local currentInventory = MainInventoryManager.GetCurrentInventory()
    if currentInventory then 
        task.delay(0, function()
            MainInventoryManager.GenerateInventory(currentInventory)
        end)    
    end 
end) 