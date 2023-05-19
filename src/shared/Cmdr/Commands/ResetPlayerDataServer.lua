local ServerScriptService = game:GetService("ServerScriptService")

local PlayerData = require(ServerScriptService.PlayerData.Manager)
local BackpackEquippingHandler = require(ServerScriptService.BackpackEquippingHandler)

return function (context, player: Player?)
	player = if player then player else context.Executor

	PlayerData.ResetAllData(player)
	BackpackEquippingHandler.UpdatePlayerBackpackLabel(player)

	return "Data Reset to Default!"
	
end
