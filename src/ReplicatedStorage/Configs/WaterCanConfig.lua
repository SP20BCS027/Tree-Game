export type WaterCanConfigTemp = {
	Name: string,
	Capacity: number, 
	Price: number, 
	Description: string,
}

local WaterCanConfig: {[string]: WaterCanConfigTemp} = {
	MiniWateringCan = {
		Name = "MiniWateringCan", 
		Capacity = 1, 
		Price = 0, 
		Description = "This is the smallest of the smallest watering cans out there. It can barely hold a drop", 
		LayoutOrder = 1, 
	}, 
	BasicWateringCan = {
		Name = "BasicWateringCan", 
		Capacity = 3, 
		Price = 100, 
		Description = "This is the basic essential watering can that every gardern must have", 
		LayoutOrder = 2, 
	}, 
	WideMouthWateringCan = {
		Name = "WideMouthWateringCan", 
		Capacity = 5, 
		Price = 500, 
		Description = "As the name suggests this watering can has an unusually wide mouth", 
		LayoutOrder = 3, 
	}, 
	TeapotWateringCan = {
		Name = "TeapotWateringCan", 
		Capacity = 9, 
		Price = 1000, 
		Description = "This watering can is literally a teapot", 
		LayoutOrder = 4, 
	}, 
	DeluxeWateringCan = {
		Name = "DeluxeWateringCan", 
		Capacity = 12, 
		Price = 2000, 
		Description = "This is a super premium watering can made out of luxury materials", 
		LayoutOrder = 5, 
	}, 
	HoseAttachmentWateringCan = {
		Name = "HoseAttachmentWateringCan", 
		Capacity = 15, 
		Price = 5000, 
		Description = "This watering can has a hose attached to its mouth", 
		LayoutOrder = 6, 
	}, 
	LongSpoutWateringCan = {
		Name = "LongSpoutWateringCan", 
		Capacity = 20, 
		Price = 10000, 
		Description = "This watering can has a longer than usual spout", 
		LayoutOrder = 7, 
	}, 
	VintageWateringCan = {
		Name = "VintageWateringCan", 
		Capacity = 25, 
		Price = 15000, 
		Description = "This watering can is said to be more than 5000 years old", 
		LayoutOrder = 8,
	}, 
	SelfWateringCan = {
		Name = "SelfWateringCan", 
		Capacity = 40, 
		Price = 50000, 
		Description = "This watering can has a very futuristic look but definitly doesn't water the trees itself.", 
		LayoutOrder = 9,
	}
}

return WaterCanConfig
