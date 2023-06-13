local Achievements = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local State = require(ReplicatedStorage.Client.State)
local ScalingUI = require(player:WaitForChild("PlayerScripts").Gui.ScalingUI.ScalingUI)
local SoundsManager = require(player:WaitForChild("PlayerScripts").Gui.Sounds.SoundsManager)

local QuestsUI = player.PlayerGui:WaitForChild("QuestsTemplate")
local MainFrame = QuestsUI.MainFrame

--local BackgroundFrame = MainFrame.BackgroundFrame

local CloseFrame = MainFrame.CloseFrame
local CloseButton = CloseFrame:WaitForChild("CloseButton")

local InventoryFrame = MainFrame.InventoryFrame
local ScrollingFrame = InventoryFrame.ScrollingFrame 
local Template = InventoryFrame.Template
local TaskTemplate = InventoryFrame.TaskTemplate

local linkedIcons = {}

local ORIGINAL_SIZE_OF_CLOSEBUTTON = CloseButton.Size

-- Toggles the visibility of icons associated with the given icon name
local function LoadUnloadItems(iconName)
    for _, icon in pairs(linkedIcons[iconName]) do
        icon.Visible = not icon.Visible
    end
end

-- Generates icons for the given item and its associated tasks
local function GenerateIcons(item)
    if not item.CurrentQuestInfo then return end

    local iconClone = Template:Clone()
    iconClone.Parent = ScrollingFrame
    iconClone.LayoutOrder = item.LayoutOrder
    iconClone.Visible = true
    iconClone.Name = item.Name

    local increment = 1
    linkedIcons[iconClone.Name] = {}

    for task, _ in item.CurrentQuestInfo do 
        if not string.find(task, "Task") then continue end
        local taskClone = TaskTemplate:Clone()
        table.insert(linkedIcons[iconClone.Name], taskClone)
        taskClone.Name = item.Name
        taskClone.Parent = ScrollingFrame
        taskClone.LayoutOrder = item.LayoutOrder + increment
        increment += 1 
    end

    -- Click event for the quest title to load/unload associated tasks
    iconClone.QuestTitle.MouseButton1Down:Connect(function()
        LoadUnloadItems(iconClone.Name)
    end)

    iconClone.QuestTitle.Text = item.CurrentQuestInfo.QuestTitle
end

local function ClearQuests()
    -- Clears all quests/icons from the Quests UI
    for _, icon in pairs(ScrollingFrame:GetChildren()) do 
        if icon.Name == "UIListLayout" then continue end 
        icon:Destroy()
    end
end

function Achievements.GenerateQuests()
    -- Generates quests/icons in the Quests UI based on active quests in the player's data
    ClearQuests()

    for _, item in pairs(State.GetData().ActiveQuests) do 
        GenerateIcons(item)
    end
end

-- Click event for the close button to close the Quests UI
CloseButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayCloseSound()
    QuestsUI.Enabled = false
end)

CloseButton.MouseEnter:Connect(function()
    SoundsManager.PlayEnterSound()
    CloseButton.Size = ScalingUI.IncreaseBy10Percent(ORIGINAL_SIZE_OF_CLOSEBUTTON)
end)

CloseButton.MouseLeave:Connect(function()
    SoundsManager.PlayLeaveSound()
    CloseButton.Size = ORIGINAL_SIZE_OF_CLOSEBUTTON
end)

return Achievements
