local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)

local Remotes = ReplicatedStorage.Remotes
local player = game.Players.LocalPlayer
local character = player.CharacterAdded:Wait()

local AnimationHandler = require(player:WaitForChild("PlayerScripts").Gui.Animations.AnimationModule)

local StateManager = require(ReplicatedStorage.Client.State)
local UI = player.PlayerGui:WaitForChild("SeedSelection")
local closeButton = UI.CloseFrame.CloseButton
local MainFrame = UI.MainFrame
local InternalFrame = MainFrame.InternalFrame
local scrollingFrame = InternalFrame.ScrollingFrame
local InformationFrame = InternalFrame.InformationFrame.Frame
local template = scrollingFrame.Template

local Seeds = StateManager.GetData().Seeds

local Seed 
local PlotID
local MudPos
local AnimPart

local crouchAnimID = "rbxassetid://13248889864"

local function LoadStats(seedReceived)
	InformationFrame.SeedDescription.Text = seedReceived.Description 
	Seed = seedReceived
end

local function CreateSeedIcon(seed)
	local seedIcon = template:Clone()
	seedIcon.Visible = true 
	seedIcon.Parent = scrollingFrame.IconsFolder
	seedIcon.Amount.Text = seed.Amount
	seedIcon.Label.Text = seed.Name
	seedIcon.Name = seed.Name
	
	seedIcon.TextButton.MouseButton1Down:Connect(function()
		LoadStats(seed)
	end)	
end

local function UpdateSeedIcons(plotReceived, mudPosition, animationPositionPart)
	PlotID = plotReceived
	MudPos = mudPosition
	AnimPart = animationPositionPart
	for _, Icon in scrollingFrame.IconsFolder:GetChildren() do

		if Icon.Name == "UIGridLayout" then continue end

		Icon.Amount.Text = Seeds[Icon.Name].Amount 
		if Seeds[Icon.Name].Amount <= 0 then
			Icon.Visible = false
		else 
			Icon.Visible = true
		end	
	end
	UI.Enabled = true
end

local function GenerateSelectableSeeds()
	for _, seed in (Seeds) do
		CreateSeedIcon(seed)
	end
end

GenerateSelectableSeeds()

local function PlantSeed()
	Remotes.UpdateOwnedSeeds:FireServer(-1, Seed.Name)
	Remotes.UpdateOccupied:FireServer(PlotID, true, Seed.Name, MudPos)
end

InformationFrame.PlantButton.MouseButton1Down:Connect(function()
	UI.Enabled = false
	PlantSeed() 	
	AnimationHandler.PlayAnimation(player, character, crouchAnimID)
	local plantingSound = AnimPart.WateringSound
	plantingSound:Play()
end)

closeButton.MouseButton1Down:Connect(function()
	UI.Enabled = false 
	PlayerMovement:Movement(player, true)
end)

Remotes.Bindables.SelectSeed.Event:Connect(UpdateSeedIcons)