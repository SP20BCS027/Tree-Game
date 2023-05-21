local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)

local Remotes = ReplicatedStorage.Remotes

local function UpdateAchievements(player: Player, achievementType: string,  amount: number)
	local profile = Manager.Profiles[player]
	if not profile then return end

	if achievementType == "MoneyEarned" then 
		amount = profile.Data.Plots[amount].Tree.MoneyGenerated
	end 

	Manager.UpdateAchievements(player, achievementType, amount)
end

Remotes.UpdateAchievements.OnServerEvent:Connect(UpdateAchievements)
