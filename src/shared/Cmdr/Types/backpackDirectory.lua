local ReplicatedStorage = game:GetService("ReplicatedStorage")

local BackpacksConfig = require(ReplicatedStorage.Configs.BackpacksConfig) 

local directories = {}

for directory, _ in BackpacksConfig do 
	table.insert(directories, directory)
end

return function(registry)
	registry:RegisterType("backpackDirectory", registry.Cmdr.Util.MakeEnumType("backpackDirectory", directories))
end
