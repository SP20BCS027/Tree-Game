local MainInventory = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local State = require(ReplicatedStorage.Client.State)

local player = game.Players.LocalPlayer

local InventoryUIColors = require(ReplicatedStorage.Configs.InventoryUIColors)
local ScalingUI = require(player:WaitForChild("PlayerScripts").Gui.ScalingUI.ScalingUI)
local SoundsManager = require(player:WaitForChild("PlayerScripts").Gui.Sounds.SoundsManager)

local Configs = {}

local CurrentDirectory

local MainInventoryUI = player.PlayerGui:WaitForChild("MainInventory")
local MainFrame = MainInventoryUI.MainFrame

local BackgroundFrame = MainFrame.BackgroundFrame
local HeadingFrame = MainFrame.HeadingFrame
local HeadingFrameBackground = MainFrame.HeadingFrameBackground

local FarmButtons = MainFrame.FarmButtons
local BattleButtons = MainFrame.BattleButtons

local CloseButton = MainFrame.CloseFrame.CloseButton

local InventoryFrame = MainFrame.InventoryFrame
local EmptyFrame = InventoryFrame.EmptyFrame
local ScrollingFrame = InventoryFrame.ScrollingFrame
local Template = InventoryFrame.Template

local EquippedFrame = MainFrame.EquippedFrame
local IconImage = EquippedFrame.IconImage
local IconName = EquippedFrame.Stats.IconName
local IconAmount = EquippedFrame.Stats.IconAmount
local IconDescription = EquippedFrame.Stats.Description.IconDescription
local DescriptionFrame = EquippedFrame.Stats.Description
local EquipButton = EquippedFrame.Stats.EquipButton

local ITEM_NAME = "Name: REPLACE"
local ITEM_AMOUNT = "Amount: REPLACE"
local ITEM_CAPACITY = "Capacity: REPLACE"

local ORIGINAL_SIZE_OF_EQUIPBUTTON = EquipButton.Size
local ORIGINAL_SIZE_OF_CLOSEBUTTON = CloseButton.Size

local TOTALITEMS

local SelectedItem
local CurrentInventory
local CurrentInventoryType = "Farm"
local EquippedItem

-- This function loads the most updated data in the Configs table
local function GetDataFromClient()
    Configs["Backpacks"] = State.GetData().OwnedBackpacks
    Configs["Fertilizers"] = State.GetData().Fertilizers 
    Configs["Seeds"] = State.GetData().Seeds
    Configs["WaterCans"] = State.GetData().OwnedWaterCans
    Configs["EquippedBackpack"] = State.GetData().EquippedBackpack
    Configs["EquippedWaterCan"] = State.GetData().EquippedWaterCan

    Configs["Weapons"] = State.GetData().OwnedWeapons
    Configs["Armors"] = State.GetData().OwnedArmors
    Configs["Pets"] = State.GetData().OwnedPets
    Configs["Potions"] = State.GetData().OwnedPotions
    Configs["Eggs"] = State.GetData().Eggs
    Configs["EquippedPotions"] = State.GetData().EquippedPotions
    Configs["EquippedWeapons"] = State.GetData().EquippedWeapons
    Configs["EquippedPets"] = State.GetData().EquippedPets
    Configs["EquippedArmors"] = State.GetData().EquippedArmor
end

-- This function sets the current directory variable
local function SetCurrentConfig(setID)
    GetDataFromClient()
    CurrentDirectory = Configs[setID]
end

-- This function hides all the stats of the information frame
local function HideStats()
    IconAmount.Visible = false
    IconName.Visible = false
    DescriptionFrame.Visible = false
    EquipButton.Visible = false
    IconImage.Visible = false
end

-- This function makes the Equip Button visible if the inventory is either Backpack or Watering Can
local function ShowEquipButton()
    if CurrentInventory == "Backpacks" or CurrentInventory == "WaterCans" then 
        EquipButton.Visible = true
        EquipButton.Text = "Equip"
    elseif CurrentInventory == "Weapons" or CurrentInventory == "Armors" then
        EquipButton.Visible = true
        EquipButton.Text = "Use"
    end
end

