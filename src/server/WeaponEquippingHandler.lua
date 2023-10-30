local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes
local Weapons = ReplicatedStorage.Assets.Weapons
local WeaponsConfig = require(ReplicatedStorage.Configs.WeaponsConfig)
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
    if weapon then 
        weapon:Destroy()
    end
end

local function givePlayerWeapon(player: Player, WeaponType, WeaponID: string)
    print(WeaponID)
    DeleteEquippedTool(player, WeaponID)
    local currentWeapon = WeaponsConfig[WeaponType][WeaponID]
    local weaponTool = Weapons[currentWeapon.Type][currentWeapon.WeaponType][currentWeapon.Rarity][currentWeapon.UID]:Clone()
    weaponTool.Name = "weapon"
    weaponTool.Parent = player.Backpack
end

Remotes.GivePlayerWeaponTool.OnServerEvent:Connect(givePlayerWeapon) 

return WeaponEquipping