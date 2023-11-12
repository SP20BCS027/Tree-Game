local MainInventory = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local State = require(ReplicatedStorage.Client.State)

local player = game.Players.LocalPlayer

local InventoryUIColors = require(ReplicatedStorage.Configs.InventoryUIColors)
local ScalingUI = require(player:WaitForChild("PlayerScripts").Gui.ScalingUI.ScalingUI)
local SoundsManager = require(player:WaitForChild("PlayerScripts").Gui.Sounds.SoundsManager)

local Configs = {}

local CurrentDirectory

local CombatInventoryUI = player.PlayerGui:WaitForChild("CombatInventory")
local MainFrame = CombatInventoryUI.MainFrame

local BackgroundFrame = MainFrame.BackgroundFrame
local HeadingFrame = MainFrame.HeadingFrame
local HeadingFrameBackground = MainFrame.HeadingFrameBackground

local CloseButton = MainFrame.CloseFrame.CloseButton

local InventoryFrame = MainFrame.InventoryFrame
local EmptyFrame = InventoryFrame.EmptyFrame
local ScrollingFrame = InventoryFrame.ScrollingFrame
local Template = InventoryFrame.Template

local EquippedFrame = MainFrame.EquippedFrame

local PetsFrame = EquippedFrame.Pets
local PetFrames = {
    Pet1 = PetsFrame.Pet1, 
    Pet2 = PetsFrame.Pet2,
    Pet3 = PetsFrame.Pet3,
}

local StatsFrame = EquippedFrame.Stats
local IconImage = StatsFrame.IconImage
local IconName = StatsFrame.IconName
local IconAmount = StatsFrame.IconAmount
local IconDescription = StatsFrame.Description.IconDescription
local DescriptionFrame = StatsFrame.Description
local EquipButton = StatsFrame.EquipButton

local PotionTypeHolder = MainFrame.PotionTypeHolder
local WeaponTypeHolder = MainFrame.WeaponTypeHolder 
local ElementTypeButtons = MainFrame.ElementTypeButtons
local ArmorTypeHolder = MainFrame.ArmorTypeHolder

local ITEM_NAME = "Name: REPLACE"
local ITEM_AMOUNT = "Amount: REPLACE"
local ITEM_CAPACITY = "Capacity: REPLACE"

local ORIGINAL_SIZE_OF_EQUIPBUTTON = EquipButton.Size
local ORIGINAL_SIZE_OF_CLOSEBUTTON = CloseButton.Size

local TOTALITEMS

local SelectedItem
local SelectedItemType
local CurrentInventory
local CurrentWeaponType
local CurrentPotionType
local CurrentEggType
local CurrentPetType
local CurrentElement 
local CurrentArmorType
local EquippedItem

-- This function loads the most updated data in the Configs table
local function GetDataFromClient()
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
    StatsFrame.Visible = false
end

local function HidePets()
    EquippedFrame.Pets.Visible = false
end

local function ShowPets()
    EquippedFrame.Pets.Visible = true
end 

-- This function makes the Equip Button visible if the inventory is either Backpack or Watering Can
local function ShowEquipButton()
    if CurrentInventory == "Weapons" or CurrentInventory == "Armors" or CurrentInventory == "Pets" then
        EquipButton.Visible = true
        EquipButton.Text = "Equip"
    end
    if CurrentInventory == "Potions" then 
        EquipButton.Visible = true
        EquipButton.Text = "Use"
    end
    if CurrentInventory == "Eggs" then 
        EquipButton.Visible = true 
        EquipButton.Text = "Hatch"
    end
end

-- This function makes the items in the information frame visible
local function ShowStats(item)
    StatsFrame.Visible = true
    ShowEquipButton()
    if item.Name == EquippedItem then 
        EquipButton.Text = "Equipped"
    end
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

local function UpdatePetsData()
    for Pet, item in PetFrames do 
        if State.GetData().EquippedPets[Pet].UID == nil then 
            item.PetFrame.ImageLabel.Image = ""
            item.PetFrame.PetName.Text = "No Pet Equipped"
            item.EquipButtonFrame.EquipButton.Text = "Equip"
            continue
        end
        item.PetFrame.ImageLabel.Image = State.GetData().EquippedPets[Pet].ImageID
        item.PetFrame.PetName.Text = State.GetData().EquippedPets[Pet].Name
        item.EquipButtonFrame.EquipButton.Text = "Unequip"
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

    if item.ImageID then
        icon.ImageLabel.Image = item.ImageID
    end

    -- Set the layout order if provided
    if item.LayoutOrder then 
        icon.LayoutOrder = item.LayoutOrder
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
        if CurrentInventory == "Weapons" then 
            SelectedItemType = item.Type
        end
        if CurrentInventory == "Pets" then 
            SelectedItemType = item.Type
            ShowPets()
            return
        end
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

local function CreateWeaponIcons(elementType, weaponType)

    weaponType = weaponType or "Sword"
    elementType = elementType or "Neutral"
    local CurrentWeapons = {}
    for _, item in CurrentDirectory[elementType] do
        if item.WeaponType == weaponType then 
            CurrentWeapons[item.UID] = item
        end
    end
    for _, item in CurrentWeapons do 
        CreateIcon(item)
    end
