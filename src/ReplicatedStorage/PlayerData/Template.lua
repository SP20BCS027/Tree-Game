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
local EggsConfig = require(ReplicatedStorage.Configs.EggsConfig)
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
		Neutral = {
			StarterSword = WeaponsConfig.Neutral.StarterSword,
		},
		Fire = {}, 
		Water = {},
		Air = {},  
		Geo = {}, 
	},
	EquippedWeapon = WeaponsConfig.Neutral.StarterSword,

	OwnedArmors = {
		Neutral = {
			Chest = {
				StarterChestPlate = ArmorsConfig.Neutral.Chest.StarterChestPlate,
			},
			Arms = {
				StarterArmGuard = ArmorsConfig.Neutral.Arms.StarterArmGuard, 
			},
			Legs = {
				StarterLegsGuard = ArmorsConfig.Neutral.Legs.StarterLegsGuard,
			},
			Head = {
				StarterHelmet = ArmorsConfig.Neutral.Head.StarterHelmet, 
			},
		},
		Fire = {}, 
		Water = {},
		Air = {},  
		Geo = {}, 
	}, 
	EquippedArmors = {
		Chest = ArmorsConfig.Neutral.Chest.StarterChestPlate, 
		Arms = ArmorsConfig.Neutral.Arms.StarterArmGuard, 
		Legs = ArmorsConfig.Neutral.Legs.StarterLegsGuard, 
		Head = ArmorsConfig.Neutral.Head.StarterHelmet, 
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
		Neutral = {
			NeutralEgg = EggsConfig.Neutral.NeutralEgg
		},
		Fire = {
			FireEgg = EggsConfig.Fire.FireEgg
		}, 
		Water = {}, 
		Air = {}, 
		Geo = {},
	},
	
	Achievements = AchievementsConfig,
	ActiveQuests = QuestsConfig,

	UnlockedDungeons = DungeonConfig, 
	Settings = SettingsConfig, 
}

export type PlayerData = typeof(Template)

return Template
