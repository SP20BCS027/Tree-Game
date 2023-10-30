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
			UIID = "NeutralEgg", 
			Name = "Neutral Egg", 
			Description = "A Bunny that Fires", 
			Type = "Fire", 
			Rarity = "Basic",
			Price = 100, 
		}
	}, 
	FireEggs = {
		FireEgg = {
			UIID = "FireEgg", 
			Name = "Fire Egg", 
			Description = "A Bunny that Fires", 
			Type = "Fire", 
			Rarity = "Basic",
			Price = 100, 
		}
	}, 
	WaterEggs = {
		WaterEgg = {
			UIID = "WaterEgg", 
			Name = "Water Egg", 
			Description = "A Bunny that Fires", 
			Type = "Water", 
			Rarity = "Basic",
			Price = 100, 
		}
	}, 
	AirEggs = {
		AirEgg = {
			UIID = "AirEgg", 
			Name = "Air Egg", 
			Description = "A Bunny that Fires", 
			Type = "Air", 
			Rarity = "Basic",
			Price = 100, 
		}  
	}, 
	GeoPets = {
		GeoEgg = {
			UIID = "GeoEgg", 
			Name = "Geo Egg", 
			Description = "A Bunny that Fires", 
			Type = "Geo", 
			Rarity = "Basic",
			Price = 100, 
		}
	},  
}

return Eggs