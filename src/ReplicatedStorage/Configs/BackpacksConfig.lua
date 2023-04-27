export type BackpackConfigTemp = {
	Name: string,
	Capacity: number, 
	Price: number
}

local Backpacks: {[string]: BackpackConfigTemp} = {
	SmallPouch = {
		Name = "SmallPouch", 
		Capacity = 100, 
		Price = 0, 
	}, 
	DrawStringBag = {
		Name = "DrawStringBag", 
		Capacity = 250, 
		Price = 10, 
	}, 
	BasicBackpack = {
		Name = "BasicBackpack", 
		Capacity = 500, 
		Price = 25
	}, 
	TravelerBackpack = {
		Name = "TravelerBackpack", 
		Capacity = 1000, 
		Price = 50 
	}, 
	HikerBackpack = {
		Name = "HikerBackpack", 
		Capacity = 2500, 
		Price = 70
	}, 
	AdventurerBackpack = {
		Name = "AdventurerBackpack", 
		Capacity = 5000, 
		Price = 90
	}, 
	ExplorerBackpack = {
		Name = "ExplorerBackpack", 
		Capacity = 10000, 
		Price = 100 
	}, 
	MasterBackpack = {
		Name = "MasterBackpack", 
		Capacity = 25000, 
		Price = 100
	}, 
	LegendBackpack = {
		Name = "LegendBackpack", 
		Capacity = 50000,
		Price = 100
	}, 
	DivineBackpack = {
		Name = "DivineBackpack", 
		Capacity = 100000, 
		Price = 100
	}
}

return Backpacks
