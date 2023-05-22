type QuestsLogTemplate = {
	Name: string, 
	CurrentAchievementNo: number,  
	AmountAchieved: number,
	AmountToAchieve: number, 
}

local QuestsLog :{[string] : QuestsLogTemplate} = {
	Bakri = {
		Quest_1 = {
			QuestTitle = "This is the First Quest",
			QuestTask_1 = {
				QuestTask = "Plant Trees", 
				AmountToAchieve = 2, 
				AmountAchieved = 0
			}
		},
		Quest_2 = {
			QuestTask_1 = {
				QuestTask = "Harvest Trees", 
				AmountToAchieve = 2, 
				AmountAchieved = 0,
			}, 
			QuestTask_2 = {
				QuestTask = "Water Trees", 
				AmountToAchieve = 2, 
				AmountAchieved = 0,
			}
		}, 
		
	}, 
	Ghora = {
		Quest_1 = {
			QuestTitle = "This is the Second Quest",
			QuestTask_1 = {
				QuestTask = "Harvest Trees", 
				AmountToAchieve = 2, 
				AmountAchieved = 0,
			}, 
			QuestTask_2 = {
				QuestTask = "Water Trees", 
				AmountToAchieve = 2, 
				AmountAchieved = 0,
			}
		}, 
	}
}

return QuestsLog
