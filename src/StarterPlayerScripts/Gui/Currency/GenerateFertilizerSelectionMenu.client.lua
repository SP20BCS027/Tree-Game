local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)

local Remotes = ReplicatedStorage.Remotes
local player = game.Players.LocalPlayer
local character = player.CharacterAdded:Wait()

local AnimationHandler = require(player:WaitForChild("PlayerScripts").Gui.Animations.AnimationModule)

local State = require(ReplicatedStorage.Client.State)
local UI = player.PlayerGui:WaitForChild("FertilizerSelection")
local closeButton = UI.CloseFrame.CloseButton
local MainFrame = UI.MainFrame
local InternalFrame = MainFrame.InternalFrame
local scrollingFrame = InternalFrame.ScrollingFrame
local InformationFrame = InternalFrame.InformationFrame.Frame
local template = scrollingFrame.Template

local Fertilizers = State.GetData().Fertilizers

local Fertilizer
local PlotID
local AnimPart

local crouchAnimID = "rbxassetid://13248889864"

local function LoadStats(fertilizer)
	InformationFrame.SeedDescription.Text = fertilizer.Description 
	Fertilizer = fertilizer
end

local function CreateFertilizerIcon(fertilizer)
	local seedIcon = template:Clone()
	seedIcon.Visible = true 
	seedIcon.Parent = scrollingFrame.IconsFolder
	seedIcon.Label.Text = fertilizer.Name
	seedIcon.Name = fertilizer.Name
	
	seedIcon.TextButton.MouseButton1Down:Connect(function()
		LoadStats(fertilizer)
	end)	
end

local function UpdateFertilizerIcons(plotReceived: string, animationPositionPart)
	PlotID = plotReceived
	AnimPart = animationPositionPart
	for _, icon in scrollingFrame.IconsFolder:GetChildren() do
		if icon.Name == "UIGridLayout" then continue end  
		icon.Amount.Text = Fertilizers[icon.Name].Amount		
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

InformationFrame.PlantButton.MouseButton1Down:Connect(function()
	UI.Enabled = false
	FertilizePlot() 	
	AnimationHandler.PlayAnimation(player, character, crouchAnimID)
	local fertilizingSound = AnimPart.WateringSound
	fertilizingSound:Play()
end)

closeButton.MouseButton1Down:Connect(function()
	UI.Enabled = false 
	PlayerMovement:Movement(player, true)
end)

Remotes.Bindables.SelectFertilizer.Event:Connect(UpdateFertilizerIcons)