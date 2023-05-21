return {
	Name = "fillupPlayerMoney"; 
	Aliases = { "fillupPlayerMoney", "fpm" };
	Description = "Fills up the Backpack of the current Player";
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
