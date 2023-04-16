local ReplicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")

local player = game.Players.LocalPlayer
local Remotes = ReplicatedStorage.Remotes
local StateManager = require(ReplicatedStorage.Client.State)
local FormatTime = require(ReplicatedStorage.Libs.FormatTime)

local PlotsGui = player.PlayerGui:WaitForChild("PlotStatistics")
local InventoryButtons = player.PlayerGui:WaitForChild("InventoryButtons")

local TreeButton = InventoryButtons.ButtonsHolder.TreeButton.TreeInventoryButton

local CloseButton = PlotsGui.CloseFrame.CloseButton
local MainFrame = PlotsGui.MainFrame
local InternalFrame = MainFrame.InternalFrame
local ScrollingFrame = InternalFrame.ScrollingFrame
local Template = InternalFrame.Template

local TIMER = "Time:  XYZ"

local plotIcons = {}

local function updateMoneyTimer(plotIcon)
    local currentPlot = StateManager.GetData().Plots[plotIcon.Name]
    if currentPlot.Occupied then 
        local endTime = currentPlot.Tree.TimeUntilMoney
        if (endTime - os.time()) > 0 then 
            plotIcon.MoneyBar.Text = TIMER:gsub("XYZ", FormatTime.convertToHMS(endTime - os.time()))
        else
            plotIcon.MoneyBar.Text = TIMER:gsub("XYZ", "Ready To Collect")
        end
    end
end

local function updateWaterTimer(plotIcon)
    local currentPlot = StateManager.GetData().Plots[plotIcon.Name]
    if currentPlot.Occupied then 
        local endTime = currentPlot.Tree.TimeUntilWater
        if (endTime - os.time()) > 0 then 
            plotIcon.WaterBar.Text = TIMER:gsub("XYZ", FormatTime.convertToHMS(endTime - os.time()))
        else
            plotIcon.WaterBar.Text = TIMER:gsub("XYZ", "Water Me!")
        end
    end
end

local function createIcon(plot)
    local plotIcon = Template:Clone()
    plotIcon.Parent = ScrollingFrame
    plotIcon.Visible = true 
    plotIcon.Name = plot.Id

    plotIcons[plot.Id] =  plotIcon

<<<<<<< Updated upstream
    if plot["Occupied"] then 
        local moneyTime = plot["Tree"].TimeUntilMoney
        local waterTime = plot["Tree"].TimeUntilWater
        plotIcon.MoneyBar.Text = TIMER:gsub("XYZ", FormatTime.convertToHMS(moneyTime - os.time()))
        plotIcon.WaterBar.Text = TIMER:gsub("XYZ", FormatTime.convertToHMS(waterTime - os.time()))
    end
=======
    local moneyTime = plot.Tree.TimeUntilMoney
    local waterTime = plot.Tree.TimeUntilWater
    plotIcon.MoneyBar.Text = TIMER:gsub("XYZ", FormatTime.convertToHMS(moneyTime - os.time()))
    plotIcon.WaterBar.Text = TIMER:gsub("XYZ", FormatTime.convertToHMS(waterTime - os.time()))
    plotIcon.LevelBar.Text = LEVEL:gsub("AMOUNT", plot.Tree.CurrentLevel)

    plotIcon.CycleBar.Text = CYCLE:gsub("AMOUNT", plot.Tree.CurrentCycle.." / "..plot.Tree.MaxCycle) 
    
>>>>>>> Stashed changes
end

local function generatePlotsUI()
    for _, plot in (StateManager.GetData().Plots) do 
        if plot.Occupied then 
            createIcon(plot)
        end
    end
end

local function clearPlotIcons()
    for _, icon in pairs (ScrollingFrame:GetChildren()) do 
        if icon.Name == "UIGridLayout" then continue end 
        icon:Destroy()
    end
    table.clear(plotIcons)
end

generatePlotsUI()

<<<<<<< Updated upstream
=======
local function updateLevelLabel(plotIconId)
    local plotIcon = plotIcons[plotIconId]
    local currentPlot = StateManager.GetData().Plots[plotIcon.Name]

    plotIcon.LevelBar.Text = LEVEL:gsub("AMOUNT", currentPlot["Tree"].CurrentLevel)
end

local function updateCycleLabel(plotIconId)
    local plotIcon = plotIcons[plotIconId]
    local currentPlot = StateManager.GetData().Plots[plotIcon.Name]

    plotIcon.CycleBar.Text = CYCLE:gsub("AMOUNT", currentPlot["Tree"].CurrentCycle.." / "..currentPlot["Tree"].MaxCycle) 
end

>>>>>>> Stashed changes
TreeButton.MouseButton1Down:Connect(function()
    PlotsGui.Enabled = not PlotsGui.Enabled
end)

CloseButton.MouseButton1Down:Connect(function()
    PlotsGui.Enabled = false
end)

<<<<<<< Updated upstream
while true do 
    for _, plotIcon in (plotIcons) do 
        updateMoneyTimer(plotIcon)
        updateWaterTimer(plotIcon)
    end
    task.wait(1)
end
=======
Remotes.Bindables.UpdateTreeLevel.Event:Connect(function(plotIconId)
    task.delay(1, function()
        updateLevelLabel(plotIconId)
    end)
end)
Remotes.Bindables.UpdateTreeCycle.Event:Connect(function(plotIconId)
    task.delay(1, function()
        updateCycleLabel(plotIconId)
    end)
end)
Remotes.UpdateOwnedPlots.OnClientEvent:Connect(function()
    --clearPlotIcons()
    task.delay(0, generatePlotsUI)
end)
Remotes.UpdateOccupied.OnClientEvent:Connect(function()
    clearPlotIcons()
    task.delay(0, generatePlotsUI)
end)


task.spawn(function()
	while task.wait(1) do 
		for _, plotIcon in (plotIcons) do 
			updateMoneyTimer(plotIcon)
			updateWaterTimer(plotIcon)
		end
	end
end)
>>>>>>> Stashed changes
