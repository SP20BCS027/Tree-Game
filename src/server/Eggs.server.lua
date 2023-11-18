local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local PetsConfig = require(ReplicatedStorage.Configs.PetsConfig)
local EggsConfig = require(ReplicatedStorage.Configs.EggsConfig)

local Remotes = ReplicatedStorage.Remotes

local HatchingEggAmount = 1

local function selectRandomPet(eggType)
	local sortedEggs = {}
	for _, egg in PetsConfig[eggType] do
		table.insert(sortedEggs, egg)
	end

	local randomIndex = math.random(table.maxn(sortedEggs))	
	return sortedEggs[randomIndex]
end

local function HatchEgg(player: Player, eggType, eggID: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	if not profile.Data.Eggs[eggType][eggID] then 
		print("The egg " .. eggID .. " does not exist in Player Data ~~ Server")
		return 
	end

	if profile.Data.Eggs[eggType][eggID].Amount <= 0 then 
		print("The Player has 0 or negative eggs of" .. eggID ..  "~~ Server")
		return
	end

	if not EggsConfig[eggType][eggID] then 
		print("The egg" .. eggID .. " does not exist in Eggs ~~ Server")
		return
	end

	local randomPet = selectRandomPet(eggType)
	-- Check to see if the player already has this pet and refund them half the price of the egg if they already have
	-- Add this ^^^ here later
	Manager.PurchasePet(player, randomPet.Type, randomPet.UID)

	if profile.Data.Eggs[eggType][eggID].Amount > 0 then  
		Manager.AdjustEggs(player, -HatchingEggAmount, eggType, eggID)
	end
end

local function PurchaseEgg(player: Player, amount: number,  eggType: string, eggID: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	if not EggsConfig[eggType][eggID] then 
		print("The egg" .. eggID .. " does not exist in Eggs ~~ Server")
		return
	end
	 Manager.AdjustEggs(player, amount, eggType, eggID)
	 Manager.AdjustCoins(player, -amount)
end

Remotes.UpdateOwnedEggs.OnServerEvent:Connect(PurchaseEgg)
Remotes.HatchEgg.OnServerEvent:Connect(HatchEgg)
