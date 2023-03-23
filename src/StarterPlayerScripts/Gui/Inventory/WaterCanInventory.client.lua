local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer
local Remotes = ReplicatedStorage.Remotes

local StateManager = require(ReplicatedStorage.Client.State)

local UI = player.PlayerGui:WaitForChild("BackpackInventory")
local WaterUI = player.PlayerGui:WaitForChild("Stats")
local CloseButton = UI.CloseFrame.CloseButton
local MainFrame = UI.MainFrame
local InternalFrame = MainFrame.InternalFrame
local ScrollingFrame = InternalFrame.ScrollingFrame
local Template = ScrollingFrame.Template
local WaterInventoryButton = WaterUI.WateringCan.InventoryButton

local WaterCans = StateManager.GetData().OwnedWaterCans

local function generateIcon(can)
    local waterIcon = Template:Clone()
    waterIcon.Visible = true
    waterIcon.Parent = ScrollingFrame
    waterIcon.Capacity.Text = can.Capacity
    waterIcon.Identity.Text = can.Name
end

local function generateSelectableWateringCan()
    for _, can in (WaterCans) do 
        generateIcon(can)
    end 
end

local function changeEquippedWateringCan()

end

generateSelectableWateringCan()


WaterInventoryButton.MouseButton1Down:Connect(function()
    UI.Enabled = not UI.Enabled
end)

CloseButton.MouseButton1Down:Connect(function()
	UI.Enabled = false 
end)

