local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- local ServerScriptService = game:GetService("ServerScriptService")

-- local player = game.Players.LocalPlayer
local Remotes = ReplicatedStorage.Remotes

local State = require(ReplicatedStorage.Client.State)
task.wait(5)

local DontCheckForWaterTimer = {}
local DontCheckForMoneyTimer = {}

local function CheckWaterTimer(plot: string) 
    local currentPlot = State.GetData().Plots[plot]
    if currentPlot.Tree then 
        local endTime = currentPlot.Tree.TimeUntilWater
        if (endTime - os.time()) > 0 then
            print("NOT Ready for harvest" .. plot)
            DontCheckForWaterTimer[plot] = true
            task.delay(endTime - os.time(), function()
                DontCheckForWaterTimer[plot] = nil
            end)
        else
            print("Ready for harvest" .. plot)
            DontCheckForWaterTimer[plot] = true
            Remotes.Bindables.UpdateAlert:Fire()
        end
    end
end

local function CheckMoneyTimer(plot: string) 
    local currentPlot = State.GetData().Plots[plot]
    if currentPlot.Tree then 
        local endTime = currentPlot.Tree.TimeUntilMoney
        if (endTime - os.time()) > 0 then
            print("NOT Ready for harvest" .. plot)
            Remotes.UpdateMoneyObjectsOnTimerExpire:FireServer(plot, 1)
            DontCheckForMoneyTimer[plot] = true
            task.delay(endTime - os.time(), function()
                DontCheckForMoneyTimer[plot] = nil
            end)
        else
            print("Ready for harvest" .. plot)
            DontCheckForMoneyTimer[plot] = true
            Remotes.Bindables.UpdateAlert:Fire()
            Remotes.UpdateMoneyObjectsOnTimerExpire:FireServer(plot, 0)
        end
    end
end

local function SetCheckForMoneyTimer(discard: number, plot: string)
    if not discard then 
        print("Wowie something went wrong")
    end
    DontCheckForMoneyTimer[plot] = nil
    Remotes.Bindables.UpdateAlert:Fire()
end

local function SetCheckForWaterTimer(discard: number, plot: string)
    if not discard then 
        print("Wowie something went wrong")
    end
    DontCheckForWaterTimer[plot] = nil
    Remotes.Bindables.UpdateAlert:Fire()
end

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

TimeCheckSpawner()

Remotes.UpdateTreeMoneyTimer.OnClientEvent:Connect(function(discard: number, plot: string)
    task.delay(0, function()
        SetCheckForMoneyTimer(discard, plot)
    end)
end)

Remotes.UpdateTreeWaterTimer.OnClientEvent:Connect(function(discard: number, plot: string)
    task.delay(0, function()
        SetCheckForWaterTimer(discard, plot)
    end)
end)

