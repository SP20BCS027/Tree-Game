local WorkSpace = game:GetService("Workspace")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local Manager = require(ServerScriptService.PlayerData.Manager)

local Touchpart = WorkSpace:WaitForChild("SellPart")

local debounce = {}

Touchpart.Touched:Connect(function(touch)
	local Player = Players:GetPlayerFromCharacter(touch.Parent)
	
	if Player then 
		if debounce[Player] then return end
		
		local profile = Manager.Profiles[Player]
		if not profile then return end 
		
		Manager.AdjustCoins(Player, profile.Data.Money)
		Manager.SellAllMoney(Player)		
		
		task.delay(0.5, function()
			debounce[Player] = nil
		end)
	end
end)