local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)

local Remotes = ReplicatedStorage.Remotes

-- Update the achievements for the given player based on the achievement type and amount.
-- The function retrieves the player's profile data and checks if the achievement type exists.
local function UpdateAchievements(player: Player, achievementType: string, amount: number)
    local profile = Manager.Profiles[player]
    if not profile then return end

    if profile.Data.Achievements[achievementType] == nil then 
        print("This achievement " .. achievementType .. " does not exist for the player " .. player .. " ~~ Server")
        return
    end 

    if achievementType == "MoneyEarned" then 
        amount = profile.Data.Plots[amount].Tree.MoneyGenerated * profile.Data.Plots[amount].Tree.CurrentLevel
    end 

    if amount < 0 then 
        print("Negative amount values are not allowed! ~~ Server") 
        return
    end

    Manager.UpdateAchievements(player, achievementType, amount)
end


Remotes.UpdateAchievements.OnServerEvent:Connect(UpdateAchievements)
