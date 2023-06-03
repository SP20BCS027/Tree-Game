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
		local player = Players:GetPlayerFromCharacter(touch.Parent)
		local profile = Manager.Profiles[player]
		if not profile then return end
		if player and houseObject.owner == nil and houseObject:CheckOwner(player) == false then
			houseObject.owner = player
			Remotes.EstablishWaterRefillUI:FireClient(player, houseObject.well)
			Remotes.EstablishPlotsUI:FireClient(player)
			House.PlantTrees(houseObject, profile.Data.Plots)
			House.GeneratePlots(houseObject, profile.Data.Plots)
		end
	end)

	game.Players.PlayerRemoving:Connect(function(player: Player)
		if houseObject.owner == player then
			houseObject.owner = nil
			House.ClearPlotOnPlayerLeaving(houseObject)
		end
	end)
	return houseObject
end

function House:Update()
	self.signLabel.Text = self.owner and self.owner.Name or "No Owner!"
end

function House:CheckOwner(player: Player)
	for _, house in pairs(self.allHouses) do
		if house.owner == player then
			return true
		end
	end
	return false
end

function House.PlantTrees(house, playerDataPlots)
	for name, plot in pairs(house.Plots)do 
		if not playerDataPlots[name] then continue end
		if not playerDataPlots[name].Tree then continue end

		local spawnPosition = plot["Mud"].Position
		local tree = playerDataPlots[name].Tree
		local treeModel: Model = TreeModels:FindFirstChild(tree.Rarity):FindFirstChild(tree.Name):FindFirstChild(tree.CurrentLevel):FindFirstChild(tree.Name):Clone()
		treeModel.Parent = house.Plots[name]
		treeModel:PivotTo(CFrame.new(spawnPosition + Vector3.new(0, 5, 0)))
	end
end

function House.GeneratePlots(house, playerDataPlots)
	for name, plot in pairs (house.Plots) do 
		if not playerDataPlots[name] then continue end 
		
		for _, part: Part in pairs (plot:GetChildren()) do 
			if part:IsA("Part") then 
				if part.Name == "AnimationPosition" then continue end 
				part.Transparency = 0 
				part.CanCollide = true 
			end 
		end 
	end 
end 

function House.ClearPlotOnPlayerLeaving(house)
	for _, plot in house.Plots do 
		for _, part in plot:GetChildren() do 
			if part:IsA("Part") then 
				if part.Name == "AnimationPosition" then continue end 
				part.Transparency = 1
				part.CanCollide = false 
			end 
			if string.find(part.Name, "Tree") then 
				part:Destroy()
			end
		end
	end 
end

return House