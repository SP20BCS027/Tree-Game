local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WorkSpace = game:GetService("Workspace")
local Players = game:GetService("Players")

local Remotes = ReplicatedStorage.Remotes

local triggerpart = WorkSpace.WateringCanShop
local debounce = {}
local DELAY = 5

local function generateUI(player: Player)
    if debounce[player] then return end 

	Remotes.OpenWaterCanShop:FireClient(player)

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



