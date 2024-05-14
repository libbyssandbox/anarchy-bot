local COMMAND = {}

function COMMAND:describe()
	self:set_name("no")
	self:set_description("no No NO")

	self.m_No = { "no", "No", "NO" }
end

function COMMAND:do_call()
	local prefix = self.m_No[math.random(1, #self.m_No)]
	local suffix = libbys.util.flip_coin() and "!" or ""

	anarchy_bot.bot_say("%s%s", prefix, suffix)
end

return libbys.objects.define_subclass("anarchy_bot_NoCommand", "anarchy_bot_BaseCommand", COMMAND)
