return {
	Name = "givePlayerWaterCan"; 
	Aliases = { "givePlayerWaterCan", "gpwc" };
	Description = "Gives the Player the mentioned Water Can";
	Group = "Admin"; 
	Args = {
		{
			Type = "waterCanDirectory"; 
			Name = "Water Can Name"; 
			Description = "The Name of the Water Can"; 
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
