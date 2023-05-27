local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)

local Remotes = ReplicatedStorage.Remotes

local function UpdateSettings(player: Player, setting: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	if profile.Data.Settings[setting] == nil then 
		print("This Setting " .. setting .. " does not exist ~~ Server")
		return 
	end

	Manager.UpdateSettings(player, setting)
end

Remotes.UpdateSettings.OnServerEvent:Connect(UpdateSettings)
