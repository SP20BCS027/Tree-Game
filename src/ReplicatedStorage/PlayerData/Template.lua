local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlotsConfig = require(ReplicatedStorage.Configs.PlotsConfig)
local BackpackConfig = require(ReplicatedStorage.Configs.BackpacksConfig)
local WaterCanConfig = require(ReplicatedStorage.Configs.WaterCanConfig)
<<<<<<< Updated upstream

local Seeds = {
	Basic = {
		Name = "Basic", 
		Amount = 010, 
		Description = "This will plant a Basic Tree"
	}, 
	Uncommon = {
		Name = "Uncommon", 
		Amount = 010, 
		Description = "This will plant an Uncommon Tree"
	}, 
	Rare = {
		Name = "Rare", 
		Amount = 010, 
		Description = "This will plant a Rare Tree"
	}, 
	Legendary = {
		Name = "Legendary", 
		Amount = 010, 
		Description = "This will plant a Legendary Tree"
	}, 
	Mythical = {
		Name = "Mythical", 
		Amount = 0, 
		Description = "This will plant a Mythical Tree"
	}
}
=======
local DungeonConfig = require(ReplicatedStorage.Configs.DungeonConfig)
local SeedsConfig = require(ReplicatedStorage.Configs.SeedsConfig)
local FertilizerConfig = require(ReplicatedStorage.Configs.FertilizerConfig)
>>>>>>> Stashed changes

local Template = {
	IsOwner =  false,
	Coins = 0, 
	Gems = 100, 
	Water = 0, 
	Money = 0, 
	
	Seeds = SeedsConfig,
	Fertilizers = FertilizerConfig, 
	
	Plots = {
		Plot_1 = PlotsConfig.Plot_1, 
		Plot_2 = PlotsConfig.Plot_2, 
	},
	
	EquippedWaterCan = WaterCanConfig.MiniWateringCan, 
	OwnedWaterCans = {
		MiniWateringCan = WaterCanConfig.MiniWateringCan, 
		BasicWateringCan = WaterCanConfig.BasicWateringCan, 
		WideMouthWateringCan = WaterCanConfig.WideMouthWateringCan
	},
	
	EquippedBackpack = BackpackConfig.BasicBackpack,
	OwnedBackpacks = {
<<<<<<< Updated upstream
		BackpackConfig.BasicBackpack, 
		BackpackConfig.SmallPouch, 
		BackpackConfig.DrawStringBag
	}
=======
		BasicBackpack = BackpackConfig.BasicBackpack, 
		SmallPouch = BackpackConfig.SmallPouch, 
		DrawStringBag = BackpackConfig.DrawStringBag
	},
>>>>>>> Stashed changes
	
}

export type PlayerData = typeof(Template)

return Template
