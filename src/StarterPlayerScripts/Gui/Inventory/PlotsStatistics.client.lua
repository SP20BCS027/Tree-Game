local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer
local Remotes = ReplicatedStorage.Remotes

local State = require(ReplicatedStorage.Client.State)
local FormatTime = require(ReplicatedStorage.Libs.FormatTime)
local SoundsManager = require(player:WaitForChild("PlayerScripts").Gui.Sounds.SoundsManager)
local ScalingUI = require(player:WaitForChild("PlayerScripts").Gui.ScalingUI.ScalingUI)
local UISettings = require(player:WaitForChild("PlayerScripts").Gui.UISettings.UISettings)

local PlotsGUI = player.PlayerGui:WaitForChild("Plots_Stats")
local MainFrame = PlotsGUI.MainFrame

local InventoryButton = player.PlayerGui:WaitForChild("InventoryButton")

local PlotsButton = InventoryButton.Frame.Plots
local HarvestAlert = PlotsButton.Alerts.HarvestAlert
local WaterAlert = PlotsButton.Alerts.WaterAlert

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

local ORIGINAL_SIZE_OF_CLOSEBUTTON = CloseButton.Size
local ORIGINAL_SIZE_OF_DELETEBUTTON = DeleteButton.Size

local LoadedIcon
local PreviousIcon

local function ToggleHarvestAlertNotification()
    -- Count the number of plots ready for harvest
    local numberOfHarvestReadyPlots = 0
    for _, plot in pairs(State.GetData().Plots) do
        if plot.Tree == nil then continue end
        if plot.Tree.TimeUntilMoney - os.time() <= 0 then
            numberOfHarvestReadyPlots += 1
        end
    end
    -- Toggle the visibility of the harvest alert notification
    HarvestAlert.Visible = false
    if numberOfHarvestReadyPlots > 0 then
        HarvestAlert.Visible = true
    end
end

local function ToggleWaterAlertNotification()
    -- Count the number of plots ready for watering
    local numberOfWaterReadyPlots = 0
    for _, plot in State.GetData().Plots do
        if plot.Tree == nil then continue end
        if plot.Tree.TimeUntilWater - os.time() <= 0 then
            numberOfWaterReadyPlots += 1
        end
    end
    -- Toggle the visibility of the water alert notification
    WaterAlert.Visible = false
    if numberOfWaterReadyPlots > 0 then
        WaterAlert.Visible = true
    end
end

local function UpdateMoneyTimer(plotIcon)
    -- Update the money timer for the specified plot
    local currentPlot = State.GetData().Plots[plotIcon.Name]
    if currentPlot.Tree then
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
    -- Update the water timer for the specified plot
    local currentPlot = State.GetData().Plots[plotIcon.Name]
    if currentPlot.Tree then
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
    -- Update the money and water timers for the given plot
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
    -- Hide the stats section in the selected frame
    SelectedFrame.Stats.Visible = false
    SelectedFrame.Plot_ID.Visible = false
    PreviousIcon = nil
end

local function ShowStats()
    -- Show the stats section in the selected frame
    SelectedFrame.Stats.Visible = true
    SelectedFrame.Plot_ID.Visible = true
end

local function DeleteTree(plot)
    -- Delete the tree associated with the given plot
    Remotes.DeleteTree:FireServer(plot)
end

-- Loads the stats for a plot and updates the UI accordingly
local function LoadStats(plot)
    SelectedFrame.Plot_ID.Image = plot.imageID
    StatsFrame.IconTreeName.Text = plot.Tree.Name


    StatsFrame.IconLevel.Text = LEVEL:gsub("AMOUNT", plot.Tree.CurrentLevel)
    StatsFrame.IconCycle.Text = CYCLE:gsub("AMOUNT", plot.Tree.CurrentCycle .. " / " .. plot.Tree.MaxCycle)

    -- Show the stats section
    ShowStats()

    if PreviousIcon then
        if LoadedIcon.Name == PreviousIcon.Name then return end
        UpdateTimers(plot)
        return
    end

    UpdateTimers(plot)
end

-- Creates a plot icon and sets up its functionality
local function CreateIcon(plot)
    local plotIcon = Template:Clone()
    plotIcon.Parent = ScrollingFrame
    plotIcon.Visible = true
    plotIcon.Name = plot.Id
    plotIcon.ImageLabel.Image = plot.imageID
    plotIcon.LayoutOrder = plot.LayoutOrder
    plotIcon:WaitForChild("ItemName").Text = plot.Id

    -- Display alerts based on the time until money and water
    if plot.Tree.TimeUntilMoney - os.time() <= 0 then
        plotIcon.AlertFrame.WaterAlert.Visible = true
    end
    if plot.Tree.TimeUntilWater - os.time() <= 0 then
        plotIcon.AlertFrame.HarvestAlert.Visible = true
    end

    -- Handle mouse interactions with the plot icon
    plotIcon.MouseButton1Down:Connect(function()
        SoundsManager.PlayPressSound()
        LoadedIcon = plotIcon
        LoadStats(plot)
        PreviousIcon = LoadedIcon
    end)

    -- Handle delete button interactions
    local ORIGINAL_SIZE_OF_PLOTDELETEBUTTON = plotIcon.DeleteButton.Size

    plotIcon.DeleteButton.MouseButton1Down:Connect(function()
        SoundsManager.PlayPressSound()
        DeleteTree(plot.Id)
    end)

    plotIcon.DeleteButton.MouseEnter:Connect(function()
        SoundsManager.PlayEnterSound()
        plotIcon.DeleteButton.Size = ScalingUI.IncreaseBy10Percent(ORIGINAL_SIZE_OF_PLOTDELETEBUTTON)
    end)

    plotIcon.DeleteButton.MouseLeave:Connect(function()
        SoundsManager.PlayLeaveSound()
        plotIcon.DeleteButton.Size = ORIGINAL_SIZE_OF_PLOTDELETEBUTTON
    end)
