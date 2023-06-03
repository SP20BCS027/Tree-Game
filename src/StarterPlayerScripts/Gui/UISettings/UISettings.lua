local UISettings = {}

local player = game.Players.LocalPlayer

function UISettings.DisableAll(skip: string)
    skip = skip or ""
    for _, UI in player.PlayerGui:GetChildren() do 
        if UI.Name == "PlotStats" or UI.Name == "Stats" or UI.Name == "WaterRefill" or UI.Name == "LoadingScreen" or UI.Name == "InventoryButton" or UI.Name == skip then continue end 
        UI.Enabled = false
    end
end

return UISettings