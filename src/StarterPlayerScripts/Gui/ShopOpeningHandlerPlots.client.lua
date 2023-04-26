local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local Remotes = ReplicatedStorage.Remotes

local PlayerMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)

local Plots = require(ReplicatedStorage.Configs.PlotsConfig)
local StateManager = require(ReplicatedStorage.Client.State)
local UI = player.PlayerGui:WaitForChild("PlotsShop")
local CloseButton = UI.CloseFrame.CloseButton
local ScrollingFrame = UI.MainFrame.InternalFrame.ScrollingFrame
local InformationFrame = UI.MainFrame.InternalFrame.InformationFrame
local InternalFrame = UI.MainFrame.InternalFrame
local Template = InternalFrame.Template
local PurchaseButton = InformationFrame.Frame.Template

local selectedItem 



local function buySelectedItem(item)
	
	if StateManager.GetData().Coins >= item.Price then
		Remotes.UpdateOwnedPlots:FireServer(item)
		Remotes.UpdateCoins:FireServer(-(item.Price))
		print("Bought")
	else
		print("You don't have enough money")
	end
end

local function loadStats(item) 
	InformationFrame.Frame.Price.Text = item.Price
	
	selectedItem = item 
end

local function createPlotIcon(item)
	local shopItem = Template:Clone()
	shopItem.Parent = ScrollingFrame
	shopItem.Name = item.Name
	shopItem.Label.Text = item.Name
	shopItem.Amount.Text = item.Id

	if not StateManager.GetData().Plots[item.Id] then
		shopItem.Visible = true
	end

	shopItem.TextButton.MouseButton1Down:Connect(function()
		loadStats(item)
	end)
end

local function GenerateShopItems()
	for _, item in Plots do 
		createPlotIcon(item)
	end
end

local function ClearShop()
	for _, item in pairs(ScrollingFrame:GetChildren()) do 
		if item.Name == "UIGridLayout" then continue end 
		item:Destroy()
	end 
end

local function ShopOpener()
	UI.Enabled = not UI.Enabled
	PlayerMovement:Movement(player, false)
	ClearShop()
	GenerateShopItems()
end

local function RegenerateShop()
	task.delay(0, function()
		ClearShop()
		GenerateShopItems()
	end)
end

CloseButton.MouseButton1Down:Connect(function()
	UI.Enabled = false
	PlayerMovement:Movement(player, true)
end)

PurchaseButton.MouseButton1Down:Connect(function()
	if selectedItem then 
		buySelectedItem(selectedItem)
	end 
end)

Remotes.UpdateOwnedPlots.OnClientEvent:Connect(RegenerateShop)
Remotes.OpenPlotsShop.OnClientEvent:Connect(ShopOpener)