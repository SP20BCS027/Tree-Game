local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer

local Remotes = ReplicatedStorage.Remotes

local State = require(ReplicatedStorage.Client.State)
local SoundsManager = require(player:WaitForChild("PlayerScripts").Gui.Sounds.SoundsManager)
local ScalingUI = require(player:WaitForChild("PlayerScripts").Gui.ScalingUI.ScalingUI)

local IndexSelectScreenUI = player.PlayerGui:WaitForChild("IndexSelectScreen")
local IndexTemplate = player.PlayerGui:WaitForChild("IndexTemplate")

local MainFrame = IndexSelectScreenUI.Frame
local CloseFrame = MainFrame.CloseFrame
local CloseButton = CloseFrame.CloseButton
local BackgroundFrame = MainFrame.BackgroundFrame
local Heading = MainFrame.Heading 
local HeadingBackground = MainFrame.HeadingBackground 
local HolderFrame = MainFrame.HolderFrame
local IndexesFrame = MainFrame.IndexesFrame

local IndexTemplateMainFrame = IndexTemplate.Frame
local IndexTemplateCloseFrame = IndexTemplateMainFrame.CloseFrame
local IndexTemplateCloseButton = IndexTemplateCloseFrame.CloseButton

local TreeIndexFrame = HolderFrame.TreeIndexFrame

local ORIGINAL_SIZE_OF_CLOSEBUTTON = CloseButton.Size
local ORIGINAL_SIZE_OF_INDEXCLOSEBUTTON = IndexTemplateCloseButton.Size

local IndexManager = {}

function IndexManager.GenerateIndex()

end

function IndexManager.ToggleSelectMenu()
    IndexSelectScreenUI.Enabled = not IndexSelectScreenUI.Enabled
end

function IndexManager.UpdateTreeIndexStats()
end

function IndexManager.UpdatePetsIndexStats()
end

function IndexManager.UpdateEnemiesIndexStats()
end

TreeIndexFrame.Button.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    IndexSelectScreenUI.Enabled = false
    IndexTemplate.Enabled = true
end)
TreeIndexFrame.Button.MouseEnter:Connect(function()
    SoundsManager.PlayEnterSound()
end)
TreeIndexFrame.Button.MouseLeave:Connect(function()
    SoundsManager.PlayLeaveSound()
end)

IndexTemplateCloseButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayCloseSound()
    IndexTemplate.Enabled = false
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
