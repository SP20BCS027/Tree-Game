local MainInventory = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local State = require(ReplicatedStorage.Client.State)

local Configs = {}

--local ToolsConfig

local CurrentDirectory

local player = game.Players.LocalPlayer

local MainInventoryUI = player.PlayerGui:WaitForChild("MainInventory")
local MainFrame = MainInventoryUI.MainFrame
local CloseButton = MainFrame.CloseFrame.CloseButton

local InventoryFrame = MainFrame.InventoryFrame
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

local SelectedItem
local CurrentInventory
local EquippedItem

local function GetDataFromClient()
    Configs["Backpacks"] = State.GetData().OwnedBackpacks
    Configs["Fertilizers"] = State.GetData().Fertilizers 
    Configs["Seeds"] = State.GetData().Seeds
    Configs["WaterCans"] = State.GetData().OwnedWaterCans
    Configs["EquippedBackpack"] = State.GetData().EquippedBackpack
    Configs["EquippedWaterCan"] = State.GetData().EquippedWaterCan
end

local function SetCurrentConfig(setID)
    GetDataFromClient()
    CurrentDirectory = Configs[setID]
end

local function HideStats()
    IconAmount.Visible = false
    IconName.Visible = false
    DescriptionFrame.Visible = false
    EquipButton.Visible = false
    IconImage.Visible = false
end 

local function HideEquipButton()
    if CurrentInventory == "Backpacks" or CurrentInventory == "WaterCans" then 
        EquipButton.Visible = true
        EquipButton.Text = "Equip"
    end
end

local function ShowStats(item)
    IconAmount.Visible = true
    IconName.Visible = true
    DescriptionFrame.Visible = true

    HideEquipButton()

    if item.Name == EquippedItem then 
        EquipButton.Text = "Already Equipped"
    end
    IconImage.Visible = true
end

local function ResetTransparency()
    for _, item in ScrollingFrame:GetChildren() do 
        if item.Name == "UIGridLayout" then continue end
        item.BackgroundTransparency = 0
    end
end

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
    local icon = Template:Clone()
    icon.Parent = ScrollingFrame
    icon.Name = item.Name
    icon.ItemName.Text = item.Name
	if icon.Name == Configs["EquippedBackpack"].Name or icon.Name == Configs["EquippedWaterCan"].Name  then 
        icon.EquippedIcon.Visible = true 
        EquippedItem = item.Name
    end 
    if item.Amount then 
        if item.Amount > 0 then 
            icon.Visible = true 
        end
    else
        icon.Visible = true
    end

    icon.MouseButton1Down:Connect(function()
        ResetTransparency()
        SelectedItem = item.Name
        icon.BackgroundTransparency = 0.5

        LoadStats(item)
    end)
end

local function ClearInventory()
    for _, icon in ScrollingFrame:GetChildren() do 
        if icon.Name == "UIGridLayout" then continue end 
        icon:Destroy()
    end
end

function MainInventory.ChangeEquipped()
    GetDataFromClient()
    for _, item in ScrollingFrame:GetChildren() do 
        if item.Name == "UIGridLayout" then continue end 
        item.EquippedIcon.Visible = false
        if item.Name == Configs["EquippedBackpack"].Name or item.Name == Configs["EquippedWaterCan"].Name then 
            item.EquippedIcon.Visible = true
        end
        EquipButton.Text = "Already Equipped"
    end
end

function MainInventory.GenerateInventory(setID)
    SetCurrentConfig(setID)
    GetDataFromClient()
    ClearInventory()
    HideStats()

    CurrentInventory = setID

    for _, item in CurrentDirectory do 
        CreateIcon(item)
    end 
end 

EquipButton.MouseButton1Down:Connect(function()
    if not SelectedItem then return end
    if SelectedItem == EquippedItem then return end 

    EquippedItem = SelectedItem
    
    if CurrentInventory == "Backpacks" then 
        ReplicatedStorage.Remotes.ChangeEquippedBackpack:FireServer(SelectedItem)
    end
    if CurrentInventory == "WaterCans" then 
        ReplicatedStorage.Remotes.ChangeEquippedWateringCan:FireServer(SelectedItem)
    end
end)

ReplicatedStorage.Remotes.ChangeEquippedWateringCan.OnClientEvent:Connect(function()
    task.delay(0, MainInventory.ChangeEquipped)
end)

ReplicatedStorage.Remotes.ChangeEquippedBackpack.OnClientEvent:Connect(function()
    task.delay(0, MainInventory.ChangeEquipped)
end)

CloseButton.MouseButton1Down:Connect(function()
    MainInventoryUI.Enabled = false 
end)

return MainInventory