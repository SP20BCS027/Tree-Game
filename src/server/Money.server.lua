local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local Houses = require(ServerScriptService.Houses)
local BackpackEquippingHandler = require(ServerScriptService.BackpackEquippingHandler)

local Remotes = ReplicatedStorage.Remotes

local function UpdateTreeMoneyTimerAndUpdateMoney(player: Player, plotID: number)
	local backpackIsFull = Manager.AdjustPlayerMoney(player, plotID)
	
	if not backpackIsFull then 
		Manager.UpdateTreeMoneyTimer(player, plotID)
		BackpackEquippingHandler.UpdatePlayerBackpackLabel(player)
		local plot = Houses.GetPlayerPlot(player, plotID)
		local tree = Houses.GetTreeObject(plot)
		Houses.SetTreeHarvestTransparency(tree, 1)
	end	
end

local function SellAllMoney(player: Player)
	Manager.SellAllMoney(player)
	BackpackEquippingHandler.UpdatePlayerBackpackLabel(player)
end

Remotes.UpdateTreeMoneyTimer.OnServerEvent:Connect(UpdateTreeMoneyTimerAndUpdateMoney)
Remotes.SellAllMoney.OnServerEvent:Connect(SellAllMoney)
