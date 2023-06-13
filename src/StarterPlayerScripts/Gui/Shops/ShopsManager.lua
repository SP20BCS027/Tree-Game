local ShopsManager = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local Remotes = ReplicatedStorage.Remotes
local Configs = ReplicatedStorage.Configs

local PlayerMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)
local State = require(ReplicatedStorage.Client.State)
local InventoryUIColors = require(ReplicatedStorage.Configs.InventoryUIColors)
local ScalingUI = require(player:WaitForChild("PlayerScripts").Gui.ScalingUI.ScalingUI)
local SoundsManager = require(player:WaitForChild("PlayerScripts").Gui.Sounds.SoundsManager)
local UISettings = require(player:WaitForChild("PlayerScripts").Gui.UISettings.UISettings)

local ShopUI = player.PlayerGui:WaitForChild("ShopTemplate")
local MainFrame = ShopUI.MainFrame
local CloseButton = MainFrame.CloseFrame.CloseButton
local BackgroundFrame = MainFrame.BackgroundFrame
local HeadingFrame = MainFrame.HeadingFrame
local HeadingFrameBackground = MainFrame.HeadingFrameBackground
local SelectedFrame = MainFrame.SelectedFrame
local IconImage = SelectedFrame.IconImage
local IconStats = SelectedFrame.Stats
local IconName = IconStats.IconName
local IconPrice = IconStats.IconPrice
local IconAmount = IconStats.IconAmount
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
local CAPACITY_TEXT = "Capacity: REPLACE"

local SelectedItem
local CurrentShop
local NumberOfPlots
local AmountOfItems = 1 

local ORIGINAL_SIZE_OF_CLOSEBUTTON = CloseButton.Size
local ORIGINAL_SIZE_OF_BUYBUTTON = BuyButton.Size
local ORIGINAL_SIZE_OF_NUMBERBUYBUTTON = NumberBuyButton.Size

local Shops = {}

-- This function loads the data from Configs into the Shops table
local function LoadDataFromConfigs()
    Shops["Backpacks"] = require(Configs.BackpacksConfig)
    Shops["Fertilizers"] = require(Configs.FertilizerConfig)
    Shops["Plots"] = require(Configs.PlotsConfig)
    Shops["Seeds"] = require(Configs.SeedsConfig)
    Shops["WaterCans"] = require(Configs.WaterCanConfig)
end

LoadDataFromConfigs()

-- This function changes the colors of the UI elements based on the current shop
local function ChangeColors()
    BackgroundFrame.BackgroundColor3 = InventoryUIColors[CurrentShop].BackgroundFrame
    HeadingFrame.BackgroundColor3 = InventoryUIColors[CurrentShop].HeadingFrame
    HeadingFrameBackground.BackgroundColor3 = InventoryUIColors[CurrentShop].HeadingFrameBackground
    InventoryFrame.BackgroundColor3 = InventoryUIColors[CurrentShop].InventoryFrame    
    SelectedFrame.BackgroundColor3 = InventoryUIColors[CurrentShop].EquippedFrame
    DescriptionFrame.BackgroundColor3 = InventoryUIColors[CurrentShop].DescriptionFrame
    IconPrice.BackgroundColor3 = InventoryUIColors[CurrentShop].IconPrice
    IconAmount.BackgroundColor3 = InventoryUIColors[CurrentShop].IconAmount
    IconName.BackgroundColor3 = InventoryUIColors[CurrentShop].IconName
    IconImage.BackgroundColor3 = InventoryUIColors[CurrentShop].IconImage
end

-- This function checks for ownership of the Watering Can or the Backpack and returns a boolean value
local function CheckForOwnerShip(item)
    item = item or SelectedItem.Name
    if CurrentShop == "Backpacks" then 
        if State.GetData().OwnedBackpacks[item] then 
            return true
        end
    end
    if CurrentShop == "WaterCans" then 
        if State.GetData().OwnedWaterCans[item] then 
            return true
        end
    end
    return false 
end

-- This function checks for ownership of a plot and returns a boolean value
local function CheckForPlotOwnerShip(Plot)
    Plot = Plot or SelectedItem.Id
    if State.GetData().Plots[Plot] then 
        return true
    end
    return false
