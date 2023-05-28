local ContentProvider = game:GetService("ContentProvider")
local player = game.Players.LocalPlayer

local Assets = game:GetDescendants()

local LoadingScreenUI = player.PlayerGui:WaitForChild("LoadingScreen")
local LoadingText = LoadingScreenUI.Frame.LoadingText
local SkipButton = LoadingScreenUI.Frame.SkipButton

LoadingScreenUI.Enabled = true

local SKIPPED = false

repeat task.wait(1) 
until game:IsLoaded()

SkipButton.MouseButton1Down:Connect(function()
    LoadingScreenUI.Enabled = false
end)

task.spawn(function()
    local StartTime = os.time()
    local EndTime = StartTime + 10

    while task.wait() do 
        if os.time() > EndTime then 
            SkipButton.Visible = true
            SKIPPED = true
        end
    end
end)

for i = 1, #Assets do 
    local asset = Assets[i]

    ContentProvider:PreloadAsync({asset})
    LoadingText.Text = "Loading: " .. asset.Name ..  " [" .. i .. "/" .. #Assets .. "]"
    
    if SKIPPED == true then  break end
end

LoadingScreenUI.Enabled = false