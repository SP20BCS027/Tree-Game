local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer
local Remotes = ReplicatedStorage.Remotes

local StateManager = require(ReplicatedStorage.Client.State)

local UI = player.PlayerGui:WaitForChild("WateringCanInventory")
local WaterUI = player.PlayerGui:WaitForChild("InventoryButtons")
local CloseButton = UI.CloseFrame.CloseButton
local MainFrame = UI:WaitForChild("MainFrame")
local InternalFrame = MainFrame.InternalFrame
local InformationFrame = InternalFrame.InformationFrame
local WaterCanDescription = InformationFrame.Frame.WaterCanDescription
local WaterCanEquipButton = InformationFrame.Frame.EquipButton
local ScrollingFrame = InternalFrame.ScrollingFrame
local Template = InternalFrame.Template
local WaterInventoryButton = WaterUI.ButtonsHolder.WaterCanButton.WaterCanInventoryButton

local selectedWateringCan

local function changeEquippedWateringCan()
    Remotes.ChangeEquippedWateringCan:FireServer(selectedWateringCan)
end

local function loadWateringCan(can)
    WaterCanDescription.Text = can.Name
    selectedWateringCan = can.Name
    WaterCanEquipButton.MouseButton1Down:Connect(function()
        changeEquippedWateringCan()
    end)
end

local function generateIcon(can)
    local waterIcon = Template:Clone()
    waterIcon.Visible = true
    waterIcon.Parent = ScrollingFrame
    waterIcon.Capacity.Text = can.Capacity
    waterIcon.Identity.Text = can.Name

    waterIcon.TextButton.MouseButton1Down:Connect(function()
        loadWateringCan(can)
    end)
end

local function generateSelectableWateringCan()
    for _, item in (ScrollingFrame:GetChildren()) do 
        if item.Name ~= "UIGridLayout" then 
            item:Destroy()
        end
    end

    for _, can in (StateManager.GetData().OwnedWaterCans) do 
        generateIcon(can)
    end 
end

generateSelectableWateringCan()

WaterInventoryButton.MouseButton1Down:Connect(function()
    UI.Enabled = not UI.Enabled
end)

CloseButton.MouseButton1Down:Connect(function()
	UI.Enabled = false 
end)

Remotes.Bindables.OnReset.GenerateWaterCanInventory.Event:Connect(function()
    generateSelectableWateringCan()
end)
