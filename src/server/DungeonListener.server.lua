local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WorkSpace = game:GetService("Workspace")
local Players = game:GetService("Players")

local Remotes = ReplicatedStorage.Remotes

local triggerparts = WorkSpace.Dungeons:GetChildren()
local debounce = {}

local function generateUI(player: Player, DungeonName)
    if debounce[player] then return end 

	Remotes.GenerateDungeons:FireClient(player, DungeonName)

    print("This player ".. player.Name .. " Triggered")

    debounce[player] = true
    task.delay(0.5, function()
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



