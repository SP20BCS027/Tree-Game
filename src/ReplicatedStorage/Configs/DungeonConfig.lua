export type DungeonConfigTemp = {
	UIID : string, 
	Name: string,
	Description: string, 
	MaxFloor: number,
	UnlockedFloor: number,
	IsUnlocked: boolean,   
}

local DungeonConfig: {[string]: DungeonConfigTemp }= {
	TutorialDungeon = {
		UIID = "Tutorial", 
		Name = "Tutorial Dungeon", 
		Description = "This is the tutorial Dungeon and we will teach you all about combat in these floors. Enjoy!", 
		MaxFloor = 5,
		UnlockedFloor = 1,  
		IsUnlocked = true, 
	}, 
	FireDungeon = {
		UIID = "Fire", 
		Name = "Fire Dungeon", 
		Description = "This is the tutorial Dungeon and we will teach you all about combat in these floors. Enjoy!", 
		MaxFloor = 10,
		UnlockedFloor = 0, 
		IsUnlocked = false, 
	}, 
	WaterDungeon = {
		UIID = "Water", 
		Name = "Water Dungeon", 
		Description = "This is the tutorial Dungeon and we will teach you all about combat in these floors. Enjoy!", 
		MaxFloor = 10,
		UnlockedFloor = 0,
		IsUnlocked = false,   
	}, 
	ElectricDungeon = {
		UIID = "Electric", 
		Name = "Electric Dungeon", 
		Description = "This is the tutorial Dungeon and we will teach you all about combat in these floors. Enjoy!", 
		MaxFloor = 10,
		UnlockedFloor = 0,  
		IsUnlocked = false, 
	},  
	NaturalDunegon = {
		UIID = "Natural", 
		Name = "Natural Dungeon", 
		Description = "This is the tutorial Dungeon and we will teach you all about combat in these floors. Enjoy!", 
		MaxFloor = 10,
		UnlockedFloor = 0,  
		IsUnlocked = false, 
	}, 
}

return DungeonConfig