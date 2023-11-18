local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")

local player = game.Players.LocalPlayer

local CombatInventoryManager = require(player:WaitForChild("PlayerScripts").Gui.Inventory.CombatInventoryManager)
local SoundsManager = require(player:WaitForChild("PlayerScripts").Gui.Sounds.SoundsManager)
local UISettings = require(player:WaitForChild("PlayerScripts").Gui.UISettings.UISettings)

local CombatInventoryUI = player.PlayerGui:WaitForChild("CombatInventory")
local InventoryButtonUI = player.PlayerGui:WaitForChild("InventoryButton")

local CombatInventoryButton = InventoryButtonUI.Frame.Combat

local MainFrame = CombatInventoryUI.MainFrame
local BattleButtons = MainFrame.BattleButtons

-- Battle Buttons
local EggsButton = BattleButtons.EggsButtonFrame.TextButton
local WeaponsButton = BattleButtons.WeaponsButtonFrame.TextButton
local ArmorsButton = BattleButtons.ArmorButtonFrame.TextButton
local PotionsButton = BattleButtons.PotionsButtonFrame.TextButton
local PetsButton = BattleButtons.PetsButtonFrame.TextButton
local KeysButton = BattleButtons.KeysButtonFrame.TextButton

-- When the Eggs button is pressed, generate the "Eggs" inventory
EggsButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    CombatInventoryManager.GenerateInventory("Eggs")
end)

-- When the Weapons button is pressed, generate the "Weapons" Inventory
WeaponsButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    CombatInventoryManager.GenerateInventory("Weapons")
end)

-- When the Weapons button is pressed, generate the "Armors" Inventory
ArmorsButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    CombatInventoryManager.GenerateInventory("Armors")
end)

-- When the Weapons button is pressed, generate the "Potions" Inventory
PotionsButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    CombatInventoryManager.GenerateInventory("Potions")
end)

-- When the Weapons button is pressed, generate the "Pets" Inventory
PetsButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    CombatInventoryManager.GenerateInventory("Pets")
end)

KeysButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    CombatInventoryManager.GenerateInventory("Keys")
end)

-- When the Inventory button is pressed, toggle the visibility of the MainInventoryUI
CombatInventoryButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    local currentInventory = CombatInventoryManager.GetCurrentInventory()
    currentInventory = currentInventory or "Weapons"
    CombatInventoryManager.GenerateInventory(currentInventory)
    
    UISettings.DisableAll("CombatInventory")
    CombatInventoryUI.Enabled = not CombatInventoryUI.Enabled
end)

ReplicatedStorage.Remotes.ChangeEquippedPets.OnClientEvent:Connect(function()
    local currentInventory = CombatInventoryManager.GetCurrentInventory()
    local currentWeapon = CombatInventoryManager.GetCurrentWeaponType()
    local currentPotion = CombatInventoryManager.GetCurrentPotionType()
    local currentElement = CombatInventoryManager.GetCurrentElement()
    local currentArmor = CombatInventoryManager.GetCurrentArmorType()

    if currentInventory then 
        task.delay(0, function()
            CombatInventoryManager.GenerateInventory(currentInventory, currentWeapon, currentElement, currentPotion, currentArmor)
        end)
    end 
end)

ReplicatedStorage.Remotes.UpdateOwnedEggs.OnClientEvent:Connect(function()
    local currentInventory = CombatInventoryManager.GetCurrentInventory()
    local currentWeapon = CombatInventoryManager.GetCurrentWeaponType()
    local currentPotion = CombatInventoryManager.GetCurrentPotionType()
    local currentElement = CombatInventoryManager.GetCurrentElement()
    local currentArmor = CombatInventoryManager.GetCurrentArmorType()

    if currentInventory then 
        task.delay(0, function()
            CombatInventoryManager.GenerateInventory(currentInventory, currentWeapon, currentElement, currentPotion, currentArmor)
        end)
    end 
end)

-- When the data is reset, regenerate the current inventory
ReplicatedStorage.Remotes.ResetData.OnClientEvent:Connect(function()
    local currentInventory = CombatInventoryManager.GetCurrentInventory()
    if currentInventory then 
        task.delay(0, function()
            CombatInventoryManager.GenerateInventory(currentInventory)
        end)    
    end 
end) 
