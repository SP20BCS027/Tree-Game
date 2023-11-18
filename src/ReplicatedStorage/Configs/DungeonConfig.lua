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
	Neutral = {
		UID = "Neutral", 
		Name = "Neutral Dungeon",
		Description = "This is the tutorial Dungeon and we will teach you all about combat in these floors. Enjoy!",  
		MaxFloor = 10,
		UnlockedFloor = 1, 
		IsUnlocked = false, 
	},
	Fire = {
		UID = "Fire", 
		Name = "Fire Dungeon",
		Description = "This is the tutorial Dungeon and we will teach you all about combat in these floors. Enjoy!",  
		MaxFloor = 10,
		UnlockedFloor = 10, 
		IsUnlocked = false, 
	}, 
	Water = {
		UID = "Water", 
		Name = "Water Dungeon", 
		Description = "This is the tutorial Dungeon and we will teach you all about combat in these floors. Enjoy!", 
		MaxFloor = 10,
		UnlockedFloor = 1,
		IsUnlocked = false,   
	}, 
	Air = {
		UID = "Air", 
		Name = "Air Dungeon", 
		Description = "This is the tutorial Dungeon and we will teach you all about combat in these floors. Enjoy!", 
		MaxFloor = 10,
		UnlockedFloor = 1,  
		IsUnlocked = false, 
	},  
	Geo = {
		UID = "Geo", 
		Name = "Geo Dungeon", 
		Description = "This is the tutorial Dungeon and we will teach you all about combat in these floors. Enjoy!", 
		MaxFloor = 10,
		UnlockedFloor = 1,  
		IsUnlocked = false, 
	}, 
}

return DungeonConfig