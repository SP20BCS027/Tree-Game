local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer
local Remotes = ReplicatedStorage.Remotes

local State = require(ReplicatedStorage.Client.State)
local FormatTime = require(ReplicatedStorage.Libs.FormatTime)

local PlotsGUI = player.PlayerGui:WaitForChild("PlotStatistics")
local InventoryButton = player.PlayerGui:WaitForChild("InventoryButton")

local TreeButton = InventoryButton.Frame.Plots

local CloseButton = PlotsGUI.CloseFrame.CloseButton
local MainFrame = PlotsGUI.MainFrame
local InternalFrame = MainFrame.InternalFrame
local ScrollingFrame = InternalFrame.ScrollingFrame
local Template = InternalFrame.Template

local TIMER = "Time:  XYZ"
local LEVEL = "Level: AMOUNT"
local CYCLE = "Cycle: AMOUNT"


local PlotIcons = {}

local function UpdateMoneyTimer(plotIcon)
    local currentPlot = State.GetData().Plots[plotIcon.Name]
    if currentPlot.Occupied then 
        local endTime = currentPlot.Tree.TimeUntilMoney
        if (endTime - os.time()) > 0 then 
            plotIcon.MoneyBar.Text = TIMER:gsub("XYZ", FormatTime.convertToHMS(endTime - os.time()))
        else
            plotIcon.MoneyBar.Text = TIMER:gsub("XYZ", "Ready To Collect")
        end
    end
end

local function UpdateWaterTimer(plotIcon)
    local currentPlot = State.GetData().Plots[plotIcon.Name]
    if currentPlot.Occupied then 
        local endTime = currentPlot.Tree.TimeUntilWater
        if (endTime - os.time()) > 0 then 
            plotIcon.WaterBar.Text = TIMER:gsub("XYZ", FormatTime.convertToHMS(endTime - os.time()))
        else
            plotIcon.WaterBar.Text = TIMER:gsub("XYZ", "Water Me!")
        end
    end
end

local function CreateIcon(plot)
    local plotIcon = Template:Clone()
    plotIcon.Parent = ScrollingFrame
    plotIcon.Visible = true 
    plotIcon.Name = plot.Id

    PlotIcons[plot.Id] =  plotIcon

    local moneyTime = plot.Tree.TimeUntilMoney
    local waterTime = plot.Tree.TimeUntilWater
    plotIcon.MoneyBar.Text = TIMER:gsub("XYZ", FormatTime.convertToHMS(moneyTime - os.time()))
    plotIcon.WaterBar.Text = TIMER:gsub("XYZ", FormatTime.convertToHMS(waterTime - os.time()))

    plotIcon.LevelBar.Text = LEVEL:gsub("AMOUNT", plot.Tree.CurrentLevel)
    plotIcon.CycleBar.Text = CYCLE:gsub("AMOUNT", plot.Tree.CurrentCycle.." / "..plot.Tree.MaxCycle) 
    

end

local function GeneratePlotsUI()
    for _, plot in (State.GetData().Plots) do 
        if plot.Occupied then 
            CreateIcon(plot)
        end
    end
end

local function ClearPlotIcons()
    for _, icon in pairs (ScrollingFrame:GetChildren()) do 
        if icon.Name == "UIGridLayout" then continue end 
        icon:Destroy()
    end
    table.clear(PlotIcons)
end

GeneratePlotsUI()

local function UpdateLevelLabel(plotIconID)
    local plotIcon = PlotIcons[plotIconID]
    local currentPlot = State.GetData().Plots[plotIcon.Name]

    plotIcon.LevelBar.Text = LEVEL:gsub("AMOUNT", currentPlot.Tree.CurrentLevel)

end

local function UpdateCycleLabel(plotIconId)
    local plotIcon = PlotIcons[plotIconId]
    local currentPlot = State.GetData().Plots[plotIcon.Name]

    plotIcon.CycleBar.Text = CYCLE:gsub("AMOUNT", currentPlot.Tree.CurrentCycle .. " / " .. currentPlot.Tree.MaxCycle) 
end

TreeButton.MouseButton1Down:Connect(function()
    PlotsGUI.Enabled = not PlotsGUI.Enabled
end)

CloseButton.MouseButton1Down:Connect(function()
    PlotsGUI.Enabled = false
end)

Remotes.UpdateTreeLevel.OnClientEvent:Connect(function(prompt: string, plotID: string)
    if prompt == "LEVEL" then 
        task.delay(0, function()
            UpdateLevelLabel(plotID)
        end)
    end
    if prompt == "CYCLE" then 
        task.delay(0, function()
            UpdateCycleLabel(plotID)
        end)
    end
end)

Remotes.UpdateOwnedPlots.OnClientEvent:Connect(function()
    --clearPlotIcons()
    --task.delay(0, generatePlotsUI)
end)
Remotes.UpdateOccupied.OnClientEvent:Connect(function()
    ClearPlotIcons()
    task.delay(0, GeneratePlotsUI)
end)

Remotes.Bindables.OnReset.GenerateOwnedPlots.Event:Connect(function()
    ClearPlotIcons()
    task.delay(0, GeneratePlotsUI)
end)

task.spawn(function()
	while task.wait(1) do 
		for _, plotIcon in (PlotIcons) do 
			UpdateMoneyTimer(plotIcon)
			UpdateWaterTimer(plotIcon)
		end
	end
end)
