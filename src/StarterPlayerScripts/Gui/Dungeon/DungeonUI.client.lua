local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WorkSpace = game:GetService("Workspace")

local player = game.Players.LocalPlayer
local Remotes = ReplicatedStorage.Remotes 

local DungeonsConfig = require(ReplicatedStorage.Configs.DungeonConfig)
local SoundsManager = require(player:WaitForChild("PlayerScripts").Gui.Sounds.SoundsManager)
local ScalingUI = require(player:WaitForChild("PlayerScripts").Gui.ScalingUI.ScalingUI)
local UISettings = require(player:WaitForChild("PlayerScripts").Gui.UISettings.UISettings)

local PhysicalDungeons = WorkSpace:WaitForChild("PhysicalDungeons")
local TutorialDungeon = PhysicalDungeons:WaitForChild("TutorialDungeon")

local DungeonUI = player.PlayerGui:WaitForChild("DungeonSelectMenu")
local CloseFrame = DungeonUI.CloseFrame
local CloseButton = CloseFrame.CloseButton

local InformationFrame = DungeonUI.InformationFrame
local ScrollingFrame = InformationFrame.ScrollingFrame

local Template = InformationFrame.Template

local SelectFrame = DungeonUI.SelectFrame
local BattleButton = SelectFrame.BattleButton
local Heading = SelectFrame.Heading
local Description = SelectFrame.Description 

local ORIGINAL_SIZE_OF_CLOSEBUTTON = CloseButton.Size

-- Updates the select frame in the dungeon UI based on the selected dungeon.
-- Sets the heading and description text according to the dungeon configuration.
-- Connects the battle button's MouseButton1Down event to teleport the player and disable the dungeon UI.
local function UpdateSelectFrame(DungeonName)
    Heading.Text = DungeonsConfig[DungeonName].Name
    Description.Text = DungeonsConfig[DungeonName].Description

    BattleButton.MouseButton1Down:Connect(function()
        SoundsManager.PlayPressSound()
        local playerModel = player.Character
        playerModel.HumanoidRootPart.CFrame = TutorialDungeon.SpawnPoint.CFrame + Vector3.new(0, 3, 0)
        DungeonUI.Enabled = false
    end)
end

-- Generates the UI for the selected dungeon.
-- Disables all other screens, enables the dungeon UI, and clears the existing floor icons.
-- Creates floor icons based on the maximum floor count of the selected dungeon.
-- Updates the visibility and text of the floor icons based on the unlocked floor.
-- Connects the MouseButton1Down event of the floor icons to update the select frame.
local function GenerateUI(DungeonName)
    UISettings.DisableAll()
    DungeonUI.Enabled = true

    for _, child in ipairs(ScrollingFrame:GetChildren()) do
        if child.Name == "UIGridLayout" or child.Name == "UIPadding" then
            continue
        end
        child:Destroy()
    end

    for i = 1, DungeonsConfig[DungeonName].MaxFloor do
        local FloorIcon = Template:Clone()
        FloorIcon.Visible = true

        FloorIcon.Button.Visible = true
        FloorIcon.Button.Text = i
        FloorIcon.Parent = ScrollingFrame

        if i > DungeonsConfig[DungeonName].UnlockedFloor then
            FloorIcon.Button.Visible = false
            FloorIcon.Unlocked.Visible = true
        end

        FloorIcon.Button.MouseButton1Down:Connect(function()
            SoundsManager.PlayPressSound()
            UpdateSelectFrame(DungeonName)
        end)
    end
end

-- Connects the MouseButton1Down event of the close button to play the close sound and disable the dungeon UI.
CloseButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayCloseSound()
    DungeonUI.Enabled = false
end)

-- Connects the MouseEnter event of the close button to play the enter sound and increase the button size.
CloseButton.MouseEnter:Connect(function()
    SoundsManager.PlayEnterSound()
    CloseButton.Size = ScalingUI.IncreaseBy10Percent(ORIGINAL_SIZE_OF_CLOSEBUTTON)
end)

-- Connects the MouseLeave event of the close button to play the leave sound and reset the button size.
CloseButton.MouseLeave:Connect(function()
    SoundsManager.PlayLeaveSound()
    CloseButton.Size = ORIGINAL_SIZE_OF_CLOSEBUTTON
end)

-- Connects the OnClientEvent of the GenerateDungeons remote event.
-- Calls the GenerateUI function to generate the UI for the received DungeonName.
Remotes.GenerateDungeons.OnClientEvent:Connect(function(DungeonName)
    GenerateUI(DungeonName)
end)
