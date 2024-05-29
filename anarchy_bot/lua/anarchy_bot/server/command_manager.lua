function anarchy_bot:create_template_config(command)
	local config = setmetatable({}, self.commands._BASE_CONFIG)

	command.m_Config = config
	config:init()
end

function anarchy_bot:fix_command_name(name)
	name = tostring(name):lower():Trim()

	if name:StartsWith("!") then
		name = name:sub(2)
	end

	return name
end

function anarchy_bot:register_command(metatable, name)
	name = self:fix_command_name(name)

	metatable.__index = metatable
	setmetatable(metatable, self.commands._BASE)

	local new_command = setmetatable({}, metatable)

	self:create_template_config(new_command)
	new_command:init()
	new_command:describe()

	new_command.m_strName = name

	self.commands[name] = new_command
end

function anarchy_bot:register_command_alias(name, new_name)
	name = self:fix_command_name(name)

	if not self:find_command(name) then
		ErrorNoHalt(("Tried to error non-existant commmand '%s'\n"):format(name))
		return
	end

	new_name = self:fix_command_name(new_name)

	self.command_alias[new_name] = name
end

function anarchy_bot:find_command(name)
	name = self:fix_command_name(name)

	local command = self.commands[name]
	if command then return command end

	local alias = self.command_alias[name]
	if alias then
		return self:find_command(alias)
	end

	return nil
end

function anarchy_bot:drop_commands()
	for k, _ in next, anarchy_bot.commands do
		anarchy_bot.commands[k] = nil
	end
end
