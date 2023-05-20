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
	MoneyEarned = {
		[1] = 100, 
		[2] = 500, 
		[3] = 1000, 
		[4] = 2000, 
		[5] = 5000, 
		[6] = 10000, 
		[7] = 25000, 
		[8] = 50000,
	}, 
	CoinsEarned = {
		[1] = 100, 
		[2] = 250, 
		[3] = 500, 
		[4] = 1000, 
		[5] = 2500, 
		[6] = 5000, 
		[7] = 10000, 
	}
}


return NumberOfAchievement
