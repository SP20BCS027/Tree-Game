local ShopsManager = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local Remotes = ReplicatedStorage.Remotes
local Configs = ReplicatedStorage.Configs

local PlayerMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)
local State = require(ReplicatedStorage.Client.State)
local InventoryUIColors = require(ReplicatedStorage.Configs.InventoryUIColors)

local ShopUI = player.PlayerGui:WaitForChild("ShopTemplate")
local MainFrame = ShopUI.MainFrame
local CloseButton = MainFrame.CloseFrame.CloseButton
local BackgroundFrame = MainFrame.BackgroundFrame
local SelectedFrame = MainFrame.SelectedFrame
local IconImage = SelectedFrame.IconImage
local IconStats = SelectedFrame.Stats
local IconName = IconStats.IconName
local IconPrice = IconStats.IconPrice
local BuyButton = IconStats.BuyButton
local BuyFrame = IconStats.BuyFrame 
local NumberBuyButton = BuyFrame.BuyButton
local AdditionFrame = BuyFrame.AdditionFrame
local AmountLabel = AdditionFrame.AmountLabel 
local MinusButton = AdditionFrame.MinusButtonFrame.MinusButton
local PlusButton = AdditionFrame.PlusButtonFrame.PlusButton 

local DescriptionFrame = IconStats.Description
local IconDescription = IconStats.Description.IconDescription

local InventoryFrame = MainFrame.InventoryFrame
local ScrollingFrame = InventoryFrame.ScrollingFrame
local Template = InventoryFrame.Template

local NAME_TEXT = "Name: REPLACE"
local PRICE_TEXT = "Price: REPLACE"

local SelectedItem
local CurrentShop
local NumberOfPlots
local AmountOfItems = 1 

local Shops = {}

-- This function loads the Configs into the Shops Table

local function GetDataFromConfigs()
    Shops["Backpacks"] = require(Configs.BackpacksConfig)
    Shops["Fertilizers"] = require(Configs.FertilizerConfig)
    Shops["Plots"] = require(Configs.PlotsConfig)
    Shops["Seeds"] = require(Configs.SeedsConfig)
    Shops["WaterCans"] = require(Configs.WaterCanConfig)
end

GetDataFromConfigs()

local function ChangeColors()
    BackgroundFrame.BackgroundColor3 = InventoryUIColors[CurrentShop].BackgroundFrame
    InventoryFrame.BackgroundColor3 = InventoryUIColors[CurrentShop].InventoryFrame    
    SelectedFrame.BackgroundColor3 = InventoryUIColors[CurrentShop].EquippedFrame
    DescriptionFrame.BackgroundColor3 = InventoryUIColors[CurrentShop].DescriptionFrame
    IconPrice.BackgroundColor3 = InventoryUIColors[CurrentShop].IconAmount
    IconName.BackgroundColor3 = InventoryUIColors[CurrentShop].IconName
    IconImage.BackgroundColor3 = InventoryUIColors[CurrentShop].IconImage
end

-- Thsi function Checks for owner of the Watering Can or the Bacpack and returns a boolean Value

local function CheckForOwnerShip()
    if CurrentShop == "Backpacks" then 
        if State.GetData().OwnedBackpacks[SelectedItem.Name] then 
            return true
        end
    end
    if CurrentShop == "WaterCans" then 
        if State.GetData().OwnedWaterCans[SelectedItem.Name] then 
            return true
        end
    end
    return false 
end

local function CheckForPlotOwnerShip(Plot)
    Plot = if Plot then Plot else SelectedItem.Id
    if State.GetData().Plots[Plot] then 
        return true
    end
    return false
end

-- Thsi function Buys the Backpack if it is not already owned 

local function BuyBackpack()
    if CheckForOwnerShip() then 
        print("Item Already owned")
        BuyButton.Text = "Owned"
        return
    end

    if State.GetData().Coins >= SelectedItem.Price then 
        Remotes.UpdateOwnedBackpacks:FireServer(SelectedItem.Name)
        Remotes.GivePlayerBackpack:FireServer(SelectedItem.Name)
        print("Bought")
        BuyButton.Text = "Owned"
        return
    end
    print("Not Enough Money")
end

-- This function Buys the Watering Can if it is not already owned and player has enough Coins

local function BuyWaterCan()
    if CheckForOwnerShip() then 
        print("Item Already Owned")
        return
    end 

    if State.GetData().Coins >= SelectedItem.Price then 
        Remotes.UpdateOwnedWaterCans:FireServer(SelectedItem.Name)
        print("Item Has been Bought")
        return
    end
    print("Not Enough Money")
end

-- This function Buys the Selected Seed if the player has enough coins 

local function BuySeed()
    if State.GetData().Coins >= SelectedItem.Price then
		Remotes.UpdateOwnedSeeds:FireServer(AmountOfItems, SelectedItem.Name)
		print("Bought")
	else
		print("You don't have enough money")
	end
end

-- This function Buys the Selected Fertilizer if the player has enough coins

local function BuyFertilizer()
    if State.GetData().Coins >= SelectedItem.Price then
		Remotes.UpdateOwnedFertilizers:FireServer(AmountOfItems, SelectedItem.Name)
		print("Bought")
	else
		print("You don't have enough money")
	end
end

