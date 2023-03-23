local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)

local Remotes = ReplicatedStorage.Remotes

local function changeCoins(player: Player, amount: number)
	Manager.AdjustCoins(player, amount)
end

Remotes.UpdateCoins.OnServerEvent:Connect(changeCoins)