local ServerScriptService = game:GetService("ServerScriptService")

local PlayerData = require(ServerScriptService.PlayerData.Manager)

return function (context, nameOfWaterCan: string, player: Player?)
	player = if player then player else context.Executor

	PlayerData.PurchaseWaterCan(player, nameOfWaterCan)
	
	return "The Water can has been given to the player."
end
