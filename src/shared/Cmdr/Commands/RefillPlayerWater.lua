return {
	Name = "refillPlayerWater"; 
	Aliases = { "refillPlayerWater", "rpw" };
	Description = "Refills the Water Can of the current Player";
	Group = "Admin"; 
	Args = {
		{
			Type = "player"; 
			Name = "Player"; 
			Description = "The Player"; 
			Optional = true; 
		}
	};
}
