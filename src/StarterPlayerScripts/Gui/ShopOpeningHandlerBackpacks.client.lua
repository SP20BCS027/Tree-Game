local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local Remotes = ReplicatedStorage.Remotes

local PlayerMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)
local Backpacks = require(ReplicatedStorage.Configs.BackpacksConfig)
local State = require(ReplicatedStorage.Client.State)

local BackpackShopUI = player.PlayerGui:WaitForChild("BackpackShop")
local CloseButton = BackpackShopUI.CloseFrame.CloseButton
local ScrollingFrame = BackpackShopUI.MainFrame.InternalFrame.ScrollingFrame
local InformationFrame = BackpackShopUI.MainFrame.InternalFrame.InformationFrame
local Template = ScrollingFrame.Template
local PurchaseButton = InformationFrame.Frame.Template

local SelectedItem

local function ShopOpener()
	BackpackShopUI.Enabled = not BackpackShopUI.Enabled
	PlayerMovement:Movement(player, false)
end

local function BuySelectedItem(item)
	if State.GetData().OwnedBackpacks[item.Name] then 
		print("Item Already Owned")
		return
	end 
	
	if State.GetData().Coins >= item.Price then
		Remotes.UpdateOwnedBackpacks:FireServer(item.Name)
		Remotes.UpdateCoins:FireServer(-(item.Price))
		print("Bought")
	else
		print("You don't have enough money")
	end
end

local function LoadStats(item) 
	InformationFrame.Frame.Capacity.Text = item.Capacity
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
	for _, item in Backpacks do 
		CreateWaterCanIcon(item)
	end
end

GenerateShopItems()

CloseButton.MouseButton1Down:Connect(function()
	BackpackShopUI.Enabled = false
	PlayerMovement:Movement(player, true)

end)

PurchaseButton.MouseButton1Down:Connect(function()
	if SelectedItem then 
		BuySelectedItem(SelectedItem)
	end
end)

Remotes.Bindables.BackpackShopOpener.Event:Connect(ShopOpener)
Remotes.OpenBackpackShop.OnClientEvent:Connect(ShopOpener)