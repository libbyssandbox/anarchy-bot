local command = {}

function command:describe()
	self:set_description("!help | !help (command_name)")

	self:get_config():set_cooldown_duration(3)
end

function command:help_with(found_command)
	if not found_command then
		anarchy_bot:say("I can't find that command!")
		return true
	end

	anarchy_bot:say("!%s - %s", found_command:get_name(), found_command:get_description())
end

function command:help_all()
	local generated = {}

	for index_name, index_command in SortedPairs(anarchy_bot.commands) do
		if index_name == "_BASE" or index_name == "_BASE_CONFIG" then continue end

		table.insert(generated, ("!%s"):format(index_command:get_name()))
	end

	anarchy_bot:say(table.concat(generated, ", "))
end

function command:do_call(bot, ply, command_name)
	if isstring(command_name) then
		return self:help_with(anarchy_bot.commands[command_name:lower()])
	else
		return self:help_all()
	end
end

anarchy_bot:register_command(command, "help")
