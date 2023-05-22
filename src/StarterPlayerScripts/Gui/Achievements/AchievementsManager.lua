local Achievements = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local State = require(ReplicatedStorage.Client.State)
local ScalingUI = require(player:WaitForChild("PlayerScripts").Gui.ScalingUI.ScalingUI)

local AchievementsUI = player.PlayerGui:WaitForChild("AchievementTemplate")
local MainFrame = AchievementsUI.MainFrame

--local BackgroundFrame = MainFrame.BackgroundFrame

local CloseFrame = MainFrame.CloseFrame
local CloseButton = CloseFrame.CloseButton

local InventoryFrame = MainFrame.InventoryFrame
local ScrollingFrame = InventoryFrame.ScrollingFrame 
local Template = InventoryFrame.Template

local ORIGINAL_SIZE_OF_CLOSEBUTTON = CloseButton.Size

local function GenerateIcon(achievementName: string, item)
    local iconClone = Template:Clone()
    iconClone.Parent = ScrollingFrame
    iconClone.Visible = true
    iconClone.Name = item.Name

    local amountAchieved = State.GetData().Achievements[achievementName].AmountAchieved 
    local amountToAchieve = State.GetData().Achievements[achievementName].AmountToAchieve
    local barCompleted = amountAchieved / amountToAchieve

    iconClone.AchievementTitle.Text = item.Name 
    iconClone.AchievementBarBackground.AchievementBarText.Text = amountAchieved .. " / " .. amountToAchieve
    iconClone.AchievementBarBackground.AchievementBarCompleted.Size = UDim2.new(barCompleted, 0, 1, 0) 
end

local function ClearAchievements()
    for _, icon in pairs(ScrollingFrame:GetChildren()) do 
        if icon.Name == "UIGridLayout" then continue end 
        icon:Destroy()
    end
end

function Achievements.GenerateAchievements()
    ClearAchievements()

    for achievementName, item in pairs(State.GetData().Achievements) do 
        GenerateIcon( achievementName ,item)
    end
end

CloseButton.MouseButton1Down:Connect(function()
    AchievementsUI.Enabled = false
end)

CloseButton.MouseEnter:Connect(function()
    CloseButton.Size = ScalingUI.IncreaseBy10Percent(ORIGINAL_SIZE_OF_CLOSEBUTTON)
end)

CloseButton.MouseLeave:Connect(function()
    CloseButton.Size = ORIGINAL_SIZE_OF_CLOSEBUTTON
end)

return Achievements