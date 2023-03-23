return {
	Name = "adjustPlayerPlot"; 
	Aliases = {"app"};
	Description = "Toggles the first plot from empty or occupied.";
	Group = "Admin"; 
	Args = {
		{
			Type = "player"; 
			Name = "Player"; 
			Description = "The Player"; 
		},
		{
			Type = "boolean"; 
			Name = "Occupied or Not"; 
			Description = "The status of First Plot"; 
		}
	};
}
