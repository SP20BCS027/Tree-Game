export type PetsConfigTemp = {
	UID : string, 
	Name: string,
	Description: string, 
	Type: string, 
	Rarity: string, 
	Amount : number,
}

local Eggs = {
	Neutral = {
		NeutralEgg = {
			UID = "NeutralEgg", 
			Name = "Neutral Egg", 
			Description = "A Bunny that Fires", 
			Type = "Neutral", 
			Rarity = "Basic",
			Price = 100, 
			ImageID = "rbxassetid://15217376249",
		}
	}, 
	Fire = {
		FireEgg = {
			UID = "FireEgg", 
			Name = "Fire Egg", 
			Description = "A Bunny that Fires", 
			Type = "Fire", 
			Rarity = "Basic",
			Price = 100, 
			ImageID = "rbxassetid://15217391614",
		}
	}, 
	Water = {
		WaterEgg = {
			UID = "WaterEgg", 
			Name = "Water Egg", 
			Description = "A Bunny that Fires", 
			Type = "Water", 
			Rarity = "Basic",
			Price = 100, 
			ImageID = "rbxassetid://15217400528",
		}
	}, 
	Air = {
		AirEgg = {
			UID = "AirEgg", 
			Name = "Air Egg", 
			Description = "A Bunny that Fires", 
			Type = "Air", 
			Rarity = "Basic",
			Price = 100, 
			ImageID = "rbxassetid://15217408485",
		}  
	}, 
	Geo = {
		GeoEgg = {
			UID = "GeoEgg", 
			Name = "Geo Egg", 
			Description = "A Bunny that Fires", 
			Type = "Geo", 
			Rarity = "Basic",
			Price = 100, 
			ImageID = "rbxassetid://15217429275",
		}
	},  
}

return Eggs