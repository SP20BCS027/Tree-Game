local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer
local Remotes = ReplicatedStorage.Remotes

local State = require(ReplicatedStorage.Client.State)

local UI = player.PlayerGui:WaitForChild("BackpackInventory")
local BackpackUI = player.PlayerGui:WaitForChild("InventoryButtons")
local CloseButton = UI.CloseFrame.CloseButton
local MainFrame = UI.MainFrame
local InternalFrame = MainFrame.InternalFrame
local InformationFrame = InternalFrame.InformationFrame
local EquipButton = InformationFrame.Frame.EquipButton
local BackpackDescription = InformationFrame.Frame.BackpackDescription
local ScrollingFrame = InternalFrame.ScrollingFrame
local Template = InternalFrame.Template
local BackpackInventoryButton = BackpackUI.ButtonsHolder.BackpackButton.BackpackInventory

local selectedBackpack

local function ChangeEquippedBackpack()
    Remotes.ChangeEquippedBackpack:FireServer(selectedBackpack)
end

local function LoadBackpack(pack)
    BackpackDescription.Text = pack.Name
    selectedBackpack = pack.Name

    EquipButton.MouseButton1Down:Connect(function()
        ChangeEquippedBackpack()
    end)
end

local function GenerateIcon(pack)
    local packIcon = Template:Clone()

    packIcon.Visible = true
    packIcon.Parent = ScrollingFrame
    packIcon.Capacity.Text = pack.Capacity
    packIcon.Identity.Text = pack.Name

    packIcon.TextButton.MouseButton1Down:Connect(function()
        LoadBackpack(pack)
    end)
end

local function GenerateSelectableBackpack()
    for _, item in (ScrollingFrame:GetChildren()) do 
        if item.Name ~= "UIGridLayout" then 
            item:Destroy()
        end
    end
    for _, pack in (State.GetData().OwnedBackpacks) do 
        GenerateIcon(pack)
    end 
end

GenerateSelectableBackpack()

BackpackInventoryButton.MouseButton1Down:Connect(function()
    UI.Enabled = not UI.Enabled
end)

CloseButton.MouseButton1Down:Connect(function()
	UI.Enabled = false 
end)

Remotes.Bindables.OnReset.GenerateBackpackInventory.Event:Connect(function()
    GenerateSelectableBackpack()
end) 

