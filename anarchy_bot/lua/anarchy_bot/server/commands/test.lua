local command = {}

function command:describe()
	self:set_description("A test command")

	self:get_config():set_cooldown_duration(10)
end

function command:do_call(bot, ply, ...)
	anarchy_bot:say("Hello %s! You gave me %s", ply:GetName(), table.concat({ ... }))
end

anarchy_bot:register_command(command, "test")
