local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Manager = require(ServerScriptService.PlayerData.Manager)

local Remotes = ReplicatedStorage.Remotes
local TreeModels = ReplicatedStorage.Trees

local House = {}

House.__index = House

function House.new(houseFolder, allHouses)
	local houseObject = {}
	setmetatable(houseObject, House)
	
	houseObject.Name = houseFolder.Name
	houseObject.claimPart = houseFolder.Claim_Part
	houseObject.well = houseFolder.Well
	houseObject.owner = nil
	houseObject.signLabel = houseFolder.Claim_Part.BillboardGui.TextLabel
	houseObject.allHouses = allHouses
	houseObject.Plots = {}
	for _, plot in pairs (houseFolder.Plots:GetChildren()) do 
		houseObject.Plots[plot.Name] = plot
	end 

	houseObject.claimPart.Touched:Connect(function(touch)
		local Player = Players:GetPlayerFromCharacter(touch.Parent)
		local profile = Manager.Profiles[Player]
		if not profile then return end
		if Player and houseObject.owner == nil and houseObject:checkOwner(Player) == false then
			houseObject.owner = Player
			Remotes.EstablishWaterRefillUI:FireClient(Player, houseObject.well)
			Remotes.EstablishPlotsUI:FireClient(Player)
			House.plantTrees(houseObject, profile.Data.Plots)
			House.GeneratePlots(houseObject, profile.Data.Plots)
			House.ClearPlotOnPlayerLeaving(houseObject)

		end
	end)

	game.Players.PlayerRemoving:Connect(function(Player: Player)
		if houseObject.owner == Player then
			houseObject.owner = nil
			House.ClearPlotOnPlayerLeaving(houseObject)
		end
	end)

	return houseObject
end

function House:update()
	self.signLabel.Text = self.owner and self.owner.Name or "No Owner!"
end

function House:checkOwner(Player)
	for _, house in pairs(self.allHouses) do
		if house.owner == Player then
			return true
		end
	end
	return false
end

function House.plantTrees(house, playerDataPlots)

	for name, plot in pairs(house.Plots)do 
		if not playerDataPlots[name] then  continue end
		if not playerDataPlots[name].Tree then continue end

		local spawnPosition = plot["Mud"].Position
		local tree = playerDataPlots[name].Tree
		
		local treeModel: Model = TreeModels:FindFirstChild(tree.Rarity):FindFirstChild(tree.Name):FindFirstChild(tree.Name.. "_" .. tree.CurrentLevel):Clone()
		treeModel.Parent = house.Plots[name]
		treeModel:PivotTo(CFrame.new(spawnPosition + Vector3.new(0, 5, 0)))
	end
end

function House.GeneratePlots(house, playerDataPlots)
	for name, plot in pairs (house.Plots) do 
		if not playerDataPlots[name] then continue end 
		
		for _, part: Part in pairs (plot:GetChildren()) do 
			if part:IsA("Part") then 
				part.Transparency = 0 
				part.CanCollide = true 
			end 
		end 
	end 
end 

function House.ClearPlotOnPlayerLeaving(house)
	for _, plot in house.Plots do 
		for _, part in plot:GetChildren() do 
			if string.find(part.Name, "Tree") then 
				part:Destroy()
			end
		end
	end 
end

return House