end

-- Generates the plot icons in the UI based on the data in State
local function GeneratePlotsUI()
    for _, plot in pairs(State.GetData().Plots) do
        if plot.Tree == nil then continue end
        CreateIcon(plot)
    end
end

-- Clears the plot icons from the UI
local function ClearPlotIcons()
    for _, icon in pairs(ScrollingFrame:GetChildren()) do
        if icon.Name == "UIGridLayout" then continue end
        icon:Destroy()
    end
    HideStats()
end

-- Generate the plot icons UI
GeneratePlotsUI()

-- Update the level label for a specific plot icon
local function UpdateLevelLabel(plotIconID)
    local plotIcon = ScrollingFrame[plotIconID]
    local currentPlot = State.GetData().Plots[plotIcon.Name]

    StatsFrame.IconLevel.Text = LEVEL:gsub("AMOUNT", currentPlot.Tree.CurrentLevel)
end
-- Update the cycle label for a specific plot icon
local function UpdateCycleLabel(plotIconID)
    local plotIcon = ScrollingFrame[plotIconID]
    local currentPlot = State.GetData().Plots[plotIcon.Name]

    StatsFrame.IconCycle.Text = CYCLE:gsub("AMOUNT", currentPlot.Tree.CurrentCycle .. " / " .. currentPlot.Tree.MaxCycle)
end

-- Handles the button click event for the "Plots" button
PlotsButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    UISettings.DisableAll("Plots_Stats")
    PlotsGUI.Enabled = not PlotsGUI.Enabled
    ClearPlotIcons()
    GeneratePlotsUI()
end)

-- Handles the button click event for the "Close" button
CloseButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayCloseSound()
    PlotsGUI.Enabled = false
    ClearPlotIcons()
    GeneratePlotsUI()
end)

-- Handles the mouse enter event for the "Close" button
CloseButton.MouseEnter:Connect(function()
    SoundsManager.PlayEnterSound()
    CloseButton.Size = ScalingUI.IncreaseBy10Percent(ORIGINAL_SIZE_OF_CLOSEBUTTON)
end)

-- Handles the mouse leave event for the "Close" button
CloseButton.MouseLeave:Connect(function()
    SoundsManager.PlayLeaveSound()
    CloseButton.Size = ORIGINAL_SIZE_OF_CLOSEBUTTON
end)

-- Handles the button click event for the "Delete" button
DeleteButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    DeleteTree(LoadedIcon.Name)
end)

-- Handles the mouse enter event for the "Delete" button
DeleteButton.MouseEnter:Connect(function()
    SoundsManager.PlayEnterSound()
    DeleteButton.Size = ScalingUI.IncreaseBy2Point5Percent(ORIGINAL_SIZE_OF_DELETEBUTTON)
end)

-- Handles the mouse leave event for the "Delete" button
DeleteButton.MouseLeave:Connect(function()
    SoundsManager.PlayLeaveSound()
    DeleteButton.Size = ORIGINAL_SIZE_OF_DELETEBUTTON
end)

-- Handles the client event for updating the tree level and cycle
Remotes.UpdateTreeLevel.OnClientEvent:Connect(function(plotID: string)
    task.delay(0, function()
        UpdateLevelLabel(plotID)
        UpdateCycleLabel(plotID)
    end)
end)

-- Handles the client event for updating owned plots
Remotes.UpdateOwnedPlots.OnClientEvent:Connect(function()
    -- clearPlotIcons()
    -- task.delay(0, generatePlotsUI)
end)

-- Handles the client event for updating the tree
Remotes.UpdateTree.OnClientEvent:Connect(function()
    ClearPlotIcons()
    task.delay(0, GeneratePlotsUI)
end)

-- Handles the client event for deleting a tree
Remotes.DeleteTree.OnClientEvent:Connect(function()
    ClearPlotIcons()
    task.delay(0, GeneratePlotsUI)
end)

-- Handles the client event for updating the alerts
Remotes.Bindables.UpdateAlert.Event:Connect(function()
    ToggleWaterAlertNotification()
    ToggleHarvestAlertNotification()
    ClearPlotIcons()
    GeneratePlotsUI()
end)

-- Handles the client event for resetting data
Remotes.ResetData.OnClientEvent:Connect(function()
    ClearPlotIcons()
    task.delay(0, GeneratePlotsUI)
end)
