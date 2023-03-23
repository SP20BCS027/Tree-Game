local ServerScriptService = game:GetService("ServerScriptService")

local PlayerData = require(ServerScriptService.PlayerData.Manager)

return function (context,player: Player, toggle: boolean)
	
	PlayerData.ToggleFirstPlot(player, toggle)
	
	return "Occupation Toggled"
	
end
