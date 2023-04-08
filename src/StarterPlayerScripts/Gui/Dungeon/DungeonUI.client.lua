local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer
local Remotes = ReplicatedStorage.Remotes 

local DungeonsConfig = require(ReplicatedStorage.Configs.DungeonConfig)

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

local function updateSelectFrame(DungeonName)


    Heading.Text = DungeonsConfig[DungeonName].Name
    Description.Text = DungeonsConfig[DungeonName].Description
    BattleButton.MouseButton1Down:Connect(function()
        local playerModel = player.Character
        playerModel.HumanoidRootPart.CFrame = CFrame.new(-80.5, 20.5, 82.7)
        DungeonUI.Enabled = false
    end)
end

local function generateUI(DungeonName)
    DungeonUI.Enabled = true

    for _, child in ScrollingFrame:GetChildren() do 
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
            updateSelectFrame(DungeonName)
        end)
    end
end

CloseButton.MouseButton1Down:Connect(function()
    DungeonUI.Enabled = false
end)

Remotes.GenerateDungeons.OnClientEvent:Connect(function(DungeonName)
    generateUI(DungeonName)
end)
