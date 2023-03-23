local ServerScriptService = game:GetService("ServerScriptService")

local Players = game.Players
local Manager = require(ServerScriptService.PlayerData.Manager)

Players.PlayerRemoving:Connect(function(player)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	profile.Data.IsOwner = false
	print("Ownership removed")
	
end)