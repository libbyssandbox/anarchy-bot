local command = {}

function command:describe()
	self:set_description("Get server uptime")
end

function command:do_call(bot, ply, ...)
	anarchy_bot:say("The server has been up for about %s", string.NiceTime(SysTime()))
end

anarchy_bot:register_command(command, "uptime")
