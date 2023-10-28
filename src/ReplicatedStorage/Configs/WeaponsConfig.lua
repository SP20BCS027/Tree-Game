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
	NeutralWeapons = {
		StarterSword = {
			UID = "SS__001", 
			Name = "Starter Sword", 
			Description = "The Starter Sword",  
			Attack = 2, 
			Price = 100,
			Type = "Neutral", 
			WeaponType = "Sword", 
			Rarity = "Common",
			CritRate = 0.2, 
			CritAmount = 2, 
			Equipped = false,
		}
	},
	FireWeapons = {
		FireSword = {
			UID = "FS__001", 
			Name = "Fire Sword", 
			Description = "A Fire Sword",  
			Attack = 2, 
			Price = 100,
			Type = "Fire", 
			WeaponType = "Sword", 
			Rarity = "Common",
			CritRate = 0.2, 
			CritAmount = 2, 
			Equipped = false,
		}
	}, 
	WaterWeapons = {
		WaterSword = {
			UID = "WS__001", 
			Name = "Water Sword", 
			Description = "A Water Sword", 
			Attack = 2, 
			Price = 100,
			Type = "Water", 
			WeaponType = "Sword", 
			Rarity = "Common",
			CritRate = 0.2, 
			CritAmount = 2, 
			Equipped = false,
		},  
	}, 
	AirWeapons = {
		AirSword = {
			UID = "AS__001", 
			Name = "Air Sword", 
			Description = "An Air Sword", 
			Attack = 2, 
			Price = 100,
			Type = "Air", 
			WeaponType = "Sword", 
			Rarity = "Common",
			CritRate = 0.2, 
			CritAmount = 2, 
			Equipped = false,
		},   
	}, 
	GeoWeapons = {
		GeoSword = {
			UID = "GS__001", 
			Name = "Geo Sword", 
			Description = "A Geo Sword", 
			Attack = 2, 
			Price = 100,
			Type = "Geo", 
			WeaponType = "Sword", 
			Rarity = "Common",
			CritRate = 0.2, 
			CritAmount = 2, 
			Equipped = false,
		},
	},  
}

return Weapons