end

local function CreatePotionIcons(potionType)
    potionType = potionType or "Attack"

    local CurrentPotions = {}
    for _, item in CurrentDirectory[potionType] do
        if item.PotionType == potionType then 
            CurrentPotions[item.UID] = item
        end
    end
    for _, item in CurrentPotions do 
        CreateIcon(item)
    end
end

local function CreateEggIcons(eggType)
    eggType = eggType or "Neutral"
    local CurrentEggs = {}
    for _, item in CurrentDirectory[eggType] do 
        CurrentEggs[item.UID] = item
    end
    for _, item in CurrentEggs do 
        CreateIcon(item)
    end
end

local function CreatePetIcons(petType)
    petType = petType or "Neutral"
    local CurrentPets = {}
    for _, item in CurrentDirectory[petType] do 
        CurrentPets[item.UID] = item
    end
    for _, item in CurrentPets do
        CreateIcon(item)
    end
end

local function CreateArmorIcons(elementType, armorType)
    elementType = elementType or "Neutral"
    armorType = armorType or "Head"
    local CurrentArmors = {}
    for _, item in CurrentDirectory[elementType] do 
        for _, innerItem in item do
            if innerItem.ArmorType == armorType then 
                CurrentArmors[innerItem.UID] = innerItem
            end
        end
    end
    for _, item in CurrentArmors do 
        CreateIcon(item)
    end
end

-- This function is responsible for generating the inventory with the desired ID
function MainInventory.GenerateInventory(setID, weaponType, elementType, potionType, armorType)
    SetCurrentConfig(setID)
    GetDataFromClient()
    ClearInventory()
    UpdatePetsData()
    HideStats()
    HidePets()

    SelectedItem = nil
    CurrentElement = elementType or "Neutral"
    CurrentWeaponType = weaponType or "Sword"
    CurrentPotionType = potionType or "Attack"
    CurrentEggType = elementType or "Neutral"
    CurrentPetType = elementType or "Neutral"
    CurrentArmorType = armorType or "Head"
    CurrentInventory = setID
    ChangeColors()
    TOTALITEMS = 0

    -- for _, subDir in CurrentDirectory do 
    --     for _, item in subDir do 
    --         CreateIcon(item)
    --     end
    -- end 

    if CurrentInventory == "Weapons" then 
        WeaponTypeHolder.Visible = true 
        PotionTypeHolder.Visible = false 
        ElementTypeButtons.Visible = true
        ArmorTypeHolder.Visible = false
        CreateWeaponIcons(elementType, weaponType)
    end

    if CurrentInventory == "Potions" then 
        WeaponTypeHolder.Visible = false
        PotionTypeHolder.Visible = true
        ElementTypeButtons.Visible = false
        ArmorTypeHolder.Visible = false 
        CreatePotionIcons(potionType)
    end

    if CurrentInventory == "Eggs" then 
        WeaponTypeHolder.Visible = false
        PotionTypeHolder.Visible = false 
        ElementTypeButtons.Visible = true
        ArmorTypeHolder.Visible = false
        CreateEggIcons(CurrentEggType)
    end

    if CurrentInventory == "Armors" then 
        WeaponTypeHolder.Visible = false 
        PotionTypeHolder.Visible = false 
        ElementTypeButtons.Visible = true
        ArmorTypeHolder.Visible = true
        CreateArmorIcons(elementType, armorType)
    end

    if CurrentInventory == "Pets" then 
        WeaponTypeHolder.Visible = false
        PotionTypeHolder.Visible = false 
        ElementTypeButtons.Visible = true
        ArmorTypeHolder.Visible = false
        ShowPets()
        CreatePetIcons(CurrentPetType)
    end

    if TOTALITEMS == 0 then 
        EmptyFrame.Visible = true
    else
        EmptyFrame.Visible = false
    end
end

-- This function returns the current inventory as a string.
function MainInventory.GetCurrentInventory(): string
    return CurrentInventory
end

function MainInventory.GetCurrentWeaponType(): string
    return CurrentWeaponType
end

function MainInventory.GetCurrentElement(): string 
    return CurrentElement
end 

function MainInventory.GetCurrentPotionType(): string
    return CurrentPotionType
end
function MainInventory.GetCurrentArmorType(): string
    return CurrentArmorType
end

WeaponTypeHolder.Sword.TextButton.MouseButton1Down:Connect(function()
    MainInventory.GenerateInventory(CurrentInventory, "Sword", CurrentElement, CurrentPotionType, CurrentArmorType)
end)
WeaponTypeHolder.Ranged.TextButton.MouseButton1Down:Connect(function()
    MainInventory.GenerateInventory(CurrentInventory, "Ranged", CurrentElement, CurrentPotionType, CurrentArmorType)
end)
WeaponTypeHolder.Staff.TextButton.MouseButton1Down:Connect(function()
    MainInventory.GenerateInventory(CurrentInventory, "Staff", CurrentElement, CurrentPotionType, CurrentArmorType)
end)

