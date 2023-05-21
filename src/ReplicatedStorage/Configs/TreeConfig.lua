export type TreeConfig = {
	Name: string,
	Rarity: string, 
	CurrentLevel: number, 
	MaxLevel: number, 
	CurrentCycle: number, 
	MaxCycle: number, 
	MoneyGenerated: number,
	TimeUntilWater: number, 
	TimeUntilMoney: number
}

local Config: {[string]: TreeConfig} = {
	CashTree = {
		Name = "CashTree",
		Rarity = "Basic", 
		CurrentLevel = 1, 
		MaxLevel = 10, 
		CurrentCycle = 0, 
		MaxCycle = 1,
		MoneyGenerated = 10,
		MoneyIncrement = 1,
		TimeBetweenMoney = 60,
		TimeBetweenWater = 60,
		TimeUntilWater = 0,
		TimeUntilMoney = 0, 
	}, 
	CoinTree = {
		Name = "CoinTree",
		Rarity = "Basic", 
		CurrentLevel = 1, 
		MaxLevel = 10, 
		CurrentCycle = 0, 
		MaxCycle = 1, 
		MoneyGenerated = 15, 
		MoneyIncrement = 2,
		TimeBetweenMoney = 60,
		TimeBetweenWater = 60,
		TimeUntilWater = 0, 
		TimeUntilMoney = 0,
	}, 
	SilverTree = {
		Name = "SilverTree",
		Rarity = "Basic", 
		CurrentLevel = 1, 
		MaxLevel = 10,  
		CurrentCycle = 0,
		MaxCycle = 1, 
		MoneyGenerated = 20, 
		MoneyIncrement = 2,
		TimeBetweenMoney = 60,
		TimeBetweenWater = 60,
		TimeUntilMoney = 0, 
		TimeUntilWater = 0,
	}, 
	GoldTree = {
		Name = "GoldTree", 
		Rarity = "Uncommon", 
		CurrentLevel = 1, 
		MaxLevel = 10, 
		CurrentCycle = 0, 
		MaxCycle = 1, 
		MoneyGenerated = 50, 
		MoneyIncrement = 3,
		TimeBetweenMoney = 60,
		TimeBetweenWater = 60,
		TimeUntilMoney = 0, 
		TimeUntilWater = 0,
	}, 
	PlatinumTree = {
		Name = "PlatinumTree",
		Rarity = "Uncommon", 
		CurrentLevel = 1, 
		MaxLevel = 10, 
		CurrentCycle = 0, 
		MaxCycle = 1, 
		MoneyGenerated = 75, 
		MoneyIncrement = 3,
		TimeBetweenMoney = 60,
		TimeBetweenWater = 60,
		TimeUntilMoney = 0, 
		TimeUntilWater = 0,
	}, 
	AmethystTree = {
		Name =  "AmethystTree",
		Rarity = "Rare", 
		CurrentLevel = 1, 
		MaxLevel = 10, 
		CurrentCycle = 0, 
		MaxCycle = 1, 
		MoneyGenerated = 100, 
		MoneyIncrement = 4,
		TimeBetweenMoney = 60,
		TimeBetweenWater = 60,
		TimeUntilMoney = 0, 
		TimeUntilWater = 0,
	}, 
	RubyTree = {
		Name = "RubyTree", 
		Rarity = "Rare", 
		CurrentLevel = 1, 
		MaxLevel = 10, 
		CurrentCycle = 0, 
		MaxCycle = 1, 
		MoneyGenerated = 150, 
		MoneyIncrement = 4,
		TimeBetweenMoney = 60,
		TimeBetweenWater = 60,
		TimeUntilMoney = 0, 
		TimeUntilWater = 0,
	}, 
	PearlTree = {
		Name = "PearlTree",
		Rarity = "Rare", 
		CurrentLevel = 1, 
		MaxLevel = 10, 
		CurrentCycle = 0, 
		MaxCycle = 1, 
		MoneyGenerated = 200, 
		MoneyIncrement = 5,
		TimeBetweenMoney = 60,
		TimeBetweenWater = 60,
		TimeUntilMoney = 0, 
		TimeUntilWater = 0,	
	}, 
	SapphireTree = {
		Name = "SapphireTree", 
		Rarity = "Legendary", 
		CurrentLevel = 1, 
		MaxLevel = 15, 
		CurrentCycle = 0, 
		MaxCycle = 1, 
		MoneyGenerated = 400, 
		MoneyIncrement = 10,
		TimeBetweenMoney = 60,
		TimeBetweenWater = 60,
		TimeUntilMoney = 0, 
		TimeUntilWater = 0,	
	}, 
	EmeraldTree = {
		Name = "EmeraldTree", 
		Rarity = "Legendary", 
		CurrentLevel = 1, 
		MaxLevel = 15, 
		CurrentCycle = 0, 
		MaxCycle = 1, 
		MoneyGenerated = 500, 
		MoneyIncrement = 15,
		TimeBetweenMoney = 60,
		TimeBetweenWater = 60,
		TimeUntilMoney = 0, 
		TimeUntilWater = 0,
	}, 
	DiamondTree = {
		Name = "DiamondTree",
		Rarity = "Mythical", 
		CurrentLevel = 1, 
		MaxLevel = 20, 
		CurrentCycle = 0, 
		MaxCycle = 1, 
		MoneyGenerated = 1000, 
		MoneyIncrement = 50,
		TimeBetweenMoney = 60,
		TimeBetweenWater = 60,
		TimeUntilMoney = 0, 
		TimeUntilWater = 0,
	}
}

<<<<<<< Updated upstream
local Trees = {}

Trees = Config

return Trees
=======
return TreeConfig
>>>>>>> Stashed changes
