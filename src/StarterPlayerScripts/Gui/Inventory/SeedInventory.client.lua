local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StateManager = require(ReplicatedStorage.Client.State)
local Remotes = ReplicatedStorage.Remotes

local player = game.Players.LocalPlayer

local InventoryGUI = player.PlayerGui:WaitForChild("Inventory")
local CloseButton = InventoryGUI.CloseFrame.CloseButton
local scrollingFrame = InventoryGUI.MainFrame.InternalFrame.ScrollingFrame
local InternalFrame = InventoryGUI.MainFrame.InternalFrame
local template = InternalFrame.Template

local InventoryButton = player.PlayerGui:WaitForChild("Stats").Frame.InventoryButtonFrame.InventoryButton

local Seeds = StateManager.GetData().Seeds

local function generateUI()
	for _, Entry in (Seeds) do
		local clonedTemplate = template:Clone()
		clonedTemplate.Parent = scrollingFrame
		clonedTemplate.Visible = true
		clonedTemplate.Amount.Text = Entry.Amount
		clonedTemplate.Label.Text = Entry.Name
		clonedTemplate.Name = Entry.Name 
	end
end

local function updateUI()
	for _, Icon in scrollingFrame:GetChildren() do
		if Icon.Name == "UIGridLayout" then continue end 
		Icon.Amount.Text = Seeds[Icon.Name].Amount
	end
end

generateUI()

CloseButton.MouseButton1Down:Connect(function()
	InventoryGUI.Enabled = false
end)

InventoryButton.MouseButton1Down:Connect(function()
	InventoryGUI.Enabled = not InventoryGUI.Enabled
	updateUI()
end)

Remotes.Bindables.OnReset.GenerateSeedsInventory.Event:Connect(function()
    task.delay(0, updateUI)
end)