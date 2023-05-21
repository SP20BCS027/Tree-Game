type ColorsConfig = {
	BackgroundFrame: Color3,
	InventoryFrame: Color3, 
	EquippedFrame: Color3,
	DescriptionFrame: Color3,
	IconAmount: Color3, 
	IconName: Color3, 
	IconImage: Color3, 
}

local Colors : {[string]: ColorsConfig} = {
	Backpacks = {
		BackgroundFrame = Color3.fromRGB(112, 66, 33), 
		InventoryFrame = Color3.fromRGB(179, 105, 53), 
		EquippedFrame = Color3.fromRGB(179, 105, 53),
		DescriptionFrame = Color3.fromRGB(112, 66, 33),
		IconAmount = Color3.fromRGB(112, 66, 33), 
		IconName = Color3.fromRGB(112, 66, 33), 
		IconImage = Color3.fromRGB(112, 66, 33), 
		}, 
	WaterCans = {
		BackgroundFrame = Color3.fromRGB(0, 180, 216), 
		InventoryFrame = Color3.fromRGB(144, 224, 239), 
		EquippedFrame = Color3.fromRGB(144, 224, 239), 
		DescriptionFrame = Color3.fromRGB(0, 180, 216), 
		IconAmount = Color3.fromRGB(0, 180, 216), 
		IconName = Color3.fromRGB(0, 180, 216), 
		IconImage = Color3.fromRGB(0, 180, 216),
	}, 
	Fertilizers = {
		BackgroundFrame = Color3.fromRGB(74, 124, 89), 
		InventoryFrame = Color3.fromRGB(143, 192, 169), 
		EquippedFrame = Color3.fromRGB(143, 192, 169), 
		DescriptionFrame = Color3.fromRGB(74, 124, 89), 
		IconAmount = Color3.fromRGB(74, 124, 89), 
		IconName = Color3.fromRGB(74, 124, 89), 
		IconImage = Color3.fromRGB(74, 124, 89),
	}, 
	Seeds = {
		BackgroundFrame = Color3.fromRGB(212, 163, 115),
		InventoryFrame = Color3.fromRGB(250, 237, 205), 
		EquippedFrame = Color3.fromRGB(250, 237, 205), 
		DescriptionFrame = Color3.fromRGB(212, 163, 115), 
		IconAmount = Color3.fromRGB(212, 163, 115), 
		IconName = Color3.fromRGB(212, 163, 115), 
		IconImage = Color3.fromRGB(212, 163, 115),
	}, 
	Plots = {
		BackgroundFrame = Color3.fromRGB(212, 163, 115),
		InventoryFrame = Color3.fromRGB(250, 237, 205), 
		EquippedFrame = Color3.fromRGB(250, 237, 205), 
		DescriptionFrame = Color3.fromRGB(212, 163, 115), 
		IconAmount = Color3.fromRGB(212, 163, 115), 
		IconName = Color3.fromRGB(212, 163, 115), 
		IconImage = Color3.fromRGB(212, 163, 115),
	}

}


return Colors
