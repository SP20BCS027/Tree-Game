local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WorkSpace = game:GetService("Workspace")
local Players = game:GetService("Players")

local Remotes = ReplicatedStorage.Remotes

local triggerpart = WorkSpace.SeedsShop 
local debounce = {}
local DELAY = 5
local VERTICAL_OFFSET = Vector3.new(0, 3, 0)

local function generateUI(player: Player)
    if debounce[player] then return end 

	Remotes.OpenSeedsShop:FireClient(player)

    local character = player.Character 
    character.HumanoidRootPart.CFrame = triggerpart.PositionPart.CFrame + VERTICAL_OFFSET

    debounce[player] = true
    task.delay(DELAY, function()
        debounce[player] = nil 
    end)
end

local function ListenToWaterShopTouch()
    triggerpart.Touched:Connect(function(hit)
        local player = Players:GetPlayerFromCharacter(hit.Parent)

        if player then 
            generateUI(player)
        end
    end)
end

ListenToWaterShopTouch()



