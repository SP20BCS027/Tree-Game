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
		BasicBackpack = BackpackConfig.BasicBackpack, 
		SmallPouch = BackpackConfig.SmallPouch, 
		DrawStringBag = BackpackConfig.DrawStringBag
	},
	
	UnlockedDungeons = DungeonConfig, 

}

export type PlayerData = typeof(Template)

return Template
