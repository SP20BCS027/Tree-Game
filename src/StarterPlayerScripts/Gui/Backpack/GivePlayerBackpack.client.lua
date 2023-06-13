local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes

local State = require(ReplicatedStorage.Client.State)

-- When the Player's Data has been loaded on the client they will be given the Backpack model on the server 

Remotes.GivePlayerBackpack:FireServer(State.GetData().EquippedBackpack.UID)
Remotes.UpdateBackpackLabel:FireServer()