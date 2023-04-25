local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WorkSpace = game:GetService("Workspace")
local Players = game:GetService("Players")

local Remotes = ReplicatedStorage.Remotes

local triggerparts = WorkSpace.Dungeons:GetChildren()
local debounce = {}
local DELAY = 5


local function generateUI(player: Player, DungeonName)
    if debounce[player] then return end 

	Remotes.GenerateDungeons:FireClient(player, DungeonName)
    debounce[player] = true
    task.delay(DELAY, function()
        debounce[player] = nil 
    end)
end

local function ListenToDungeonTouch()
    for _, part in triggerparts do 
        local DungeonName = part.Name
        part.Touched:Connect(function(hit)
            local player = Players:GetPlayerFromCharacter(hit.Parent)

            if player then 
                generateUI(player, DungeonName)
            end
        end)
    end
end

ListenToDungeonTouch()



