local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer
local Remotes = ReplicatedStorage.Remotes

local State = require(ReplicatedStorage.Client.State)
local FormatTime = require(ReplicatedStorage.Libs.FormatTime)

local PlotsGUI = player.PlayerGui:WaitForChild("Plots_Stats")
local MainFrame = PlotsGUI.MainFrame

local InventoryButton = player.PlayerGui:WaitForChild("InventoryButton")

local TreeButton = InventoryButton.Frame.Plots

local CloseButton = MainFrame.CloseFrame.CloseButton
local SelectedFrame = MainFrame.SelectedFrame
local StatsFrame = SelectedFrame.Stats
local DeleteButton = StatsFrame.DeleteButton
local InventoryFrame = MainFrame.InventoryFrame
local ScrollingFrame = InventoryFrame.ScrollingFrame
local Template = InventoryFrame.Template

local TIMER = "Time:  XYZ"
local LEVEL = "Level: AMOUNT"
local CYCLE = "Cycle: AMOUNT"

local LoadedIcon
local PreviousIcon

local function UpdateMoneyTimer(plotIcon)
    local currentPlot = State.GetData().Plots[plotIcon.Name]
    if currentPlot.Occupied then 
        local endTime = currentPlot.Tree.TimeUntilMoney
        if (endTime - os.time()) > 0 then 
            StatsFrame.TimeUntilMoney.Text = TIMER:gsub("XYZ", FormatTime.convertToHMS(endTime - os.time()))
        else
            StatsFrame.TimeUntilMoney.Text = TIMER:gsub("XYZ", "Ready To Collect")
            return true
        end
    end
end

local function UpdateWaterTimer(plotIcon)
    local currentPlot = State.GetData().Plots[plotIcon.Name]
    if currentPlot.Occupied then 
        local endTime = currentPlot.Tree.TimeUntilWater
        if (endTime - os.time()) > 0 then 
            StatsFrame.TimeUntilWater.Text = TIMER:gsub("XYZ", FormatTime.convertToHMS(endTime - os.time()))
        else
            StatsFrame.TimeUntilWater.Text = TIMER:gsub("XYZ", "Water Me!")
            return true
        end
    end
end

local function UpdateTimers(plot)
    task.spawn(function()
        repeat
            local updateMoney = UpdateMoneyTimer(LoadedIcon)
            local updateWater = UpdateWaterTimer(LoadedIcon)
            print("Repeating")

            if updateMoney and updateWater then break end
            if LoadedIcon.Name ~= plot.Id then break end 
            if PlotsGUI.Enabled == false then break end 

        until not task.wait(1) 
        return
    end)
end 

local function HideStats()
    SelectedFrame.Stats.Visible = false
    SelectedFrame.Plot_ID.Visible = false
    PreviousIcon = nil 
end 

local function ShowStats()
    SelectedFrame.Stats.Visible = true
    SelectedFrame.Plot_ID.Visible = true
end

local function DeleteTree(plot)
    Remotes.DeleteTree:FireServer(plot)
end

local function LoadStats(plot)
    SelectedFrame.Plot_ID.Text = plot.Id
    StatsFrame.IconTreeName.Text = plot.Tree.Name

    StatsFrame.IconLevel.Text = LEVEL:gsub("AMOUNT", plot.Tree.CurrentLevel)
    StatsFrame.IconCycle.Text = CYCLE:gsub("AMOUNT", plot.Tree.CurrentCycle.." / "..plot.Tree.MaxCycle)
    ShowStats()

    if PreviousIcon then 
        if LoadedIcon.Name == PreviousIcon.Name then return end 
        UpdateTimers(plot)
        return
    end 

    UpdateTimers(plot)
end

local function CreateIcon(plot)
    local plotIcon = Template:Clone()
    plotIcon.Parent = ScrollingFrame
    plotIcon.Visible = true 
    plotIcon.Name = plot.Id


    ShowStats()

    if PreviousIcon then 
        if LoadedIcon.Name == PreviousIcon.Name then return end 
        UpdateTimers(plot)
    end 

    UpdateTimers(plot)
end

local function CreateIcon(plot)
    local plotIcon = Template:Clone()
    plotIcon.Parent = ScrollingFrame
    plotIcon.Visible = true 
    plotIcon.Name = plot.Id
    plotIcon:WaitForChild("ItemName").Text = plot.Id 
    plotIcon.MouseButton1Down:Connect(function()
        LoadedIcon = plotIcon
        LoadStats(plot)
        PreviousIcon = LoadedIcon
    end)
    plotIcon.DeleteButton.MouseButton1Down:Connect(function()
        DeleteTree(plot.Id)
    end)
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
    HideStats()
end

GeneratePlotsUI()

local function UpdateLevelLabel(plotIconID)
    local plotIcon = ScrollingFrame[plotIconID]
    local currentPlot = State.GetData().Plots[plotIcon.Name]

    StatsFrame.IconLevel.Text = LEVEL:gsub("AMOUNT", currentPlot.Tree.CurrentLevel)
end

local function UpdateCycleLabel(plotIconID)
    local plotIcon = ScrollingFrame[plotIconID]
    local currentPlot = State.GetData().Plots[plotIcon.Name]

    StatsFrame.IconCycle.Text = CYCLE:gsub("AMOUNT", currentPlot.Tree.CurrentCycle .. " / " .. currentPlot.Tree.MaxCycle) 
end

TreeButton.MouseButton1Down:Connect(function()
    PlotsGUI.Enabled = not PlotsGUI.Enabled
    ClearPlotIcons()
    GeneratePlotsUI()
end)

CloseButton.MouseButton1Down:Connect(function()
    PlotsGUI.Enabled = false
    ClearPlotIcons()
    GeneratePlotsUI()
end)

DeleteButton.MouseButton1Down:Connect(function()
    DeleteTree(LoadedIcon.Name)
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

Remotes.DeleteTree.OnClientEvent:Connect(function()
    ClearPlotIcons()
    task.delay(0, GeneratePlotsUI)
end)

Remotes.Bindables.OnReset.GenerateOwnedPlots.Event:Connect(function()
    ClearPlotIcons()
    task.delay(0, GeneratePlotsUI)
end)


