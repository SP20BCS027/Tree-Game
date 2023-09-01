local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)

local Remotes = ReplicatedStorage.Remotes
local player = game.Players.LocalPlayer
local character = player.CharacterAdded:Wait()

local AnimationHandler = require(player:WaitForChild("PlayerScripts").Gui.Animations.AnimationModule)
local ScalingUI = require(player:WaitForChild("PlayerScripts").Gui.ScalingUI.ScalingUI)
local SoundsManager = require(player:WaitForChild("PlayerScripts").Gui.Sounds.SoundsManager)
local UISettings = require(player:WaitForChild("PlayerScripts").Gui.UISettings.UISettings)

local State= require(ReplicatedStorage.Client.State)

local UI = player.PlayerGui:WaitForChild("SeedSelection")
local MainFrame = UI.MainFrame
local CloseButton = MainFrame.CloseFrame.CloseButton
local InventoryFrame = MainFrame.InventoryFrame
local ScrollingFrame = InventoryFrame.ScrollingFrame
local SelectedFrame = MainFrame.SelectedFrame
local StatsFrame = SelectedFrame.Stats
local IconImage = SelectedFrame.IconImage
local PlantButton = StatsFrame.PlantButton
local Template = InventoryFrame.Template

local Seed 
local PlotID
local MudPos
local AnimPart

local AMOUNT = "Amount: REPLACE"
local NAME = "Name: REPLACE"

local ORIGINAL_SIZE_OF_PLANTBUTTON = PlantButton.Size
local ORIGINAL_SIZE_OF_CLOSEBUTTON = CloseButton.Size

local crouchAnimID = "rbxassetid://13248889864"
-- Makes the stats frame and icon image invisible.
local function MakeStatsInvisible()
    StatsFrame.Visible = false
    IconImage.Visible = false
end

-- Makes the stats frame and icon image visible.
local function MakeStatsVisible()
    StatsFrame.Visible = true
    IconImage.Visible = true
end

-- Loads the stats for the received seed and displays them in the stats frame.
local function LoadStats(seedReceived)
    StatsFrame.Description.IconDescription.Text = seedReceived.Description
    StatsFrame.IconAmount.Text = AMOUNT:gsub("REPLACE", seedReceived.Amount)
    StatsFrame.IconName.Text = NAME:gsub("REPLACE", seedReceived.Name)
    Seed = seedReceived
    MakeStatsVisible()
end

-- Creates a seed icon based on the provided seed data.
local function CreateSeedIcon(seed)
    local seedIcon = Template:Clone()
    seedIcon.Visible = true
    seedIcon.Parent = ScrollingFrame
    seedIcon.ItemName.Text = seed.Name
    seedIcon.Name = seed.Name

    if seed.imageID then 
        seedIcon.ImageLabel.Image = seed.imageID
    end

    if seed.Amount <= 0 then
        seedIcon.Visible = false
    end

    seedIcon.MouseButton1Down:Connect(function()
        SoundsManager.PlayPressSound()
        LoadStats(seed)
    end)
end

-- Updates the seed icons based on the received plot, mud position, and animation position.
local function UpdateSeedIcons(plotReceived, mudPosition, animationPositionPart)
    PlotID = plotReceived
    MudPos = mudPosition
    AnimPart = animationPositionPart

    UISettings.DisableAll()
    UI.Enabled = true
end

-- Clears the existing seed icons from the scrolling frame.
local function ClearSeeds()
    for _, item in ScrollingFrame:GetChildren() do
        if item.Name == "UIGridLayout" then
            continue
        end
        item:Destroy()
    end
end

-- Generates selectable seed icons based on the player's seed data.
local function GenerateSelectableSeeds()
    ClearSeeds()
    for _, seed in pairs(State.GetData().Seeds) do
        CreateSeedIcon(seed)
    end
end

GenerateSelectableSeeds()
-- Plant the selected seed by firing the necessary server events.
local function PlantSeed()
    Remotes.PlantedSeed:FireServer(Seed.Name)
    Remotes.UpdateAchievements:FireServer("SeedsPlanted", 1)
    Remotes.UpdateOccupied:FireServer(PlotID, Seed.Name, MudPos)
end

-- Handle the planting of a seed when the plant button is clicked.
PlantButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    UI.Enabled = false
    MakeStatsInvisible()
    PlantSeed()
    AnimationHandler.PlayAnimation(player, character, crouchAnimID)
    local plantingSound = AnimPart.WateringSound
    plantingSound:Play()
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

-- Update the seed icons and regenerate selectable seeds when a seed is selected.
Remotes.Bindables.SelectSeed.Event:Connect(function(plot, mudPos, animPart)
    UpdateSeedIcons(plot, mudPos, animPart)
    GenerateSelectableSeeds()
end)
