function anarchy_bot:create_template_config(command)
	local config = setmetatable({}, anarchy_bot.commands._BASE_CONFIG)

	command.m_Config = config
	config:init()
end

function anarchy_bot:register_command(metatable, name)
	name = name:lower():Trim()

	metatable.__index = metatable
	setmetatable(metatable, anarchy_bot.commands._BASE)

	local new_command = setmetatable({}, metatable)

	self:create_template_config(new_command)
	new_command:init()
	new_command:describe()

	anarchy_bot.commands[name] = new_command
end
