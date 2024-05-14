anarchy_bot.commands = anarchy_bot.commands or {}
local anarchy_bot_commands = anarchy_bot.commands

anarchy_bot_commands.list = {}

anarchy_bot_commands.base_meta = include("obj_command.lua")

function anarchy_bot_commands.register(meta)
	libbys.arguments.validate(1, "table")

	meta.__index = meta
	meta = setmetatable(meta, anarchy_bot_commands.base_meta)

	local command = setmetatable({}, meta)
	command:init()

	anarchy_bot_commands.list[command.m_strName] = command
end

function anarchy_bot_commands.load_static()
	local files = file.Find("anarchy_bot/commands/*.lua", "LUA")

	for _, file_name in ipairs(files) do
		include("commands/" .. file_name)
	end
end