PotionTypeHolder.Attack.TextButton.MouseButton1Down:Connect(function()
    MainInventory.GenerateInventory(CurrentInventory, CurrentWeaponType, CurrentElement, "Attack", CurrentArmorType)
end)
PotionTypeHolder.Defense.TextButton.MouseButton1Down:Connect(function()
    MainInventory.GenerateInventory(CurrentInventory, CurrentWeaponType, CurrentElement, "Defense", CurrentArmorType)
end)
PotionTypeHolder.Health.TextButton.MouseButton1Down:Connect(function()
    MainInventory.GenerateInventory(CurrentInventory, CurrentWeaponType, CurrentElement, "Health", CurrentArmorType)
end)
PotionTypeHolder.Pets.TextButton.MouseButton1Down:Connect(function()
    MainInventory.GenerateInventory(CurrentInventory, CurrentWeaponType, CurrentElement, "Pets", CurrentArmorType)
end)

ElementTypeButtons.Air.ImageButton.MouseButton1Down:Connect(function()
    MainInventory.GenerateInventory(CurrentInventory, CurrentWeaponType, "Air", CurrentPotionType, CurrentArmorType)
end)
ElementTypeButtons.Water.ImageButton.MouseButton1Down:Connect(function()
    MainInventory.GenerateInventory(CurrentInventory, CurrentWeaponType, "Water", CurrentPotionType, CurrentArmorType)
end)
ElementTypeButtons.Fire.ImageButton.MouseButton1Down:Connect(function()
    MainInventory.GenerateInventory(CurrentInventory, CurrentWeaponType, "Fire", CurrentPotionType, CurrentArmorType)
end)
ElementTypeButtons.Geo.ImageButton.MouseButton1Down:Connect(function()
    MainInventory.GenerateInventory(CurrentInventory, CurrentWeaponType, "Geo", CurrentPotionType, CurrentArmorType)
end)
ElementTypeButtons.Neutral.ImageButton.MouseButton1Down:Connect(function()
    MainInventory.GenerateInventory(CurrentInventory, CurrentWeaponType, "Neutral", CurrentPotionType, CurrentArmorType)
end)

ArmorTypeHolder.Head.TextButton.MouseButton1Down:Connect(function()
    MainInventory.GenerateInventory(CurrentInventory, CurrentWeaponType, CurrentElement, CurrentPotionType, "Head")
end)
ArmorTypeHolder.Legs.TextButton.MouseButton1Down:Connect(function()
    MainInventory.GenerateInventory(CurrentInventory, CurrentWeaponType, CurrentElement, CurrentPotionType, "Legs")
end)
ArmorTypeHolder.Arms.TextButton.MouseButton1Down:Connect(function()
    MainInventory.GenerateInventory(CurrentInventory, CurrentWeaponType, CurrentElement, CurrentPotionType, "Arms")
end)
ArmorTypeHolder.Chest.TextButton.MouseButton1Down:Connect(function()
    MainInventory.GenerateInventory(CurrentInventory, CurrentWeaponType, CurrentElement, CurrentPotionType, "Chest")
end)

for Pet, PetFrame in PetFrames do 
    PetFrame.EquipButtonFrame.EquipButton.MouseButton1Down:Connect(function()
        if State.GetData().EquippedPets[Pet].UID then 
            ReplicatedStorage.Remotes.ChangeEquippedPets:FireServer(State.GetData().EquippedPets[Pet].Type, State.GetData().EquippedPets[Pet].UID, Pet)
            print("Pet Unequipped")
            return
        end

        if not SelectedItem then return end 
        if CurrentInventory ~= "Pets" then return end 
        if State.GetData().OwnedPets[CurrentElement][SelectedItem].Equipped == true then 
        SoundsManager.PlayDenialSound()
        print("The Selected Item is Already Equipped")
        return
    end

    EquippedItem = SelectedItem
    ReplicatedStorage.Remotes.ChangeEquippedPets:FireServer(SelectedItemType, SelectedItem, Pet)
    print("Pet Equipped")
    SoundsManager.PlayPressSound()
    end)
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
    if CurrentInventory == "Weapons" then 
        ReplicatedStorage.Remotes.ChangeEquippedWeapon:FireServer(SelectedItemType, SelectedItem)
        ReplicatedStorage.Remotes.GivePlayerWeaponTool:FireServer(SelectedItemType, SelectedItem)
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

CloseButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayCloseSound()
    CombatInventoryUI.Enabled = false 
end)

CloseButton.MouseEnter:Connect(function()
    SoundsManager.PlayEnterSound()
    CloseButton.Size = ScalingUI.IncreaseBy10Percent(ORIGINAL_SIZE_OF_CLOSEBUTTON)
end)

CloseButton.MouseLeave:Connect(function()
    SoundsManager.PlayLeaveSound()
    CloseButton.Size = ORIGINAL_SIZE_OF_CLOSEBUTTON
end)

return MainInventory