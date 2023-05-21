local ServerScriptService = game:GetService("ServerScriptService")

local PlayerData = require(ServerScriptService.PlayerData.Manager)

return function (context, nameOfBackpack: string, player: Player?)
	player = if player then player else context.Executor

	PlayerData.PurchaseBackpack(player, nameOfBackpack)
	
	return "The Backpack has been given to the player."
	
end
