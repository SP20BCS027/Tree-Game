local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Manager = require(ServerScriptService.PlayerData.Manager)

local Remotes = ReplicatedStorage.Remotes

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
	houseObject.Plot_1 = houseFolder.Plantation_Place_1:GetChildren()
	houseObject.Plot_2 = houseFolder.Plantation_Place_2:GetChildren()

	houseObject.claimPart.Touched:Connect(function(touch)
		local Player = Players:GetPlayerFromCharacter(touch.Parent)
		local profile = Manager.Profiles[Player]
		if not profile then return end
		if Player and houseObject.owner == nil and houseObject:checkOwner(Player) == false then
			houseObject.owner = Player
			profile.Data.IsOwner = true
			Remotes.UpdateOwnership:FireClient(Player, true)
			Remotes.EstablishWaterRefillUI:FireClient(Player, houseObject.well)
			Remotes.EstablishPlotsUI:FireClient(Player)
		end
	end)

	game.Players.PlayerRemoving:Connect(function(Player: Player)
		if houseObject.owner == Player then
			houseObject.owner = nil
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

return House