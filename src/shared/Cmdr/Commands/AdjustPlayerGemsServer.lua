local ServerScriptService = game:GetService("ServerScriptService")

local PlayerData = require(ServerScriptService.PlayerData.Manager)

return function (context, amount: number, player: Player?)
	player = if player then player else context.Executor

	PlayerData.AdjustGems(player, amount)
	
	return "Player's Coins have been adjusted."
end
