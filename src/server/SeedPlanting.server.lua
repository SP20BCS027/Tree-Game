local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local TreeConfig = require(ReplicatedStorage.Configs.TreeConfig)
local Houses = require(ServerScriptService.Houses)

local Remotes = ReplicatedStorage.Remotes
local TreeModels = ReplicatedStorage.Assets.Trees

-- Selects a tree based on the given seed.
-- Iterates through the TreeConfig and adds trees with matching rarity to the sortedTrees table.
-- Randomly selects an index from sortedTrees and returns the corresponding tree.
local function selectTree(seed)
	local sortedTrees = {}
	for _, tree in TreeConfig do
		if tree.Rarity == seed then
			table.insert(sortedTrees, tree)
		end
	end

	local randomIndex = math.random(table.maxn(sortedTrees))	
	return sortedTrees[randomIndex]
end

-- Spawns a tree model at the specified spawnPosition for the given tree and seed.
local function spawnTree(spawnPosition, tree, seed, plotObject)
	local treeModel: Model = TreeModels:FindFirstChild(seed):FindFirstChild(tree):FindFirstChild(1):FindFirstChild(tree):Clone()
	treeModel.Parent = plotObject
	treeModel:PivotTo(CFrame.new(spawnPosition + Vector3.new(0, 5, 0)))
end

-- Changes the occupation status of a plot by planting a tree.
-- Adjusts the plot occupation status.
local function ChangeOccupationStatus(player: Player, plotID: number, seed, spawnPosition)
	-- add a server side check to check plot occupation maybe? 
	local profile = Manager.Profiles[player]
	if not profile then return end

	if not profile.Data.Plots[plotID] then 
		print("This plot does not exist ~~ Server")
		return
	end

	if profile.Data.Plots[plotID].Occupied then 
		print("This plot is occupied ~~ Server")
		return
	end

	if profile.Data.Seeds[seed].Amount < 0 then 
		print("You don't have the Seed ~~ Server")
		return
	end

	local treeToPlant = selectTree(seed).Name
	Manager.AdjustTreeIndex(player, treeToPlant, 1)
	local plotObject = Houses.GetPlayerPlot(player, plotID)  
	spawnTree(spawnPosition, treeToPlant, seed, plotObject)
	Manager.AdjustPlotOccupation(player, plotID, treeToPlant)
end


Remotes.UpdateOccupied.OnServerEvent:Connect(ChangeOccupationStatus)