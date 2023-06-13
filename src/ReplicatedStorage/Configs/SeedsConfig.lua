type SeedsConfigTemp = {
	Name: string, 
	Amount: number, 
	Price: number, 
	Description: string,
}

local SeedsConfig: {[string] : SeedsConfigTemp} = {
	Common = {
		UID = "Common", 
		Name = "Common", 
		Amount = 10, 
		Description = "This will plant a Basic Tree", 
		Price = 100,
		LayoutOrder = 1, 
	}, 
	Uncommon = {
		UID = "Uncommon", 
		Name = "Uncommon", 
		Amount = 10, 
		Description = "This will plant an Uncommon Tree", 
		Price = 500,
		LayoutOrder = 2, 
	}, 
	Rare = {
		UID = "Rare", 
		Name = "Rare", 
		Amount = 10, 
		Description = "This will plant a Rare Tree",
		Price = 2500,
		LayoutOrder = 3, 
	}, 
	Legendary = {
		UID = "Legendary", 
		Name = "Legendary", 
		Amount = 10, 
		Description = "This will plant a Legendary Tree", 
		Price = 10000,
		LayoutOrder = 4,
	}, 
	Mythical = {
		UID = "Mythical", 
		Name = "Mythical", 
		Amount = 10, 
		Description = "This will plant a Mythical Tree", 
		Price = 1000000,
		LayoutOrder = 5, 
	}
}

return SeedsConfig