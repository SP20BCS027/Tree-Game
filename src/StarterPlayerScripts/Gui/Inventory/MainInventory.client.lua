local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer

local MainInventoryManager = require(player:WaitForChild("PlayerScripts").Gui.Inventory.MainInventoryManager)
local SoundsManager = require(player:WaitForChild("PlayerScripts").Gui.Sounds.SoundsManager)
local UISettings = require(player:WaitForChild("PlayerScripts").Gui.UISettings.UISettings)

local MainInventoryUI = player.PlayerGui:WaitForChild("MainInventory")
local InventoryButtonUI = player.PlayerGui:WaitForChild("InventoryButton")

local InventoryButton = InventoryButtonUI.Frame.Inventory

local MainFrame = MainInventoryUI.MainFrame
local FarmButtons = MainFrame.FarmButtons
local BattleButtons = MainFrame.BattleButtons

-- Farm Buttons
local BackpackButton = FarmButtons.BackpackButtonFrame.TextButton
local FertilizerButton = FarmButtons.FertilizerButtonFrame.TextButton
local SeedButton = FarmButtons.SeedButtonFrame.TextButton
local WaterCanButton = FarmButtons.WaterCanButtonFrame.TextButton

-- Battle Buttons
local EggsButton = BattleButtons.EggsButtonFrame.TextButton
local WeaponsButton = BattleButtons.WeaponsButtonFrame.TextButton
local ArmorsButton = BattleButtons.ArmorButtonFrame.TextButton
local PotionsButton = BattleButtons.PotionsButtonFrame.TextButton
local PetsButton = BattleButtons.PetsButtonFrame.TextButton

-- When the Backpack button is pressed, generate the "Backpacks" inventory
BackpackButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    MainInventoryManager.GenerateInventory("Backpacks")
end)

-- When the Fertilizer button is pressed, generate the "Fertilizers" inventory
FertilizerButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    MainInventoryManager.GenerateInventory("Fertilizers")
end)

-- When the Seed button is pressed, generate the "Seeds" inventory
SeedButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    MainInventoryManager.GenerateInventory("Seeds")
end)

-- When the Watering Can button is pressed, generate the "WaterCans" inventory
WaterCanButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    MainInventoryManager.GenerateInventory("WaterCans")
end)

-- When the Eggs button is pressed, generate the "Eggs" inventory
EggsButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    MainInventoryManager.GenerateInventory("Eggs")
end)

-- When the Weapons button is pressed, generate the "Weapons" Inventory
WeaponsButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    MainInventoryManager.GenerateInventory("Weapons")
end)

-- When the Weapons button is pressed, generate the "Armors" Inventory
ArmorsButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    MainInventoryManager.GenerateInventory("Armors")
end)

-- When the Weapons button is pressed, generate the "Potions" Inventory
PotionsButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    MainInventoryManager.GenerateInventory("Potions")
end)

-- When the Weapons button is pressed, generate the "Pets" Inventory
PetsButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    MainInventoryManager.GenerateInventory("Pets")
end)

-- When the Inventory button is pressed, toggle the visibility of the MainInventoryUI
InventoryButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    local currentInventory = MainInventoryManager.GetCurrentInventory()
    currentInventory = currentInventory or "Backpacks"
    MainInventoryManager.GenerateInventory(currentInventory)
    UISettings.DisableAll("MainInventory")
    MainInventoryUI.Enabled = not MainInventoryUI.Enabled
end)

-- When the owned backpacks are updated, regenerate the current inventory
ReplicatedStorage.Remotes.UpdateOwnedBackpacks.OnClientEvent:Connect(function() 
    local currentInventory = MainInventoryManager.GetCurrentInventory()
    if currentInventory then 
        task.delay(0, function()
            MainInventoryManager.GenerateInventory(currentInventory)
        end)
    end 
end)

-- When the owned water cans are updated, regenerate the current inventory
ReplicatedStorage.Remotes.UpdateOwnedWaterCans.OnClientEvent:Connect(function()
    local currentInventory = MainInventoryManager.GetCurrentInventory()
    if currentInventory then 
        task.delay(0, function()
            MainInventoryManager.GenerateInventory(currentInventory)
        end)    
    end
end)

-- When the data is reset, regenerate the current inventory
ReplicatedStorage.Remotes.ResetData.OnClientEvent:Connect(function()
    local currentInventory = MainInventoryManager.GetCurrentInventory()
    if currentInventory then 
        task.delay(0, function()
            MainInventoryManager.GenerateInventory(currentInventory)
        end)    
    end 
end) 
