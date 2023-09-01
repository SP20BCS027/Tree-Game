export type Weapons = {
	UIID : string, 
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
			UIID = "SS__001", 
			Name = "Starter Sword", 
			Description = "The Starter Sword",  
			Attack = 2, 
			Type = "Neutral", 
			WeaponType = "Sword", 
			Rarity = "Basic",
			CritRate = 0.2, 
			CritAmount = 2, 
			Equipped = false,
		}
	},
	FireWeapons = {
		FireSword = {
			UIID = "FS__001", 
			Name = "Fire Sword", 
			Description = "A Fire Sword",  
			Attack = 2, 
			Type = "Fire", 
			WeaponType = "Sword", 
			Rarity = "Basic",
			CritRate = 0.2, 
			CritAmount = 2, 
			Equipped = false,
		}
	}, 
	WaterWeapons = {
		WaterSword = {
			UIID = "WS__001", 
			Name = "Water Sword", 
			Description = "A Water Sword", 
			Attack = 2, 
			Type = "Water", 
			WeaponType = "Sword", 
			Rarity = "Basic",
			CritRate = 0.2, 
			CritAmount = 2, 
			Equipped = false,
		},  
	}, 
	AirWeapons = {
		AirSword = {
			UIID = "AS__001", 
			Name = "Air Sword", 
			Description = "An Air Sword", 
			Attack = 2, 
			Type = "Air", 
			WeaponType = "Sword", 
			Rarity = "Basic",
			CritRate = 0.2, 
			CritAmount = 2, 
			Equipped = false,
		},   
	}, 
	GeoWeapons = {
		GeoSword = {
			UIID = "GS__001", 
			Name = "Geo Sword", 
			Description = "A Geo Sword", 
			Attack = 2, 
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