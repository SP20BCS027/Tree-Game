local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local SeedsConfig = require(ReplicatedStorage.Configs.SeedsConfig)

local Remotes = ReplicatedStorage.Remotes

local SeedPlantingAmount = 1

local function UpdateSeeds(player: Player, amount: number, seedType: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	if not profile.Data.Seeds[seedType] then 
		print("The Seed " .. seedType .. " does not exist ~~ Server")
		return 
	end

	if profile.Data.Coins < SeedsConfig[seedType].Price then 
		print("The player " .. player.Name .. " does not have enough coins ~~ Server")
		return 
	end

	Manager.AdjustCoins(player, -(amount * SeedsConfig[seedType].Price))
	Manager.AdjustSeeds(player, amount, seedType)
end

local function PlantSeed(player: Player, seedType: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	if profile.Data.Seeds[seedType].Amount > 0 then  
		Manager.AdjustSeeds(player, -SeedPlantingAmount, seedType)
	end
end

Remotes.PlantedSeed.OnServerEvent:Connect(PlantSeed)
Remotes.UpdateOwnedSeeds.OnServerEvent:Connect(UpdateSeeds)
