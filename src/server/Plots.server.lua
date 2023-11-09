local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local Houses = require(ServerScriptService.Houses)
local PlotsConfig = require(ReplicatedStorage.Configs.PlotsConfig)

local Remotes = ReplicatedStorage.Remotes

-- Updates the player's owned plots.
-- Checks if the player has enough coins to purchase the plot.
-- Calls the appropriate manager functions to purchase the plot and adjust the player's coins.
local function UpdateOwnedPlots(player: Player, plot: {})	
	local profile = Manager.Profiles[player]
	if not profile then return end

	if not PlotsConfig[plot.Id] then 
		print("The Plot " .. plot.Id .. " does not exist ~~ Server")
		return
	end 
	if profile.Data.Plots[plot.Id] then 
		print("The Player " .. player.Name .. " already owns this plot " .. plot.Id .. " ~~ Server")
		return 
	end 
	
	local numberOfPlots = 0
	for _ in pairs(profile.Data.Plots) do 
		numberOfPlots += 1
	end

	if PlotsConfig[plot.Id].LayoutOrder > numberOfPlots + 1 then 
		print("The plot " .. plot.Id .. " is not unlocked yet by Player " .. player.Name .. " ~~ Server")
		return 
	end

	if profile.Data.Coins < PlotsConfig[plot.Id].Price then 
		print("The player " .. player.Name .. " does not have enough Coins ~~ Server")
		return
	end

	Manager.PurchasePlot(player, plot)
	Manager.AdjustCoins(player, -PlotsConfig[plot.Id].Price)
	local playerPlot = Houses.GetPlayerPlot(player, plot.Id)
	if not playerPlot then return end 
	for _, part in pairs(playerPlot:GetChildren()) do 
		if part:IsA("Part") then 
			if part.Name == "AnimationPosition" then continue end 
			part.Transparency = 0
			part.CanCollide = true
		end
	end 
end

-- Deletes the tree in the specified plot for the player.
-- Calls the appropriate manager function to delete the tree.
local function DeleteTree(player: Player, plotID: string)
	Manager.DeleteTree(player, plotID)

	local playerPlot = Houses.GetPlayerPlot(player, plotID)
	if not playerPlot then return end

	local plotTree = Houses.GetTreeObject(playerPlot)
	plotTree:Destroy()
end


Remotes.DeleteTree.OnServerEvent:Connect(DeleteTree)
Remotes.UpdateOwnedPlots.OnServerEvent:Connect(UpdateOwnedPlots)