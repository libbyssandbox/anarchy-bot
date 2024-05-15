local COMMAND = {}

function COMMAND:describe()
	self:set_cooldown(10)

	self:set_name("gpt")
	self:set_description("Say something to ChatGPT")
end

function COMMAND:do_call(ply)
	anarchy_bot.bot_say("I need an API key hmmm")
end

return libbys.objects.define_subclass("anarchy_bot_GPTCommand", "anarchy_bot_BaseCommand", COMMAND)
