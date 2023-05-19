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
		ChangeEquippedBackpack(player, backpack)
		BackpackEquippingHandler.UpdatePlayerBackpackLabel(player)
	end
end

Remotes.UpdateOwnedBackpacks.OnServerEvent:Connect(PurchasePack) 
--Remotes.ChangeEquippedBackpack.OnServerEvent:Connect(ChangeEquippedBackpack)