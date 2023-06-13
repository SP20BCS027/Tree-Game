local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes

local State = require(ReplicatedStorage.Client.State)

-- Wait for 5 seconds before starting the timers
task.wait(5)

-- Tables to keep track of plots where timer checks should be skipped
local DontCheckForWaterTimer = {}
local DontCheckForMoneyTimer = {}

-- Function to check the water timer for a specific plot
local function CheckWaterTimer(plot)
    local currentPlot = State.GetData().Plots[plot]
    if currentPlot.Tree then
        local endTime = currentPlot.Tree.TimeUntilWater
        if (endTime - os.time()) > 0 then
            print("NOT Ready for harvest: " .. plot)
            DontCheckForWaterTimer[plot] = true
            task.delay(endTime - os.time(), function()
                DontCheckForWaterTimer[plot] = nil
            end)
        else
            print("Ready for harvest: " .. plot)
            DontCheckForWaterTimer[plot] = true
            Remotes.Bindables.UpdateAlert:Fire()
        end
    end
    Remotes.Bindables.UpdateAlert:Fire()
end

-- Function to check the money timer for a specific plot
local function CheckMoneyTimer(plot)
    local currentPlot = State.GetData().Plots[plot]
    if currentPlot.Tree then
        local endTime = currentPlot.Tree.TimeUntilMoney
        if (endTime - os.time()) > 0 then
            print("NOT Ready for harvest: " .. plot)
            Remotes.UpdateMoneyObjectsOnTimerExpire:FireServer(plot, 1)
            DontCheckForMoneyTimer[plot] = true
            task.delay(endTime - os.time(), function()
                DontCheckForMoneyTimer[plot] = nil
            end)
        else
            print("Ready for harvest: " .. plot)
            DontCheckForMoneyTimer[plot] = true
            Remotes.Bindables.UpdateAlert:Fire()
            Remotes.UpdateMoneyObjectsOnTimerExpire:FireServer(plot, 0)
        end
    end
end

-- Function to unset the money timer check for a specific plot
local function SetCheckForMoneyTimer(discard, plot)
    if not discard then
        print("Something went wrong")
    end
    DontCheckForMoneyTimer[plot] = nil
    Remotes.Bindables.UpdateAlert:Fire()
end

-- Function to unset the water timer check for a specific plot
local function SetCheckForWaterTimer(discard, plot)
    if not discard then
        print("Something went wrong")
    end
    DontCheckForWaterTimer[plot] = nil
    Remotes.Bindables.UpdateAlert:Fire()
end

-- Function to spawn a task that continuously checks the timers for all plots
local function TimeCheckSpawner()
    task.spawn(function()
        repeat
            for plotID, _ in pairs(State.GetData().Plots) do
                if not DontCheckForMoneyTimer[plotID] then
                    CheckMoneyTimer(plotID)
                end
                if not DontCheckForWaterTimer[plotID] then
                    CheckWaterTimer(plotID)
                end
            end
        until not task.wait(1)
    end)
end

-- Start the timer checks
TimeCheckSpawner()

-- Event handlers for updating money and water timers

Remotes.UpdateTreeMoneyTimer.OnClientEvent:Connect(function(discard, plot)
    task.delay(0, function()
        SetCheckForMoneyTimer(discard, plot)
    end)
end)

Remotes.UpdateTreeWaterTimer.OnClientEvent:Connect(function(discard, plot)
    task.delay(0, function()
        SetCheckForWaterTimer(discard, plot)
    end)
end)

-- Event handler for deleting a tree

Remotes.DeleteTree.OnClientEvent:Connect(function(plotID)
    DontCheckForMoneyTimer[plotID] = nil
    DontCheckForWaterTimer[plotID] = nil
end)
