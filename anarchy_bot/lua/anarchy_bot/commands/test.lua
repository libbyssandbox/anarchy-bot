local COMMAND = {}

function COMMAND:describe()
	self:set_name("test")
	self:set_description("Test command")
end

function COMMAND:call(ply, arg1)
	anarchy_bot.bot_say("hello %s! you gave me %s", ply:GetName(), arg1)
end

return libbys.objects.define_subclass("anarchy_bot_TestCommand", "anarchy_bot_BaseCommand", COMMAND)