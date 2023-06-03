local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes
local Trees = ReplicatedStorage.Trees

local House = require(game.ServerScriptService.Classes.House)
local Houses = {}
local HouseModule = {}

local function CreateHouses()
    for _, houseFolder in pairs(workspace.Houses:GetChildren()) do 
        local houseObj = House.new(houseFolder, Houses)
        table.insert(Houses, houseObj)
    end
end

CreateHouses()

function HouseModule.GetPlayerPlot(player: Player, plot: string)
	for _, house in pairs(Houses) do
		if house.owner == player then 
			return house.Plots[plot]
		end
	end
end

function HouseModule.GetAllHouses()
	return Houses
end

function HouseModule.GetNoOwnerHouseClaimParts()
	local NoOwnerHouses = {}
	for _, house in pairs(Houses) do 
		if house.owner == nil then 
			NoOwnerHouses[house.Name] = house.claimPart
		end
	end
	return NoOwnerHouses
end

function HouseModule.ReturnPlayerWell(player: Player)
	for _, HouseOb in pairs(Houses) do
		if HouseOb.owner == player then 
			print("Player is the owner of this house " .. HouseOb.Name .. ".")	
			return HouseOb.well
		end 
	end
end

function HouseModule.GetTreeObject(plotObject: Model)
	for _, child in pairs (plotObject:GetChildren()) do 
		if string.find(child.Name, "Tree") then 
			return child 
		end 
	end 
end

function HouseModule.CheckForOwnerShip(player: Player)
	for _, house in pairs(Houses) do 
		if house.owner == player then return true end
	end
	return false
end

local function GetNewTree(nameOfTree: string, level: number, rarity: string)
	return Trees[rarity][nameOfTree][level][nameOfTree]
end

function HouseModule.ChangeTreeModel(plotObject: Model, treeLevel: number, treeRarity: string)
	local plantedTree = HouseModule.GetTreeObject(plotObject)
	local treeName = plantedTree.Name 
	
	local updatedTree = GetNewTree(treeName, treeLevel, treeRarity):Clone()
	updatedTree.Parent = plantedTree.Parent 
	updatedTree:PivotTo(CFrame.new(plantedTree:GetPivot().p))
	plantedTree:Destroy()
end

function HouseModule.SetTreeHarvestTransparency(treeObject: Model, transparency: number)
	for _, valuable in pairs(treeObject.Money:GetChildren()) do 
		valuable.Transparency = transparency
	end
end

Remotes.AskUIInformation.OnServerInvoke = HouseModule.GetPlayerPlot
Remotes.GetHouseWell.OnServerInvoke = HouseModule.ReturnPlayerWell
Remotes.GetAllHouses.OnServerInvoke = HouseModule.GetAllHouses
Remotes.GetNoOwnerHouses.OnServerInvoke = HouseModule.GetNoOwnerHouseClaimParts
Remotes.IsPlayerOwner.OnServerInvoke = HouseModule.CheckForOwnerShip

task.spawn(function()
    while wait(1)  do
        for _, HouseOb in pairs(Houses) do
            HouseOb:Update()
        end
    end
end)

return HouseModule