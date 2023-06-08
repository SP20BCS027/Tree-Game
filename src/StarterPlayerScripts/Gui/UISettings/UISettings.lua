local UISettings = {}

local player = game.Players.LocalPlayer

local ListOfUINamesToDisable = {
    "AchievementTemplate", 
    "DungeonSelectMenu", 
    "FertilizerSelection", 
    "IndexSelectScreen", 
    "IndexTemplate", 
    "LoadingScreen", 
    "MainInventory", 
    "Plots_Stats", 
    "QuestsTemplate", 
    "SeedsSelection", 
    "SettingsTemplate", 
    "ShopTemplate", 
}

function UISettings.DisableAll(skip)
    skip = skip or ""
    for _, UI in ipairs(player.PlayerGui:GetChildren()) do
        if UI:IsA("ScreenGui")  then
            for _, name in ipairs(ListOfUINamesToDisable) do
                if UI.Name == skip then break end 
                if UI.Name == name then
                    UI.Enabled = false
                    break
                end
            end
        end
    end
end

return UISettings