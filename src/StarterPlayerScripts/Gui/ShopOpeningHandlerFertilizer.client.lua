local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local Remotes = ReplicatedStorage.Remotes
local Configs = ReplicatedStorage.Configs

local Fertilizers = require(Configs.FertilizerConfig)
local StateManager = require(ReplicatedStorage.Client.State)
local UI = player.PlayerGui:WaitForChild("FertilizerShop")
local CloseButton = UI.CloseFrame.CloseButton
local ScrollingFrame = UI.MainFrame.InternalFrame.ScrollingFrame
local InformationFrame = UI.MainFrame.InternalFrame.InformationFrame
local Template = UI.MainFrame.InternalFrame.Template
local PurchaseButton = InformationFrame.Frame.Template

local selectedItem 

local function buySelectedItem(item)
	if StateManager.GetData().Coins >= item.Price then
		Remotes.UpdateOwnedFertilizers:FireServer(1, item.Name)
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

local function createWaterCanIcon(item)
	local shopItem = Template:Clone()
	shopItem.Parent = ScrollingFrame
	shopItem.Name = item.Name
	shopItem.Label.Text = item.Name
	shopItem.Amount.Text = item.Price 
	shopItem.Visible = true
	
	shopItem.TextButton.MouseButton1Down:Connect(function()
		loadStats(item)
	end)
end

local function GenerateShopItems()
	for _, item in Fertilizers do 
		createWaterCanIcon(item)
	end
end

local function ClearShopItems()
	for _, item in ScrollingFrame:GetChildren() do 
		if item.name == "UIGridLayout" then continue end 
		item:Destroy()
	end 
end 

local function ShopOpener()
	UI.Enabled = not UI.Enabled
	ClearShopItems() 
	GenerateShopItems()
end

PurchaseButton.MouseButton1Down:Connect(function()
	if selectedItem then 
		buySelectedItem(selectedItem)
	end
end)

CloseButton.MouseButton1Down:Connect(function()
	UI.Enabled = false
end)

Remotes.OpenFertilizerShop.OnClientEvent:Connect(ShopOpener)