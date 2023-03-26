local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer
local Remotes = ReplicatedStorage.Remotes

local StateManager = require(ReplicatedStorage.Client.State)

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

local function changeEquippedBackpack()
    Remotes.ChangeEquippedBackpack:FireServer(selectedBackpack)
end

local function loadBackpack(pack)
    BackpackDescription.Text = pack.Name
    selectedBackpack = pack.Name

    EquipButton.MouseButton1Down:Connect(function()
        changeEquippedBackpack()
    end)
end

local function generateIcon(pack)
    local packIcon = Template:Clone()

    packIcon.Visible = true
    packIcon.Parent = ScrollingFrame
    packIcon.Capacity.Text = pack.Capacity
    packIcon.Identity.Text = pack.Name

    packIcon.TextButton.MouseButton1Down:Connect(function()
        loadBackpack(pack)
    end)
end

local function generateSelectableBackpack()
    for _, item in (ScrollingFrame:GetChildren()) do 
        if item.Name ~= "UIGridLayout" then 
            item:Destroy()
        end
    end
    for _, pack in (StateManager.GetData().OwnedBackpacks) do 
        generateIcon(pack)
    end 
end

generateSelectableBackpack()

BackpackInventoryButton.MouseButton1Down:Connect(function()
    UI.Enabled = not UI.Enabled
end)

CloseButton.MouseButton1Down:Connect(function()
	UI.Enabled = false 
end)

Remotes.Bindables.GenerateBackpackInventory.Event:Connect(function()
    generateSelectableBackpack()
end) 

