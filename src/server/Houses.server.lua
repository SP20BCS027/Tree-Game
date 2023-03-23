local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes

local House = require(game.ServerScriptService.Classes.House)
local Houses = {}

for _, houseFolder in pairs(workspace.Houses:GetChildren()) do 
	local houseObj = House.new(houseFolder, Houses)
	table.insert(Houses, houseObj)
end

local function GetplayerHouse(player: Player, plot: string)
	for _, HouseOb in pairs(Houses) do
		if HouseOb.owner == player then 
			return HouseOb[plot]
		end
	end
end

Remotes.AskUIInformation.OnServerInvoke = GetplayerHouse

while wait(1)  do
	for _, HouseOb in pairs(Houses) do
		HouseOb:update()
	end
end
