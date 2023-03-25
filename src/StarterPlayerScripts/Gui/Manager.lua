local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer
local Remotes = ReplicatedStorage.Remotes

local StateManager = require(ReplicatedStorage.Client.State)

local Manager = {}

function Manager.UpdateOwnedBackpack()
    --Update UI Here
end

return Manager