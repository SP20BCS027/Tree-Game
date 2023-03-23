return {
	Name = "getPlayerData"; 
	Aliases = { "getData", "gpd" };
	Description = "Prints the Player Data of a Specific Directory.";
	Group = "Admin"; 
	Args = {
		{
			Type = "player"; 
			Name = "Player"; 
			Description = "The Player"; 
			Optional = true; 
		},
		{
			Type = "dataDirectory"; 
			Name = "Data Directory"; 
			Description = "The directory you want to get of a player"; 
			Optional = true; 
		}
	};
}
