local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local Remotes = ReplicatedStorage.Remotes

local QuestsManager = require(player:WaitForChild("PlayerScripts").Gui.Quests.QuestsManager)
local SoundsManager = require(player:WaitForChild("PlayerScripts").Gui.Sounds.SoundsManager)
local UISettings = require(player:WaitForChild("PlayerScripts").Gui.UISettings.UISettings)

local QuestsUI = player.PlayerGui:WaitForChild("QuestsTemplate")
local InventoryButtonUI = player.PlayerGui:WaitForChild("InventoryButton")

local QuestButton = InventoryButtonUI.Frame.Quests

-- Opens the Quests UI when the Quests button is clicked
QuestButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    QuestsManager.GenerateQuests() 
    UISettings.DisableAll("QuestsTemplate") 
    QuestsUI.Enabled = not QuestsUI.Enabled
end)

-- Updates the quests in the UI when a quest update event is received from the server
Remotes.UpdateQuests.OnClientEvent:Connect(function()
    task.delay(0, function()
        QuestsManager.GenerateAchievements() 
    end)
end)
