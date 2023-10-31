export type DungeonConfigTemp = {
	UID : string, 
	Name: string,
	Description: string, 
	MaxFloor: number,
	UnlockedFloor: number,
	IsUnlocked: boolean,   
}

local DungeonConfig: {[string]: DungeonConfigTemp} = {
	TutorialDungeon = {
		UID = "Tutorial", 
		Name = "Tutorial Dungeon", 
		Description = "This is the tutorial Dungeon and we will teach you all about combat in these floors. Enjoy!", 
		MaxFloor = 5,
		UnlockedFloor = 1,  
		IsUnlocked = true, 
	}, 
	FireDungeon = {
		UID = "Fire", 
		Name = "Fire Dungeon", 
		MaxFloor = 10,
		UnlockedFloor = 0, 
		IsUnlocked = false, 
	}, 
	WaterDungeon = {
		UID = "Water", 
		Name = "Water Dungeon", 
		MaxFloor = 10,
		UnlockedFloor = 0,
		IsUnlocked = false,   
	}, 
	ElectricDungeon = {
		UID = "Electric", 
		Name = "Electric Dungeon", 
		MaxFloor = 10,
		UnlockedFloor = 0,  
		IsUnlocked = false, 
	},  
	NaturalDunegon = {
		UID = "Natural", 
		Name = "Natural Dungeon", 
		MaxFloor = 10,
		UnlockedFloor = 0,  
		IsUnlocked = false, 
	}, 
}

return DungeonConfig