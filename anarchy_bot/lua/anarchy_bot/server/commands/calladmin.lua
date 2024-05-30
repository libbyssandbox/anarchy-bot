local command = {}

function command:describe()
	self:set_description("Calls a trusted, certified Libby's admin")

	self:get_config():set_cooldown_duration(5)
	self:get_config():set_use_global_cooldown(true)
end

function command:do_call(bot, ply, ...)
	local percent = math.random()

	if percent > 0.8 then
		anarchy_bot:say("Admens are busy suckin' dick, DO NOT DISTURB!!!")
	elseif percent > 0.6 then
		anarchy_bot:say("Admins are on lunch break, please try again later")
	else
		anarchy_bot:say("Admins have been pinged! Someone will come to help shortly!")
	end
end

anarchy_bot:register_command(command, "calladmin")
anarchy_bot:register_command_alias("calladmin", "helpimretarded")
