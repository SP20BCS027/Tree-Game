return {
	Name = "givePlayerBackpack"; 
	Aliases = { "givePlayerBackpack", "gpb" };
	Description = "Gives the Player the mentioned Backpack";
	Group = "Admin"; 
	Args = {
		{
			Type = "backpackDirectory"; 
			Name = "Backpack Name"; 
			Description = "The Name of the Backpack"; 
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
