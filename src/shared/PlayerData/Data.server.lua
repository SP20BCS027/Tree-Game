local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Template = require(ReplicatedStorage.PlayerData.Template)
local Manager = require(ServerScriptService.PlayerData.Manager)
local ProfileService = require(ServerScriptService.Libs.ProfileService)

local ProfileStore = ProfileService.GetProfileStore("Test", Template)

local KICK_MESSAGE = "Data Issue, Try again shortly. If the issue persists contact us!"

local function CreateLeaderstats(player: Player)
	local profile = Manager.Profiles[player]
	if not profile then return end 
	
	local leaderstats = Instance.new("Folder")
	leaderstats.Parent = player
	leaderstats.Name = "leaderstats"
	
	local coins = Instance.new("NumberValue")
	coins.Parent = leaderstats
	coins.Name = "Coins"
	coins.Value = profile.Data.Coins
	
	local gems = Instance.new("NumberValue")
	gems.Parent = leaderstats
	gems.Name = "Gems"
	gems.Value = profile.Data.Gems 	
	
end


local function LoadData(player: Player)
	local profile = ProfileStore:LoadProfileAsync("Player_"..player.UserId)
	if not profile then 
		player:Kick(KICK_MESSAGE)
		return
	end
	
	profile:AddUserId(player.UserId)
	profile:Reconcile()
	profile:ListenToRelease(function()
		Manager.Profiles[player] = nil
		player:Kick(KICK_MESSAGE)
	end)
	
	if player:IsDescendantOf(Players) then 
		Manager.Profiles[player] = profile
		CreateLeaderstats(player)
	end
	
end

for _, player in Players:GetPlayers() do
	task.spawn(LoadData, player)
end

Players.PlayerAdded:Connect(LoadData)

Players.PlayerRemoving:Connect(function(player)
	local profile = Manager.Profiles[player]
	if profile then 
		profile:Release()
	end
end)
