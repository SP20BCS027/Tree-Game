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

local function RefillWater(animationPosition)
	Remotes.RefillWater:FireServer()

	local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

	humanoidRootPart.CFrame = animationPosition.CFrame + VERTICAL_OFFSET
	PlayerMovement:Movement(player, false)
	AnimationHandler.PlayAnimation(player, character, crouchAnimID)
	
	animationPosition.WateringSound:Play()
end

local function GetHouseWell()
	return Remotes.GetHouseWell:InvokeServer()
end

local function AdorneeUI()
	local housewell = GetHouseWell()

	RefillIcon.Enabled = true
	RefillIcon.Adornee = housewell.Well

	RefillIcon.Holder.WaterButton.MouseButton1Down:Connect(function()
		RefillWater(housewell.AnimationPosition)
	end)
end

Remotes.EstablishWaterRefillUI.OnClientEvent:Connect(AdorneeUI)