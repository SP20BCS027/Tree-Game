type SeedsConfigTemp = {
	Name: string, 
	Amount: number, 
	Price: number, 
	Description: string,
}

local SeedsConfig: {[string] : SeedsConfigTemp} = {
	Basic = {
		Name = "Basic", 
		Amount = 010, 
		Description = "This will plant a Basic Tree", 
		Price = 10
	}, 
	Uncommon = {
		Name = "Uncommon", 
		Amount = 010, 
		Description = "This will plant an Uncommon Tree", 
		Price = 50
	}, 
	Rare = {
		Name = "Rare", 
		Amount = 010, 
		Description = "This will plant a Rare Tree",
		Price = 100
	}, 
	Legendary = {
		Name = "Legendary", 
		Amount = 010, 
		Description = "This will plant a Legendary Tree", 
		Price = 200
	}, 
	Mythical = {
		Name = "Mythical", 
		Amount = 0, 
		Description = "This will plant a Mythical Tree", 
		Price = 500
	}
}

return SeedsConfig
