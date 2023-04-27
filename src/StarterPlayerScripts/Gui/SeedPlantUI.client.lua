local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes
local player = game.Players.LocalPlayer
local character = player.CharacterAdded:Wait()

local AnimationHandler = require(player:WaitForChild("PlayerScripts").Gui.Animations.AnimationModule)
local PlayerMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)

local State = require(ReplicatedStorage.Client.State)
local PlotStatsUI = player.PlayerGui:WaitForChild("PlotStats")
local Template = PlotStatsUI.Template

local VERTICAL_OFFSET = Vector3.new(0, 3, 0)
local crouchAnimID = "rbxassetid://13248889864"

local function ChangeCharacterPosition(position)
	character:WaitForChild("HumanoidRootPart").CFrame = position + VERTICAL_OFFSET
end

local function PlantSeed(plotId, mudPosition, animationPositionPart)
	if not State.GetData().Plots[plotId].Occupied then 
		Remotes.Bindables.SelectSeed:Fire(plotId, mudPosition, animationPositionPart)
		ChangeCharacterPosition(animationPositionPart.CFrame)
		PlayerMovement:Movement(player, false)
		
		print("Seed Planted")
	else
		print("This plot is occupied!")
	end
end

local function WaterTree(plotId, animationPositionPart)
	if State.GetData().Plots[plotId].Occupied and State.GetData().Plots[plotId].Tree then
		if State.GetData().Plots[plotId].Tree.TimeUntilWater < os.time() and State.GetData().Water > 0 then
			Remotes.UpdateTreeWaterTimer:FireServer(plotId)
			Remotes.UpdateTreeLevel:FireServer(plotId)
			Remotes.UpdateWater:FireServer()

			ChangeCharacterPosition(animationPositionPart.CFrame)
			PlayerMovement:Movement(player, false)
			AnimationHandler.PlayAnimation(player, character, crouchAnimID)

			local wateringSound = animationPositionPart.WateringSound
			wateringSound:Play()
			print("Tree has been watered!")
		else
			print("The Tree is already watered or You have no water!")
		end
	else
		print("The plot is unoccupied or the tree does not exist")
	end
end

local function CollectMoney(plotId, animationPositionPart)
	if State.GetData().Plots[plotId].Occupied and State.GetData().Plots[plotId].Tree then
		if State.GetData().Plots[plotId].Tree.TimeUntilMoney < os.time()  then
			Remotes.UpdateTreeMoneyTimer:FireServer(plotId)
			ChangeCharacterPosition(animationPositionPart.CFrame)
			PlayerMovement:Movement(player, false)
			AnimationHandler.PlayAnimation(player, character, crouchAnimID)
			local collectingSound = animationPositionPart.WateringSound
			collectingSound:Play()
			print("Money has been collected")
		else
			print("No money to be collected!")
		end
	else
		print("The plot is unoccupied or the tree does not exist")
	end
end

local function FertilizePlot(plotId, animationPositionPart)
	if not State.GetData().Plots[plotId].Occupied then return end
	if not State.GetData().Plots[plotId].Tree then return end 
	Remotes.Bindables.SelectFertilizer:Fire(plotId, animationPositionPart)
	PlayerMovement:Movement(player, false)
	ChangeCharacterPosition(animationPositionPart.CFrame)
	print("Fertilized")
end 

local function GenerateUIs()
	for name, _ in (State.GetData().Plots) do
		local Plot = Remotes.AskUIInformation:InvokeServer(name)
		local Buttons = Template:Clone()
		Buttons.Parent = PlotStatsUI.PlotInteractive
		Buttons.Name = name
		Buttons.Enabled = true 
		
		local mud = Plot["Mud"]
		local animationPosition = Plot["AnimationPosition"]
		
		Buttons.Adornee = mud
		
		Buttons.Holder.SeedButton.MouseButton1Down:Connect(function()
			PlantSeed(name, mud.Position, animationPosition)
		end)
		Buttons.Holder.WaterButton.MouseButton1Down:Connect(function()
			WaterTree(name, animationPosition)
		end)
		Buttons.Holder.CollectButton.MouseButton1Down:Connect(function()
			CollectMoney(name, animationPosition)
		end)
		Buttons.Holder.FertilizerButton.MouseButton1Down:Connect(function()
			FertilizePlot(name, animationPosition) 
		end)
	end
end

local function ClearUIs()
	PlotStatsUI.PlotInteractive:ClearAllChildren()
end

Remotes.EstablishPlotsUI.OnClientEvent:Connect(GenerateUIs)
Remotes.UpdateOwnedPlots.OnClientEvent:Connect(function()
	ClearUIs()
	task.delay(0, function()
		GenerateUIs()
	end)
end)
