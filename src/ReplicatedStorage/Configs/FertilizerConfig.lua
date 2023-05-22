type FertilizerConfigTemp = {
	Name: string, 
	Amount: number, 
	Price: number, 
	Description: string,
	Type: string, 
	Cycles: number, 
}

local FertilizerConfig :{[string] : FertilizerConfigTemp} = {
	Basic = {
		Name = "Basic", 
		Amount = 1, 
		Description = "This will grant your tree 2 cycles", 
		Price = 10, 
		Type = "Basic", 
		Cycles = 2,
		LayoutOrder = 1,
	}, 
	Uncommon = {
		Name = "Uncommon", 
		Amount = 0, 
		Description = "This will grant your tree 3 cycles", 
		Price = 25, 
		Type = "Uncommon", 
		Cycles = 3, 
		LayoutOrder = 2, 
	}, 
	Rare = {
		Name = "Rare",
		Amount = 0,  
		Description = "This will grant your tree 4 cycles", 
		Price = 50, 
		Type = "Rare", 
		Cycles = 4, 
		LayoutOrder = 3,
	}, 
	Legendary = {
		Name = "Legendary",
		Amount = 0,  
		Description = "This will grant your tree 6 cycles", 
		Price = 100, 
		Type = "Legendary", 
		Cycles = 6, 
		LayoutOrder = 4,
	}, 
	Mythical = {
		Name = "Mythical", 
		Amount = 0, 
		Description = "This will grant your tree 10 cycles", 
		Price = 100, 
		Type = "Mythical", 
		Cycles = 10,
		LayoutOrder = 5,
	}
}

return FertilizerConfig
