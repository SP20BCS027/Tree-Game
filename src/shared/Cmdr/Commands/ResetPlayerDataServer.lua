local ServerScriptService = game:GetService("ServerScriptService")

local PlayerData = require(ServerScriptService.PlayerData.Manager)
local BackpackEquippingHandler = require(ServerScriptService.BackpackEquippingHandler)
local Houses = require(ServerScriptService.Houses)
local House = require(ServerScriptService.Classes.House)


return function (context, player: Player?)
	player = if player then player else context.Executor
	
	print("Reset function got called from command")

	PlayerData.ResetAllData(player)
	local house = Houses.GetPlayerHouse(player)
	House.ClearPlotOnDataReset(house)
	BackpackEquippingHandler.UpdatePlayerBackpackLabel(player)

	return "Data Reset to Default!"
end
