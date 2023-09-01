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

local WeaponsConfig = require(ReplicatedStorage.Configs.WeaponsConfig)
local ArmorsConfig = require(ReplicatedStorage.Configs.ArmorConfig)
local PotionsConfig = require(ReplicatedStorage.Configs.PotionsConfig)
-- local EggsConfig = require(ReplicatedStorage.Configs.EggsConfig)
-- local PetsConfig = require(ReplicatedStorage.Configs.PetsConfig)

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

	OwnedWeapons = {
		NeutralWeapons = {
			WeaponsConfig.NeutralWeapons.StarterSword,
		},
		FireWeapons = {}, 
		WaterWeapons = {},
		AirWeapons = {},  
		GeoWeapons = {}, 
	},
	EquippedWeapon = WeaponsConfig.NeutralWeapons.StarterSword,

	OwnedArmors = {
		NeutralArmors = {
			Chest = {
				StarterChestPlate = ArmorsConfig.NeutralArmors.Chest.StarterChestPlate,
			},
			Arms = {
				StarterArmGuard = ArmorsConfig.NeutralArmors.Arms.StarterArmGuard, 
			},
			Legs = {
				StarterLegsGuard = ArmorsConfig.NeutralArmors.Legs.StarterLegsGuard,
			},
			Head = {
				StarterHelmet = ArmorsConfig.NeutralArmors.Head.StarterHelmet, 
			},
		},
		FireArmors = {}, 
		WaterArmors = {},
		AirWArmors = {},  
		GeoArmors = {}, 
	}, 
	EquippedArmors = {
		Chest = ArmorsConfig.NeutralArmors.Chest.StarterChestPlate, 
		Arms = ArmorsConfig.NeutralArmors.Arms.StarterArmGuard, 
		Legs = ArmorsConfig.NeutralArmors.Legs.StarterLegsGuard, 
		Head = ArmorsConfig.NeutralArmors.Head.StarterHelmet, 
	}, 

	OwnedPotions = {
		Attack = {
			DoubleAttack = PotionsConfig.Attack.DoubleAttack,
		}, 
		Health = {
			FullHealPotion = PotionsConfig.Health.FullHealPotion, 
		}, 
		Defense = {
			DoubleDefense = PotionsConfig.Defense.DoubleDefense, 
		}, 
		Pets = {
			DoublePetsAttack = PotionsConfig.Pets.DoublePetsAttack,
		},
	},
	EquippedPotions = {
		PrimaryPotion = {}, 
		SecondaryPotion = {},
	},

	MaxEquippedPets = 3, 
	OwnedPets = {
		NeutralPets = {},
		FirePets = {}, 
		WaterPets = {}, 
		AirPets = {}, 
		GeoPets = {}, 
	},
	EquippedPets = {
	},
	Eggs = {
		NeutralEggs = {},
		FireEggs = {}, 
		WaterEggs = {}, 
		AirEggs = {}, 
		GeoEggs = {},
	},
	
	Achievements = AchievementsConfig,
	ActiveQuests = QuestsConfig,

	UnlockedDungeons = DungeonConfig, 
	Settings = SettingsConfig, 
}

export type PlayerData = typeof(Template)

return Template