local function BuyPlot()
    if CheckForPlotOwnerShip() then 
        print("Item Already Owned")
        return
    end 

    if SelectedItem.LayoutOrder > NumberOfPlots + 1 then 
        print("Item is Locked")
        return 
    end

    if State.GetData().Coins >= SelectedItem.Price then 
        Remotes.UpdateOwnedPlots:FireServer(SelectedItem)
        print("Item Has been Bought")
        BuyButton.Text = "Owned"
        return
    end
    print("Not Enough Money")
end

local function SetAmountLabelText()
    AmountLabel.Text = AmountOfItems
end 

-- This funcion shows all the stats of the Information Frame 

local function ShowStats()
    IconName.Visible = true
    IconPrice.Visible = true
    DescriptionFrame.Visible = true
    BuyButton.Visible = true
    if CurrentShop == "Seeds" or CurrentShop == "Fertilizers" then 
        BuyButton.Visible = false
        BuyFrame.Visible = true 
    end
    IconImage.Visible = true 
    AmountLabel.Text = 1
    AmountOfItems = 1 
end

-- This function Hides all the stats of the Information Frame 

local function HideStats()
    IconName.Visible = false
    IconPrice.Visible = false
    DescriptionFrame.Visible = false 
    BuyButton.Visible = false
    BuyFrame.Visible = false 
    IconImage.Visible = false
end

-- This funciton Loads the stats of the selected item into the Information Frame.

local function LoadStats(item)
    IconName.Text = NAME_TEXT:gsub("REPLACE", item.Name)
    IconPrice.Text = PRICE_TEXT:gsub("REPLACE", item.Price)
    if item.Description then 
        IconDescription.Text = item.Description
    end
    BuyButton.Text = "Buy"
    if CurrentShop == "Backpacks" or CurrentShop == "Watercans" then 
        if CheckForOwnerShip() then 
            BuyButton.Text = "Owned"
        end
    end

    if CurrentShop == "Plots" then 
        if CheckForPlotOwnerShip() then 
            BuyButton.Text = "Owned" 
        end
        if item.LayoutOrder > NumberOfPlots + 1 then 
            BuyButton.Text = "🔒"
        end
    end
    ShowStats()
end

-- This Resets the Background Transparency of all the Icons in the current Menu

local function ResetTransparency()
    for _, item in ScrollingFrame:GetChildren() do 
        if item.Name == "UIGridLayout" then continue end
        item.BackgroundTransparency = 0
    end
end

-- This function Creates the Icon and Hooks up their pressed event 

local function CreateIcon(item)
    local icon = Template:Clone()
    icon.Parent = ScrollingFrame
    icon.Name = item.Name
    icon.ItemName.Text = item.Name
    icon.Visible = true

    if item.LayoutOrder then 
        icon.LayoutOrder = item.LayoutOrder
    end

    if CurrentShop == "Plots" then 
        icon.Name = item.Id
        if CheckForPlotOwnerShip(icon.Name) then 
            icon.EquippedIcon.Visible = true 
        end
        if item.LayoutOrder > NumberOfPlots + 1 then 
            icon.EquippedIcon.Text = "🔒"
            icon.EquippedIcon.Visible = true
        end 
    end

    icon.MouseButton1Down:Connect(function()
        ResetTransparency()
        SelectedItem = item
        icon.BackgroundTransparency = 0.5

        LoadStats(item)
    end)
end

-- This function deletes all the Icons from the Shops Inventory

local function ClearInventory()
    for _, icon in ScrollingFrame:GetChildren() do 
        if icon.Name == "UIGridLayout" then continue end 
        icon:Destroy()
    end
end

-- This function gets called to and creates all the Icons of the current Shop

function ShopsManager.GenerateShop(shopID, hideShop: boolean?)
    ClearInventory()
    if hideShop then 
        HideStats()
    end
    PlayerMovement:Movement(player, false)
    CurrentShop = shopID
    ShopUI.Enabled = true

    ChangeColors()

    if CurrentShop == "Plots" then 
        NumberOfPlots = 0 
        for _ in pairs(State.GetData().Plots) do 
            NumberOfPlots += 1
        end 
    end 

    for _, item in Shops[shopID] do 
        CreateIcon(item)
    end
end

-- This closes the menu when the X button is pressed 

CloseButton.MouseButton1Down:Connect(function()
    PlayerMovement:Movement(player, true)
    ShopUI.Enabled = false
end)

-- When the Buy Button is pressed calls the desired Buy Function

BuyButton.MouseButton1Down:Connect(function()
    if CurrentShop == "Backpacks" then 
        BuyBackpack()
        return
    end
    if CurrentShop == "WaterCans" then 
        BuyWaterCan() 
        return
    end
    if CurrentShop == "Plots" then 
        BuyPlot()
        return 
    end 
end)

NumberBuyButton.MouseButton1Down:Connect(function()
    if CurrentShop == "Seeds" then 
        BuySeed()
        return
    end
    if CurrentShop == "Fertilizers" then 
        BuyFertilizer()
        return
    end
end)

MinusButton.MouseButton1Down:Connect(function()
    if AmountOfItems < 2 then
        AmountOfItems = 1 
    else 
        AmountOfItems -= 1 
    end
    SetAmountLabelText()
end)

PlusButton.MouseButton1Down:Connect(function()
    if AmountOfItems > 9 then 
        AmountOfItems = 10 
    else 
        AmountOfItems += 1
    end
    SetAmountLabelText()
end)

return ShopsManager