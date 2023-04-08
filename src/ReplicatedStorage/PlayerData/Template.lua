local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlotsConfig = require(ReplicatedStorage.Configs.PlotsConfig)
local BackpackConfig = require(ReplicatedStorage.Configs.BackpacksConfig)
local WaterCanConfig = require(ReplicatedStorage.Configs.WaterCanConfig)
local DungeonConfig = require(ReplicatedStorage.Configs.DungeonConfig)

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

local Template = {
	IsOwner =  false,
	Coins = 0, 
	Gems = 100, 
	Water = 0, 
	Money = 0, 
	
	Seeds = Seeds,
	Plots = PlotsConfig,
	
	EquippedWaterCan = WaterCanConfig.MiniWateringCan, 
	OwnedWaterCans = {
		WaterCanConfig.MiniWateringCan, 
		WaterCanConfig.BasicWateringCan, 
		WaterCanConfig.WideMouthWateringCan
	},
	
	EquippedBackpack = BackpackConfig.BasicBackpack,
	OwnedBackpacks = {
		BackpackConfig.BasicBackpack, 
		BackpackConfig.SmallPouch, 
		BackpackConfig.DrawStringBag
	},
	
	UnlockedDungeons = DungeonConfig, 

}

export type PlayerData = typeof(Template)

return Template
