return {
	Name = "resetPlayerData"; 
	Aliases = { "getData", "gpd" };
	Description = "Prints the Player Data of a Specific Directory.";
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
