local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes
local player = game.Players.LocalPlayer
local character = player.CharacterAdded:Wait()

local AnimationHandler = require(player:WaitForChild("PlayerScripts").Gui.Animations.AnimationModule)
local PlayerMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)
local SoundsManager = require(player:WaitForChild("PlayerScripts").Gui.Sounds.SoundsManager)

local State = require(ReplicatedStorage.Client.State)
local PlotStatsUI = player.PlayerGui:WaitForChild("PlotStats")
local Template = PlotStatsUI.Template

local VERTICAL_OFFSET = Vector3.new(0, 3, 0)
local crouchAnimID = "rbxassetid://13248889864"

-- Function to change the character's position
local function ChangeCharacterPosition(position)
	character:WaitForChild("HumanoidRootPart").CFrame = position + VERTICAL_OFFSET
end

-- Function to plant a seed in a plot, disabling player movement during the animation
local function PlantSeed(plotId: string, mudPosition: Vector3, animationPositionPart: Part)
	if State.GetData().Plots[plotId].Tree == nil  then 
		Remotes.Bindables.SelectSeed:Fire(plotId, mudPosition, animationPositionPart)
		ChangeCharacterPosition(animationPositionPart.CFrame)
		PlayerMovement:Movement(player, false)
		SoundsManager.PlayPressSound()
	else
		SoundsManager.PlayDenialSound()
		print("This plot is occupied!")
	end
end

-- Function to water a tree in the selected plot and render the player motionless until the animation is complete
local function WaterTree(plotId, animationPositionPart)
	if State.GetData().Plots[plotId].Tree ~= nil then
		if State.GetData().Plots[plotId].Tree.TimeUntilWater < os.time() and State.GetData().Water > 0 then
			Remotes.UpdateTreeWaterTimer:FireServer(plotId)

			ChangeCharacterPosition(animationPositionPart.CFrame)
			PlayerMovement:Movement(player, false)
			AnimationHandler.PlayAnimation(player, character, crouchAnimID)

			local wateringSound = animationPositionPart.WateringSound
			wateringSound:Play()
			print("Tree has been watered!")
			SoundsManager.PlayPressSound()
		else
			print("The Tree is already watered or You have no water!")
			SoundsManager.PlayDenialSound()
		end
	else
		print("There is no Tree in the Plot")
		SoundsManager.PlayDenialSound()
	end
end

-- Function to collect money from the tree in the current plot and render the player motionless until the animation is complete
local function CollectMoney(plotId, animationPositionPart)
	if State.GetData().Plots[plotId].Tree == nil then
		print("There is no Tree in this Plot")
		return
	end
	if State.GetData().EquippedBackpack.Capacity <= State.GetData().Money then 
		print("Backpack is Full!")
		return
	end
	if State.GetData().Plots[plotId].Tree.TimeUntilMoney < os.time() then
		Remotes.UpdateAchievements:FireServer("MoneyEarned", plotId)
		Remotes.UpdateTreeMoneyTimer:FireServer(plotId)

		ChangeCharacterPosition(animationPositionPart.CFrame)
		PlayerMovement:Movement(player, false)
		AnimationHandler.PlayAnimation(player, character, crouchAnimID)
		local collectingSound = animationPositionPart.WateringSound
		collectingSound:Play()
		print("Money has been collected")
		SoundsManager.PlayPressSound()
	else
		print("Harvest is not Ready!")
		SoundsManager.PlayDenialSound()
	end
end

-- Function to open the fertilization selection menu and fertilize the plot
local function FertilizePlot(plotId, animationPositionPart)
	if State.GetData().Plots[plotId].Tree == nil then return end 
	Remotes.Bindables.SelectFertilizer:Fire(plotId, animationPositionPart)
	PlayerMovement:Movement(player, false)
	ChangeCharacterPosition(animationPositionPart.CFrame)
end 

-- Function to generate UIs for each plot the player owns and adornee them to the respective plots
local function GenerateUIs()
	for name, _ in (State.GetData().Plots) do
		local Plot = Remotes.AskUIInformation:InvokeServer(name)
		if not Plot then return end
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

-- Function to clear all UIs from the plots
local function ClearUIs()
	PlotStatsUI.PlotInteractive:ClearAllChildren()
end

Remotes.EstablishPlotsUI.OnClientEvent:Connect(GenerateUIs)
Remotes.ResetData.OnClientEvent:Connect(function()
	ClearUIs()
	task.delay(0, function()
		GenerateUIs()
	end)
end)
Remotes.UpdateOwnedPlots.OnClientEvent:Connect(function()
	ClearUIs()
	task.delay(0, function()
		GenerateUIs()
	end)
end)
