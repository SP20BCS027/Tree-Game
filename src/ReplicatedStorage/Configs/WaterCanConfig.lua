export type WaterCanConfigTemp = {
	Name: string,
	Capacity: number, 
	Price: number, 
	Description: string,
}

local WaterCanConfig: {[string]: WaterCanConfigTemp} = {
	MiniWateringCan = {
		UID = "MiniWateringCan",
		Name = "Mini Watering Can", 
		Capacity = 1, 
		Price = 0, 
		Description = "This is the smallest of the smallest watering cans out there. It can barely hold a drop", 
		LayoutOrder = 1, 
		imageID = "rbxassetid://13806800107" 
	}, 
	BasicWateringCan = {
		UID = "BasicWateringCan", 
		Name = "Basic Watering Can", 
		Capacity = 3, 
		Price = 100, 
		Description = "This is the basic essential watering can that every gardern must have", 
		LayoutOrder = 2, 
		imageID = "rbxassetid://13806804274" 
	}, 
	WideMouthWateringCan = {
		UID = "WideMouthWateringCan", 
		Name = "Wide Mouth Watering Can", 
		Capacity = 5, 
		Price = 500, 
		Description = "As the name suggests this watering can has an unusually wide mouth", 
		LayoutOrder = 3, 
		imageID = "rbxassetid://13806807988" 
	}, 
	TeapotWateringCan = {
		UID = "TeapotWateringCan", 
		Name = "Teapot Watering Can", 
		Capacity = 9, 
		Price = 1000, 
		Description = "This watering can is literally a teapot", 
		LayoutOrder = 4, 
		imageID = "rbxassetid://13806811009" 
	}, 
	DeluxeWateringCan = {
		UID = "DeluxeWateringCan", 
		Name = "Deluxe Watering Can", 
		Capacity = 12, 
		Price = 2000, 
		Description = "This is a super premium watering can made out of luxury materials", 
		LayoutOrder = 5, 
		imageID = "rbxassetid://13806814139" 
	}, 
	HoseAttachmentWateringCan = {
		UID = "HoseAttachmentWateringCan", 
		Name = "Hose Attachment Watering Can",
		Capacity = 15, 
		Price = 5000, 
		Description = "This watering can has a hose attached to its mouth", 
		LayoutOrder = 6, 
		imageID = "rbxassetid://13806816929"
	}, 
	LongSpoutWateringCan = {
		UID = "LongSpoutWateringCan", 
		Name = "Long Spout Watering Can", 
		Capacity = 20, 
		Price = 10000, 
		Description = "This watering can has a longer than usual spout", 
		LayoutOrder = 7, 
		imageID = "rbxassetid://13806828452"
	}, 
	VintageWateringCan = {
		UID = "VintageWateringCan", 
		Name = "Vintage Watering Can", 
		Capacity = 25, 
		Price = 15000, 
		Description = "This watering can is said to be more than 5000 years old", 
		LayoutOrder = 8,
		imageID = "rbxassetid://13806833092"
	}, 
	SelfWateringCan = {
		UID = "SelfWateringCan", 
		Name = "Self Watering Can", 
		Capacity = 40, 
		Price = 50000, 
		Description = "This watering can has a very futuristic look but definitly doesn't water the trees itself.", 
		LayoutOrder = 9,
		imageID = "rbxassetid://13806838223"
	}
}

return WaterCanConfig
