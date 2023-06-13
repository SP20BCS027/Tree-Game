local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)

local Remotes = ReplicatedStorage.Remotes
local BackpackEquipping = {}

-- Give the player a backpack with the specified ID.
-- The function clones the backpack model from the replicated storage, assigns it a name and parents it to the character.
local function GivePlayerBackpack(player: Player, BackpackID: string)
    local character = player.Character or player.CharacterAdded:Wait()

    if character then 
        if character:FindFirstChild("Backpack") then 
            character:FindFirstChild("Backpack"):Destroy()
        end
    end

    local backpack = ReplicatedStorage.Backpacks[BackpackID]:Clone()
    backpack.Name = "Backpack"
    backpack.Parent = character 

    local upperTorso = character:WaitForChild("UpperTorso")
    local moveCFrame = upperTorso.CFrame * upperTorso.BodyBackAttachment.CFrame
    backpack:PivotTo(moveCFrame)

    local weld = Instance.new("WeldConstraint")
    weld.Parent = backpack.Part
    weld.Part0 = backpack.Part
    weld.Part1 = character.UpperTorso

    BackpackEquipping.UpdatePlayerBackpackLabel(player)
end

-- Update the player's backpack label with the current amount of money and backpack capacity.
function BackpackEquipping.UpdatePlayerBackpackLabel(player: Player)
    local profile = Manager.Profiles[player]
    if not profile then return end

    local character = player.Character or player.CharacterAdded:Wait()

    if not character then return end
    if not character:FindFirstChild("Backpack") then return end

    local backpack = character:FindFirstChild("Backpack")
    local backpackLabel = backpack.Part.BackpackStorage.Amount

    backpackLabel.Text = profile.Data.Money .. " / " .. profile.Data.EquippedBackpack.Capacity
end


Remotes.UpdateBackpackLabel.OnServerEvent:Connect(BackpackEquipping.UpdatePlayerBackpackLabel)
Remotes.GivePlayerBackpack.OnServerEvent:Connect(GivePlayerBackpack) 

return BackpackEquipping