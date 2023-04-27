local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local Remotes = ReplicatedStorage.Remotes
local Configs = ReplicatedStorage.Configs

local PlayerMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)
local WaterCanConfig = require(Configs.WaterCanConfig)
local StateManager = require(ReplicatedStorage.Client.State)

local WaterShopUI = player.PlayerGui:WaitForChild("WaterShop")
local CloseButton = WaterShopUI.CloseFrame.CloseButton
local ScrollingFrame = WaterShopUI.MainFrame.InternalFrame.ScrollingFrame
local InformationFrame = WaterShopUI.MainFrame.InternalFrame.InformationFrame
local Template = ScrollingFrame.Template
local PurchaseButton = InformationFrame.Frame.Template

local selectedItem 

local function ShopOpener()
	WaterShopUI.Enabled = not WaterShopUI.Enabled
	PlayerMovement:Movement(player, false)
end

local function BuySelectedItem(item)
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

local function LoadStats(item) 
	InformationFrame.Frame.Capacity.Text = item.Capacity
	InformationFrame.Frame.Price.Text = item.Price
	
	selectedItem = item 
end

local function CreateWaterCanIcon(item)
	local shopItem = Template:Clone()
	shopItem.Parent = ScrollingFrame
	shopItem.Name = item.Name
	shopItem.Label.Text = item.Name
	shopItem.Amount.Text = item.Price 
	shopItem.Visible = true
	
	shopItem.TextButton.MouseButton1Down:Connect(function()
		LoadStats(item)
	end)
end

local function GenerateShopItems()
	for _, item in WaterCanConfig do 
		CreateWaterCanIcon(item)
	end
end

GenerateShopItems()

PurchaseButton.MouseButton1Down:Connect(function()
	if selectedItem then 
		BuySelectedItem(selectedItem)
	end
end)

CloseButton.MouseButton1Down:Connect(function()
	WaterShopUI.Enabled = false
	PlayerMovement:Movement(player, true)
end)

Remotes.Bindables.WaterShopOpener.Event:Connect(ShopOpener)
Remotes.OpenWaterCanShop.OnClientEvent:Connect(ShopOpener)