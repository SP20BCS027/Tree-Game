export type BackpackConfigTemp = {
	Name: string,
	Capacity: number, 
	Price: number,
	Description: string
}

local Backpacks: {[string]: BackpackConfigTemp} = {
	SmallPouch = {
		UID = "SmallPouch",
		Name = "Small Pouch", 
		Capacity = 100, 
		Price = 0, 
		Description = "This is the smallest backpack",
		LayoutOrder = 1,
	}, 
	DrawStringBag = {
		UID = "DrawStringBag", 
		Name = "Draw String Bag", 
		Capacity = 250, 
		Price = 10, 
		Description = "This is the Draw String Bag", 
		LayoutOrder = 2, 
	}, 
	BasicBackpack = {
		UID = "BasicBackpack",
		Name = "Basic Backpack", 
		Capacity = 500, 
		Price = 25, 
		Description = "This is the Basic of the Basic Backpacks",
		LayoutOrder = 3, 
	}, 
	TravelerBackpack = {
		UID = "TravelerBackpack", 
		Name = "Traveler Backpack", 
		Capacity = 1000, 
		Price = 50, 
		Description = "This is the Essential backpack for traveling", 
		LayoutOrder = 4, 
	}, 
	HikerBackpack = {
		UID = "HikerBackpack", 
		Name = "Hiker Backpack", 
		Capacity = 2500, 
		Price = 70, 
		Description = "This is the backpack all Hiker's carry.", 
		LayoutOrder = 5,
	}, 
	AdventurerBackpack = {
		UID = "AdventurerBackpack", 
		Name = "Adventurer Backpack", 
		Capacity = 5000, 
		Price = 90, 
		Description = "This is the backpack of a true adventurer", 
		LayoutOrder = 6,
	}, 
	ExplorerBackpack = {
		UID = "ExplorerBackpack", 
		Name = "Explorer Backpack", 
		Capacity = 10000, 
		Price = 100, 
		Description = "This backpack can only be worn by a true explorer", 
		LayoutOrder = 7,
	}, 
	MasterBackpack = {
		UID = "MasterBackpack", 
		Name = "Master Backpack", 
		Capacity = 25000, 
		Price = 100, 
		Description = "Legend has it that this backpack belonged to master shifu.", 
		LayoutOrder = 8, 
	}, 
	LegendBackpack = {
		UID = "LegendBackpack", 
		Name = "Legend Backpack", 
		Capacity = 50000,
		Price = 100, 
		Description = "This is the Legend Backpack? What does that even mean?",
		LayoutOrder = 9,
	}, 
	DivineBackpack = {
		UID = "DivineBackpack", 
		Name = "Divine Backpack", 
		Capacity = 100000, 
		Price = 100, 
		Description = "DivineBackpack (O)_(O)...",
		LayoutOrder = 10,
	}
}

return Backpacks
