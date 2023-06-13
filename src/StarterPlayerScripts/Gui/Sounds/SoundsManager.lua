local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SoundsConfig = require(ReplicatedStorage.Configs.SoundsConfig)
local State = require(ReplicatedStorage.Client.State)

local SoundsManager = {}

-- Function to play a sound based on the provided soundID
function SoundsManager.PlaySound(soundID)
    if SoundsConfig[soundID] == nil then
        return
    end
    
    if State.GetData().Settings["SoundEffects"] == false then
        return
    end
    
    SoundsConfig[soundID]:Play()
end

-- Function to play the denial sound
function SoundsManager.PlayDenialSound()
    if SoundsConfig["OnDenial"] == nil then
        return
    end
    
    if State.GetData().Settings["SoundEffects"] == false then
        return
    end
    
    SoundsConfig["OnDenial"]:Play()
end

-- Function to play the close sound
function SoundsManager.PlayCloseSound()
    if SoundsConfig["OnClose"] == nil then
        return
    end

    if State.GetData().Settings["SoundEffects"] == false then
        return
    end

    SoundsConfig["OnClose"]:Play()
end

-- Function to play the enter sound
function SoundsManager.PlayEnterSound()
    if SoundsConfig["OnEnter"] == nil then
        return
    end
    
    if State.GetData().Settings["SoundEffects"] == false then
        return
    end
    
    SoundsConfig["OnEnter"]:Play()
end

-- Function to play the leave sound
function SoundsManager.PlayLeaveSound()
    if SoundsConfig["OnLeave"] == nil then
        return
    end
    
    if State.GetData().Settings["SoundEffects"] == false then
        return
    end
    
    SoundsConfig["OnLeave"]:Play()
end

-- Function to play the press sound
function SoundsManager.PlayPressSound()
    if SoundsConfig["OnPress"] == nil then
        return
    end
    
    if State.GetData().Settings["SoundEffects"] == false then
        return
    end
    
    SoundsConfig["OnPress"]:Play()
end

return SoundsManager
