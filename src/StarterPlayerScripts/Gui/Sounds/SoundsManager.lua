local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SoundsConfig = require(ReplicatedStorage.Configs.SoundsConfig)
local State = require(ReplicatedStorage.Client.State)
local SoundsManager = {}

function SoundsManager.PlaySound(soundID: string)
    if SoundsConfig[soundID] == nil then return end 
    if State.GetData().Settings["SoundEffects"] == false then return end
    SoundsConfig[soundID]:Play()
end

function SoundsManager.PlayDenialSound()
    if SoundsConfig["OnDenial"] == nil then return end
    if State.GetData().Settings["SoundEffects"] == false then return end
    SoundsConfig["OnDenial"]:Play()
end

function SoundsManager.PlayCloseSound()
    if SoundsConfig["OnClose"] == nil then return end 
    if State.GetData().Settings["SoundEffects"] == false then return end
    SoundsConfig["OnClose"]:Play()
end

function SoundsManager.PlayEnterSound()
    if SoundsConfig["OnEnter"] == nil then return end
    if State.GetData().Settings["SoundEffects"] == false then return end
    SoundsConfig["OnEnter"]:Play()
end

function SoundsManager.PlayLeaveSound()
    if SoundsConfig["OnLeave"] == nil then return end 
    if State.GetData().Settings["SoundEffects"] == false then return end
    SoundsConfig["OnLeave"]:Play()
end

function SoundsManager.PlayPressSound()
    if SoundsConfig["OnPress"] == nil then return end
    if State.GetData().Settings["SoundEffects"] == false then return end
    SoundsConfig["OnPress"]:Play()
end

return SoundsManager