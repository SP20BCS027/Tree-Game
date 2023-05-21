local Achievements = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local State = require(ReplicatedStorage.Client.State)

local QuestsUI = player.PlayerGui:WaitForChild("QuestsTemplate")
local MainFrame = QuestsUI.MainFrame

--local BackgroundFrame = MainFrame.BackgroundFrame

local CloseFrame = MainFrame.CloseFrame
local CloseButton = CloseFrame.CloseButton

local InventoryFrame = MainFrame.InventoryFrame
local ScrollingFrame = InventoryFrame.ScrollingFrame 
local Template = InventoryFrame.Template
local TaskTemplate = InventoryFrame.TaskTemplate

local linkedIcons = {}

local function LoadUnloadItems(iconName)
    for _, icon in pairs(linkedIcons[iconName]) do
        icon.Visible = not icon.Visible
    end
end

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

    iconClone.QuestTitle.MouseButton1Down:Connect(function()
        LoadUnloadItems(iconClone.Name)
    end)

    iconClone.QuestTitle.Text = item.CurrentQuestInfo.QuestTitle
end

local function ClearQuests()
    for _, icon in pairs(ScrollingFrame:GetChildren()) do 
        if icon.Name == "UIListLayout" then continue end 
        icon:Destroy()
    end
end

function Achievements.GenerateQuests()
    ClearQuests()

    for _, item in pairs(State.GetData().ActiveQuests) do 
        GenerateIcons(item)
    end
end

CloseButton.MouseButton1Down:Connect(function()
    QuestsUI.Enabled = false
end)

return Achievements
