type AchievementsConfigTemplate = {
	Name: string, 
	CurrentAchievementNo: number,  
	AmountAchieved: number,
	AmountToAchieve: number, 
}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AchievementInfoConfig = require(ReplicatedStorage.Configs.AchievementInfoConfig)

local AchievementConfig :{[string] : AchievementsConfigTemplate} = {
	SeedsPlanted = {
		UID = "SeedsPlanted", 
		Name = "Seeds Planted", 
		CurrentAchievementNo = 1,
		AmountAchieved = 0,
		AmountToAchieve = AchievementInfoConfig["SeedsPlanted"][1].Amount,
	}, 
	MoneyEarned = {
		UID = "MoneyEarned",
		Name = "Money Collected", 
		CurrentAchievementNo = 1,
		AmountAchieved = 0,
		AmountToAchieve = AchievementInfoConfig["MoneyEarned"][1].Amount,
	}, 
	CoinsEarned = {
		UID = "CoinsEarned",
		Name = "Coins Earned", 
		CurrentAchievementNo = 1, 
		AmountAchieved = 0, 
		AmountToAchieve = AchievementInfoConfig["CoinsEarned"][1].Amount, 
	}	
}

return AchievementConfig
