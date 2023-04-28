export type BackpackConfigTemp = {
	Name: string,
	Capacity: number, 
	Price: number,
	Description: string
}

local Backpacks: {[string]: BackpackConfigTemp} = {
	SmallPouch = {
		Name = "SmallPouch", 
		Capacity = 100, 
		Price = 0, 
		Description = "This is the smallest backpack",
	}, 
	DrawStringBag = {
		Name = "DrawStringBag", 
		Capacity = 250, 
		Price = 10, 
		Description = "This is the DrawStringBag", 
	}, 
	BasicBackpack = {
		Name = "BasicBackpack", 
		Capacity = 500, 
		Price = 25, 
		Description = "This is the Basic of the Basic Backpacks",
	}, 
	TravelerBackpack = {
		Name = "TravelerBackpack", 
		Capacity = 1000, 
		Price = 50, 
		Description = "This is the Essential backpack for traveling", 
	}, 
	HikerBackpack = {
		Name = "HikerBackpack", 
		Capacity = 2500, 
		Price = 70, 
		Description = "This is the backpack all Hiker's carry.", 
	}, 
	AdventurerBackpack = {
		Name = "AdventurerBackpack", 
		Capacity = 5000, 
		Price = 90, 
		Description = "This is the backpack of a true adventurer", 
	}, 
	ExplorerBackpack = {
		Name = "ExplorerBackpack", 
		Capacity = 10000, 
		Price = 100, 
		Description = "This backpack can only be worn by a true explorer", 
	}, 
	MasterBackpack = {
		Name = "MasterBackpack", 
		Capacity = 25000, 
		Price = 100, 
		Description = "Legend has it that this backpack belonged to master shifu itself", 
	}, 
	LegendBackpack = {
		Name = "LegendBackpack", 
		Capacity = 50000,
		Price = 100, 
		Description = "This is the Legend Backpack? What does that even mean?"
	}, 
	DivineBackpack = {
		Name = "DivineBackpack", 
		Capacity = 100000, 
		Price = 100, 
		Description = "DivineBackpack (O)_(O)..."
	}
}

return Backpacks
