type KeysConfigTemp = {
	Name: string, 
	Amount: number, 
	Price: number, 
	Description: string,
}

local KeysConfig: {[string] : KeysConfigTemp} = {
	Neutral = {
		UID = "Neutral", 
		Name = "Neutral Dungeon Key", 
		Amount = 0, 
		Description = "This will open the Neutral Dungeon Door", 
		Price = 100,
		LayoutOrder = 1, 
		imageID = "rbxassetid://13806730028"
	}, 
	Fire = {
		UID = "Fire", 
		Name = "Fire Dungeon Key", 
		Amount = 0, 
		Description = "This will open the Fire Dungeon Door", 
		Price = 500,
		LayoutOrder = 2, 
		imageID = "rbxassetid://13806731990"
	}, 
	Air = {
		UID = "Air", 
		Name = "Air Dungeon Key", 
		Amount = 0, 
		Description = "This will open the Air Dungeon Door",
		Price = 2500,
		LayoutOrder = 3,
		imageID = "rbxassetid://13806736297" 
	}, 
	Water = {
		UID = "Water", 
		Name = "Water Dungeon Key", 
		Amount = 0, 
		Description = "This will open the Water Dungeon Door", 
		Price = 10000,
		LayoutOrder = 4,
		imageID = "rbxassetid://13806739408" 
	}, 
	Geo = {
		UID = "Geo", 
		Name = "Geo Dungeon Key", 
		Amount = 0, 
		Description = "This will open the Geo Dungeon Door", 
		Price = 1000000,
		LayoutOrder = 5, 
		imageID = "rbxassetid://13806741893" 
	}
}

return KeysConfig