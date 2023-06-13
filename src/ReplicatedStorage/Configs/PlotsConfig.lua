local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Trees = require(ReplicatedStorage.Configs.TreeConfig)

type PlotsConfigTemp = {
	Name: string, 
	Id: string, 
	Occupied: boolean, 
	Tree: Trees.TreeConfig?, 
	Position: CFrame, 
	Price: number, 
	LayoutOrder: number,
}

local Plots: {[number] : PlotsConfigTemp} = {
	Plot_1 = {
		Name = "First Plot",
		Id = "Plot_1",
		Tree = nil, 
		Price = 100,
		LayoutOrder = 1, 
	},
	Plot_2 = {
		Name = "Second Plot",
		Id = "Plot_2",
		Tree = nil, 
		Price = 500,
		LayoutOrder = 2, 
	}, 
	Plot_3 = {
		Name = "Third Plot",
		Id = "Plot_3",
		Tree = nil, 
		Price = 2000,
		LayoutOrder = 3, 

	}, 
	Plot_4 = {
		Name = "Fourth Plot",
		Id = "Plot_4",
		Tree = nil, 
		Price = 25000,
		LayoutOrder = 4, 

	}, 
	Plot_5 = {
		Name = "Fifth Plot",
		Id = "Plot_5",
		Tree = nil, 
    	Price = 50000,
		LayoutOrder = 5, 

	}, 
}

return Plots
