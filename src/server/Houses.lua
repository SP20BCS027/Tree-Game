local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes
local Trees = ReplicatedStorage.Trees

local House = require(game.ServerScriptService.Classes.House)
local Houses = {}
local HouseModule = {}

local function createHouses()
    for _, houseFolder in pairs(workspace.Houses:GetChildren()) do 
        local houseObj = House.new(houseFolder, Houses)
        table.insert(Houses, houseObj)
    end
end

createHouses()

function HouseModule.GetPlayerPlot(player: Player, plot: string)
	for _, HouseOb in pairs(Houses) do
		if not HouseOb.owner then return end 
        if HouseOb.owner ~= player then return end 

        return HouseOb.Plots[plot]
	end
end

function HouseModule.ReturnPlayerWell(player: Player)
	for _, HouseOb in pairs(Houses) do
		if not HouseOb.owner then return end 
        if HouseOb.owner ~= player then return end 

        return HouseOb.well
	end
end

local function getTreeObject(plotObject)
	for _, child in pairs (plotObject:GetChildren()) do 
		if string.find(child.Name, "Tree") then 
			return child 
		end 
	end 
end

local function getNewTree(nameOfTree)
	for _, desc in pairs (Trees:GetDescendants()) do 
		if desc.Name == nameOfTree then 
			return desc
		end
	end
end

function HouseModule.ChangeTreeModel(plotObject)
	print(plotObject)
	local plantedTree = getTreeObject(plotObject)
	local treeName = plantedTree.Name 

	local baseName = string.sub(treeName, 1, string.find(treeName, "_") - 1)
	local level = string.sub(treeName, -1)
	level += 1 

	local updatedTree = getNewTree(baseName .. "_" ..level)
	updatedTree.Parent = plantedTree.Parent 
	updatedTree:PivotTo(CFrame.new(plantedTree:GetPivot().p))
	plantedTree:Destroy()
end

Remotes.AskUIInformation.OnServerInvoke = HouseModule.GetPlayerPlot
Remotes.GetHouseWell.OnServerInvoke = HouseModule.ReturnPlayerWell

task.spawn(function()
    while wait(1)  do
        for _, HouseOb in pairs(Houses) do
            HouseOb:update()
        end
    end
end)

return HouseModule