local SoundService = game:GetService("SoundService")

local SoundsConfig = {
	OnDenial = SoundService:WaitForChild("OnDenial"), 
	OnClose = SoundService:WaitForChild("OnClose"), 
	OnEnter = SoundService:WaitForChild("OnEnter"), 
	OnLeave = SoundService:WaitForChild("OnLeave"), 
	OnPress = SoundService:WaitForChild("OnPress"),
}

return SoundsConfig