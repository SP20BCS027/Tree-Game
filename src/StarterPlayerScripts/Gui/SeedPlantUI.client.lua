local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes
local player = game.Players.LocalPlayer

local StateManager = require(ReplicatedStorage.Client.State)
local UI = player.PlayerGui:WaitForChild("PlotStats")
local Template = UI.Template

local mud 


local function plantSeed(plotId, mudPosition)
	if not StateManager.GetData().Plots[plotId].Occupied then 
		Remotes.Bindables.SelectSeed:Fire(plotId, mudPosition)
	else
		print("This plot is occupied!")
	end
end

local function waterTree(plotId)
	if StateManager.GetData().Plots[plotId].Occupied and StateManager.GetData().Plots[plotId].Tree then
		if StateManager.GetData().Plots[plotId].Tree.TimeUntilWater < os.time() and StateManager.GetData().Water > 0 then
			Remotes.UpdateTreeWaterTimer:FireServer(plotId)
			Remotes.UpdateTreeLevel:FireServer(plotId)
			Remotes.UpdateWater:FireServer()
			print("Tree has been watered!")
		else
			print("The Tree is already watered or You have no water!")
		end
	else
		print("The plot is unoccupied or the tree does not exist")
	end
end

local function collectMoney(plotId)
	if StateManager.GetData().Plots[plotId].Occupied and StateManager.GetData().Plots[plotId].Tree then
		if StateManager.GetData().Plots[plotId].Tree.TimeUntilMoney < os.time()  then
			Remotes.UpdateTreeMoneyTimer:FireServer(plotId)
			print("Money has been collected")
		else
			print("No money to be collected!")
		end
	else
		print("The plot is unoccupied or the tree does not exist")
	end
end

local function fertilizePlot(plotId)
	if not StateManager.GetData().Plots[plotId].Occupied then return end
	if not StateManager.GetData().Plots[plotId].Tree then return end 
	Remotes.Bindables.SelectFertilizer:Fire(plotId)

end 

local function generateUIs()
	if StateManager.GetData().IsOwner then 
		for name, _ in (StateManager.GetData().Plots) do
			local Plot = Remotes.AskUIInformation:InvokeServer(name)
			local Buttons = Template:Clone()
			Buttons.Parent = UI.PlotInteractive
			Buttons.Name = name
			Buttons.Enabled = true 
			for _, item in pairs(Plot:GetChildren()) do
				if item.Name == "Mud" then
					mud = item
				end
			end
			Buttons.Adornee = mud
			local mudPosition = mud.Position
			
			Buttons.Holder.SeedButton.MouseButton1Down:Connect(function()
				plantSeed(name, mudPosition)
			end)
			Buttons.Holder.WaterButton.MouseButton1Down:Connect(function()
				waterTree(name)
			end)
			Buttons.Holder.CollectButton.MouseButton1Down:Connect(function()
				collectMoney(name)
			end)
			Buttons.Holder.FertilizerButton.MouseButton1Down:Connect(function()
				fertilizePlot(name) 
			end)
		end
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
