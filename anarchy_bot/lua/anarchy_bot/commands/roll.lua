local COMMAND = {}

function COMMAND:describe()
	self:set_name("roll")
	self:set_description("Rolls a die")
end

function COMMAND:do_call()
	anarchy_bot.bot_say("%i", math.random(1, 6))
end

return libbys.objects.define_subclass("anarchy_bot_RollCommand", "anarchy_bot_BaseCommand", COMMAND)
