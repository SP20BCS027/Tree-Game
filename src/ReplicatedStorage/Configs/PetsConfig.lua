export type PetsConfigTemp = {
	UIID : string, 
	Name: string,
	Description: string, 
	MaxLevel: number,
	CurrentLevel: number, 
	Health: number, 
	Attack: number, 
	Type: string, 
	Rarity: string, 
	CritRate: number, 
	CritAmount: number, 
	SpecialAttack: string, 
	Equipped: number,
}

local Pets = {
	FirePets = {
		FireBunny = {
			UIID = "FB__001", 
			Name = "FireBunny", 
			Description = "A Bunny that Fires", 
			MaxLevel= 100, 
			CurrentLevel = 1, 
			Exp = 0, 
			Health = 100, 
			Attack = 2, 
			Type = "Fire", 
			Rarity = "Basic",
			CritRate = 0.2, 
			CritAmount = 2, 
			Equipped = false,
		}
	}, 
	WaterPets = {
		WaterBunny = {
			UIID = "WB__001", 
			Name = "Water Bunny", 
			Description = "A Bunny that Waters", 
			MaxLevel= 100, 
			CurrentLevel = 1,
			Exp = 0,  
			Health = 100, 
			Attack = 2, 
			Type = "Water", 
			Rarity = "Basic",
			CritRate = 0.2, 
			CritAmount = 2, 
			Equipped = false,
		},  
	}, 
	AirPets = {
		AirBunny = {
			UIID = "AB__001", 
			Name = "Air Bunny", 
			Description = "A Bunny that Airs", 
			MaxLevel= 100, 
			CurrentLevel = 1, 
			Exp = 0, 
			Health = 100, 
			Attack = 2, 
			Type = "Air", 
			Rarity = "Basic",
			CritRate = 0.2, 
			CritAmount = 2, 
			Equipped = false,
		},   
	}, 
	GeoPets = {
		GeoBunny = {
			UIID = "GB__001", 
			Name = "Geo Bunny", 
			Description = "A Bunny that Geos", 
			MaxLevel= 100, 
			CurrentLevel = 1, 
			Exp = 0, 
			Health = 100, 
			Attack = 2, 
			Type = "Geo", 
			Rarity = "Basic",
			CritRate = 0.2, 
			CritAmount = 2, 
			Equipped = false,
		},
	},  
}

return Pets