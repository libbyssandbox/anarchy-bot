if not util.IsBinaryModuleInstalled("environment") then
	return error("gmsv_environment is missing!")
end

if not util.IsBinaryModuleInstalled("commandline") then
	return error("gmsv_commandline is missing!")
end

return true