end

-- This function buys the Backpack if it is not already owned
local function BuyBackpack()
    if CheckForOwnerShip() then 
        SoundsManager.PlayDenialSound()
        print("Item Already owned")
        BuyButton.Text = "Owned"
        return
    end

    if State.GetData().Coins >= SelectedItem.Price then 
        SoundsManager.PlayPressSound()
        Remotes.UpdateOwnedBackpacks:FireServer(SelectedItem.UID)
        Remotes.GivePlayerBackpack:FireServer(SelectedItem.UID)
        print("Bought")
        BuyButton.Text = "Owned"
        return
    end
    SoundsManager.PlayDenialSound()
    print("Not Enough Money")
end


-- This function buys the Watering Can if it is not already owned and the player has enough Coins
local function BuyWaterCan()
    if CheckForOwnerShip() then 
        SoundsManager.PlayDenialSound()
        print("Item Already Owned")
        return
    end 

    if State.GetData().Coins >= SelectedItem.Price then 
        Remotes.UpdateOwnedWaterCans:FireServer(SelectedItem.UID)
        BuyButton.Text = "Owned"
        SoundsManager.PlayPressSound()
        print("Item Has been Bought")
        return
    end
    SoundsManager.PlayDenialSound()
    print("Not Enough Money")
end

-- This function buys the selected Seed if the player has enough Coins
local function BuySeed()
    if State.GetData().Coins >= SelectedItem.Price then
        SoundsManager.PlayPressSound()
		Remotes.UpdateOwnedSeeds:FireServer(AmountOfItems, SelectedItem.UID)
		print("Bought")
	else
        SoundsManager.PlayDenialSound()
		print("You don't have enough money")
	end
end

-- This function buys the selected Fertilizer if the player has enough Coins
local function BuyFertilizer()
    if State.GetData().Coins >= SelectedItem.Price then
        SoundsManager.PlayPressSound()
		Remotes.UpdateOwnedFertilizers:FireServer(AmountOfItems, SelectedItem.UID)
		print("Bought")
	else
        SoundsManager.PlayDenialSound()
		print("You don't have enough money")
	end
end

-- This function buys the selected Plot if it is not already owned, unlocked, and the player has enough Coins
local function BuyPlot()
    if CheckForPlotOwnerShip() then 
        SoundsManager.PlayDenialSound()
        print("Item Already Owned")
        return
    end 

    if SelectedItem.LayoutOrder > NumberOfPlots + 1 then 
        SoundsManager.PlayDenialSound()
        print("Item is Locked")
        return 
    end

    if State.GetData().Coins >= SelectedItem.Price then 
        SoundsManager.PlayPressSound()
        Remotes.UpdateOwnedPlots:FireServer(SelectedItem)
        print("Item Has been Bought")
        BuyButton.Text = "Owned"
        return
    end
    SoundsManager.PlayDenialSound()
    print("Not Enough Money")
end

-- This function sets the text of the AmountLabel to the current AmountOfItems value
local function SetAmountLabelText()
    AmountLabel.Text = AmountOfItems
end

-- This function shows all the stats in the Information Frame
local function ShowStats()
    IconName.Visible = true
    IconPrice.Visible = true
    IconAmount.Visible = true 
    DescriptionFrame.Visible = true
    BuyButton.Visible = true
    if CurrentShop == "Seeds" or CurrentShop == "Fertilizers" then 
        BuyButton.Visible = false
        BuyFrame.Visible = true 
        IconAmount.Visible = false
    end
    if CurrentShop == "Plots" then 
        IconAmount.Visible = false
    end
    IconImage.Visible = true 
    AmountLabel.Text = 1
    AmountOfItems = 1 
end

-- This function hides all the stats in the Information Frame
local function HideStats()
    IconName.Visible = false
    IconPrice.Visible = false
    IconAmount.Visible = false
    DescriptionFrame.Visible = false 
    BuyButton.Visible = false
    BuyFrame.Visible = false 
    IconImage.Visible = false
end

