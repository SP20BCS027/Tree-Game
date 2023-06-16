local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WorkSpace = game:GetService("Workspace")
local Players = game:GetService("Players")

local Remotes = ReplicatedStorage.Remotes

local TriggerPart = WorkSpace:WaitForChild("Shops").BackpackShop.TouchPart
local Debounce = {}
local DELAY = 5
local SHOP_ID = "Backpacks"
local VERTICAL_OFFSET = Vector3.new(0, 3, 0)

-- Generates the UI for opening the backpack shop for the specified player.
-- The function fires a remote event to open the backpack shop UI on the client-side.
local function GenerateUI(player: Player)
    if Debounce[player] then return end 

    Remotes.OpenBackpackShop:FireClient(player, SHOP_ID)

    local character = player.Character 
    character.HumanoidRootPart.CFrame = TriggerPart.Parent.PositionPart.CFrame + VERTICAL_OFFSET

    Debounce[player] = true

    task.delay(DELAY, function()
        Debounce[player] = nil 
    end)
end

-- When a player touches the trigger part, it generates the UI for the player by calling the GenerateUI function.
local function ListenToWaterShopTouch()
    TriggerPart.Touched:Connect(function(hit)
        local player = Players:GetPlayerFromCharacter(hit.Parent)

        if player then 
            GenerateUI(player)
        end
    end)
end

ListenToWaterShopTouch()
