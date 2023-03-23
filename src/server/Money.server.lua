local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)

local Remotes = ReplicatedStorage.Remotes

local function UpdateTreeMoneyTimerAndUpdateMoney(player: Player, plotId: number)
	local backpackIsFull = Manager.AdjustPlayerMoney(player, plotId)
	
	if not backpackIsFull then 
		Manager.UpdateTreeMoneyTimer(player, plotId)
	end
end

local function SellAllMoney(player:Player)
	Manager.SellAllMoney(player)
end

Remotes.UpdateTreeMoneyTimer.OnServerEvent:Connect(UpdateTreeMoneyTimerAndUpdateMoney)
Remotes.SellAllMoney.OnServerEvent:Connect(SellAllMoney)
