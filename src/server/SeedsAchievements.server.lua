local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)

local Remotes = ReplicatedStorage.Remotes

local function UpdateAchievements(player: Player, amount: number)
	Manager.UpdateAchievements(player, "SeedsPlanted", amount)
end

Remotes.SeedsAchievements.OnServerEvent:Connect(UpdateAchievements)
