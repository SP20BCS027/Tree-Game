local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local Remotes = ReplicatedStorage.Remotes

local QuestsManager = require(player:WaitForChild("PlayerScripts").Gui.Quests.QuestsManager)
local SoundsManager = require(player:WaitForChild("PlayerScripts").Gui.Sounds.SoundsManager)

local QuestsUI = player.PlayerGui:WaitForChild("QuestsTemplate")
local InventoryButtonUI = player.PlayerGui:WaitForChild("InventoryButton")

local QuestButton = InventoryButtonUI.Frame.Quests

QuestButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    QuestsManager.GenerateQuests()

    QuestsUI.Enabled = not QuestsUI.Enabled
end)

Remotes.UpdateQuests.OnClientEvent:Connect(function()
    task.delay(0, function()
        QuestsManager.GenerateAchievements()
    end)
end)
