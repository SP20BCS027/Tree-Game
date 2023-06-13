local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer

local State = require(ReplicatedStorage.Client.State)
local SoundsManager = require(player:WaitForChild("PlayerScripts").Gui.Sounds.SoundsManager)
local ScalingUI = require(player:WaitForChild("PlayerScripts").Gui.ScalingUI.ScalingUI)
local UISettings = require(player:WaitForChild("PlayerScripts").Gui.UISettings.UISettings)

local IndexSelectScreenUI = player.PlayerGui:WaitForChild("IndexSelectScreen")
local IndexTemplateUI = player.PlayerGui:WaitForChild("IndexTemplate")

local MainFrame = IndexSelectScreenUI.Frame
local CloseFrame = MainFrame.CloseFrame
local CloseButton = CloseFrame.CloseButton 
local HolderFrame = MainFrame.HolderFrame

local IndexTemplateMainFrame = IndexTemplateUI.Frame
local IndexTemplateCloseFrame = IndexTemplateMainFrame.CloseFrame
local IndexTemplateCloseButton = IndexTemplateCloseFrame.CloseButton
local IndexTemplateHolderFrame = IndexTemplateMainFrame.HolderFrame

local IndexTemplate = IndexTemplateHolderFrame.Template

local TreeIndexFrame = HolderFrame.TreeIndexFrame

local ORIGINAL_SIZE_OF_CLOSEBUTTON = CloseButton.Size
local ORIGINAL_SIZE_OF_INDEXCLOSEBUTTON = IndexTemplateCloseButton.Size

local IndexManager = {}

-- Generates the index stats for a specific heading in the index menu.
-- Clones the index template, sets layout order, heading text, and populates the scrolling frame with icons based on the provided Icons table.
function IndexManager.GenerateIndexStats(headingText: string, layoutOrder: number, Icons: {})

    local IndexDisplay = IndexTemplate:Clone()
    IndexDisplay.LayoutOrder = layoutOrder
    IndexDisplay.Parent = IndexTemplateHolderFrame
    IndexDisplay.Heading.Text = headingText
    IndexDisplay.Name = headingText
    IndexDisplay.Visible = true

    local ScrollingFrame = IndexDisplay.ScrollingFrame

    for level, tree in pairs(Icons) do
        local ItemClone = ScrollingFrame.Item:Clone()

        if tree.Unlocked == true then
            ItemClone.TreeImage.Image = tree.UnlockedImage
        else
            ItemClone.TreeImage.Image = tree.NotUnlockedImage
        end

        ItemClone.LayoutOrder = level
        ItemClone.Parent = ScrollingFrame
        ItemClone.Visible = true
    end
end

-- Clears the index menu by destroying all icons except the template.
local function ClearIndexMenu()
    for _, icon in ipairs(IndexTemplateHolderFrame:GetChildren()) do
        if icon.Name ~= "UIListLayout" and icon.Name ~= "UIPadding" and icon.Name ~= "Template" then
            icon:Destroy()
        end
    end
end

-- Generates the index menu based on the indexType.
-- Clears the existing menu and iterates over the trees and levels in the index data retrieved from State.
-- Calls GenerateIndexStats to generate the index stats for each tree.
function IndexManager.GenerateIndexMenu(indexType: string)
    ClearIndexMenu()
    
    local indexData = State.GetData().Index[indexType]

    for tree, level in pairs(indexData) do
        IndexManager.GenerateIndexStats(tree, level.LayoutOrder, level.Trees)
    end
end

-- Toggles the visibility of the Select Menu in the Index Manager.
-- Disables all other screens using UISettings.DisableAll and toggles the visibility of IndexSelectScreenUI.
function IndexManager.ToggleSelectMenu()
    UISettings.DisableAll("IndexSelectScreen")
    IndexSelectScreenUI.Enabled = not IndexSelectScreenUI.Enabled
end

