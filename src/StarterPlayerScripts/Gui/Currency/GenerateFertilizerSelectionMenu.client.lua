local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)

local Remotes = ReplicatedStorage.Remotes
local player = game.Players.LocalPlayer
local character = player.CharacterAdded:Wait()

local AnimationHandler = require(player:WaitForChild("PlayerScripts").Gui.Animations.AnimationModule)
local ScalingUI = require(player:WaitForChild("PlayerScripts").Gui.ScalingUI.ScalingUI)

local State = require(ReplicatedStorage.Client.State)

local UI = player.PlayerGui:WaitForChild("FertilizerSelection")
local MainFrame = UI.MainFrame
local CloseButton = MainFrame.CloseFrame.CloseButton
local InventoryFrame = MainFrame.InventoryFrame
local ScrollingFrame = InventoryFrame.ScrollingFrame
local SelectedFrame = MainFrame.SelectedFrame
local StatsFrame = SelectedFrame.Stats
local PlantButton = StatsFrame.PlantButton
local Template = InventoryFrame.Template

local Fertilizers = State.GetData().Fertilizers

local Fertilizer
local PlotID
local AnimPart

local AMOUNT = "Amount: REPLACE"
local NAME = "Name: REPLACE"
local ORIGINAL_SIZE_OF_CLOSEBUTTON = CloseButton.Size
local ORIGINAL_SIZE_OF_PLANTBUTTON = PlantButton.Size
local crouchAnimID = "rbxassetid://13248889864"

local function LoadStats(fertilizer)
	StatsFrame.Description.IconDescription.Text = fertilizer.Description 
	StatsFrame.IconName.Text = AMOUNT:gsub("REPLACE", fertilizer.Name) 
	StatsFrame.IconAmount.Text = NAME:gsub("REPLACE", fertilizer.Amount) 
	Fertilizer = fertilizer
end

local function CreateFertilizerIcon(fertilizer)
	local seedIcon = Template:Clone()
	seedIcon.Visible = true 
	seedIcon.Parent = ScrollingFrame
	seedIcon.ItemName.Text = fertilizer.Name
	seedIcon.Name = fertilizer.Name
	
	seedIcon.MouseButton1Down:Connect(function()
		LoadStats(fertilizer)
	end)	
end

local function UpdateFertilizerIcons(plotReceived: string, animationPositionPart)
	PlotID = plotReceived
	AnimPart = animationPositionPart

	Fertilizers = State.GetData().Fertilizers

	for _, icon in ScrollingFrame:GetChildren() do
		if icon.Name == "UIGridLayout" then continue end  
		--icon.Amount.Text = Fertilizers[icon.Name].Amount		
		if Fertilizers[icon.Name].Amount <= 0 then
			icon.Visible = false
		else 
			icon.Visible = true
		end	
	end
	UI.Enabled = true
end

local function GenerateSelectableSeeds()
	for _, fertilizer in (Fertilizers) do
		CreateFertilizerIcon(fertilizer)
	end
end

GenerateSelectableSeeds()

local function FertilizePlot()
	Remotes.UpdateOwnedFertilizers:FireServer(-1, Fertilizer.Name)
	Remotes.FertilizeTree:FireServer(PlotID, Fertilizer.Cycles)
end

PlantButton.MouseButton1Down:Connect(function()
	UI.Enabled = false
	FertilizePlot() 	
	AnimationHandler.PlayAnimation(player, character, crouchAnimID)
	local fertilizingSound = AnimPart.WateringSound
	fertilizingSound:Play()
end)

PlantButton.MouseEnter:Connect(function()
	PlantButton.Size = ScalingUI.IncreaseBy2Point5Percent(ORIGINAL_SIZE_OF_PLANTBUTTON)
end)

PlantButton.MouseLeave:Connect(function()
	PlantButton.Size = ORIGINAL_SIZE_OF_PLANTBUTTON
end)

CloseButton.MouseButton1Down:Connect(function()
	UI.Enabled = false 
	PlayerMovement:Movement(player, true)
end)

CloseButton.MouseEnter:Connect(function()
	CloseButton.Size = ScalingUI.IncreaseBy10Percent(ORIGINAL_SIZE_OF_CLOSEBUTTON)
end)

CloseButton.MouseLeave:Connect(function()
	CloseButton.Size = ORIGINAL_SIZE_OF_CLOSEBUTTON
end)

Remotes.Bindables.SelectFertilizer.Event:Connect(UpdateFertilizerIcons)