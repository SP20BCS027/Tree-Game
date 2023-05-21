local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes
local player = game.Players.LocalPlayer
local character = player.CharacterAdded:Wait()

local AnimationHandler = require(player:WaitForChild("PlayerScripts").Gui.Animations.AnimationModule)
local PlayerMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)

local StateManager = require(ReplicatedStorage.Client.State)
local UI = player.PlayerGui:WaitForChild("PlotStats")
local Template = UI.Template

local VERTICAL_OFFSET = Vector3.new(0, 3, 0)
local crouchAnimID = "rbxassetid://13248889864"

local function changeCharacterPosition(position)
	character:WaitForChild("HumanoidRootPart").CFrame = position + VERTICAL_OFFSET
end

local function plantSeed(plotId, mudPosition, animationPositionPart)
	if not StateManager.GetData().Plots[plotId].Occupied then 
		Remotes.Bindables.SelectSeed:Fire(plotId, mudPosition, animationPositionPart)
		changeCharacterPosition(animationPositionPart.CFrame)
		PlayerMovement:Movement(player, false)
		
		print("Seed Planted")
	else
		print("This plot is occupied!")
	end
end

<<<<<<< Updated upstream
local function waterTree(plotId, animationPositionPart)
	if StateManager.GetData().Plots[plotId].Occupied and StateManager.GetData().Plots[plotId].Tree then
		if StateManager.GetData().Plots[plotId].Tree.TimeUntilWater < os.time() and StateManager.GetData().Water > 0 then
=======
-- This function when called Waters the tree in the selected Plot and renders the player motionless until the animation is complete 

local function WaterTree(plotId, animationPositionPart)
	if State.GetData().Plots[plotId].Occupied and State.GetData().Plots[plotId].Tree then
		if State.GetData().Plots[plotId].Tree.TimeUntilWater < os.time() and State.GetData().Water > 0 then
			
>>>>>>> Stashed changes
			Remotes.UpdateTreeWaterTimer:FireServer(plotId)

			changeCharacterPosition(animationPositionPart.CFrame)
			PlayerMovement:Movement(player, false)
			AnimationHandler.playAnimation(player, character, crouchAnimID)

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

<<<<<<< Updated upstream
local function collectMoney(plotId, animationPositionPart)
	if StateManager.GetData().Plots[plotId].Occupied and StateManager.GetData().Plots[plotId].Tree then
		if StateManager.GetData().Plots[plotId].Tree.TimeUntilMoney < os.time()  then
			Remotes.UpdateTreeMoneyTimer:FireServer(plotId)
			changeCharacterPosition(animationPositionPart.CFrame)
			PlayerMovement:Movement(player, false)
			AnimationHandler.playAnimation(player, character, crouchAnimID)
			local collectingSound = animationPositionPart.WateringSound
			collectingSound:Play()
			print("Money has been collected")
		else
			print("No money to be collected!")
		end
	else
=======
-- This function when called collects the money from the tree in the Current Plot and renders the player motionless until the animation is complete 

local function CollectMoney(plotId, animationPositionPart)
	if not State.GetData().Plots[plotId].Occupied and not State.GetData().Plots[plotId].Tree then
>>>>>>> Stashed changes
		print("The plot is unoccupied or the tree does not exist")
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
	else
		print("Harvest is not Ready!")
	end
end

local function fertilizePlot(plotId, animationPositionPart)
	if not StateManager.GetData().Plots[plotId].Occupied then return end
	if not StateManager.GetData().Plots[plotId].Tree then return end 
	Remotes.Bindables.SelectFertilizer:Fire(plotId, animationPositionPart)
	PlayerMovement:Movement(player, false)
	changeCharacterPosition(animationPositionPart.CFrame)
	print("Fertilized")
end 

local function generateUIs()
	for name, _ in (StateManager.GetData().Plots) do
		local Plot = Remotes.AskUIInformation:InvokeServer(name)
		local Buttons = Template:Clone()
		Buttons.Parent = UI.PlotInteractive
		Buttons.Name = name
		Buttons.Enabled = true 
		
		local mud = Plot["Mud"]
		local animationPosition = Plot["AnimationPosition"]
		
		Buttons.Adornee = mud
		
		Buttons.Holder.SeedButton.MouseButton1Down:Connect(function()
			plantSeed(name, mud.Position, animationPosition)
		end)
		Buttons.Holder.WaterButton.MouseButton1Down:Connect(function()
			waterTree(name, animationPosition)
		end)
		Buttons.Holder.CollectButton.MouseButton1Down:Connect(function()
			collectMoney(name, animationPosition)
		end)
		Buttons.Holder.FertilizerButton.MouseButton1Down:Connect(function()
			fertilizePlot(name, animationPosition) 
		end)
	end
end

local function clearUIs()
	UI.PlotInteractive:ClearAllChildren()
end

Remotes.EstablishPlotsUI.OnClientEvent:Connect(generateUIs)
Remotes.UpdateOwnedPlots.OnClientEvent:Connect(function()
	clearUIs()
	task.delay(0, function()
		generateUIs()
	end)
end)
