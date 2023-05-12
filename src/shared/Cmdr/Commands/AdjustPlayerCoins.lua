return {
	Name = "adjustPlayerCoins"; 
	Aliases = { "adjustCoins", "apc" };
	Description = "Adjusts the Coins of the current Player";
	Group = "Admin"; 
	Args = {
		{
			Type = "number"; 
			Name = "Amount"; 
			Description = "The Amount of Coins"; 
			Optional = false;
		},
		{
			Type = "player"; 
			Name = "Player"; 
			Description = "The Player"; 
			Optional = true; 
		}
	};
}
