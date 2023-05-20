local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)

local Remotes = ReplicatedStorage.Remotes
local player = game.Players.LocalPlayer
local character = player.CharacterAdded:Wait()

local AnimationHandler = require(player:WaitForChild("PlayerScripts").Gui.Animations.AnimationModule)

local State= require(ReplicatedStorage.Client.State)

local UI = player.PlayerGui:WaitForChild("SeedSelection")
local MainFrame = UI.MainFrame
local CloseButton = MainFrame.CloseFrame.CloseButton
local InventoryFrame = MainFrame.InventoryFrame
local ScrollingFrame = InventoryFrame.ScrollingFrame
local SelectedFrame = MainFrame.SelectedFrame
local StatsFrame = SelectedFrame.Stats
local Template = InventoryFrame.Template

local Seeds = State.GetData().Seeds

local Seed 
local PlotID
local MudPos
local AnimPart

local AMOUNT = "Amount: REPLACE"
local NAME = "Name: REPLACE"

local crouchAnimID = "rbxassetid://13248889864"

local function LoadStats(seedReceived)
	StatsFrame.Description.IconDescription.Text = seedReceived.Description 
	StatsFrame.IconAmount.Text = AMOUNT:gsub("REPLACE", seedReceived.Amount)
	StatsFrame.IconName.Text = NAME:gsub("REPLACE", seedReceived.Name)
	Seed = seedReceived
end

local function CreateSeedIcon(seed)
	local seedIcon = Template:Clone()
	seedIcon.Visible = true 
	seedIcon.Parent = ScrollingFrame
	seedIcon.ItemName.Text = seed.Name
	seedIcon.Name = seed.Name
	
	seedIcon.MouseButton1Down:Connect(function()
		LoadStats(seed)
	end)	
end

local function UpdateSeedIcons(plotReceived, mudPosition, animationPositionPart)
	PlotID = plotReceived
	MudPos = mudPosition
	AnimPart = animationPositionPart

	Seeds = State.GetData().Seeds

	for _, Icon in ScrollingFrame:GetChildren() do

		if Icon.Name == "UIGridLayout" then continue end

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
	Remotes.UpdateAchievements:FireServer("SeedsPlanted", 1)
	Remotes.UpdateOccupied:FireServer(PlotID, true, Seed.Name, MudPos)
end

StatsFrame.PlantButton.MouseButton1Down:Connect(function()
	UI.Enabled = false
	PlantSeed() 	
	AnimationHandler.PlayAnimation(player, character, crouchAnimID)
	local plantingSound = AnimPart.WateringSound
	plantingSound:Play()
end)

CloseButton.MouseButton1Down:Connect(function()
	UI.Enabled = false 
	PlayerMovement:Movement(player, true)
end)

Remotes.Bindables.SelectSeed.Event:Connect(UpdateSeedIcons)