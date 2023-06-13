type AchievementsInfoConfigTemplate = {
	Name: string, 
	CurrentAchievementNo: number,  
	AmountAchieved: number,
	AmountToAchieve: number, 
}

local NumberOfAchievement = {
	SeedsPlanted = {
		[1] = {
			Amount = 3, 
			Reward = {
				Coins = 100, 
				Gems = 5,
			},
		}, 
		[2] = {
			Amount = 10, 
			Reward = {
				Coins = 500, 
				Gems = 10,
			}
		}, 
		[3] = {
			Amount = 20, 
			Reward = {
				Coins = 1000, 
				Gems = 20,
			}
		},
		[4] = {
			Amount = 50,
			Reward = {
				Coins = 2000, 
				Gems = 30, 
			}
		},
		[5] = {
			Amount = 75, 
			Reward = {
				Coins = 3000, 
				Gems = 50,
			}
		},
		[6] = {
			Amount = 100, 
			Reward = {
				Coins = 5000, 
				Gems = 100, 
			}
		},
	}, 
	MoneyEarned = {
		[1] = {
			Amount = 100, 
			Reward = {
				Coins = 5000, 
				Gems = 100, 
			}
		},
		[2] = {
			Amount = 250, 
			Reward = {
				Coins = 5000, 
				Gems = 100, 
			}
		}, 
		[3] = {
			Amount = 500, 
			Reward = {
				Coins = 5000, 
				Gems = 100, 
			}
		}, 
		[4] = {
			Amount = 1000, 
			Reward = {
				Coins = 5000, 
				Gems = 100, 
			}
		}, 
		[5] = {
			Amount = 2500, 
			Reward = {
				Coins = 5000, 
				Gems = 100, 
			}
		}, 
		[6] = {
			Amount = 5000, 
			Reward = {
				Coins = 5000, 
				Gems = 100, 
			}
		}, 
		[7] = {
			Amount = 10000, 
			Reward = {
				Coins = 5000, 
				Gems = 100, 
			}
		}, 
		[8] = {
			Amount = 25000, 
			Reward = {
				Coins = 5000, 
				Gems = 100, 
			}
		},
		[9] = {
			Amount = 50000, 
			Reward = {
				Coins = 5000, 
				Gems = 100, 
			}
		}, 
		[10] = {
			Amount = 100000, 
			Reward = {
				Coins = 5000, 
				Gems = 100, 
			}
		},
	}, 
	CoinsEarned = {
		[1] = {
			Amount = 100, 
			Reward = {
				Coins = 5000, 
				Gems = 100, 
			}
		}, 
		[2] = {
			Amount = 250, 
			Reward = {
				Coins = 5000, 
				Gems = 100, 
			}
		}, 
		[3] = {
			Amount = 500, 
			Reward = {
				Coins = 5000, 
				Gems = 100, 
			}
		}, 
		[4] = {
			Amount = 1000, 
			Reward = {
				Coins = 5000, 
				Gems = 100, 
			}
		}, 
		[5] = {
			Amount = 2500, 
			Reward = {
				Coins = 5000, 
				Gems = 100, 
			}
		}, 
		[6] = {
			Amount = 5000, 
			Reward = {
				Coins = 5000, 
				Gems = 100, 
			}
		}, 
		[7] = {
			Amount = 10000, 
			Reward = {
				Coins = 5000, 
				Gems = 100, 
			}
		}, 
		[8] = {
			Amount = 25000, 
			Reward = {
				Coins = 5000, 
				Gems = 100, 
			}
		}, 
		[9] = {
			Amount = 50000, 
			Reward = {
				Coins = 5000, 
				Gems = 100, 
			}
		}, 
		[10] = {
			Amount = 100000, 
			Reward = {
				Coins = 5000, 
				Gems = 100, 
			}
		},
	}
}

return NumberOfAchievement
