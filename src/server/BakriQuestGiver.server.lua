local WorkSpace = game:GetService("Workspace")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Manager = require(ServerScriptService.PlayerData.Manager)
local QuestLogNPC = require(ReplicatedStorage.Configs.QuestLogNPC)

local TouchPart = WorkSpace:WaitForChild("QuestPart")

local Debounce = {}
local DELAY = 2

TouchPart.Touched:Connect(function(touch)
	local player = Players:GetPlayerFromCharacter(touch.Parent)
	
	if player then 
		if Debounce[player] then return end
		
		local profile = Manager.Profiles[player]
		if not profile then return end 
		
		profile.Data.ActiveQuests["Bakri"].CurrentQuestInfo = QuestLogNPC["Bakri"]["Quest_1"]
		profile.Data.ActiveQuests["Ghora"].CurrentQuestInfo = QuestLogNPC["Ghora"]["Quest_1"]

		ReplicatedStorage.Remotes.BakriQuest:FireClient(player, profile.Data.ActiveQuests)

		task.delay(DELAY, function()
			Debounce[player] = nil
		end)
	end
end)