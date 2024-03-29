export type Weapons = {
	UID : string, 
	Name: string,
	Description: string, 
	Attack: number, 
	Type: string, 
	Rarity: string, 
	CritRate: number, 
	CritAmount: number, 
	SpecialAttack: string, 
	Equipped: boolean,
}

local Weapons = {
	Neutral = {
		StarterSword = {
			UID = "StarterSword", 
			Name = "Starter Sword", 
			Description = "The Starter Sword",  
			Attack = 2, 
			Price = 100,
			Type = "Neutral", 
			WeaponType = "Sword", 
			Rarity = "Basic",
			CritRate = 0.2, 
			CritAmount = 2, 
			Equipped = false,
		},
		SecondSword = {
			UID = "SecondSword", 
			Name = "Second Sword", 
			Description = "The Second Sword",  
			Attack = 2, 
			Price = 100,
			Type = "Neutral", 
			WeaponType = "Sword", 
			Rarity = "Basic",
			CritRate = 0.2, 
			CritAmount = 2, 
			Equipped = false,
		},
		StarterBow = {
			UID = "StarterBow", 
			Name = "Starter Bow", 
			Description = "The Starter Bow",  
			Attack = 2, 
			Price = 100,
			Type = "Neutral", 
			WeaponType = "Ranged", 
			Rarity = "Basic",
			CritRate = 0.2, 
			CritAmount = 2, 
			Equipped = false,
		},
		SecondBow = {
			UID = "SecondBow", 
			Name = "Second Bow", 
			Description = "The Second Bow",  
			Attack = 2, 
			Price = 100,
			Type = "Neutral", 
			WeaponType = "Ranged", 
			Rarity = "Basic",
			CritRate = 0.2, 
			CritAmount = 2, 
			Equipped = false,
		}
	},
	Fire = {
		FireSword = {
			UID = "FireSword", 
			Name = "Fire Sword", 
			Description = "A Fire Sword",  
			Attack = 2, 
			Price = 100,
			Type = "Fire", 
			WeaponType = "Sword", 
			Rarity = "Basic",
			CritRate = 0.2, 
			CritAmount = 2, 
			Equipped = false,
		}, 
		FireBow = {
			UID = "FireBow", 
			Name = "Fire Bow", 
			Description = "A Fire Bow",  
			Attack = 2, 
			Price = 100,
			Type = "Fire", 
			WeaponType = "Bow", 
			Rarity = "Basic",
			CritRate = 0.2, 
			CritAmount = 2, 
			Equipped = false,
		}
	}, 
	Water = {
		WaterSword = {
			UID = "WaterSword", 
			Name = "Water Sword", 
			Description = "A Water Sword", 
			Attack = 2, 
			Price = 100,
			Type = "Water", 
			WeaponType = "Sword", 
			Rarity = "Basic",
			CritRate = 0.2, 
			CritAmount = 2, 
			Equipped = false,
		},  
	}, 
	Air = {
		AirSword = {
			UID = "AirSword", 
			Name = "Air Sword", 
			Description = "An Air Sword", 
			Attack = 2, 
			Price = 100,
			Type = "Air", 
			WeaponType = "Sword", 
			Rarity = "Basic",
			CritRate = 0.2, 
			CritAmount = 2, 
			Equipped = false,
		},   
	}, 
	Geo = {
		GeoSword = {
			UID = "GeoSword", 
			Name = "Geo Sword", 
			Description = "A Geo Sword", 
			Attack = 2, 
			Price = 100,
			Type = "Geo", 
			WeaponType = "Sword", 
			Rarity = "Basic",
			CritRate = 0.2, 
			CritAmount = 2, 
			Equipped = false,
		},
	},  
}

return Weapons