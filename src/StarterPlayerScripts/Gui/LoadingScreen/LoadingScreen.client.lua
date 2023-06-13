local ContentProvider = game:GetService("ContentProvider")
local player = game.Players.LocalPlayer

local Assets = game:GetDescendants()

local LoadingScreenUI = player.PlayerGui:WaitForChild("LoadingScreen")
local LoadingText = LoadingScreenUI.Frame.LoadingText
local SkipButton = LoadingScreenUI.Frame.SkipButton

LoadingScreenUI.Enabled = true

local SKIPPED = false
local TIME_UNTIL_SKIP_BUTTON_VISIBLE = 1

-- Wait until the game finishes loading
repeat task.wait(1) 
until game:IsLoaded()

SkipButton.MouseButton1Down:Connect(function()
    -- Event handler for the skip button to skip the loading process
    LoadingScreenUI.Enabled = false
    SKIPPED = true
end)

task.spawn(function()
    local StartTime = os.time()
    local EndTime = StartTime + TIME_UNTIL_SKIP_BUTTON_VISIBLE

    while task.wait() do 
        -- Display the skip button after a certain time
        if os.time() > EndTime then 
            SkipButton.Visible = true
        end
    end
end)

for i = 1, #Assets do 
    local asset = Assets[i]

    -- Preload the asset asynchronously
    ContentProvider:PreloadAsync({asset})
    LoadingText.Text = "Loading: " .. asset.Name ..  " [" .. i .. "/" .. #Assets .. "]"
    
    if SKIPPED == true then break end
end

LoadingScreenUI.Enabled = false