-- This function makes the items in the information frame visible
local function ShowStats(item)
    IconAmount.Visible = true
    IconName.Visible = true
    DescriptionFrame.Visible = true

    ShowEquipButton()

    if item.Name == EquippedItem then 
        EquipButton.Text = "Equipped"
    end
    IconImage.Visible = true
end

-- This function updates the colors of the inventory UI
local function ChangeColors()
    BackgroundFrame.BackgroundColor3 = InventoryUIColors[CurrentInventory].BackgroundFrame
    HeadingFrame.BackgroundColor3 = InventoryUIColors[CurrentInventory].HeadingFrame
    HeadingFrameBackground.BackgroundColor3 = InventoryUIColors[CurrentInventory].HeadingFrameBackground
    InventoryFrame.BackgroundColor3 = InventoryUIColors[CurrentInventory].InventoryFrame    
    EquippedFrame.BackgroundColor3 = InventoryUIColors[CurrentInventory].EquippedFrame
    DescriptionFrame.BackgroundColor3 = InventoryUIColors[CurrentInventory].DescriptionFrame
    IconAmount.BackgroundColor3 = InventoryUIColors[CurrentInventory].IconAmount
    IconName.BackgroundColor3 = InventoryUIColors[CurrentInventory].IconName
    IconImage.BackgroundColor3 = InventoryUIColors[CurrentInventory].IconImage
end

-- This function resets the transparency of all icons back to 0
local function ResetTransparency()
    for _, item in ScrollingFrame:GetChildren() do 
        if item.Name == "UIGridLayout" then continue end
        item.BackgroundTransparency = 0
    end
end

-- When an icon gets selected, this function is called to load its stats in the information frame
local function LoadStats(item)
    ShowStats(item)

    IconName.Text = ITEM_NAME:gsub("REPLACE", item.Name)
    IconDescription.Text = item.Description
    if item.Amount then 
        IconAmount.Text = ITEM_AMOUNT:gsub("REPLACE", item.Amount)
    elseif item.Capacity then 
        IconAmount.Text = ITEM_CAPACITY:gsub("REPLACE", item.Capacity)
    end
end

local function CreateIcon(item)
    TOTALITEMS += 1

    -- Clone the template and set its parent to the ScrollingFrame
    local icon = Template:Clone()
    icon.Parent = ScrollingFrame
    icon.Name = item.Name
    icon.ItemName.Text = item.Name

    if item.imageID then
        icon.ImageLabel.Image = item.imageID
    end

    -- Set the layout order if provided
    if item.LayoutOrder then 
        icon.LayoutOrder = item.LayoutOrder
    end

    -- Check if the icon represents the equipped backpack or watering can
    if icon.Name == Configs["EquippedBackpack"].Name or icon.Name == Configs["EquippedWaterCan"].Name  then 
        icon.EquippedIcon.Visible = true 
        EquippedItem = item.Name
    end 

    -- Set icon visibility based on item amount
    if item.Amount then 
        if item.Amount > 0 then 
            icon.Visible = true 
        end
    else
        icon.Visible = true
    end

    -- Handle icon click event
    icon.MouseButton1Down:Connect(function()
        SoundsManager.PlayPressSound()
        ResetTransparency()
        SelectedItem = item.UID
        icon.BackgroundTransparency = 0.5
        LoadStats(item)
    end)
end

-- This function clears all the UI in the Menu
local function ClearInventory()
    for _, icon in ScrollingFrame:GetChildren() do 
        if icon.Name == "UIGridLayout" then continue end 
        icon:Destroy()
    end
end

-- When the Watering Can or Backpack is changed, this function updates the UI
function MainInventory.ChangeEquipped()
    GetDataFromClient()
    for _, item in ScrollingFrame:GetChildren() do 
        if item.Name == "UIGridLayout" then continue end 
        item.EquippedIcon.Visible = false
        if item.Name == Configs["EquippedBackpack"].Name or item.Name == Configs["EquippedWaterCan"].Name then 
            item.EquippedIcon.Visible = true
        end
    end
end

