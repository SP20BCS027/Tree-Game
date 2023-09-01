export type PetsConfigTemp = {
	UIID : string, 
	Name: string,
	Description: string, 
	Type: string, 
	Rarity: string, 
	Amount : number,
}

local Eggs = {
	NeutralEggs = {
		NeutralEgg = {
			UIID = "NE__001", 
			Name = "Neutral Egg", 
			Description = "A Bunny that Fires", 
			Type = "Fire", 
			Rarity = "Basic",
			Price = 100, 
		}
	}, 
	FireEggs = {
		FireEgg = {
			UIID = "FE__001", 
			Name = "Fire Egg", 
			Description = "A Bunny that Fires", 
			Type = "Fire", 
			Rarity = "Basic",
			Price = 100, 
		}
	}, 
	WaterEggs = {
		WaterEgg = {
			UIID = "WE__001", 
			Name = "Water Egg", 
			Description = "A Bunny that Fires", 
			Type = "Water", 
			Rarity = "Basic",
			Price = 100, 
		}
	}, 
	AirEggs = {
		AirEgg = {
			UIID = "AE__001", 
			Name = "Air Egg", 
			Description = "A Bunny that Fires", 
			Type = "Air", 
			Rarity = "Basic",
			Price = 100, 
		}  
	}, 
	GeoPets = {
		GeoEgg = {
			UIID = "GE__001", 
			Name = "Geo Egg", 
			Description = "A Bunny that Fires", 
			Type = "Geo", 
			Rarity = "Basic",
			Price = 100, 
		}
	},  
}

return Eggs