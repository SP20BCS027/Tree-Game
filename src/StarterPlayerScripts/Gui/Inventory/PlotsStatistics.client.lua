local ReplicatedStorage = game:GetService("ReplicatedStorage")

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
local InformationFrame = InternalFrame.InformationFrame
local ScrollingFrame = InternalFrame.ScrollingFrame
local Template = ScrollingFrame.Template

local TIMER = "Time:  XYZ"
local LEVEL = "Level:  AMOUNT"
local CYCLE = "Cycle:  AMOUNT"

local plotIcons = {}

local function updateMoneyTimer(plotIcon)
    local currentPlot = StateManager.GetData().Plots[tonumber(plotIcon.Name)]
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
    local currentPlot = StateManager.GetData().Plots[tonumber(plotIcon.Name)]
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
    plotIcon.Name = plot["Id"]

    table.insert(plotIcons, plotIcon)

    if plot["Occupied"] then 
        local moneyTime = plot["Tree"].TimeUntilMoney
        local waterTime = plot["Tree"].TimeUntilWater
        plotIcon.MoneyBar.Text = TIMER:gsub("XYZ", FormatTime.convertToHMS(moneyTime - os.time()))
        plotIcon.WaterBar.Text = TIMER:gsub("XYZ", FormatTime.convertToHMS(waterTime - os.time()))
        plotIcon.LevelBar.Text = LEVEL:gsub("AMOUNT", plot["Tree"].CurrentLevel)

        plotIcon.CycleBar.Text = CYCLE:gsub("AMOUNT", plot["Tree"].CurrentCycle.." / "..plot["Tree"].MaxCycle) 
    end
end

local function generatePlotsUI()
    for _, plot in (StateManager.GetData().Plots) do 
        createIcon(plot)
    end
end

generatePlotsUI()

local function updateLevelLabel(plotIconId)
    local plotIcon = plotIcons[plotIconId]
    local currentPlot = StateManager.GetData().Plots[tonumber(plotIcon.Name)]

    plotIcon.LevelBar.Text = LEVEL:gsub("AMOUNT", currentPlot["Tree"].CurrentLevel)
end

local function updateCycleLabel(plotIconId)
    local plotIcon = plotIcons[plotIconId]
    local currentPlot = StateManager.GetData().Plots[tonumber(plotIcon.Name)]

    plotIcon.CycleBar.Text = CYCLE:gsub("AMOUNT", currentPlot["Tree"].CurrentCycle.." / "..currentPlot["Tree"].MaxCycle) 
end

TreeButton.MouseButton1Down:Connect(function()
    PlotsGui.Enabled = not PlotsGui.Enabled
end)

CloseButton.MouseButton1Down:Connect(function()
    PlotsGui.Enabled = false
end)

Remotes.Bindables.UpdateTreeLevel.Event:Connect(updateLevelLabel)
Remotes.Bindables.UpdateTreeCycle.Event:Connect(updateCycleLabel)

while true do 
    for _, plotIcon in (plotIcons) do 
        updateMoneyTimer(plotIcon)
        updateWaterTimer(plotIcon)
    end
    task.wait(1)
end