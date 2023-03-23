local ServerScriptService = game:GetService("ServerScriptService")

local PlayerData = require(ServerScriptService.PlayerData.Manager)

return function (context, player: Player?, dataDirectory: string?)
	player = if player then player else context.Executor
	
	local profile = PlayerData.Profiles[player]
	
	if not profile then 
		return "No Profile Found"
	end
	
	if not dataDirectory then 
		print("This player's data is: ")
		print(profile.Data)
		
		return "All data printed!"
	end
	
	print(profile.Data[dataDirectory])
	return "Data Printed!"  
	
end