-- This function loads the stats of the selected item into the Information Frame
local function LoadStats(item)
    IconName.Text = NAME_TEXT:gsub("REPLACE", item.Name)
    IconPrice.Text = PRICE_TEXT:gsub("REPLACE", item.Price)
    if item.Description then 
        IconDescription.Text = item.Description
    end
    BuyButton.Text = "Buy"
    if CurrentShop == "Backpacks" or CurrentShop == "WaterCans" then 
        IconAmount.Text = CAPACITY_TEXT:gsub("REPLACE", item.Capacity)
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

-- This function resets the background transparency of all the icons in the current menu
local function ResetTransparency()
    for _, item in ScrollingFrame:GetChildren() do 
        if item.Name == "UIGridLayout" then continue end
        item.BackgroundTransparency = 0
    end
end

-- This function creates the icon and hooks up its pressed event
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

    if CurrentShop == "Backpacks" or CurrentShop == "WaterCans" then 
        if CheckForOwnerShip(icon.Name) then 
            icon.EquippedIcon.Visible = true
        end
    end

    icon.MouseButton1Down:Connect(function()
        SoundsManager.PlayPressSound()
        ResetTransparency()
        SelectedItem = item
        icon.BackgroundTransparency = 0.5

        LoadStats(item)
    end)
end

-- This function deletes all the icons from the shop's inventory
local function ClearInventory()
    for _, icon in ScrollingFrame:GetChildren() do 
        if icon.Name == "UIGridLayout" then continue end 
        icon:Destroy()
    end
end

-- This function is called to generate and display the icons of the current shop
function ShopsManager.GenerateShop(shopID, hideShop: boolean?)
    ClearInventory()
    if hideShop then 
        HideStats()
    end
    PlayerMovement:Movement(player, false)
    CurrentShop = shopID
    UISettings.DisableAll()
    ShopUI.Enabled = true
    HeadingFrame.TextLabel.Text = CurrentShop .. " Shop"
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

-- This function closes the menu when the X button is pressed
CloseButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    PlayerMovement:Movement(player, true)
    ShopUI.Enabled = false
end)

CloseButton.MouseEnter:Connect(function()
    SoundsManager.PlayEnterSound()
    CloseButton.Size = ScalingUI.IncreaseBy10Percent(ORIGINAL_SIZE_OF_CLOSEBUTTON)
end)

CloseButton.MouseLeave:Connect(function()
    SoundsManager.PlayLeaveSound()
    CloseButton.Size = ORIGINAL_SIZE_OF_CLOSEBUTTON
end)

-- When the Buy button is pressed, it calls the corresponding buy function based on the current shop
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

BuyButton.MouseEnter:Connect(function()
    SoundsManager.PlayEnterSound()
    BuyButton.Size = ScalingUI.IncreaseBy2Point5Percent(ORIGINAL_SIZE_OF_BUYBUTTON)
end)

BuyButton.MouseLeave:Connect(function()
    SoundsManager.PlayLeaveSound()
    BuyButton.Size = ORIGINAL_SIZE_OF_BUYBUTTON
end)

-- When the NumberBuyButton is pressed, it calls the corresponding buy function based on the current shop
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

NumberBuyButton.MouseEnter:Connect(function()
    SoundsManager.PlayEnterSound()
    NumberBuyButton.Size = ScalingUI.IncreaseBy5Percent(ORIGINAL_SIZE_OF_NUMBERBUYBUTTON)
end)

NumberBuyButton.MouseLeave:Connect(function()
    SoundsManager.PlayLeaveSound()
    NumberBuyButton.Size = ORIGINAL_SIZE_OF_NUMBERBUYBUTTON
end)

MinusButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()

    -- Decrease the amount of items by 1, with a minimum value of 1
    if AmountOfItems < 2 then
        AmountOfItems = 1 
    else 
        AmountOfItems -= 1 
    end
    SetAmountLabelText()
end)

PlusButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()

    -- Increase the amount of items by 1, with a maximum value of 10
    if AmountOfItems > 9 then 
        AmountOfItems = 10 
    else 
        AmountOfItems += 1
    end
    SetAmountLabelText()
end)

return ShopsManager
