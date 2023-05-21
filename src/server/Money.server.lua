local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)

local Remotes = ReplicatedStorage.Remotes

<<<<<<< Updated upstream
local function UpdateTreeMoneyTimerAndUpdateMoney(player: Player, plotId: number)
	local backpackIsFull = Manager.AdjustPlayerMoney(player, plotId)
	
	if not backpackIsFull then 
		Manager.UpdateTreeMoneyTimer(player, plotId)
=======
local function UpdateTreeMoneyTimerAndUpdateMoney(player: Player, plotID: number)
	local profile = Manager.Profiles[player]
	if not profile then return end

	if profile.Data.Plots[plotID].Tree.TimeUntilMoney < os.time() then
		local isBackpackFull = Manager.AdjustPlayerMoney(player, plotID)

		if not isBackpackFull then 
			Manager.UpdateTreeMoneyTimer(player, plotID)
			BackpackEquippingHandler.UpdatePlayerBackpackLabel(player)
			local plot = Houses.GetPlayerPlot(player, plotID)
			local tree = Houses.GetTreeObject(plot)
			Houses.SetTreeHarvestTransparency(tree, 1)
		end	
>>>>>>> Stashed changes
	end
end

local function SellAllMoney(player:Player)
	Manager.SellAllMoney(player)
end

Remotes.UpdateTreeMoneyTimer.OnServerEvent:Connect(UpdateTreeMoneyTimerAndUpdateMoney)
Remotes.SellAllMoney.OnServerEvent:Connect(SellAllMoney)
