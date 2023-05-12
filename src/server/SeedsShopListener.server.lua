local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WorkSpace = game:GetService("Workspace")
local Players = game:GetService("Players")

local Remotes = ReplicatedStorage.Remotes

local TriggerPart = WorkSpace.SeedsShop 
local Debounce = {}
local DELAY = 5
local VERTICAL_OFFSET = Vector3.new(0, 3, 0)
local SHOP_ID = "Seed"


local function GenerateUI(player: Player)
    if Debounce[player] then return end 

	Remotes.OpenSeedsShop:FireClient(player, SHOP_ID)

    local character = player.Character 
    character.HumanoidRootPart.CFrame = TriggerPart.PositionPart.CFrame + VERTICAL_OFFSET

    Debounce[player] = true
    task.delay(DELAY, function()
        Debounce[player] = nil 
    end)
end

local function ListenToWaterShopTouch()
    TriggerPart.Touched:Connect(function(hit)
        local player = Players:GetPlayerFromCharacter(hit.Parent)

        if player then 
            GenerateUI(player)
        end
    end)
end

ListenToWaterShopTouch()



