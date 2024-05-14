local COMMAND = {}

function COMMAND:describe()
	self:set_name("yes")
	self:set_description("yes Yes YES")

	self.m_Yes = { "yes", "Yes", "YES" }
end

function COMMAND:do_call()
	local prefix = self.m_Yes[math.random(1, #self.m_Yes)]
	local suffix = libbys.util.flip_coin() and "!" or ""

	anarchy_bot.bot_say("%s%s", prefix, suffix)
end

return libbys.objects.define_subclass("anarchy_bot_YesCommand", "anarchy_bot_BaseCommand", COMMAND)
