local COMMAND = {}

function COMMAND:describe()
	self:set_name("uptime")
	self:set_description("Get how long the server has been running")
end

function COMMAND:do_call()
	anarchy_bot.bot_say(string.NiceTime(SysTime()))
end

return libbys.objects.define_subclass("anarchy_bot_UptimeCommand", "anarchy_bot_BaseCommand", COMMAND)
