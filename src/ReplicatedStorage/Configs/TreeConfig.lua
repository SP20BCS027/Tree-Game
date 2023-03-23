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
		TimeUntilWater = 120,
		TimeUntilMoney = 100 
	}, 
	CoinTree = {
		Name = "CoinTree",
		Rarity = "Basic", 
		CurrentLevel = 1, 
		MaxLevel = 10, 
		CurrentCycle = 0, 
		MaxCycle = 1, 
		MoneyGenerated = 15, 
		TimeUntilWater = 0, 
		TimeUntilMoney = 0
	}, 
	SilverTree = {
		Name = "SilverTree",
		Rarity = "Basic", 
		CurrentLevel = 1, 
		MaxLevel = 10,  
		CurrentCycle = 0,
		MaxCycle = 1, 
		MoneyGenerated = 20, 
		TimeUntilMoney = 0, 
		TimeUntilWater = 0 
	}, 
	GoldTree = {
		Name = "GoldTree", 
		Rarity = "Uncommon", 
		CurrentLevel = 1, 
		MaxLevel = 10, 
		CurrentCycle = 0, 
		MaxCycle = 1, 
		MoneyGenerated = 50, 
		TimeUntilMoney = 0, 
		TimeUntilWater = 0
	}, 
	PlatinumTree = {
		Name = "PlatinumTree",
		Rarity = "Uncommon", 
		CurrentLevel = 1, 
		MaxLevel = 10, 
		CurrentCycle = 0, 
		MaxCycle = 1, 
		MoneyGenerated = 60, 
		TimeUntilMoney = 0, 
		TimeUntilWater = 0
	}, 
	AmethystTree = {
		Name =  "AmethystTree",
		Rarity = "Rare", 
		CurrentLevel = 1, 
		MaxLevel = 10, 
		CurrentCycle = 0, 
		MaxCycle = 1, 
		MoneyGenerated = 100, 
		TimeUntilMoney = 0, 
		TimeUntilWater = 0	
	}, 
	RubyTree = {
		Name = "RubyTree", 
		Rarity = "Rare", 
		CurrentLevel = 1, 
		MaxLevel = 10, 
		CurrentCycle = 0, 
		MaxCycle = 1, 
		MoneyGenerated = 120, 
		TimeUntilMoney = 0, 
		TimeUntilWater = 0	
	}, 
	PearlTree = {
		Name = "PearlTree",
		Rarity = "Rare", 
		CurrentLevel = 1, 
		MaxLevel = 10, 
		CurrentCycle = 0, 
		MaxCycle = 1, 
		MoneyGenerated = 140, 
		TimeUntilMoney = 0, 
		TimeUntilWater = 0	
	}, 
	SapphireTree = {
		Name = "SapphireTree", 
		Rarity = "Legendary", 
		CurrentLevel = 1, 
		MaxLevel = 10, 
		CurrentCycle = 0, 
		MaxCycle = 1, 
		MoneyGenerated = 250, 
		TimeUntilMoney = 0, 
		TimeUntilWater = 0	
	}, 
	EmeraldTree = {
		Name = "EmeraldTree", 
		Rarity = "Legendary", 
		CurrentLevel = 1, 
		MaxLevel = 10, 
		CurrentCycle = 0, 
		MaxCycle = 1, 
		MoneyGenerated = 300, 
		TimeUntilMoney = 0, 
		TimeUntilWater = 0
	}, 
	DiamondTree = {
		Name = "DiamondTree",
		Rarity = "Mythical", 
		CurrentLevel = 1, 
		MaxLevel = 10, 
		CurrentCycle = 0, 
		MaxCycle = 1, 
		MoneyGenerated = 500, 
		TimeUntilMoney = 0, 
		TimeUntilWater = 0
	}
}

local Trees = {}

Trees = Config

return Trees
