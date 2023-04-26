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

local function plantSeed(plotId, mudPosition, animationPosition)
	if not StateManager.GetData().Plots[plotId].Occupied then 
		Remotes.Bindables.SelectSeed:Fire(plotId, mudPosition)
		changeCharacterPosition(animationPosition)
		PlayerMovement:Movement(player, false)
	else
		print("This plot is occupied!")
	end
end

local function waterTree(plotId, animationPosition)
	if StateManager.GetData().Plots[plotId].Occupied and StateManager.GetData().Plots[plotId].Tree then
		if StateManager.GetData().Plots[plotId].Tree.TimeUntilWater < os.time() and StateManager.GetData().Water > 0 then
			Remotes.UpdateTreeWaterTimer:FireServer(plotId)
			Remotes.UpdateTreeLevel:FireServer(plotId)
			Remotes.UpdateWater:FireServer()

			changeCharacterPosition(animationPosition)
			PlayerMovement:Movement(player, false)
			AnimationHandler.playAnimation(player, character, crouchAnimID)

			print("Tree has been watered!")
		else
			print("The Tree is already watered or You have no water!")
		end
	else
		print("The plot is unoccupied or the tree does not exist")
	end
end

local function collectMoney(plotId, animationPosition)
	if StateManager.GetData().Plots[plotId].Occupied and StateManager.GetData().Plots[plotId].Tree then
		if StateManager.GetData().Plots[plotId].Tree.TimeUntilMoney < os.time()  then
			Remotes.UpdateTreeMoneyTimer:FireServer(plotId)
			changeCharacterPosition(animationPosition)
			PlayerMovement:Movement(player, false)
			AnimationHandler.playAnimation(player, character, crouchAnimID)
			print("Money has been collected")
		else
			print("No money to be collected!")
		end
	else
		print("The plot is unoccupied or the tree does not exist")
	end
end

local function fertilizePlot(plotId, animationPosition)
	if not StateManager.GetData().Plots[plotId].Occupied then return end
	if not StateManager.GetData().Plots[plotId].Tree then return end 
	Remotes.Bindables.SelectFertilizer:Fire(plotId)
	PlayerMovement:Movement(player, false)
	changeCharacterPosition(animationPosition)
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
			plantSeed(name, mud.Position, animationPosition.CFrame)
		end)
		Buttons.Holder.WaterButton.MouseButton1Down:Connect(function()
			waterTree(name, animationPosition.CFrame)
		end)
		Buttons.Holder.CollectButton.MouseButton1Down:Connect(function()
			collectMoney(name, animationPosition.CFrame)
		end)
		Buttons.Holder.FertilizerButton.MouseButton1Down:Connect(function()
			fertilizePlot(name, animationPosition.CFrame) 
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
