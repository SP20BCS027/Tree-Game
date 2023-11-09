export type Armor = {
	UID : string, 
	Name: string,
	Description: string, 
	Defense: number, 
	Type: string, 
	Rarity: string, 
	Equipped: boolean,
}

local Weapons = {
	Neutral = {
		Chest = {
			StarterChestPlate = {
				UID = "SCP__001", 
				Name = "Starter Chest Plate", 
				Description = "The starter chest plate that provides basic protection", 
				Defense = 10, 
				Type = "Neutral", 
				ArmorType = "Chest",
				Rarity = "Basic",
				Equipped = false,
			},  
		}, 
		Arms = {
			StarterArmGuard = {
				UID = "SAG__001", 
				Name = "Starter Arms Guard", 
				Description = "The starter arms guard that provides basic protection", 
				Defense = 10, 
				Type = "Neutral", 
				ArmorType = "Arms",
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
		Legs = {
			StarterLegsGuard = {
				UID = "SLG__001", 
				Name = "Starter Legs Guard", 
				Description = "The starter legs guard that provides basic protection", 
				Defense = 10, 
				Type = "Neutral", 
				ArmorType = "Legs",
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
		Head = {
			StarterHelmet = {
				UID = "SH__001", 
				Name = "Starter Helmet", 
				Description = "The starter helmet that provides basic protection", 
				Defense = 10, 
				Type = "Neutral",
				ArmorType = "Head", 
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
	}, 
	Fire = {
		Chest = {
			FireChestPlate = {
				UID = "FCP__001", 
				Name = "Fire Chest Plate", 
				Description = "A Fire Chest Plate that protects the Chest", 
				Defense = 10, 
				Type = "Fire", 
				ArmorType = "Chest",
				Rarity = "Basic",
				Equipped = false,
			},  
		}, 
		Arms = {
			FireArmGuard = {
				UID = "FAG__001", 
				Name = "Fire Arms Guard", 
				Description = "A Water Arms Guard that protects the Arms", 
				Defense = 10, 
				Type = "Water", 
				ArmorType = "Arms",
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
		Legs = {
			FireLegsGuard = {
				UID = "FLG__001", 
				Name = "Fire Legs Guard", 
				Description = "A Fire Legs Guard that protects the Legs", 
				Defense = 10, 
				Type = "Fire",
				ArmorType = "Legs", 
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
		Head = {
			FireHelmet = {
				UID = "FH__001", 
				Name = "Fire Helmet", 
				Description = "A Fire Helmet that protects the Head", 
				Defense = 10, 
				Type = "Fire",
				ArmorType = "Head", 
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
	}, 
	Water = {
		Chest = {
			WaterChestPlate = {
				UID = "WCP__001", 
				Name = "Water Chest Plate", 
				Description = "A Water Chest Plate that protects the Chest", 
				Defense = 10, 
				Type = "Water",
				ArmorType = "Chest", 
				Rarity = "Basic",
				Equipped = false,
			},  
		}, 
		Arms = {
			WaterArmGuard = {
				UID = "WAG__001", 
				Name = "Water Arms Guard", 
				Description = "A Water Arms Guard that protects the Arms", 
				Defense = 10, 
				Type = "Water", 
				ArmorType = "Arms",
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
		Legs = {
			WaterLegsGuard = {
				UID = "WLG__001", 
				Name = "Water Legs Guard", 
				Description = "A Water Legs Guard that protects the Legs", 
				Defense = 10, 
				Type = "Water", 
				Rarity = "Basic",
				ArmorType = "Legs",
				Equipped = false,
			},
		}, 
		Head = {
			WaterHelmet = {
				UID = "WH__001", 
				Name = "Water Helmet", 
				Description = "A Water Helmet that protects the Head", 
				Defense = 10, 
				Type = "Water",
				ArmorType = "Head", 
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
	}, 
	Air = {
		Chest = {
			AirChestPlate = {
				UID = "ACP__001", 
				Name = "Air Chest Plate", 
				Description = "An Air Chest Plate that protects the Chest", 
				Defense = 10, 
				Type = "Air", 
				ArmorType = "Chest",
				Rarity = "Basic",
				Equipped = false,
			},  
		}, 
		Arms = {
			AirArmGuard = {
				UID = "AAG__001", 
				Name = "Air Arms Guard", 
				Description = "A Air Arms Guard that protects the Arms", 
				Defense = 10, 
				Type = "Air", 
				ArmorType = "Arms",
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
		Legs = {
			AirLegsGuard = {
				UID = "WLG__001", 
				Name = "Water Legs Guard", 
				Description = "A Water Legs Guard that protects the Legs", 
				Defense = 10, 
				Type = "Water",
				ArmorType = "Legs", 
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
		Head = {
			AirHelmet = {
				UID = "AH__001", 
				Name = "Air Helmet", 
				Description = "A Air Helmet that protects the Head", 
				Defense = 10, 
				Type = "Air", 
				ArmorType = "Head",
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
	}, 
	Geo = {
		Chest = {
			GeoChestPlate = {
				UID = "GCP__001", 
				Name = "Geo Chest Plate", 
				Description = "A Geo Chest Plate that protects the Chest", 
				Defense = 10, 
				Type = "Geo", 
				ArmorType = "Chest",
				Rarity = "Basic",
				Equipped = false,
			},  
		}, 
		Arms = {
			GeoArmGuard = {
				UID = "GAG__001", 
				Name = "Geo Arms Guard", 
				Description = "A Geo Arms Guard that protects the Arms", 
				Defense = 10, 
				Type = "Geo",
				ArmorType = "Arms",
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
		Legs = {
			GeoLegsGuard = {
				UID = "GLG__001", 
				Name = "Geo Legs Guard", 
				Description = "A Geo Legs Guard that protects the Legs", 
				Defense = 10, 
				Type = "Geo", 
				ArmorType = "Legs",
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
		Head = {
			GeoHelmet = {
				UID = "GH__001", 
				Name = "Geo Helmet", 
				Description = "A Geo Helmet that protects the Head", 
				Defense = 10, 
				Type = "Geo", 
				ArmorType = "Head",
				Rarity = "Basic",
				Equipped = false,
			}, 
		}, 
	},  
}

return Weapons