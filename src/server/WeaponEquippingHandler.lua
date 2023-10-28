local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes
local WeaponEquipping = {}

-- Give the player a backpack with the specified ID.
-- The function clones the backpack model from the replicated storage, assigns it a name and parents it to the character.

function WeaponEquipping.ChangeInventory()
end

local function DeleteEquippedTool(player: Player, WeaponID: string)
    local Character = player.Character
    print("Weapon Unequipped")
    Character.Humanoid:UnequipTools()
    local weapon = player.Backpack:FindFirstChild("weapon")
    weapon:Destroy()
end

local function givePlayerWeapon(player: Player, WeaponID: string)
    print(WeaponID)
    DeleteEquippedTool(player, WeaponID)
end

Remotes.GivePlayerWeaponTool.OnServerEvent:Connect(givePlayerWeapon) 

return WeaponEquipping