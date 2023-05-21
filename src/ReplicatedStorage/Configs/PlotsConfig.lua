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
		Name = "First Plot",
		Id = "Plot_1",
		Occupied = false, 
		Tree = nil, 
		Position = 0, 
		Price = 100,
	},
	Plot_2 = {
		Name = "Second Plot",
		Id = "Plot_2",
		Occupied = false, 
		Tree = nil, 
<<<<<<< Updated upstream
		Price = 100,

=======
		Price = 500,
		LayoutOrder = 2, 
>>>>>>> Stashed changes
	}, 
	Plot_3 = {
		Name = "Third Plot",
		Id = "Plot_3",
		Occupied = false, 
		Tree = nil, 
<<<<<<< Updated upstream
		Price = 100,

=======
		Price = 2000,
		LayoutOrder = 3, 
>>>>>>> Stashed changes
	}, 
	Plot_4 = {
		Name = "Fourth Plot",
		Id = "Plot_4",
		Occupied = false, 
		Tree = nil, 
<<<<<<< Updated upstream
		Price = 100,

=======
		Price = 25000,
		LayoutOrder = 4, 
>>>>>>> Stashed changes
	}, 
	Plot_5 = {
		Name = "Fifth Plot",
		Id = "Plot_5",
		Occupied = false, 
		Tree = nil, 
<<<<<<< Updated upstream
		Price = 100,

=======
		Price = 50000,
		LayoutOrder = 5, 
>>>>>>> Stashed changes
	}, 
	
}

return Plots
