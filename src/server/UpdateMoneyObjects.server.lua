local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local Houses = require(ServerScriptService.Houses)

local Remotes = ReplicatedStorage.Remotes

local function UpdatePlot(player: Player, plot: string, transparency: number)
	if not Houses.CheckForOwnerShip(player) then return end
	local plotInstance = Houses.GetPlayerPlot(player, plot)
	local tree = Houses.GetTreeObject(plotInstance)
	Houses.SetTreeHarvestTransparency(tree, transparency)
end

Remotes.UpdateMoneyObjectsOnTimerExpire.OnServerEvent:Connect(UpdatePlot)