local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)

local Remotes = ReplicatedStorage.Remotes
local player = game.Players.LocalPlayer
local character = player.CharacterAdded:Wait()

local AnimationHandler = require(player:WaitForChild("PlayerScripts").Gui.Animations.AnimationModule)
local ScalingUI = require(player:WaitForChild("PlayerScripts").Gui.ScalingUI.ScalingUI)
local SoundsManager = require(player:WaitForChild("PlayerScripts").Gui.Sounds.SoundsManager)

local State= require(ReplicatedStorage.Client.State)

local UI = player.PlayerGui:WaitForChild("SeedSelection")
local MainFrame = UI.MainFrame
local CloseButton = MainFrame.CloseFrame.CloseButton
local InventoryFrame = MainFrame.InventoryFrame
local ScrollingFrame = InventoryFrame.ScrollingFrame
local SelectedFrame = MainFrame.SelectedFrame
local StatsFrame = SelectedFrame.Stats
local IconImage = SelectedFrame.IconImage
local PlantButton = StatsFrame.PlantButton
local Template = InventoryFrame.Template

local Seeds = State.GetData().Seeds

local Seed 
local PlotID
local MudPos
local AnimPart

local AMOUNT = "Amount: REPLACE"
local NAME = "Name: REPLACE"

local ORIGINAL_SIZE_OF_PLANTBUTTON = PlantButton.Size
local ORIGINAL_SIZE_OF_CLOSEBUTTON = CloseButton.Size

local crouchAnimID = "rbxassetid://13248889864"


local function MakeStatsInvisible()
	StatsFrame.Visible = false
	IconImage.Visible = false
end 

local function MakeStatsVisible()
	StatsFrame.Visible = true
	IconImage.Visible = true
end 

local function LoadStats(seedReceived)
	StatsFrame.Description.IconDescription.Text = seedReceived.Description 
	StatsFrame.IconAmount.Text = AMOUNT:gsub("REPLACE", seedReceived.Amount)
	StatsFrame.IconName.Text = NAME:gsub("REPLACE", seedReceived.Name)
	Seed = seedReceived
	MakeStatsVisible()
end

local function CreateSeedIcon(seed)
	local seedIcon = Template:Clone()
	seedIcon.Visible = true 
	seedIcon.Parent = ScrollingFrame
	seedIcon.ItemName.Text = seed.Name
	seedIcon.Name = seed.Name
	
	seedIcon.MouseButton1Down:Connect(function()
		SoundsManager.PlayPressSound()
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
	Remotes.PlantedSeed:FireServer(Seed.Name)
	Remotes.UpdateAchievements:FireServer("SeedsPlanted", 1)
	Remotes.UpdateOccupied:FireServer(PlotID, Seed.Name, MudPos)
end

PlantButton.MouseButton1Down:Connect(function()
	SoundsManager.PlayPressSound()
	UI.Enabled = false
	MakeStatsInvisible()
	PlantSeed() 	
	AnimationHandler.PlayAnimation(player, character, crouchAnimID)
	local plantingSound = AnimPart.WateringSound
	plantingSound:Play()
end)

PlantButton.MouseEnter:Connect(function()
	SoundsManager.PlayEnterSound()
	PlantButton.Size = ScalingUI.IncreaseBy2Point5Percent(ORIGINAL_SIZE_OF_PLANTBUTTON)
end) 
PlantButton.MouseLeave:Connect(function()
	SoundsManager.PlayLeaveSound()
	PlantButton.Size = ORIGINAL_SIZE_OF_PLANTBUTTON
end)

CloseButton.MouseButton1Down:Connect(function()
	SoundsManager.PlayCloseSound()
	UI.Enabled = false 
	MakeStatsInvisible()
	PlayerMovement:Movement(player, true)
end)

CloseButton.MouseEnter:Connect(function()
	SoundsManager.PlayEnterSound()
	CloseButton.Size = ScalingUI.IncreaseBy10Percent(ORIGINAL_SIZE_OF_CLOSEBUTTON)
end)

CloseButton.MouseLeave:Connect(function()
	SoundsManager.PlayLeaveSound()
	CloseButton.Size = ORIGINAL_SIZE_OF_CLOSEBUTTON
end)

Remotes.Bindables.SelectSeed.Event:Connect(UpdateSeedIcons)