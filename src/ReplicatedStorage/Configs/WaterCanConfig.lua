export type WaterCanConfig = {
	Name: string,
	Capacity: number, 
	Price: number
}

local WaterCans: {[string]: WaterCanConfig} = {
	MiniWateringCan = {
		Name = "MiniWateringCan", 
		Capacity = 1, 
		Price = 0
	}, 
	BasicWateringCan = {
		Name = "BasicWateringCan", 
		Capacity = 3, 
		Price = 100
	}, 
	WideMouthWateringCan = {
		Name = "WideMouthWateringCan", 
		Capacity = 5, 
		Price = 500
	}, 
	TeapotWateringCan = {
		Name = "TeapotWateringCan", 
		Capacity = 9, 
		Price = 1000 
	}, 
	DeluxeWateringCan = {
		Name = "DeluxeWateringCan", 
		Capacity = 12, 
		Price = 2000
	}, 
	HoseAttachmentWateringCan = {
		Name = "HoseAttachmentWateringCan", 
		Capacity = 15, 
		Price = 5000 
	}, 
	LongSpoutWateringCan = {
		Name = "LongSpoutWateringCan", 
		Capacity = 20, 
		Price = 10000 
	}, 
	VintageWateringCan = {
		Name = "VintageWateringCan", 
		Capacity = 25, 
		Price = 15000
	}, 
	SelfWateringCan = {
		Name = "SelfWateringCan", 
		Capacity = 40, 
		Price = 50000
	}
}

return WaterCans
