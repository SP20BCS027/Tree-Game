local WorkSpace = game:GetService("Workspace")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local Manager = require(ServerScriptService.PlayerData.Manager)

local TouchPart = WorkSpace:WaitForChild("SellPart")

local Debounce = {}
local DELAY = 2

TouchPart.Touched:Connect(function(touch)
	local player = Players:GetPlayerFromCharacter(touch.Parent)
	
	if player then 
		if Debounce[player] then return end
		
		local profile = Manager.Profiles[player]
		if not profile then return end 
		
		Manager.AdjustCoins(player, profile.Data.Money)
		Manager.SellAllMoney(player)		
		
		task.delay(DELAY, function()
			Debounce[player] = nil
		end)
	end
end)