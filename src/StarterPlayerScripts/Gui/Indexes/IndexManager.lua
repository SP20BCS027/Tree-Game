local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer

local Remotes = ReplicatedStorage.Remotes

local State = require(ReplicatedStorage.Client.State)
local SoundsManager = require(player:WaitForChild("PlayerScripts").Gui.Sounds.SoundsManager)
local ScalingUI = require(player:WaitForChild("PlayerScripts").Gui.ScalingUI.ScalingUI)

local IndexSelectScreenUI = player.PlayerGui:WaitForChild("IndexSelectScreen")
local IndexTemplateUI = player.PlayerGui:WaitForChild("IndexTemplate")

local MainFrame = IndexSelectScreenUI.Frame
local CloseFrame = MainFrame.CloseFrame
local CloseButton = CloseFrame.CloseButton
local BackgroundFrame = MainFrame.BackgroundFrame
local Heading = MainFrame.Heading 
local HeadingBackground = MainFrame.HeadingBackground 
local HolderFrame = MainFrame.HolderFrame
local IndexesFrame = MainFrame.IndexesFrame

local IndexTemplateMainFrame = IndexTemplateUI.Frame
local IndexTemplateCloseFrame = IndexTemplateMainFrame.CloseFrame
local IndexTemplateCloseButton = IndexTemplateCloseFrame.CloseButton
local IndexTemplateBackgroundFrame = IndexTemplateMainFrame.BackgroundFrame
local IndexTemplateHeading = IndexTemplateMainFrame.Heading
local IndexTemplateHeadingBackground = IndexTemplateMainFrame.HeadingBackground
local IndexTemplateHolderFrame = IndexTemplateMainFrame.HolderFrame
local IndexTemplateIndexesFrame = IndexTemplateMainFrame.IndexesFrame

local IndexTemplate = IndexTemplateHolderFrame.Template

local TreeIndexFrame = HolderFrame.TreeIndexFrame

local ORIGINAL_SIZE_OF_CLOSEBUTTON = CloseButton.Size
local ORIGINAL_SIZE_OF_INDEXCLOSEBUTTON = IndexTemplateCloseButton.Size

local IndexManager = {}

function IndexManager.GenerateIndexStats(headingText: string, Icons: {})
    local IndexDisplay = IndexTemplate:Clone()
    IndexDisplay.Parent = IndexTemplateHolderFrame
    IndexDisplay.Heading.Text = headingText
    IndexDisplay.Name = headingText
    IndexDisplay.Visible = true
    local ScrollingFrame = IndexDisplay.ScrollingFrame

    for _, isUnlocked in pairs(Icons) do 
        local ItemClone = ScrollingFrame.Item:Clone()
        ItemClone.Parent = ScrollingFrame
        ItemClone.Visible = true
    end 
end

function IndexManager.GenerateIndexMenu(indexType: string)
    for tree, level in pairs(State.GetData().Index[indexType]) do 
        IndexManager.GenerateIndexStats(tree, level)
    end
end

function IndexManager.ToggleSelectMenu()
    IndexSelectScreenUI.Enabled = not IndexSelectScreenUI.Enabled
end

function IndexManager.GetTotalTrees()
    local totalTreeIndexes = 0
    for _, level in pairs(State.GetData().Index["TreeIndex"]) do 
        for _, value in pairs(level) do 
            if value == false then 
                totalTreeIndexes += 1
            end
        end
    end
    return totalTreeIndexes
end
IndexManager.GetTotalTrees()

function IndexManager.GetUnlockedTrees()
    local totalTreeIndexes = 0
    for _, level in pairs(State.GetData().Index["TreeIndex"]) do 
        for _, value in pairs(level) do 
            if value == true then 
                totalTreeIndexes += 1
            end
        end
    end
    return totalTreeIndexes
end

function IndexManager.UpdateTreeIndexStats()
    local barCompleted = IndexManager.GetUnlockedTrees() / IndexManager.GetTotalTrees()
    TreeIndexFrame.ProgressionText.Text = IndexManager.GetUnlockedTrees() .. " / " .. IndexManager.GetTotalTrees() .. " ( " .. (IndexManager.GetUnlockedTrees() / IndexManager.GetTotalTrees()) * 100 .. "% )"
    TreeIndexFrame.ProgressBar.Bar.Size = UDim2.new(barCompleted, 0, 1, 0) 
end

function IndexManager.UpdatePetsIndexStats()
end

function IndexManager.UpdateEnemiesIndexStats()
end

TreeIndexFrame.Button.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    IndexManager.GenerateIndexMenu("TreeIndex")
    IndexSelectScreenUI.Enabled = false
    IndexTemplateUI.Enabled = true
end)
TreeIndexFrame.Button.MouseEnter:Connect(function()
    SoundsManager.PlayEnterSound()
end)
TreeIndexFrame.Button.MouseLeave:Connect(function()
    SoundsManager.PlayLeaveSound()
end)

IndexTemplateCloseButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayCloseSound()
    IndexTemplateUI.Enabled = false
end)
IndexTemplateCloseButton.MouseEnter:Connect(function()
    SoundsManager.PlayCloseSound()
    IndexTemplateCloseButton.Size = ScalingUI.IncreaseBy10Percent(ORIGINAL_SIZE_OF_INDEXCLOSEBUTTON)
end)
IndexTemplateCloseButton.MouseLeave:Connect(function()
    SoundsManager.PlayCloseSound()
    IndexTemplateCloseButton.Size = ORIGINAL_SIZE_OF_INDEXCLOSEBUTTON
end)

CloseButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayCloseSound()
    IndexSelectScreenUI.Enabled = false
end)
CloseButton.MouseEnter:Connect(function()
    SoundsManager.PlayEnterSound()
    CloseButton.Size = ScalingUI.IncreaseBy10Percent(ORIGINAL_SIZE_OF_CLOSEBUTTON)
end)
CloseButton.MouseLeave:Connect(function()
    SoundsManager.PlayLeaveSound()
    CloseButton.Size = ORIGINAL_SIZE_OF_CLOSEBUTTON
end)

return IndexManager 