-- Returns the total number of tree indexes in the "TreeIndex" index data retrieved from State.
function IndexManager.GetTotalTrees()
    local totalTreeIndexes = 0

    for _, levels in pairs(State.GetData().Index["TreeIndex"]) do
        for _ in pairs(levels.Trees) do
            totalTreeIndexes = totalTreeIndexes + 1
        end
    end

    return totalTreeIndexes
end

-- Returns the number of unlocked tree indexes in the "TreeIndex" index data retrieved from State.
function IndexManager.GetUnlockedTrees()
    local totalUnlockedTrees = 0

    for _, levels in pairs(State.GetData().Index["TreeIndex"]) do
        for _, stat in pairs(levels.Trees) do
            if stat.Unlocked == true then
                totalUnlockedTrees = totalUnlockedTrees + 1
            end
        end
    end

    return totalUnlockedTrees
end

-- Updates the tree index stats in the UI.
-- Calculates the completion percentage and updates the progress bar and text accordingly.
function IndexManager.UpdateTreeIndexStats()
    local unlockedTrees = IndexManager.GetUnlockedTrees()
    local totalTrees = IndexManager.GetTotalTrees()
    local completionPercentage = math.floor((unlockedTrees / totalTrees) * 10000) / 100

    TreeIndexFrame.ProgressionText.Text = unlockedTrees .. " / " .. totalTrees .. " (" .. completionPercentage .. "%)"
    TreeIndexFrame.ProgressBar.Bar.Size = UDim2.new(unlockedTrees / totalTrees, 0, 1, 0)
end

function IndexManager.UpdatePetsIndexStats()
    -- Update pets index stats implementation goes here
end

function IndexManager.UpdateEnemiesIndexStats()
    -- Update enemies index stats implementation goes here
end

-- Connects the button click event to generate the tree index menu, disable other screens, and enable the index template UI.
TreeIndexFrame.Button.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    IndexManager.GenerateIndexMenu("TreeIndex")
    UISettings.DisableAll()
    IndexSelectScreenUI.Enabled = false
    IndexTemplateUI.Enabled = true
end)

-- Connects the mouse enter event of the tree index button to play the enter sound.
TreeIndexFrame.Button.MouseEnter:Connect(function()
    SoundsManager.PlayEnterSound()
end)

-- Connects the mouse leave event of the tree index button to play the leave sound.
TreeIndexFrame.Button.MouseLeave:Connect(function()
    SoundsManager.PlayLeaveSound()
end)

-- Connects the mouse button 1 down event of the index template close button to play the close sound and disable the index template UI.
IndexTemplateCloseButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayCloseSound()
    IndexTemplateUI.Enabled = false
end)

-- Connects the mouse enter event of the index template close button to play the close sound and increase the button size.
IndexTemplateCloseButton.MouseEnter:Connect(function()
    SoundsManager.PlayCloseSound()
    IndexTemplateCloseButton.Size = ScalingUI.IncreaseBy10Percent(ORIGINAL_SIZE_OF_INDEXCLOSEBUTTON)
end)

-- Connects the mouse leave event of the index template close button to play the close sound and reset the button size.
IndexTemplateCloseButton.MouseLeave:Connect(function()
    SoundsManager.PlayCloseSound()
    IndexTemplateCloseButton.Size = ORIGINAL_SIZE_OF_INDEXCLOSEBUTTON
end)

-- Connects the mouse button 1 down event of the close button to play the close sound and disable the index select screen UI.
CloseButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayCloseSound()
    IndexSelectScreenUI.Enabled = false
end)

-- Connects the mouse enter event of the close button to play the enter sound and increase the button size.
CloseButton.MouseEnter:Connect(function()
    SoundsManager.PlayEnterSound()
    CloseButton.Size = ScalingUI.IncreaseBy10Percent(ORIGINAL_SIZE_OF_CLOSEBUTTON)
end)

-- Connects the mouse leave event of the close button to play the leave sound and reset the button size.
CloseButton.MouseLeave:Connect(function()
    SoundsManager.PlayLeaveSound()
    CloseButton.Size = ORIGINAL_SIZE_OF_CLOSEBUTTON
end)

return IndexManager 
