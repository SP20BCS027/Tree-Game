local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local Remotes = ReplicatedStorage.Remotes

local PlayerMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)
local Plots = require(ReplicatedStorage.Configs.PlotsConfig)
local StateManager = require(ReplicatedStorage.Client.State)

local PlotsShopUI = player.PlayerGui:WaitForChild("PlotsShop")
local CloseButton = PlotsShopUI.CloseFrame.CloseButton
local ScrollingFrame = PlotsShopUI.MainFrame.InternalFrame.ScrollingFrame
local InformationFrame = PlotsShopUI.MainFrame.InternalFrame.InformationFrame
local InternalFrame = PlotsShopUI.MainFrame.InternalFrame
local Template = InternalFrame.Template
local PurchaseButton = InformationFrame.Frame.Template

local SelectedItem 

-- This function Buys the selected Plot

local function BuySelectedItem(item)
	
	if StateManager.GetData().Coins >= item.Price then
		Remotes.UpdateOwnedPlots:FireServer(item)
		Remotes.UpdateCoins:FireServer(-(item.Price))
		print("Bought")
	else
		print("You don't have enough money")
	end
end

-- This function loads the stats of the selected Item

local function LoadStats(item) 
	InformationFrame.Frame.Price.Text = item.Price
	
	SelectedItem = item 
end

-- This function creates the Icons of all the Plots

local function CreatePlotIcon(item)
	local shopItem = Template:Clone()
	shopItem.Parent = ScrollingFrame
	shopItem.Name = item.Name
	shopItem.Label.Text = item.Name
	shopItem.Amount.Text = item.Id

	if not StateManager.GetData().Plots[item.Id] then
		shopItem.Visible = true
	end

	shopItem.TextButton.MouseButton1Down:Connect(function()
		LoadStats(item)
	end)
end

-- This function Generates all the plots Icons in the Plots Config

local function GenerateShopItems()
	for _, item in Plots do 
		CreatePlotIcon(item)
	end
end

-- This function Deletes all the Plot Icons in the Menu

local function ClearShop()
	for _, item in pairs(ScrollingFrame:GetChildren()) do 
		if item.Name == "UIGridLayout" then continue end 
		item:Destroy()
	end 
end

-- When this button is pressed the shop gets opened 

local function ShopOpener()
	PlotsShopUI.Enabled = not PlotsShopUI.Enabled
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

-- When this button is pressed the Shop gets closed 

CloseButton.MouseButton1Down:Connect(function()
	PlotsShopUI.Enabled = false
	PlayerMovement:Movement(player, true)
end)

PurchaseButton.MouseButton1Down:Connect(function()
	if SelectedItem then 
		BuySelectedItem(SelectedItem)
	end 
end)

Remotes.UpdateOwnedPlots.OnClientEvent:Connect(RegenerateShop)
Remotes.OpenPlotsShop.OnClientEvent:Connect(ShopOpener)