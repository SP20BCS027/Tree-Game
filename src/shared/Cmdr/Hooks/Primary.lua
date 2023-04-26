return function (registry)
	registry:RegisterHook("BeforeRun", function(context)
		--print(context.Executor.Name)
		--if context.Executor.UserId ~= 64371972 then
		--	return "You don't have permission to run this command"
		--end
	end)
end