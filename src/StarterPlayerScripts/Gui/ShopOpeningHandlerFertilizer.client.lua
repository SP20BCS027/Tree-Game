local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local Remotes = ReplicatedStorage.Remotes
local Configs = ReplicatedStorage.Configs

local PlayerMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)
local FertilizerConfig = require(Configs.FertilizerConfig)
local StateManager = require(ReplicatedStorage.Client.State)

local FertilizerShopUI = player.PlayerGui:WaitForChild("FertilizerShop")
local CloseButton = FertilizerShopUI.CloseFrame.CloseButton
local ScrollingFrame = FertilizerShopUI.MainFrame.InternalFrame.ScrollingFrame
local InformationFrame = FertilizerShopUI.MainFrame.InternalFrame.InformationFrame
local Template = FertilizerShopUI.MainFrame.InternalFrame.Template
local PurchaseButton = InformationFrame.Frame.Template

local SelectedItem 

local function BuySelectedItem(item)
	if StateManager.GetData().Coins >= item.Price then
		Remotes.UpdateOwnedFertilizers:FireServer(1, item.Name)
		Remotes.UpdateCoins:FireServer(-(item.Price))
		print("Bought")
	else
		print("You don't have enough money")
	end
end

local function LoadStats(item) 
	InformationFrame.Frame.Price.Text = item.Price
	
	SelectedItem = item 
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
	for _, item in FertilizerConfig do 
		CreateWaterCanIcon(item)
	end
end

local function ClearShopItems()
	for _, item in ScrollingFrame:GetChildren() do 
		if item.name == "UIGridLayout" then continue end 
		item:Destroy()
	end 
end 

local function ShopOpener()
	FertilizerShopUI.Enabled = not FertilizerShopUI.Enabled
	PlayerMovement:Movement(player, false)
	ClearShopItems() 
	GenerateShopItems()
end

PurchaseButton.MouseButton1Down:Connect(function()
	if SelectedItem then 
		BuySelectedItem(SelectedItem)
	end
end)

CloseButton.MouseButton1Down:Connect(function()
	FertilizerShopUI.Enabled = false
	PlayerMovement:Movement(player, true)
end)

Remotes.OpenFertilizerShop.OnClientEvent:Connect(ShopOpener)