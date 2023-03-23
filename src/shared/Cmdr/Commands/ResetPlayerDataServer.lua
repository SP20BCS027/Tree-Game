local ServerScriptService = game:GetService("ServerScriptService")

local PlayerData = require(ServerScriptService.PlayerData.Manager)

return function (context, player: Player?, dataDirectory: string?)
	
	PlayerData.ResetAllData(player)
	
	return "Data Reset to Default!"
	
end
