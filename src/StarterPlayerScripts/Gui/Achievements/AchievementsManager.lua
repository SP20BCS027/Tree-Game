local Achievements = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local State = require(ReplicatedStorage.Client.State)
local ScalingUI = require(player:WaitForChild("PlayerScripts").Gui.ScalingUI.ScalingUI)
local SoundsManager = require(player:WaitForChild("PlayerScripts").Gui.Sounds.SoundsManager)

local AchievementsUI = player.PlayerGui:WaitForChild("AchievementTemplate")
local MainFrame = AchievementsUI.MainFrame

--local BackgroundFrame = MainFrame.BackgroundFrame

local CloseFrame = MainFrame.CloseFrame
local CloseButton = CloseFrame.CloseButton

local InventoryFrame = MainFrame.InventoryFrame
local ScrollingFrame = InventoryFrame.ScrollingFrame 
local Template = InventoryFrame.Template

local ORIGINAL_SIZE_OF_CLOSEBUTTON = CloseButton.Size

-- Generate an icon for the given achievement name and item data.
-- The icon is cloned from a template, assigned a name, and updated with achievement progress.
local function GenerateIcon(achievementName: string, item)
    local iconClone = Template:Clone()
    iconClone.Parent = ScrollingFrame
    iconClone.Visible = true
    iconClone.Name = item.Name

    local amountAchieved = State.GetData().Achievements[achievementName].AmountAchieved 
    local amountToAchieve = State.GetData().Achievements[achievementName].AmountToAchieve
    local barCompleted = amountAchieved / amountToAchieve

    if barCompleted > 1 then 
        barCompleted = 1 
    end 

    iconClone.AchievementTitle.Text = item.Name 
    iconClone.AchievementBarBackground.AchievementBarText.Text = amountAchieved .. " / " .. amountToAchieve
    iconClone.AchievementBarBackground.AchievementBarCompleted.Size = UDim2.new(barCompleted, 0, 1, 0) 
end

-- Clear all achievement icons from the ScrollingFrame.
local function ClearAchievements()
    for _, icon in pairs(ScrollingFrame:GetChildren()) do 
        if icon.Name == "UIGridLayout" then continue end 
        icon:Destroy()
    end
end

-- Generate all achievement icons by iterating over the achievements in the player's data and calling GenerateIcon.
function Achievements.GenerateAchievements()
    ClearAchievements()

    for achievementName, item in pairs(State.GetData().Achievements) do 
        GenerateIcon(achievementName, item)
    end
end

-- CloseButton event handlers for mouse button down, mouse enter, and mouse leave.
CloseButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayCloseSound()
    AchievementsUI.Enabled = false
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

