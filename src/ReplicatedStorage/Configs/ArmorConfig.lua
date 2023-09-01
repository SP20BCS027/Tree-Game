export type Armor = {
	UIID : string, 
	Name: string,
	Description: string, 
	Defense: number, 
	Type: string, 
	Rarity: string, 
	Equipped: boolean,
}

local Weapons = {
	NeutralArmors = {
		Chest = {
			StarterChestPlate = {
				UIID = "SCP__001", 
				Name = "Starter Chest Plate", 
				Description = "The starter chest plate that provides basic protection", 
				Defense = 10, 
				Type = "Neutral", 
				Rarity = "Basic",
				Equipped = false,
			},  
		}, 
		Arms = {
			StarterArmGuard = {
				UIID = "SAG__001", 
				Name = "Starter Arms Guard", 
				Description = "The starter arms guard that provides basic protection", 
				Defense = 10, 
				Type = "Neutral", 
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
		Legs = {
			StarterLegsGuard = {
				UIID = "SLG__001", 
				Name = "Starter Legs Guard", 
				Description = "The starter legs guard that provides basic protection", 
				Defense = 10, 
				Type = "Neutral", 
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
		Head = {
			StarterHelmet = {
				UIID = "SH__001", 
				Name = "Starter Helmet", 
				Description = "The starter helmet that provides basic protection", 
				Defense = 10, 
				Type = "Neutral", 
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
	}, 
	FireArmors = {
		Chest = {
			FireChestPlate = {
				UIID = "FCP__001", 
				Name = "Fire Chest Plate", 
				Description = "A Fire Chest Plate that protects the Chest", 
				Defense = 10, 
				Type = "Fire", 
				Rarity = "Basic",
				Equipped = false,
			},  
		}, 
		Arms = {
			FireArmGuard = {
				UIID = "FAG__001", 
				Name = "Fire Arms Guard", 
				Description = "A Water Arms Guard that protects the Arms", 
				Defense = 10, 
				Type = "Water", 
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
		Legs = {
			FireLegsGuard = {
				UIID = "FLG__001", 
				Name = "Fire Legs Guard", 
				Description = "A Fire Legs Guard that protects the Legs", 
				Defense = 10, 
				Type = "Fire", 
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
		Head = {
			FireHelmet = {
				UIID = "FH__001", 
				Name = "Fire Helmet", 
				Description = "A Fire Helmet that protects the Head", 
				Defense = 10, 
				Type = "Fire", 
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
	}, 
	WaterArmors = {
		Chest = {
			WaterChestPlate = {
				UIID = "WCP__001", 
				Name = "Water Chest Plate", 
				Description = "A Water Chest Plate that protects the Chest", 
				Defense = 10, 
				Type = "Water", 
				Rarity = "Basic",
				Equipped = false,
			},  
		}, 
		Arms = {
			WaterArmGuard = {
				UIID = "WAG__001", 
				Name = "Water Arms Guard", 
				Description = "A Water Arms Guard that protects the Arms", 
				Defense = 10, 
				Type = "Water", 
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
		Legs = {
			WaterLegsGuard = {
				UIID = "WLG__001", 
				Name = "Water Legs Guard", 
				Description = "A Water Legs Guard that protects the Legs", 
				Defense = 10, 
				Type = "Water", 
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
		Head = {
			WaterHelmet = {
				UIID = "WH__001", 
				Name = "Water Helmet", 
				Description = "A Water Helmet that protects the Head", 
				Defense = 10, 
				Type = "Water", 
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
	}, 
	AirArmors = {
		Chest = {
			AirChestPlate = {
				UIID = "ACP__001", 
				Name = "Air Chest Plate", 
				Description = "An Air Chest Plate that protects the Chest", 
				Defense = 10, 
				Type = "Air", 
				Rarity = "Basic",
				Equipped = false,
			},  
		}, 
		Arms = {
			AirArmGuard = {
				UIID = "AAG__001", 
				Name = "Air Arms Guard", 
				Description = "A Air Arms Guard that protects the Arms", 
				Defense = 10, 
				Type = "Air", 
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
		Legs = {
			AirLegsGuard = {
				UIID = "WLG__001", 
				Name = "Water Legs Guard", 
				Description = "A Water Legs Guard that protects the Legs", 
				Defense = 10, 
				Type = "Water", 
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
		Head = {
			AirHelmet = {
				UIID = "AH__001", 
				Name = "Air Helmet", 
				Description = "A Air Helmet that protects the Head", 
				Defense = 10, 
				Type = "Air", 
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
	}, 
	GeoArmors = {
		Chest = {
			GeoChestPlate = {
				UIID = "GCP__001", 
				Name = "Geo Chest Plate", 
				Description = "A Geo Chest Plate that protects the Chest", 
				Defense = 10, 
				Type = "Geo", 
				Rarity = "Basic",
				Equipped = false,
			},  
		}, 
		Arms = {
			GeoArmGuard = {
				UIID = "GAG__001", 
				Name = "Geo Arms Guard", 
				Description = "A Geo Arms Guard that protects the Arms", 
				Defense = 10, 
				Type = "Geo", 
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
		Legs = {
			GeoLegsGuard = {
				UIID = "GLG__001", 
				Name = "Geo Legs Guard", 
				Description = "A Geo Legs Guard that protects the Legs", 
				Defense = 10, 
				Type = "Geo", 
				Rarity = "Basic",
				Equipped = false,
			},
		}, 
		Head = {
			GeoHelmet = {
				UIID = "GH__001", 
				Name = "Geo Helmet", 
				Description = "A Geo Helmet that protects the Head", 
				Defense = 10, 
				Type = "Geo", 
				Rarity = "Basic",
				Equipped = false,
			}, 
		}, 
	},  
}

return Weapons