local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes
local player = game.Players.LocalPlayer
local character = player.CharacterAdded:Wait()

local PlayerMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)
local AnimationHandler = require(player:WaitForChild("PlayerScripts").Gui.Animations.AnimationModule)

local UI = player.PlayerGui:WaitForChild("WaterRefill")
local RefillIcon = UI.IconHolder

local VERTICAL_OFFSET = Vector3.new(0, 3, 0)
local crouchAnimID = "rbxassetid://13248889864"

local function RefillWater(position)
	Remotes.RefillWater:FireServer()
	character:WaitForChild("HumanoidRootPart").CFrame = position + VERTICAL_OFFSET
	PlayerMovement:Movement(player, false)
	AnimationHandler.playAnimation(player, character, crouchAnimID)
end

local function AdorneeUI()
	local well = Remotes.GetHouseWell:InvokeServer()

	RefillIcon.Enabled = true
	RefillIcon.Adornee = well.Well

	RefillIcon.Holder.WaterButton.MouseButton1Down:Connect(function()
		RefillWater(well.AnimationPosition.CFrame)
	end)
end

Remotes.EstablishWaterRefillUI.OnClientEvent:Connect(AdorneeUI)