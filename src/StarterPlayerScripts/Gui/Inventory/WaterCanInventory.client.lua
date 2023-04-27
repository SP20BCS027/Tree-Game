local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer
local Remotes = ReplicatedStorage.Remotes

local State = require(ReplicatedStorage.Client.State)

local WaterCanUI = player.PlayerGui:WaitForChild("WateringCanInventory")
local WaterUI = player.PlayerGui:WaitForChild("InventoryButtons")
local CloseButton = WaterCanUI.CloseFrame.CloseButton
local MainFrame = WaterCanUI:WaitForChild("MainFrame")
local InternalFrame = MainFrame.InternalFrame
local InformationFrame = InternalFrame.InformationFrame
local WaterCanDescription = InformationFrame.Frame.WaterCanDescription
local WaterCanEquipButton = InformationFrame.Frame.EquipButton
local ScrollingFrame = InternalFrame.ScrollingFrame
local Template = InternalFrame.Template
local WaterInventoryButton = WaterUI.ButtonsHolder.WaterCanButton.WaterCanInventoryButton

local SelectedWateringCan

local function ChangeEquippedWateringCan()
    Remotes.ChangeEquippedWateringCan:FireServer(SelectedWateringCan)
end

local function LoadWateringCan(canName: string)
    WaterCanDescription.Text = canName
    SelectedWateringCan = canName
    WaterCanEquipButton.MouseButton1Down:Connect(function()
        ChangeEquippedWateringCan()
    end)
end

local function GenerateIcon(can: {})
    local waterIcon = Template:Clone()
    waterIcon.Visible = true
    waterIcon.Parent = ScrollingFrame
    waterIcon.Capacity.Text = can.Capacity
    waterIcon.Identity.Text = can.Name

    waterIcon.TextButton.MouseButton1Down:Connect(function()
        LoadWateringCan(can.Name)
    end)
end

local function GenerateSelectableWateringCan()
    for _, item in (ScrollingFrame:GetChildren()) do 
        if item.Name ~= "UIGridLayout" then 
            item:Destroy()
        end
    end

    for _, can in (State.GetData().OwnedWaterCans) do 
        GenerateIcon(can)
    end 
end

GenerateSelectableWateringCan()

WaterInventoryButton.MouseButton1Down:Connect(function()
    WaterCanUI.Enabled = not WaterCanUI.Enabled
end)

CloseButton.MouseButton1Down:Connect(function()
	WaterCanUI.Enabled = false 
end)

Remotes.Bindables.OnReset.GenerateWaterCanInventory.Event:Connect(function()
    GenerateSelectableWateringCan()
end)
