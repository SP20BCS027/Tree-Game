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

local ShopUI = player.PlayerGui:WaitForChild("BattleShopTemplate")
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

local WeaponTypeButtonsFrame = MainFrame.WeaponTypeButtons
local RangedButton = WeaponTypeButtonsFrame.Ranged.ImageButton
local SwordButton = WeaponTypeButtonsFrame.Sword.ImageButton
local StaffButton = WeaponTypeButtonsFrame.Staff.ImageButton

local ElementTypeButtonsFrame = MainFrame.ElementTypeButtons
local AirButton = ElementTypeButtonsFrame.Air.ImageButton
local FireButton = ElementTypeButtonsFrame.Fire.ImageButton
local GeoButton = ElementTypeButtonsFrame.Geo.ImageButton
local WaterButton = ElementTypeButtonsFrame.Water.ImageButton 
local NeutralButton = ElementTypeButtonsFrame.Neutral.ImageButton

local PotionsTypeButtonsFrame = MainFrame.PotionTypeHolder
local AttackButton = PotionsTypeButtonsFrame.Attack.TextButton 
local HealthButton = PotionsTypeButtonsFrame.Health.TextButton 
local DefenseButton = PotionsTypeButtonsFrame.Defense.TextButton
local PetsButton = PotionsTypeButtonsFrame.Pets.TextButton

local ArmorsTypeButtonsFrame = MainFrame.ArmorTypeButtons
local ArmsButton = ArmorsTypeButtonsFrame.Arms.ImageButton
local ChestButton = ArmorsTypeButtonsFrame.Chest.ImageButton
local HeadButton = ArmorsTypeButtonsFrame.Head.ImageButton
local LegsButton = ArmorsTypeButtonsFrame.Legs.ImageButton

local NAME_TEXT = "Name: REPLACE"
local PRICE_TEXT = "Price: REPLACE"
local CAPACITY_TEXT = "Capacity: REPLACE"

local SelectedItem
local CurrentShop
local CurrentElement
local CurrentWeaponType
local CurrentPotionType
local CurrentArmorType
local AmountOfItems = 1 

local ORIGINAL_SIZE_OF_CLOSEBUTTON = CloseButton.Size
local ORIGINAL_SIZE_OF_BUYBUTTON = BuyButton.Size
local ORIGINAL_SIZE_OF_NUMBERBUYBUTTON = NumberBuyButton.Size

local Shops = {}
 
-- This function loads the data from Configs into the Shops table
local function LoadDataFromConfigs()
    Shops["Weapons"] = require(Configs.WeaponsConfig)
    Shops["Potions"] = require(Configs.PotionsConfig)
    Shops["Eggs"] = require(Configs.EggsConfig)
    Shops["Pets"] = require(Configs.PetsConfig)
    Shops["Armors"] = require(Configs.ArmorConfig)
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
    item = item or SelectedItem.UID
    if CurrentShop == "Weapons" then 
        if State.GetData().OwnedWeapons[CurrentElement][item] then 
            return true
        end
    end

    return false 
end

local function BuyWeapon()
    if CheckForOwnerShip() then 
        SoundsManager.PlayDenialSound()
        print("Item Already Owned")
        return
    end

    if State.GetData().Coins >= SelectedItem.Price then 
        Remotes.UpdateOwnedWeapons:FireServer(CurrentElement, SelectedItem.UID)
        BuyButton.Text = "Owned"
        SoundsManager.PlayPressSound()
        print("Item Has been Bought")
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

    if item.imageID then 
        IconImage.Image = item.imageID
    end 

    BuyButton.Text = "Buy"
    if CurrentShop == "Weapons" then 
        IconAmount.Text = CAPACITY_TEXT:gsub("REPLACE", item.Attack)
        if CheckForOwnerShip() then 
            BuyButton.Text = "Owned"
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

    if item.ImageID then 
        icon.ImageLabel.Image = item.ImageID
    end

    if item.LayoutOrder then 
        icon.LayoutOrder = item.LayoutOrder
    end


    if CurrentShop == "Weapons" then 
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

local function GenerateWeaponIcons(WeaponType, ElementType)
    WeaponType = WeaponType or "Sword"
    ElementType = ElementType or "Neutral"

    local CurrentWeapons = {}
    for _, item in Shops[CurrentShop][ElementType] do
        if item.WeaponType == WeaponType then 
            CurrentWeapons[item.UID] = item
        end
    end
    for _, item in CurrentWeapons do 
        CreateIcon(item)
    end
end

local function GeneratePotionIcons(potionType)
    potionType = potionType or "Attack"

    local CurrentPotions = {}
    for _, item in Shops[CurrentShop][potionType] do
        if item.PotionType == potionType then 
            CurrentPotions[item.UID] = item
        end
    end
    for _, item in CurrentPotions do 
        CreateIcon(item)
    end
end

local function GenerateEggIcons(eggType)
    eggType = eggType or "Neutral"

    local CurrentEggs = {}
    for _, item in Shops[CurrentShop][eggType] do 
        if item.Type == eggType then 
            CurrentEggs[item.UID] = item
        end
    end
    for _, item in CurrentEggs do 
        CreateIcon(item)
    end
end

local function GenerateArmorIcons(elementType, armorType)
    elementType = elementType or "Neutral"
    armorType = armorType or "Head"

    local CurrentArmors = {}
    for _, item in Shops[CurrentShop][elementType] do
        for _, innerItem in item do 
            if innerItem.ArmorType == armorType then 
                CurrentArmors[innerItem] = innerItem
            end
        end
    end
    for _, item in CurrentArmors do 
        CreateIcon(item)
    end
end

function ShopsManager.GetCurrentWeaponType(): string 
    return CurrentWeaponType or "Sword"
