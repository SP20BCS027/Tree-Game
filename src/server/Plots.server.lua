local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local Houses = require(ServerScriptService.Houses)

local Remotes = ReplicatedStorage.Remotes

local function UpdateOwnedPlots(player: Player, plot: directory)	
	Manager.PurchasePlot(player, plot)
	local playerPlot = Houses.GetPlayerPlot(player, plot.Id)
	if not playerPlot then return end 
	for _, part in pairs (playerPlot:GetChildren()) do 
		part.Transparency = 0
		part.CanCollide = true
	end 
end

Remotes.UpdateOwnedPlots.OnServerEvent:Connect(UpdateOwnedPlots)
