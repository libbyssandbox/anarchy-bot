local command = {}

function command:describe()
	self:set_description("Rolls a die")
end

function command:do_call(bot, ply, ...)
	anarchy_bot:say("I rolled and got a %i", math.random(1, 6))
end

anarchy_bot:register_command(command, "roll")
