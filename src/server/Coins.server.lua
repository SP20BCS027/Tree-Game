local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)

local Remotes = ReplicatedStorage.Remotes

-- Adjust the Coins of the specified player
local function ChangeCoins(player: Player, amount: number)
	Manager.AdjustCoins(player, amount)
end

Remotes.UpdateCoins.OnServerEvent:Connect(ChangeCoins)