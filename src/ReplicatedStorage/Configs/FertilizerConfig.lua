type FertilizerConfig = {
	Name: string, 
	Amount: number, 
	Price: number, 
	Description: string,
	Type: string, 
	Cycles: number, 
}

local FertilizerConfig :{ [string] : FertilizerConfig } = {
	Basic = {
		Name = "Basic", 
		Amount = 1, 
		Description = "This will grant your tree 2 cycles", 
		Price = 10, 
		Type = "Basic", 
		Cycles = 2
	}, 
	Uncommon = {
		Name = "Uncommon", 
		Amount = 0, 
		Description = "This will grant your tree 3 cycles", 
		Price = 25, 
		Type = "Uncommon", 
		Cycles = 3
	}, 
	Rare = {
		Name = "Rare",
		Amount = 0,  
		Description = "This will grant your tree 4 cycles", 
		Price = 50, 
		Type = "Rare", 
		Cycles = 4
	}, 
	Legendary = {
		Name = "Legendary",
		Amount = 0,  
		Description = "This will grant your tree 6 cycles", 
		Price = 100, 
		Type = "Legendary", 
		Cycles = 6
	}, 
	Mythical = {
		Name = "Mythical", 
		Amount = 0, 
		Description = "This will grant your tree 10 cycles", 
		Price = 100, 
		Type = "Mythical", 
		Cycles = 10
	}
}

return FertilizerConfig
