local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlotsConfig = require(ReplicatedStorage.Configs.PlotsConfig)
local TreesConfig = require(ReplicatedStorage.Configs.TreeConfig)
local BackpackConfig = require(ReplicatedStorage.Configs.BackpacksConfig)
local WaterCanConfig = require(ReplicatedStorage.Configs.WaterCanConfig)

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

local Plots = {
	Plot_1 = {
		Occupied = true, 	
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
	OwnedWaterCans = {WaterCanConfig.MiniWateringCan},
	
	EquippedBackpack = BackpackConfig.BasicBackpack,
	OwnedBackpacks = {BackpackConfig.BasicBackpack}
	
}

export type PlayerData = typeof(Template)

return Template
