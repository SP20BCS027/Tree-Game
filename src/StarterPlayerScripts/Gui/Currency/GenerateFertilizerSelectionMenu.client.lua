local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)

local Remotes = ReplicatedStorage.Remotes
local player = game.Players.LocalPlayer
local character = player.CharacterAdded:Wait()

local AnimationHandler = require(player:WaitForChild("PlayerScripts").Gui.Animations.AnimationModule)
local ScalingUI = require(player:WaitForChild("PlayerScripts").Gui.ScalingUI.ScalingUI)
local SoundsManager = require(player:WaitForChild("PlayerScripts").Gui.Sounds.SoundsManager)
local UISettings = require(player:WaitForChild("PlayerScripts").Gui.UISettings.UISettings)

local State = require(ReplicatedStorage.Client.State)

local UI = player.PlayerGui:WaitForChild("FertilizerSelection")
local MainFrame = UI.MainFrame
local CloseButton = MainFrame.CloseFrame.CloseButton
local InventoryFrame = MainFrame.InventoryFrame
local ScrollingFrame = InventoryFrame.ScrollingFrame
local SelectedFrame = MainFrame.SelectedFrame
local StatsFrame = SelectedFrame.Stats
local IconImage = SelectedFrame.IconImage
local PlantButton = StatsFrame.PlantButton
local Template = InventoryFrame.Template

local Fertilizer
local PlotID
local AnimPart

local AMOUNT = "Amount: REPLACE"
local NAME = "Name: REPLACE"
local ORIGINAL_SIZE_OF_CLOSEBUTTON = CloseButton.Size
local ORIGINAL_SIZE_OF_PLANTBUTTON = PlantButton.Size
local crouchAnimID = "rbxassetid://13248889864"

-- Make the stats frame and icon image invisible.
local function MakeStatsInvisible()
    StatsFrame.Visible = false
    IconImage.Visible = false
end

-- Make the stats frame and icon image visible.
local function MakeStatsVisible()
    StatsFrame.Visible = true
    IconImage.Visible = true
end

-- Load the stats of the selected fertilizer and display them in the UI.
local function LoadStats(fertilizer)
    StatsFrame.Description.IconDescription.Text = fertilizer.Description
    StatsFrame.IconName.Text = NAME:gsub("REPLACE", fertilizer.Name)
    StatsFrame.IconAmount.Text = AMOUNT:gsub("REPLACE", fertilizer.Amount)
    Fertilizer = fertilizer
    MakeStatsVisible()
end

-- Create an icon for a fertilizer and add it to the scrolling frame.
local function CreateFertilizerIcon(fertilizer)
    local fertilizerIcon = Template:Clone()
    fertilizerIcon.Visible = true
    fertilizerIcon.Parent = ScrollingFrame
    fertilizerIcon.ItemName.Text = fertilizer.Name
    fertilizerIcon.Name = fertilizer.Name

    if fertilizer.imageID then 
        fertilizerIcon.ImageLabel.Image = fertilizer.imageID
    end


    if fertilizer.Amount <= 0 then
        fertilizerIcon.Visible = false
    end

    fertilizerIcon.MouseButton1Down:Connect(function()
        SoundsManager.PlayPressSound()
        LoadStats(fertilizer)
    end)
end

-- Update the fertilizer icons and enable the UI.
local function UpdateFertilizerIcons(plotID, animationPositionPart)
    PlotID = plotID
    AnimPart = animationPositionPart

    UISettings.DisableAll()
    UI.Enabled = true
end

-- Clear all existing fertilizer icons in the scrolling frame.
local function ClearAll()
    for _, item in ScrollingFrame:GetChildren() do
        if item.Name == "UIGridLayout" then
            continue
        end
        item:Destroy()
    end
end

-- Generate the selectable fertilizer icons.
local function GenerateSelectableFertilizers()
    ClearAll()
    for _, fertilizer in pairs(State.GetData().Fertilizers) do
        CreateFertilizerIcon(fertilizer)
    end
end

-- Fire the server event to fertilize the plot with the selected fertilizer.
local function FertilizePlot()
    Remotes.FertilizeTree:FireServer(PlotID, Fertilizer.Name)
end

-- Handle the fertilization of a plot when the plant button is clicked.
PlantButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    UI.Enabled = false
    MakeStatsInvisible()
    FertilizePlot()
    AnimationHandler.PlayAnimation(player, character, crouchAnimID)
    local fertilizingSound = AnimPart.WateringSound
    fertilizingSound:Play()
end)

-- Play a sound effect and increase the size of the plant button when the mouse enters.
PlantButton.MouseEnter:Connect(function()
    SoundsManager.PlayEnterSound()
    PlantButton.Size = ScalingUI.IncreaseBy2Point5Percent(ORIGINAL_SIZE_OF_PLANTBUTTON)
end)

-- Play a sound effect and restore the original size of the plant button when the mouse leaves.
PlantButton.MouseLeave:Connect(function()
    SoundsManager.PlayLeaveSound()
    PlantButton.Size = ORIGINAL_SIZE_OF_PLANTBUTTON
end)

-- Close the UI and perform necessary actions when the close button is clicked.
CloseButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayCloseSound()
    UI.Enabled = false
    MakeStatsInvisible()
    PlayerMovement:Movement(player, true)
end)

-- Play a sound effect and increase the size of the close button when the mouse enters.
CloseButton.MouseEnter:Connect(function()
    SoundsManager.PlayEnterSound()
    CloseButton.Size = ScalingUI.IncreaseBy10Percent(ORIGINAL_SIZE_OF_CLOSEBUTTON)
end)

-- Play a sound effect and restore the original size of the close button when the mouse leaves.
CloseButton.MouseLeave:Connect(function()
    SoundsManager.PlayLeaveSound()
    CloseButton.Size = ORIGINAL_SIZE_OF_CLOSEBUTTON
end)

-- Update the fertilizer icons and regenerate selectable fertilizers when a fertilizer is selected.
Remotes.Bindables.SelectFertilizer.Event:Connect(function(plotID, animPart)
    UpdateFertilizerIcons(plotID, animPart)
    GenerateSelectableFertilizers()
end)
