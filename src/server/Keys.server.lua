local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local KeysConfig = require(ReplicatedStorage.Configs.KeysConfig)

local Remotes = ReplicatedStorage.Remotes

local function PurchaseKey(player: Player, amount: number, keyID: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	if not KeysConfig[keyID] then 
		print("The key" .. keyID .. " does not exist in Keys ~~ Server")
		return
	end
	 Manager.AdjustKeys(player, amount, keyID)
	 Manager.AdjustCoins(player, -(amount * KeysConfig[keyID].Price))
end

local function UseKeys(player: Player, amount: number, keyID: string)
	local profile = Manager.Profiles[player]
	if not profile then return end

	if not KeysConfig[keyID] then 
		print("The key" .. keyID .. " does not exist in Keys ~~ Server")
		return
	end

	Manager.AdjustKeys(player, -amount, keyID)
end


Remotes.UseKeys.OnServerEvent:Connect(UseKeys)
Remotes.UpdateOwnedKeys.OnServerEvent:Connect(PurchaseKey)