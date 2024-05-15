local COMMAND = {}

function COMMAND:describe()
	self:set_cooldown(10)

	self:set_name("gpt")
	self:set_description("Say something to ChatGPT")

	self.m_strToken = GetEnvironmentVariable("LIBBYS_GPT_TOKEN")
end

function COMMAND:do_call(ply)
	if not isstring(self.m_strToken) or self.m_strToken:len() < 1 then
		anarchy_bot.bot_say("I need an API key hmmm")
		return true
	end
end

return libbys.objects.define_subclass("anarchy_bot_GPTCommand", "anarchy_bot_BaseCommand", COMMAND)
