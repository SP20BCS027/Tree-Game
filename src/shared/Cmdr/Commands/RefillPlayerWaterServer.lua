local ServerScriptService = game:GetService("ServerScriptService")

local PlayerData = require(ServerScriptService.PlayerData.Manager)

return function (context, player: Player?)
	player = if player then player else context.Executor

	PlayerData.RefillWater(player)
	
	return "Player's Water Can has been Refilled"
	
end
