local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Trees = require(ReplicatedStorage.Configs.TreeConfig)

type PlotsConfig = {
	Name: string, 
	Id: string, 
	Occupied: boolean, 
	Tree: Trees.TreeConfig?, 
	Position: CFrame, 
	Price: number, 
}

local Plots:{ [number] : PlotsConfig } = {
	Plot_1 = {
		Name = "FirstPlot",
		Id = "Plot_1",
		Occupied = false, 
		Tree = nil, 
		Position = 0, 
		Price = 100,
	},
	Plot_2 = {
		Name = "SecondPlot",
		Id = "Plot_2",
		Occupied = false, 
		Tree = nil, 
		Price = 100,

	}, 
	Plot_3 = {
		Name = "ThirdPlot",
		Id = "Plot_3",
		Occupied = false, 
		Tree = nil, 
		Price = 100,

	}, 
	Plot_4 = {
		Name = "FourthPlot",
		Id = "Plot_4",
		Occupied = false, 
		Tree = nil, 
		Price = 100,

	}, 
	Plot_5 = {
		Name = "FifthPlot",
		Id = "Plot_5",
		Occupied = false, 
		Tree = nil, 
		Price = 100,

	}, 
	
}

return Plots
