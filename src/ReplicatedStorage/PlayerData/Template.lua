local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlotsConfig = require(ReplicatedStorage.Configs.PlotsConfig)
local BackpackConfig = require(ReplicatedStorage.Configs.BackpacksConfig)
local WaterCanConfig = require(ReplicatedStorage.Configs.WaterCanConfig)
local DungeonConfig = require(ReplicatedStorage.Configs.DungeonConfig)
local SeedsConfig = require(ReplicatedStorage.Configs.SeedsConfig)
local FertilizerConfig = require(ReplicatedStorage.Configs.FertilizerConfig)
local AchievementsConfig = require(ReplicatedStorage.Configs.AchievementsConfig)
local QuestsConfig = require(ReplicatedStorage.Configs.QuestsConfig)
local SettingsConfig = require(ReplicatedStorage.Configs.SettingsConfig)
local TreeIndexConfig = require(ReplicatedStorage.Configs.TreeIndexConfig)

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
	
	EquippedWaterCan = WaterCanConfig.SelfWateringCan, 
	OwnedWaterCans = {
		MiniWateringCan = WaterCanConfig.MiniWateringCan, 
		SelfWateringCan = WaterCanConfig.SelfWateringCan,
	},
	
	EquippedBackpack = BackpackConfig.DrawStringBag,
	OwnedBackpacks = {
		BasicBackpack = BackpackConfig.BasicBackpack,
		DrawStringBag = BackpackConfig.DrawStringBag,
	},

	Index = {
		TreeIndex = TreeIndexConfig, 
	},
	
	Achievements = AchievementsConfig,
	ActiveQuests = QuestsConfig,

	UnlockedDungeons = DungeonConfig, 
	Settings = SettingsConfig, 
}

export type PlayerData = typeof(Template)

return Template
