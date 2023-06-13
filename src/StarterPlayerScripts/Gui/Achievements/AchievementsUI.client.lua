local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local Remotes = ReplicatedStorage.Remotes

local AchievementsManager = require(player:WaitForChild("PlayerScripts").Gui.Achievements.AchievementsManager)
local UISettings = require(player:WaitForChild("PlayerScripts").Gui.UISettings.UISettings)

local AchievementUI = player.PlayerGui:WaitForChild("AchievementTemplate")
local InventoryButtonUI = player.PlayerGui:WaitForChild("InventoryButton")

local AchievementButton = InventoryButtonUI.Frame.Achievements

-- Generate the achievements, and toggle the visibility of the Achievement UI.
AchievementButton.MouseButton1Down:Connect(function()
    UISettings.DisableAll("AchievementTemplate")
    AchievementsManager.GenerateAchievements()
    AchievementUI.Enabled = not AchievementUI.Enabled
end)

-- When the server sends an update for achievements
Remotes.UpdateAchievements.OnClientEvent:Connect(function()
    task.delay(0, function()
        AchievementsManager.GenerateAchievements()
    end)
end)

