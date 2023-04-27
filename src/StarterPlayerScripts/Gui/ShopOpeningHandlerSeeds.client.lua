local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local Remotes = ReplicatedStorage.Remotes
local Configs = ReplicatedStorage.Configs

local PlayerMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)
local SeedsConfig = require(Configs.SeedsConfig)
local StateManager = require(ReplicatedStorage.Client.State)

local SeedsShopUI = player.PlayerGui:WaitForChild("SeedsShop")
local CloseButton = SeedsShopUI.CloseFrame.CloseButton
local ScrollingFrame = SeedsShopUI.MainFrame.InternalFrame.ScrollingFrame
local InformationFrame = SeedsShopUI.MainFrame.InternalFrame.InformationFrame
local Template = ScrollingFrame.Template
local PurchaseButton = InformationFrame.Frame.Template

local SelectedItem

local function ShopOpener()
	SeedsShopUI.Enabled = not SeedsShopUI.Enabled
	PlayerMovement:Movement(player, false)
end

local function BuySelectedItem(item)
	if StateManager.GetData().Coins >= item.Price then
		Remotes.UpdateOwnedSeeds:FireServer(1, item.Name)
		Remotes.UpdateCoins:FireServer(-(item.Price))
		print("Bought")
	else
		print("You don't have enough money")
	end
end

local function LoadStats(item) 
	InformationFrame.Frame.Description.Text = item.Description
	InformationFrame.Frame.Price.Text = item.Price
	
	SelectedItem = item
end

local function createWaterCanIcon(item)
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
	for _, item in SeedsConfig do 
		createWaterCanIcon(item)
	end
end

GenerateShopItems()

CloseButton.MouseButton1Down:Connect(function()
	SeedsShopUI.Enabled = false
	PlayerMovement:Movement(player, true)
end)

PurchaseButton.MouseButton1Down:Connect(function()
	if SelectedItem then 
		BuySelectedItem(SelectedItem)
	end 
end)

Remotes.Bindables.WaterShopOpener.Event:Connect(ShopOpener)
Remotes.OpenSeedsShop.OnClientEvent:Connect(ShopOpener)