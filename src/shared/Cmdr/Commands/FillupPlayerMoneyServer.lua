local ServerScriptService = game:GetService("ServerScriptService")

local PlayerData = require(ServerScriptService.PlayerData.Manager)

return function (context, player: Player?)
	player = if player then player else context.Executor

	PlayerData.FillupBackpack(player)
	
	return "Player's Backpack has been Filledup"
	
end
