local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes
local Weapons = ReplicatedStorage.Assets.Weapons
local WeaponsConfig = require(ReplicatedStorage.Configs.WeaponsConfig)
local PetEquipping = {}

-- Give the player a backpack with the specified ID.
-- The function clones the backpack model from the replicated storage, assigns it a name and parents it to the character.

-- function PetEquipping.ChangeInventory()
-- end

-- local function givePlayerWeapon(player: Player, WeaponType, WeaponID: string)
--     local currentWeapon = WeaponsConfig[WeaponType][WeaponID]
--     local weaponTool = Weapons[currentWeapon.Type][currentWeapon.WeaponType][currentWeapon.Rarity][currentWeapon.UID]:Clone()
--     weaponTool.Name = "weapon"
--     weaponTool.Parent = player.Backpack
-- end

-- Remotes.GivePlayerWeaponTool.OnServerEvent:Connect(givePlayerWeapon) 

-- return PetEquipping