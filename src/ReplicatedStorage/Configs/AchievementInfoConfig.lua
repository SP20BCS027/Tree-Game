type AchievementsInfoConfigTemplate = {
	Name: string, 
	CurrentAchievementNo: number,  
	AmountAchieved: number,
	AmountToAchieve: number, 
}

local NumberOfAchievement = {
	SeedsPlanted = {
		[1] = 3, 
		[2] = 10, 
		[3] = 20, 
		[4] = 50, 
		[5] = 75,
		[6] = 100,
	}, 
}


return NumberOfAchievement
