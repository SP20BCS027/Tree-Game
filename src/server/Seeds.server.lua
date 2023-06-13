local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local SeedsConfig = require(ReplicatedStorage.Configs.SeedsConfig)

local Remotes = ReplicatedStorage.Remotes

local SeedPlantingAmount = 1

-- Updates the seeds in the player's profile by adjusting the amount and deducting the cost from the player's coins.
-- Adjusts the player's seeds by adding the specified amount.
local function UpdateSeeds(player: Player, amount: number, seedType: string)
	print("Got Called")
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

-- Plants a seed by adjusting the seed amount in the player's profile.
-- Adjusts the player's seeds by deducting the planting amount.
local function PlantSeed(player: Player, seedType: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	if not profile.Data.Seeds[seedType] then 
		print("The Seed " .. seedType .. " does not exist ~~ Server")
		return 
	end

	if profile.Data.Seeds[seedType].Amount > 0 then  
		Manager.AdjustSeeds(player, -SeedPlantingAmount, seedType)
	end
end


Remotes.PlantedSeed.OnServerEvent:Connect(PlantSeed)
Remotes.UpdateOwnedSeeds.OnServerEvent:Connect(UpdateSeeds)