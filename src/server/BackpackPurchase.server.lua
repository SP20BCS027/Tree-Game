local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local Backpacks = require(ReplicatedStorage.Configs.BackpacksConfig)

local Remotes = ReplicatedStorage.Remotes

local function changeEquippedBackpack(player: Player, backpack: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	if profile.Data.OwnedBackpacks[backpack] then 
		Manager.EquipBackpack(player, backpack)
	end
end

local function purchasePack(player: Player, backpack: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	if profile.Data.Coins >= Backpacks[backpack].Price then 
		Manager.PurchaseBackpack(player, backpack)
		changeEquippedBackpack(player, backpack)
	end
end

Remotes.UpdateOwnedBackpacks.OnServerEvent:Connect(purchasePack) 
Remotes.ChangeEquippedBackpack.OnServerEvent:Connect(changeEquippedBackpack)