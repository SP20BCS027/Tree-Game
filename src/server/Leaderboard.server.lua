-- local Workspace = game:GetService("Workspace")
-- local DataStoreService = game:GetService("DataStoreService")
-- local Players = game:GetService("Players")
-- local DataStore = DataStoreService:GetOrderedDataStore("Test")
-- local ServerScriptService = game:GetService("ServerScriptService")
-- local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- local Manager = require(ServerScriptService.PlayerData.Manager)

-- local DataTemplate = require(ReplicatedStorage.PlayerData.Template)

-- local ProfileService = require(ServerScriptService.Libs.ProfileService)
-- local ProfileStore = ProfileService.GetProfileStore("Test", DataTemplate)

-- local Leaderboards = {
-- 	MoneyLeaderBoard = Workspace:WaitForChild("MoneyEarned"), 
-- 	CoinsLeaderBoard = Workspace:WaitForChild("CoinsEarned"), 
-- }

-- local DELAY = 55
-- local MAXITEMS = 100
-- local COLORS = {
-- 	Default = Color3.fromRGB(38, 50, 56),
-- 	Gold = Color3.fromRGB(255, 215, 0),
-- 	Silver = Color3.fromRGB(192, 192, 192),
-- 	Bronze = Color3.fromRGB(205, 127, 50)
-- }

-- local DATA
-- local ScrollingFrame
-- local Template
-- local Heading

-- local function ClearLeaderboard()
-- 	for _, item in ScrollingFrame:GetChildren() do
-- 		if item.Name == "UIListLayout" then continue end 
-- 		if item.Name == "Template" then continue end 
-- 		item:Destroy()
-- 	end
-- end

-- local function GetStats()
	
-- 	local data = DataStore:GetSortedAsync(false, MAXITEMS)
-- 	local topPage = data:GetCurrentPage()

-- 	for position, v in ipairs(topPage) do
-- 		local userId = v.key 
-- 		local username = "[Not Available]"
-- 		local color = COLORS.Default

-- 		local profile

-- 		if not Manager.Profiles[Players:GetPlayerByUserId(userId)] then 
-- 			profile = ProfileStore:LoadProfileAsync("Player_" .. userId)
-- 		end

-- 		profile = Manager.Profiles[Players:GetPlayerByUserId(userId)]

-- 		if not profile then return end 

-- 		Heading.Text = profile.Data.Achievements[DATA].Name .. " Leaderboard"
-- 		local value = profile.Data.Achievements[DATA].AmountAchieved

-- 		local success, err = pcall(function()
-- 			username = Players:GetNameFromUserIdAsync(userId)
-- 		end)

-- 		if not success then
-- 			print("Error: " .. err) 
-- 		end

-- 		if position == 1 then
-- 			color = COLORS.Gold
-- 		elseif position == 2 then
-- 			color = COLORS.Silver
-- 		elseif position == 3 then
-- 			color = COLORS.Bronze
-- 		end

-- 		local item = Template:Clone()
-- 		item.Name = username
-- 		item.Visible = true
-- 		item.LayoutOrder = value
-- 		item.Rank.TextColor3 = color
-- 		item.Rank.Text = position
-- 		item.Username.Text = username
-- 		item.Stat.Text = value
-- 		item.Parent = ScrollingFrame
-- 	end
-- end

-- while task.wait(20) do 
-- 	for _, leaderboard in Leaderboards do 
-- 		DATA = leaderboard.name
-- 		local SurfaceGUI = leaderboard:WaitForChild("SurfaceGui")
-- 		local MainFrame = SurfaceGUI.MainFrame
-- 		ScrollingFrame = MainFrame.ScrollingFrame
-- 		Heading = MainFrame.Heading.Leaderboard
-- 		Template = ScrollingFrame.Template

-- 		ClearLeaderboard()
-- 		GetStats()
-- 	end
-- 	task.wait(DELAY)
-- end

