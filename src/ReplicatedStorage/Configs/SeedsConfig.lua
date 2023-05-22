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
<<<<<<< Updated upstream
		Price = 10
=======
		Price = 100,
		LayoutOrder = 1, 
>>>>>>> Stashed changes
	}, 
	Uncommon = {
		Name = "Uncommon", 
		Amount = 010, 
		Description = "This will plant an Uncommon Tree", 
<<<<<<< Updated upstream
		Price = 50
=======
		Price = 500,
		LayoutOrder = 2, 
>>>>>>> Stashed changes
	}, 
	Rare = {
		Name = "Rare", 
		Amount = 010, 
		Description = "This will plant a Rare Tree",
<<<<<<< Updated upstream
		Price = 100
=======
		Price = 2500,
		LayoutOrder = 3, 
>>>>>>> Stashed changes
	}, 
	Legendary = {
		Name = "Legendary", 
		Amount = 010, 
		Description = "This will plant a Legendary Tree", 
<<<<<<< Updated upstream
		Price = 200
=======
		Price = 10000,
		LayoutOrder = 4,
>>>>>>> Stashed changes
	}, 
	Mythical = {
		Name = "Mythical", 
		Amount = 010, 
		Description = "This will plant a Mythical Tree", 
<<<<<<< Updated upstream
		Price = 500
=======
		Price = 1000000,
		LayoutOrder = 5, 
>>>>>>> Stashed changes
	}
}

return SeedsConfig
