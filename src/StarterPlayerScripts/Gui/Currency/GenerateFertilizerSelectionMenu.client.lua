local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes
local player = game.Players.LocalPlayer

local StateManager = require(ReplicatedStorage.Client.State)
local UI = player.PlayerGui:WaitForChild("FertilizerSelection")
local closeButton = UI.CloseFrame.CloseButton
local MainFrame = UI.MainFrame
local InternalFrame = MainFrame.InternalFrame
local scrollingFrame = InternalFrame.ScrollingFrame
local InformationFrame = InternalFrame.InformationFrame.Frame
local template = scrollingFrame.Template

local Fertilizers = StateManager.GetData().Fertilizers

local Fertilizer
local plotId

local function loadStats(fertilizer)
	InformationFrame.SeedDescription.Text = fertilizer.Description 
	Fertilizer = fertilizer
end

local function createFertilizerIcon(fertilizer)
	local seedIcon = template:Clone()
	seedIcon.Visible = true 
	seedIcon.Parent = scrollingFrame.IconsFolder
	seedIcon.Label.Text = fertilizer.Name
	seedIcon.Name = fertilizer.Name
	
	seedIcon.TextButton.MouseButton1Down:Connect(function()
		loadStats(fertilizer)
	end)	
end

local function updateFertilizerIcons(plotIdrcv)
	plotId = plotIdrcv
	for _, Icon in scrollingFrame.IconsFolder:GetChildren() do
		if Icon.Name == "UIGridLayout" then continue end  
		Icon.Amount.Text = Fertilizers[Icon.Name].Amount		
		if Fertilizers[Icon.Name].Amount <= 0 then
			Icon.Visible = false
		else 
			Icon.Visible = true
		end	
	end
	UI.Enabled = true
end

local function generateSelectableSeeds()
	for _, fertilizer in (Fertilizers) do
		createFertilizerIcon(fertilizer)
	end
end

generateSelectableSeeds()

local function fertilizePlot()
	Remotes.UpdateOwnedFertilizers:FireServer(-1, Fertilizer.Name)
	Remotes.FertilizeTree:FireServer(plotId, Fertilizer.Cycles)
end

InformationFrame.PlantButton.MouseButton1Down:Connect(function()
	UI.Enabled = false
	fertilizePlot() 	
end)

closeButton.MouseButton1Down:Connect(function()
	UI.Enabled = false 
end)

Remotes.Bindables.SelectFertilizer.Event:Connect(updateFertilizerIcons)