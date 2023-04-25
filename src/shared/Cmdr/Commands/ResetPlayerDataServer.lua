local ServerScriptService = game:GetService("ServerScriptService")

local PlayerData = require(ServerScriptService.PlayerData.Manager)

return function (context, player: Player?)
	player = if player then player else context.Executor


	PlayerData.ResetAllData(player)
	
	return "Data Reset to Default!"
	
end