-- This function is responsible for generating the inventory with the desired ID
function MainInventory.GenerateInventory(setID)
    SetCurrentConfig(setID)
    GetDataFromClient()
    ClearInventory()
    HideStats()
    
    CurrentInventory = setID
    TOTALITEMS = 0
    ChangeColors()

    if CurrentInventory == "Potions" or CurrentInventory == "Weapons" or CurrentInventory == "Armors" or CurrentInventory == "Pets" or CurrentInventory == "Eggs" then 
        for _, subDir in CurrentDirectory do 
            for _, item in subDir do 
                CreateIcon(item)
            end
        end 
    else
        for _, item in CurrentDirectory do 
            CreateIcon(item)
        end 
    end

    if TOTALITEMS == 0 then 
        EmptyFrame.Visible = true
    else
        EmptyFrame.Visible = false
    end

end

function MainInventory.HideFarm()
    FarmButtons.Visible = false 
    BattleButtons.Visible = true
end

function MainInventory.HideBattle()
    FarmButtons.Visible = true
    BattleButtons.Visible = false
end

-- This function returns the current inventory as a string.
function MainInventory.GetCurrentInventory(): string
    return CurrentInventory
end

function MainInventory.GetCurrentInventoryType(): string 
    return CurrentInventoryType
end

-- When the Equip button is pressed, the selected item gets equipped if it is not already equipped.
EquipButton.MouseButton1Down:Connect(function()
    if not SelectedItem then return end
    if SelectedItem == EquippedItem then 
        SoundsManager.PlayDenialSound()
        print("The Selected Item is Already Equipped")
        return
    end 

    SoundsManager.PlayPressSound()
    EquippedItem = SelectedItem
    
    if CurrentInventory == "Backpacks" then 
        ReplicatedStorage.Remotes.ChangeEquippedBackpack:FireServer(SelectedItem)
        ReplicatedStorage.Remotes.GivePlayerBackpack:FireServer(SelectedItem)
    end
    if CurrentInventory == "WaterCans" then 
        ReplicatedStorage.Remotes.ChangeEquippedWateringCan:FireServer(SelectedItem)
    end

    if CurrentInventory == "Weapons" then 
        print(SelectedItem)
        print(EquippedItem)
        ReplicatedStorage.Remotes.ChangeEquippedWeapon:FireServer(SelectedItem)
        ReplicatedStorage.Remotes.GivePlayerWeaponTool:FireServer(SelectedItem)
    end

    EquipButton.Text = "Equipped"
end)

EquipButton.MouseEnter:Connect(function()
    SoundsManager.PlayEnterSound()
    EquipButton.Size = ScalingUI.IncreaseBy2Point5Percent(ORIGINAL_SIZE_OF_EQUIPBUTTON)
end)

EquipButton.MouseLeave:Connect(function()
    SoundsManager.PlayLeaveSound()
    EquipButton.Size = ORIGINAL_SIZE_OF_EQUIPBUTTON
end)

-- This updates the inventory after a delay.
ReplicatedStorage.Remotes.ChangeEquippedWateringCan.OnClientEvent:Connect(function()
    task.delay(0, MainInventory.ChangeEquipped)
end)

-- This updates the inventory after a delay.
ReplicatedStorage.Remotes.ChangeEquippedBackpack.OnClientEvent:Connect(function()
    task.delay(0, MainInventory.ChangeEquipped)
end)

-- When pressed, this function closes the inventory menu.
CloseButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayCloseSound()
    MainInventoryUI.Enabled = false 
end)

CloseButton.MouseEnter:Connect(function()
    SoundsManager.PlayEnterSound()
    CloseButton.Size = ScalingUI.IncreaseBy10Percent(ORIGINAL_SIZE_OF_CLOSEBUTTON)
end)

CloseButton.MouseLeave:Connect(function()
    SoundsManager.PlayLeaveSound()
    CloseButton.Size = ORIGINAL_SIZE_OF_CLOSEBUTTON
end)

HeadingFrame.Peace.TextButton.MouseButton1Down:Connect(function()
    MainInventory.GenerateInventory("Backpacks")
    MainInventory.HideBattle()
    CurrentInventoryType = "Peace"
end)

HeadingFrame.Battle.TextButton.MouseButton1Down:Connect(function()
    MainInventory.GenerateInventory("Pets")
    MainInventory.HideFarm()
    CurrentInventoryType = "Battle"
end)

return MainInventory