local ReplicatedStorage = game:GetService("ReplicatedStorage")

local WaterCanConfig = require(ReplicatedStorage.Configs.WaterCanConfig) 

local directories = {}

for directory, _ in WaterCanConfig do 
	table.insert(directories, directory)
end

return function(registry)
	registry:RegisterType("waterCanDirectory", registry.Cmdr.Util.MakeEnumType("waterCanDirectory", directories))
end
