local COMMAND = {}

function COMMAND:describe()
	self:set_name("help")
	self:set_description("!help | !help (command name)")
end

function COMMAND:should_display(ply, command) -- Don't show them things they can't run
	if not command.m_bEnabled then return false end
	if command.m_bAdminOnly and not ply:IsAdmin() then return false end

	return true
end

function COMMAND:do_call(ply, command_name)
	local command = anarchy_bot.commands.find(tostring(command_name))

	if command then
		if not self:should_display(ply, command) then
			anarchy_bot.bot_say("I can't help with that!")
		else
			anarchy_bot.bot_say("!%s - %s", command.m_strName, command.m_strDescription)
		end
	else
		-- Construct our command list
		-- Maybe some form of caching?
		local command_list = {}

		for command_name, command in next, anarchy_bot.commands.list do
			if not self:should_display(ply, command) then continue end

			table.insert(command_list, "!" .. command_name)
		end

		anarchy_bot.bot_say(table.concat(command_list, ", "))
	end
end

return libbys.objects.define_subclass("anarchy_bot_HelpCommand", "anarchy_bot_BaseCommand", COMMAND)
