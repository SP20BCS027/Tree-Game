local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local BackpacksConfig = require(ReplicatedStorage.Configs.BackpacksConfig)
local BackpackEquippingHandler = require(ServerScriptService.BackpackEquippingHandler)

local Remotes = ReplicatedStorage.Remotes

local function ChangeEquippedBackpack(player: Player, backpack: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	if profile.Data.OwnedBackpacks[backpack] then 
		Manager.EquipBackpack(player, backpack)
	end
end

local function PurchasePack(player: Player, backpack: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	if profile.Data.Coins >= BackpacksConfig[backpack].Price then 
		Manager.PurchaseBackpack(player, backpack)
local function PurchasePack(player: Player, backpack: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	-- Server Side Sanity Checks
	if not BackpacksConfig[backpack] then 
		print("The Backpack " .. backpack .. " does not exist ~~ Server")
		return

		ChangeEquippedBackpack(player, backpack)
		BackpackEquippingHandler.UpdatePlayerBackpackLabel(player)

	end
	if profile.Data.OwnedBackpacks[backpack] then 
		print("The player " .. player.Name .. " already owns this backpack " .. backpack .. " ~~ Server")
		return
	end
	if profile.Data.Coins < BackpacksConfig[backpack].Price then 
		print("The player " .. player.Name .. " does not have enough coins ~~ Server")
		return
	end

	Manager.PurchaseBackpack(player, backpack)
	Manager.AdjustCoins(player, -BackpacksConfig[backpack].Price)
	Manager.EquipBackpack(player, backpack)
	BackpackEquippingHandler.UpdatePlayerBackpackLabel(player)
end

Remotes.UpdateOwnedBackpacks.OnServerEvent:Connect(PurchasePack) 
--Remotes.ChangeEquippedBackpack.OnServerEvent:Connect(ChangeEquippedBackpack)