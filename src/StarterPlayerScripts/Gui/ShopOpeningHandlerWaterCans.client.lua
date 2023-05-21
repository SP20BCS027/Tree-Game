local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local Remotes = ReplicatedStorage.Remotes
local Configs = ReplicatedStorage.Configs

local PlayerMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)

local WaterConfigs = require(Configs.WaterCanConfig)
local StateManager = require(ReplicatedStorage.Client.State)
local UI = player.PlayerGui:WaitForChild("WaterShop")
local CloseButton = UI.CloseFrame.CloseButton
local ScrollingFrame = UI.MainFrame.InternalFrame.ScrollingFrame
local InformationFrame = UI.MainFrame.InternalFrame.InformationFrame
local Template = ScrollingFrame.Template
local PurchaseButton = InformationFrame.Frame.Template

local selectedItem 

local function ShopOpener()
	UI.Enabled = not UI.Enabled
	PlayerMovement:Movement(player, false)
end

local function buySelectedItem(item)
	if StateManager.GetData().OwnedWaterCans[item.Name] then 
		print("You already own this item") 
		return
	end 
		
	if StateManager.GetData().Coins >= item.Price then
		Remotes.UpdateOwnedWaterCans:FireServer(item.Name)
		Remotes.UpdateCoins:FireServer(-(item.Price))
		print("Bought")
	else
		print("You don't have enough money")
	end
end

local function loadStats(item) 
	InformationFrame.Frame.Capacity.Text = item.Capacity
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
	for _, item in WaterConfigs do 
		createWaterCanIcon(item)
	end
end

GenerateShopItems()

PurchaseButton.MouseButton1Down:Connect(function()
	if selectedItem then 
		buySelectedItem(selectedItem)
	end
end)

CloseButton.MouseButton1Down:Connect(function()
	UI.Enabled = false
	PlayerMovement:Movement(player, true)
end)

Remotes.Bindables.WaterShopOpener.Event:Connect(ShopOpener)
Remotes.OpenWaterCanShop.OnClientEvent:Connect(ShopOpener)