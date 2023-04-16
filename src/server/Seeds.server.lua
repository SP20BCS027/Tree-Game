local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)

local Remotes = ReplicatedStorage.Remotes

local function UpdateSeeds(player: Player, amount: number?, seedType: string)
	Manager.AdjustSeeds(player, amount, seedType)
end

Remotes.UpdateOwnedSeeds.OnServerEvent:Connect(UpdateSeeds)
