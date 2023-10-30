local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WorkSpace = game:GetService("Workspace")
local Players = game:GetService("Players")

local Remotes = ReplicatedStorage.Remotes

local Shops = WorkSpace:WaitForChild("Shops"):GetChildren()
local BattleShops = WorkSpace:WaitForChild("BattleShops"):GetChildren()

local TriggerParts = {}
local BattleTriggerParts = {}

for _, shop in Shops do
    if shop.TouchPart then 
        TriggerParts[shop.Name] = shop.TouchPart
    end
end

for _, shop in BattleShops do 
    if shop.TouchPart then 
        BattleTriggerParts[shop.Name] = shop.TouchPart
    end
end

local Debounce = {}
local DELAY = 5
local VERTICAL_OFFSET = Vector3.new(0, 3, 0)
local SHOP_ID

local function GenerateUI(player: Player, TriggerPart)
    if Debounce[player] then return end 
    SHOP_ID = TriggerPart.Parent.Name

	Remotes.OpenShop:FireClient(player, SHOP_ID)

    local character = player.Character 
    character.HumanoidRootPart.CFrame = TriggerPart.Parent.PositionPart.CFrame + VERTICAL_OFFSET
    Debounce[player] = true
    task.delay(DELAY, function()
        Debounce[player] = nil 
    end)
end

local function GenerateBattleUI(player: Player, TriggerPart)
    if Debounce[player] then return end
    SHOP_ID = TriggerPart.Parent.Name

    Remotes.OpenBattleShop:FireClient(player, SHOP_ID, "Sword", "Neutral", true)

    local character = player.Character 
    character.HumanoidRootPart.CFrame = TriggerPart.Parent.PositionPart.CFrame + VERTICAL_OFFSET
    Debounce[player] = true
    task.delay(DELAY, function()
        Debounce[player] = nil 
    end)
end

local function ListenToShopTouch()
    for _, TriggerPart in TriggerParts do 
        TriggerPart.Touched:Connect(function(hit)
            local player = Players:GetPlayerFromCharacter(hit.Parent)
    
            if player then 
                GenerateUI(player, TriggerPart)
            end
        end)
    end
end

local function ListenToBattleShopTouch()
    for _, TriggerPart in BattleTriggerParts do 
        TriggerPart.Touched:Connect(function(hit)
            local player = Players:GetPlayerFromCharacter(hit.Parent)
    
            if player then 
                GenerateBattleUI(player, TriggerPart)
            end
        end)
    end
end

ListenToBattleShopTouch()
ListenToShopTouch()

