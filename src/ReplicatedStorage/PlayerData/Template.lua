local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlotsConfig = require(ReplicatedStorage.Configs.PlotsConfig)
local BackpackConfig = require(ReplicatedStorage.Configs.BackpacksConfig)
local WaterCanConfig = require(ReplicatedStorage.Configs.WaterCanConfig)
local DungeonConfig = require(ReplicatedStorage.Configs.DungeonConfig)
local SeedsConfig = require(ReplicatedStorage.Configs.SeedsConfig)
local FertilizerConfig = require(ReplicatedStorage.Configs.FertilizerConfig)

local Template = {
	Coins = 0, 
	Gems = 100, 
	Water = 0, 
	Money = 0, 
	
	Seeds = SeedsConfig,
	Fertilizers = FertilizerConfig, 
	
	Plots = {
		Plot_1 = PlotsConfig.Plot_1
	},
	
	EquippedWaterCan = WaterCanConfig.MiniWateringCan, 
	OwnedWaterCans = {
		MiniWateringCan = WaterCanConfig.MiniWateringCan, 
	},
	
	EquippedBackpack = BackpackConfig.BasicBackpack,
	OwnedBackpacks = {
		BasicBackpack = BackpackConfig.BasicBackpack, 
	},
	
	UnlockedDungeons = DungeonConfig, 
}

export type PlayerData = typeof(Template)

return Template
