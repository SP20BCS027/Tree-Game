local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer

local Remotes = ReplicatedStorage.Remotes

local State = require(ReplicatedStorage.Client.State)

local SoundsManager = require(player:WaitForChild("PlayerScripts").Gui.Sounds.SoundsManager)
local UISettings = require(player:WaitForChild("PlayerScripts").Gui.UISettings.UISettings)

local InventoryButtonUI = player.PlayerGui:WaitForChild("InventoryButton")
local SettingsButton = InventoryButtonUI.Frame.Settings

local SettingsUI = player.PlayerGui:WaitForChild("SettingsTemplate")
local MainFrame = SettingsUI.MainFrame
--local HeadingFrame = MainFrame.HeadingFrame
--local BackgroundFrame = MainFrame.BackgroundFrame 
local CloseFrame = MainFrame.CloseFrame
local CloseButton = CloseFrame.CloseButton
--local HeadingShading = MainFrame.HeadingShading
local InventoryFrame = MainFrame.InventoryFrame
local ScrollingFrame = InventoryFrame.ScrollingFrame

local CROSS_TEXT = "✖️"
local TICK_TEXT = "✔️"  

local TICK_BACKGROUND_COLOR = Color3.fromRGB(85, 188, 105)
local CROSS_BACKGROUND_COLOR = Color3.fromRGB(206, 47, 36)

local TICK_POSITION = UDim2.new(0.55, 0, 0.5, 0)
local CROSS_POSITION = UDim2.new(0.05, 0, 0.5, 0)


local function LinkingClickEvents()
    for _, setting in ScrollingFrame:GetChildren() do 
        if setting.Name == "UIGridLayout" then continue end 
        setting.ToggleFrame.ToggleButton.MouseButton1Down:Connect(function()
            -- Fire some event to the server to update the Client's Data on the server
            Remotes.UpdateSettings:FireServer(setting.Name)
            if not State.GetData().Settings[setting.Name] == true then
                setting.ToggleFrame.ToggleButton.Position = TICK_POSITION
                setting.ToggleFrame.Background.BackgroundColor3 = TICK_BACKGROUND_COLOR
                setting.ToggleFrame.ToggleButton.Text = TICK_TEXT
            else
                setting.ToggleFrame.ToggleButton.Position = CROSS_POSITION
                setting.ToggleFrame.Background.BackgroundColor3 = CROSS_BACKGROUND_COLOR
                setting.ToggleFrame.ToggleButton.Text = CROSS_TEXT
            end
        end)
    end
end

local function UpdateIconStatus()
    for _, setting in ScrollingFrame:GetChildren() do 
        if State.GetData().Settings[setting.Name] == nil then continue end
        
        if State.GetData().Settings[setting.Name] == true then
            setting.ToggleFrame.ToggleButton.Position = TICK_POSITION
            setting.ToggleFrame.Background.BackgroundColor3 = TICK_BACKGROUND_COLOR
            setting.ToggleFrame.ToggleButton.Text = TICK_TEXT
        else
            setting.ToggleFrame.ToggleButton.Position = CROSS_POSITION
            setting.ToggleFrame.Background.BackgroundColor3 = CROSS_BACKGROUND_COLOR
            setting.ToggleFrame.ToggleButton.Text = CROSS_TEXT
        end
    end
end

UpdateIconStatus()
LinkingClickEvents()

CloseButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    SettingsUI.Enabled = false 
end)

SettingsButton.MouseButton1Down:Connect(function()
    SoundsManager.PlayPressSound()
    UISettings.DisableAll("SettingsTemplate")
    SettingsUI.Enabled = not SettingsUI.Enabled
end)