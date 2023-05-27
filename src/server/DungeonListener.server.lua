local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WorkSpace = game:GetService("Workspace")
local Players = game:GetService("Players")

local Remotes = ReplicatedStorage.Remotes

local TriggerParts = WorkSpace.Dungeons:GetChildren()
local Debounce = {}
local DELAY = 5


local function GenerateUI(player: Player, DungeonName: string)
    if Debounce[player] then return end 

	Remotes.GenerateDungeons:FireClient(player, DungeonName)
    Debounce[player] = true
    task.delay(DELAY, function()
        Debounce[player] = nil 
    end)
end

local function ListenToDungeonTouch()
    for _, part in TriggerParts do 
        local DungeonName = part.Name
        part.Touched:Connect(function(hit)
            local player = Players:GetPlayerFromCharacter(hit.Parent)

            if player then 
                GenerateUI(player, DungeonName)
            end
        end)
    end
end

ListenToDungeonTouch()