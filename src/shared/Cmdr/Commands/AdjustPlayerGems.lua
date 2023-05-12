return {
	Name = "adjustPlayerGems"; 
	Aliases = { "adjustGems", "apg" };
	Description = "Adjusts the Gems of the current Player";
	Group = "Admin"; 
	Args = {
		{
			Type = "number"; 
			Name = "Amount"; 
			Description = "The Amount of Gems"; 
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
