local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes

local House = require(game.ServerScriptService.Classes.House)
local Houses = {}

for _, houseFolder in pairs(workspace.Houses:GetChildren()) do 
	local houseObj = House.new(houseFolder, Houses)
	table.insert(Houses, houseObj)
	print(Houses)
end

local function GetplayerHouse(player: Player, plot: string?, nameOfFetch: string?)
	for _, HouseOb in pairs(Houses) do
		if not HouseOb.owner then return end 
		if HouseOb.owner == player then 
			if nameOfFetch == "plot" then 
				return HouseOb.Plots[plot]
			elseif nameOfFetch == "folder" then 
				return HouseOb.treeFolder
			end
		end
	end
end

Remotes.AskUIInformation.OnServerInvoke = GetplayerHouse
Remotes.Bindables.GetPlayerHouseInfo.Event:Connect(GetplayerHouse)

while wait(1)  do
	for _, HouseOb in pairs(Houses) do
		HouseOb:update()
	end
end
