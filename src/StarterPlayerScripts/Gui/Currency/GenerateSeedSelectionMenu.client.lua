local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes
local player = game.Players.LocalPlayer

local StateManager = require(ReplicatedStorage.Client.State)
local UI = player.PlayerGui:WaitForChild("SeedSelection")
local closeButton = UI.CloseFrame.CloseButton
local MainFrame = UI.MainFrame
local InternalFrame = MainFrame.InternalFrame
local scrollingFrame = InternalFrame.ScrollingFrame
local InformationFrame = InternalFrame.InformationFrame.Frame
local template = scrollingFrame.Template

local Seeds = StateManager.GetData().Seeds

local seedthing 
local plotId
local MudPos

local function loadStats(seed)
	InformationFrame.SeedDescription.Text = seed.Description 
	seedthing = seed
end

local function createSeedIcon(seed)
	local seedIcon = template:Clone()
	seedIcon.Visible = true 
	seedIcon.Parent = scrollingFrame.IconsFolder
	seedIcon.Amount.Text = seed.Amount
	seedIcon.Label.Text = seed.Name
	seedIcon.Name = seed.Name
	
	seedIcon.TextButton.MouseButton1Down:Connect(function()
		loadStats(seed)
	end)	
end

local function updateSeedIcons(plotIdrcv, mudPosition)
	plotId = plotIdrcv
	MudPos = mudPosition
	for _, Icon in scrollingFrame.IconsFolder:GetChildren() do

		if Icon.Name == "UIGridLayout" then continue end  

		if Icon.Name == Seeds.Basic.Name then
			Icon.Amount.Text = Seeds.Basic.Amount
		elseif Icon.Name == Seeds.Uncommon.Name then 
			Icon.Amount.Text = Seeds.Uncommon.Amount
		elseif Icon.Name == Seeds.Rare.Name then
			Icon.Amount.Text = Seeds.Rare.Amount
		elseif Icon.Name == Seeds.Legendary.Name then 
			Icon.Amount.Text = Seeds.Legendary.Amount
		elseif Icon.Name == Seeds.Mythical.Name then
			Icon.Amount.Text = Seeds.Mythical.Amount
		end
		
		if Seeds[Icon.Name].Amount <= 0 then
			Icon.Visible = false
		end	
	end
	UI.Enabled = true
end

local function generateSelectableSeeds()
	for _,seed in (Seeds) do
		createSeedIcon(seed)
	end
end

generateSelectableSeeds()

local function plantSeed()
	Remotes.UpdateSeeds:FireServer(-1, seedthing.Name)
	Remotes.UpdateOccupied:FireServer(plotId, true, seedthing.Name, MudPos)
end

InformationFrame.PlantButton.MouseButton1Down:Connect(function()
	UI.Enabled = false
	plantSeed() 	
end)

closeButton.MouseButton1Down:Connect(function()
	UI.Enabled = false 
end)

Remotes.Bindables.SelectSeed.Event:Connect(updateSeedIcons)