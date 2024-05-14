anarchy_bot.commands = anarchy_bot.commands or {}
local anarchy_bot_commands = anarchy_bot.commands

anarchy_bot_commands.list = {}

function anarchy_bot_commands.load_static()
	local files = file.Find("anarchy_bot/commands/*.lua", "LUA")

	for _, file_name in ipairs(files) do
		local command_metatable = include("commands/" .. file_name)

		local command = libbys.objects.create_instance(command_metatable.m_strLibbysClassName)
		command:init()

		anarchy_bot_commands.list[command.m_strName] = command
	end
end
