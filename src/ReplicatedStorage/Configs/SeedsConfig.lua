type SeedsConfigTemp = {
	Name: string, 
	Amount: number, 
	Price: number, 
	Description: string,
}

local SeedsConfig: {[string] : SeedsConfigTemp} = {
	Basic = {
		Name = "Basic", 
		Amount = 10, 
		Description = "This will plant a Basic Tree", 
		Price = 100,
		LayoutOrder = 1, 
	}, 
	Uncommon = {
		Name = "Uncommon", 
		Amount = 10, 
		Description = "This will plant an Uncommon Tree", 
		Price = 500,
		LayoutOrder = 2, 
	}, 
	Rare = {
		Name = "Rare", 
		Amount = 10, 
		Description = "This will plant a Rare Tree",
		Price = 2500,
		LayoutOrder = 3, 
	}, 
	Legendary = {
		Name = "Legendary", 
		Amount = 10, 
		Description = "This will plant a Legendary Tree", 
		Price = 10000,
		LayoutOrder = 4,
	}, 
	Mythical = {
		Name = "Mythical", 
		Amount = 10, 
		Description = "This will plant a Mythical Tree", 
		Price = 1000000,
		LayoutOrder = 5, 
	}
}

return SeedsConfig