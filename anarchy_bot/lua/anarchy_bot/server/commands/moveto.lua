local command = {}

function command:describe()
	self:set_description("!moveto (target | x) (y) (z)")

	self:get_config():set_cooldown_duration(10)
end

function command:do_call(bot, ply, x, y, z)
	if not ply:Alive() then
		anarchy_bot:say("You're dead!")
		return true
	end

	-- Try x y z
	if libbys.util.try_teleport(ply, x, y, z) then
		anarchy_bot:say("Here we go!")
		return
	end

	-- Try a player
	if libbys.util.try_teleport(ply, libbys.util.find_player(x)) then
		anarchy_bot:say("Here we go!")
		return
	end

	-- Idiot
	anarchy_bot:say("You can't teleport to imaginary friends, take your meds")
	return true
end

anarchy_bot:register_command(command, "moveto")
