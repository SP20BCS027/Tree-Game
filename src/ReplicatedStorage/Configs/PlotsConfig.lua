local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Trees = require(ReplicatedStorage.Configs.TreeConfig)

type PlotsConfig = {
	Occupied: boolean, 
	Tree: Trees.TreeConfig?
}

local Config:{ [number] : PlotsConfig } = {
	[1] = {
		Id = "1",
		Occupied = false, 
		Tree = nil
	},
	[2] = {
		Id = "2",
		Occupied = false, 
		Tree = nil
	}
}

local Plots= {}

Plots = Config

return Plots
