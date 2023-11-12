export type PetsConfigTemp = {
	UID : string, 
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
	Fire = {
		FireBunny = {
			UID = "FireBunny", 
			Name = "Fire Bunny", 
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
			ImageID = "rbxassetid://13806908261"
		}
	}, 
	Water = {
		WaterBunny = {
			UID = "WaterBunny", 
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
			ImageID = "rbxassetid://13806908261"
		},  
	}, 
	Air = {
		AirBunny = {
			UID = "AirBunny", 
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
			ImageID = "rbxassetid://13806908261"
		},   
	}, 
	Geo = {
		GeoBunny = {
			UID = "GeoBunny", 
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
			ImageID = "rbxassetid://13806908261"
		},
	},  
}

return Pets