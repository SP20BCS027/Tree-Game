local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local Remotes = ReplicatedStorage.Remotes

local AchievementsManager = require(player:WaitForChild("PlayerScripts").Gui.Achievements.AchievementsManager)

local AchievementUI = player.PlayerGui:WaitForChild("AchievementTemplate")
local InventoryButtonUI = player.PlayerGui:WaitForChild("InventoryButton")

local AchievementButton = InventoryButtonUI.Frame.Achievements

AchievementButton.MouseButton1Down:Connect(function()
    AchievementsManager.GenerateAchievements()
    AchievementUI.Enabled = not AchievementUI.Enabled
end)

Remotes.UpdateAchievements.OnClientEvent:Connect(function()
    task.delay(0, function()
        AchievementsManager.GenerateAchievements()
    end)
end)
