local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)
local BackpackEquippingHandler = require(ServerScriptService.BackpackEquippingHandler)

local Remotes = ReplicatedStorage.Remotes

-- Changes the equipped watering can for the specified player.
local function ChangeEquippedWateringCan(player: Player, waterCan: string)
    Manager.EquipWaterCan(player, waterCan)
end

-- Changes the equipped backpack for the specified player.
local function ChangeEquippedBackpack(player: Player, backpack: string)
    local profile = Manager.Profiles[player]
    if not profile then return end

    if profile.Data.OwnedBackpacks[backpack] then 
        Manager.EquipBackpack(player, backpack)
        BackpackEquippingHandler.UpdatePlayerBackpackLabel(player)
    end
end

local function ChangeEquippedWeapon(player: Player, element, weapon: string)
    local profile = Manager.Profiles[player]
    if not profile then return end 
    if profile.Data.OwnedWeapons[element][weapon] then 
        Manager.EquipWeapon(player, element, weapon)
    end
end

local function ChangeEquippedPet(player: Player, element, pet: string, petSlot: string)
    local profile = Manager.Profiles[player]
    if not profile then return end 

    if profile.Data.EquippedPets[petSlot].UID then 
        Manager.UnEquipPet(player, element, pet, petSlot)
        return
    end

    if profile.Data.OwnedPets[element][pet].Equipped == true then 
        print("The selected Pet is already Equipped by the Player ~Server")
        return
    end

    if profile.Data.OwnedPets[element][pet] then 
        Manager.EquipPet(player, element, pet, petSlot)
    end
end

Remotes.ChangeEquippedPets.OnServerEvent:Connect(ChangeEquippedPet)
Remotes.ChangeEquippedWeapon.OnServerEvent:Connect(ChangeEquippedWeapon)
Remotes.ChangeEquippedBackpack.OnServerEvent:Connect(ChangeEquippedBackpack)
Remotes.ChangeEquippedWateringCan.OnServerEvent:Connect(ChangeEquippedWateringCan)