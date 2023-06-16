local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes
local player = game.Players.LocalPlayer
local character = player.CharacterAdded:Wait()

local PlayerMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)
local AnimationHandler = require(player:WaitForChild("PlayerScripts").Gui.Animations.AnimationModule)
local State = require(ReplicatedStorage.Client.State)
local SoundsManager = require(player:WaitForChild("PlayerScripts").Gui.Sounds.SoundsManager)

local UI = player.PlayerGui:WaitForChild("WaterRefill")
local RefillIcon = UI.IconHolder

local VERTICAL_OFFSET = Vector3.new(0, 3, 0)
local crouchAnimID = "rbxassetid://13248889864"

-- Function to refill the water, change player position, play refill animation, and disable player movement
local function RefillWater(animationPosition)
	if State.GetData().Water >= State.GetData().EquippedWaterCan.Capacity then 
		print("The Water Can is already full")
		SoundsManager.PlayDenialSound()	
		return 
	end

	Remotes.RefillWater:FireServer()

	local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

	humanoidRootPart.CFrame = animationPosition.CFrame + VERTICAL_OFFSET
	PlayerMovement:Movement(player, false)
	AnimationHandler.PlayAnimation(player, character, crouchAnimID)
	
	SoundsManager.PlayPressSound()
	animationPosition.WateringSound:Play()
end

-- Function to get the well object from the player's house
local function GetHouseWell()
	return Remotes.GetHouseWell:InvokeServer()
end

-- Function to adorne the Refill Button to the House Well
local function AdorneeUI()
	local housewell = GetHouseWell()

	RefillIcon.Enabled = true
	RefillIcon.Adornee = housewell.Well

	RefillIcon.Holder.WaterButton.MouseButton1Down:Connect(function()
		RefillWater(housewell.AnimationPosition)
	end)
end

-- Connect the AdorneeUI function to the client event that establishes the water refill UI
Remotes.EstablishWaterRefillUI.OnClientEvent:Connect(AdorneeUI)