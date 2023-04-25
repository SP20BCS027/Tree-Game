local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local Trees = require(ReplicatedStorage.Configs.TreeConfig)
local Houses = require(ServerScriptService.Houses)

local Remotes = ReplicatedStorage.Remotes
local TreeModels = ReplicatedStorage.Trees

local function selectTree(seed)
	local sortedTrees = {}
	for _, tree in Trees do
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

local function ChangeOccupationStatus(player: Player, plotId: number, isOccupied: boolean, seed, spawnPosition)
	-- add a server side check to check plot occupation maybe? 
	local treeToPlant = selectTree(seed).Name
	local plotObject = Houses.GetPlayerPlot(player, plotId)
	spawnTree(spawnPosition, treeToPlant, seed, plotObject)
	Manager.AdjustPlotOccupation(player, plotId, isOccupied, treeToPlant)
end

Remotes.UpdateOccupied.OnServerEvent:Connect(ChangeOccupationStatus)