export type Armor = {
	UID : string, 
	Name: string,
	Description: string, 
	Defense: number, 
	Type: string, 
	Rarity: string, 
	Equipped: boolean,
}

local Potions = {
	Attack = {
		DoubleAttack = {
			UID = "DoubleAttack", 
			Name = "Double Attack Potion", 
			Description = "This doubles your weapons attack for 5 mins", 
			PotionType = "Attack", 
			Multiplier = 2, 
			Time = 300, 
			Rarity = "Rare", 
			Price = 100, 
			Amount = 1,
		}, 
		TripleAttack = {
			UID = "TripleAttack", 
			Name = "Triple Attack Potion", 
			Description = "This triples your weapons attack for 30 seconds", 
			PotionType = "Attack", 
			Multiplier = 3, 
			Time = 30, 
			Rarity = "Uncommon", 
			Price = 100, 
			Amount = 1,
		}, 
		FiftypercentBuff = {
			UID = "FiftypercentBuff", 
			Name = "50% Buff Potion", 
			Description = "This potion increases your weapons damage by 50% for 2 mins", 
			PotionType = "Attack", 
			Multiplier = 1.5, 
			Time = 120, 
			Rarity = "Common", 
			Price = 100, 
			Amount = 1,
		}, 
	}, 
	Health = {
		FullHealPotion = {
			UID = "FullHealPotion", 
			Name = "Full Heal Potion", 
			Description = "This Completely Refills your Health", 
			PotionType = "Health", 
			Multiplier = 1, 
			Time = 0, 
			Rarity = "Rare", 
			Price = 100, 
			Amount = 1,
		}, 
		DoubleHealthPotion = {
			UID = "DoubleHealthPotion", 
			Name = "Double Health Potion", 
			Description = "This potion doubles your health for 30 seconds", 
			PotionType = "Health", 
			Multiplier = 2, 
			Time = 30, 
			Rarity = "Rare", 
			Price = 100, 
			Amount = 1,
		}, 
		TripleHealthPotion = {
			UID = "TripleHealthPotion", 
			Name = "Triple Health Potion", 
			Description = "This potion doubles your health for 25 seconds", 
			PotionType = "Health", 
			Multiplier = 3, 
			Time = 25, 
			Rarity = "Legendary", 
			Price = 100, 
			Amount = 1,
		}, 
		DoubleHealthRegeneration = {
			UID = "DoubleHealthRegeneration", 
			Name = "Double Health Regeneration", 
			Description = "This potion doubles your health regeneration for 25 seconds", 
			PotionType = "Health", 
			Multiplier = 2, 
			Time = 25, 
			Rarity = "Rare", 
			Price = 100, 
			Amount = 1,
		}, 
	}, 
	Defense = {
		DoubleDefense = {
			UID = "DoubleDefense", 
			Name = "Double Defenses Potion", 
			Description = "This potion doubles your defense for 25 seconds", 
			PotionType = "Defense", 
			Multiplier = 2, 
			Time = 25, 
			Rarity = "Rare", 
			Price = 100, 
			Amount = 1,
		}, 
		TripleDefense = {
			UID = "TripleDefense", 
			Name = "Triple Defense Potion", 
			Description = "This potion triples your health for 50 seconds", 
			PotionType = "Health", 
			Multiplier = 3, 
			Time = 50, 
			Rarity = "Legendary", 
			Price = 100,
			Amount = 1, 
		}, 

	}, 
	Pets = {
		DoublePetsAttack = {
			UID = "DoublePetsAttack", 
			Name = "Double Pets Attack", 
			Description = "This potion doubles all Equipped Pet's Attack for 10 seconds", 
			PotionType = "Pets", 
			Multiplier = 2, 
			Time = 10, 
			Rarity = "Legendary", 
			Price = 100, 
			Amount = 1,
		}, 
		DoublePetsCritRate = {
			UID = "DoublePetsCritRate", 
			Name = "Double Pets Critical Rate Potion", 
			Description = "This potion doubles all Eqiupped Pet's Critical Damage Rate for 25 seconds", 
			PotionType = "Pets", 
			Multiplier = 2, 
			Time = 25, 
			Rarity = "Legendary", 
			Price = 100, 
			Amount = 1,
		}, 
	},  
}

return Potions