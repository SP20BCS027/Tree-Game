local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Manager = require(ServerScriptService.PlayerData.Manager)

local Remotes = ReplicatedStorage.Remotes
local BackpackEquipping = {}

local function GivePlayerBackpack(player: Player, BackpackID: string)
	local character = player.Character

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

function BackpackEquipping.UpdatePlayerBackpackLabel(player: Player)
	local profile = Manager.Profiles[player]
	if not profile then return end

	local character = player.Character

	if not character then return end
	if not character:FindFirstChild("Backpack") then return end

	local backpack = character:FindFirstChild("Backpack")
	local backpackLabel = backpack.Part.BackpackStorage.Amount

	backpackLabel.Text = profile.Data.Money .. " / " .. profile.Data.EquippedBackpack.Capacity
end

Remotes.UpdateBackpackLabel.OnServerEvent:Connect(BackpackEquipping.UpdatePlayerBackpackLabel)
Remotes.GivePlayerBackpack.OnServerEvent:Connect(GivePlayerBackpack) 

return BackpackEquipping