end

function ShopsManager.GetCurrentPotionType(): string 
    return CurrentPotionType or "Attack"
end

function ShopsManager.GetCurrentElementType(): string
    return CurrentElement or "Neutral"
end

function ShopsManager.GetCurrentArmorType(): string 
    return CurrentArmorType or "Head"
end 

-- This function is called to generate and display the icons of the current shop
function ShopsManager.GenerateShop(shopID, hideShop: boolean?, weaponType, elementType, potionType, armorType)
    hideShop = hideShop or true
    ClearInventory()
    if hideShop then 
        HideStats()
    end
    PlayerMovement:Movement(player, false)
    CurrentShop = shopID
    CurrentWeaponType = weaponType or "Sword"
    CurrentElement = elementType or "Neutral"
    CurrentPotionType = potionType or "Attack"
    CurrentArmorType = armorType or "Head"
    UISettings.DisableAll()
    ShopUI.Enabled = true
    HeadingFrame.TextLabel.Text = CurrentShop .. " Shop"
    ChangeColors()

    if CurrentShop == "Weapons" then 
        WeaponTypeButtonsFrame.Visible = true 
        ElementTypeButtonsFrame.Visible = true
        PotionsTypeButtonsFrame.Visible = false
        ArmorsTypeButtonsFrame.Visible = false
        GenerateWeaponIcons(weaponType, elementType)
    end
    if CurrentShop == "Potions" then 
        WeaponTypeButtonsFrame.Visible = false
        ElementTypeButtonsFrame.Visible = false
        PotionsTypeButtonsFrame.Visible = true
        ArmorsTypeButtonsFrame.Visible = false
        GeneratePotionIcons(potionType)
    end
    if CurrentShop == "Eggs" then 
        WeaponTypeButtonsFrame.Visible = false
        ElementTypeButtonsFrame.Visible = true
        PotionsTypeButtonsFrame.Visible = false
        ArmorsTypeButtonsFrame.Visible = false
        GenerateEggIcons(elementType)
    end
    if CurrentShop == "Armors" then
        WeaponTypeButtonsFrame.Visible = false
        ElementTypeButtonsFrame.Visible = true
        PotionsTypeButtonsFrame.Visible = false
        ArmorsTypeButtonsFrame.Visible = true
        GenerateArmorIcons(elementType, armorType)
    end
end

SwordButton.MouseButton1Down:Connect(function()
    ShopsManager.GenerateShop(CurrentShop, true, "Sword", CurrentElement, CurrentPotionType, CurrentArmorType)
end)
RangedButton.MouseButton1Down:Connect(function()
    ShopsManager.GenerateShop(CurrentShop, true, "Ranged", CurrentElement, CurrentPotionType, CurrentArmorType)
end)
StaffButton.MouseButton1Down:Connect(function()
    ShopsManager.GenerateShop(CurrentShop, true, "Staff", CurrentElement, CurrentPotionType, CurrentArmorType)
end)
AirButton.MouseButton1Down:Connect(function()
    ShopsManager.GenerateShop(CurrentShop, true, CurrentWeaponType, "Air", CurrentPotionType, CurrentArmorType)
end)
WaterButton.MouseButton1Down:Connect(function()
    ShopsManager.GenerateShop(CurrentShop, true, CurrentWeaponType, "Water", CurrentPotionType, CurrentArmorType)
end)
GeoButton.MouseButton1Down:Connect(function()
    ShopsManager.GenerateShop(CurrentShop, true, CurrentWeaponType, "Geo", CurrentPotionType, CurrentArmorType)
end)
FireButton.MouseButton1Down:Connect(function()
    ShopsManager.GenerateShop(CurrentShop, true, CurrentWeaponType, "Fire", CurrentPotionType, CurrentArmorType)
end)
NeutralButton.MouseButton1Down:Connect(function()
    ShopsManager.GenerateShop(CurrentShop, true, CurrentWeaponType, "Neutral", CurrentPotionType, CurrentArmorType)
end)
AttackButton.MouseButton1Down:Connect(function()
    ShopsManager.GenerateShop(CurrentShop, true, CurrentWeaponType, CurrentElement, "Attack", CurrentArmorType)
end)
DefenseButton.MouseButton1Down:Connect(function()
    ShopsManager.GenerateShop(CurrentShop, true, CurrentWeaponType, CurrentElement, "Defense", CurrentArmorType)
end)
HealthButton.MouseButton1Down:Connect(function()
    ShopsManager.GenerateShop(CurrentShop, true, CurrentWeaponType, CurrentElement, "Health", CurrentArmorType)
end)
PetsButton.MouseButton1Down:Connect(function()
    ShopsManager.GenerateShop(CurrentShop, true, CurrentWeaponType, CurrentElement, "Pets", CurrentArmorType)
end)
ArmsButton.MouseButton1Down:Connect(function()
    ShopsManager.GenerateShop(CurrentShop, true, CurrentWeaponType, CurrentElement, CurrentPotionType, "Arms")   
end)
HeadButton.MouseButton1Down:Connect(function()
    ShopsManager.GenerateShop(CurrentShop, true, CurrentWeaponType, CurrentElement, CurrentPotionType, "Head")   
end)
LegsButton.MouseButton1Down:Connect(function()
    ShopsManager.GenerateShop(CurrentShop, true, CurrentWeaponType, CurrentElement, CurrentPotionType, "Legs")   
end)
ChestButton.MouseButton1Down:Connect(function()
    ShopsManager.GenerateShop(CurrentShop, true, CurrentWeaponType, CurrentElement, CurrentPotionType, "Chest")   
end)
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
    if CurrentShop == "Weapons" then 
        BuyWeapon()
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