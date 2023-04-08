local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes
local player = game.Players.LocalPlayer

local StateManager = require(ReplicatedStorage.Client.State)
local UI = player.PlayerGui:WaitForChild("PlotStats")
local Template = UI.Template


local mud 

local Plots = {
	"Plot_1", 
	"Plot_2"
}

local function plantSeed(plotId, mudPosition)
	print(plotId)
	if not StateManager.GetData().Plots[plotId].Occupied then 
		Remotes.Bindables.SelectSeed:Fire(plotId, mudPosition)
		--Remotes.UpdateSeeds:FireServer(-1)
		--Remotes.UpdateOccupied:FireServer(plotId, true)
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

local function generateUIs()
	if StateManager.GetData().IsOwner then 
		for number, plot in (Plots) do
			local Plot = Remotes.AskUIInformation:InvokeServer(plot, "plot")
			local Buttons = Template:Clone()
			Buttons.Parent = UI.PlotInteractive
			Buttons.Name = number
			Buttons.Enabled = true 
			for _, item in pairs(Plot:GetChildren()) do
				if item.Name == "Mud" then
					mud = item
				end
			end
			Buttons.Adornee = mud
			local mudPosition = mud.Position
			
			Buttons.Holder.SeedButton.MouseButton1Down:Connect(function()
				plantSeed(number, mudPosition)
			end)
			Buttons.Holder.WaterButton.MouseButton1Down:Connect(function()
				waterTree(number)
			end)
			Buttons.Holder.CollectButton.MouseButton1Down:Connect(function()
				collectMoney(number)
			end)
			Buttons.Holder.FertilizerButton.MouseButton1Down:Connect(function()
				-- DO nothing for now 
			end)
		end

	end
end

Remotes.EstablishPlotsUI.OnClientEvent:Connect(generateUIs)
