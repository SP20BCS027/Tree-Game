type QuestsConfigTemplate = {
	Name: string, 
	CurrentQuestNo: number, 
	CurrentQuestInfo: {},
}

local QuestsConfig :{[string] : QuestsConfigTemplate} = {
	Bakri = {
		Name = "Bakri", 
		CurrentQuestNo = 1,
		LayoutOrder = 1, 
		CurrentQuestInfo = nil, 
	}, 
	Ghora = {
		Name = "Ghora",
		CurrentQuestNo = 1,
		LayoutOrder = 100, 
		CurrentQuestInfo = nil, 
	}
}

return QuestsConfig
