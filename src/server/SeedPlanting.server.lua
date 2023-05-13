local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local TreeConfig = require(ReplicatedStorage.Configs.TreeConfig)
local Houses = require(ServerScriptService.Houses)

local Remotes = ReplicatedStorage.Remotes
local TreeModels = ReplicatedStorage.Trees

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

local function spawnTree(spawnPosition, tree, seed, plotObject)
	local treeModel: Model = TreeModels:FindFirstChild(seed):FindFirstChild(tree):FindFirstChild(tree.."_1"):Clone()
	treeModel.Parent = plotObject
	treeModel:PivotTo(CFrame.new(spawnPosition + Vector3.new(0, 5, 0)))
end

local function ChangeOccupationStatus(player: Player, plotID: number, isOccupied: boolean, seed, spawnPosition)
	-- add a server side check to check plot occupation maybe? 
	print(plotID)
	local treeToPlant = selectTree(seed).Name
	local plotObject = Houses.GetPlayerPlot(player, plotID)
	spawnTree(spawnPosition, treeToPlant, seed, plotObject)
	Manager.AdjustPlotOccupation(player, plotID, isOccupied, treeToPlant)
end


Remotes.UpdateOccupied.OnServerEvent:Connect(ChangeOccupationStatus)