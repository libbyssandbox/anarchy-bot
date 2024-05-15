local COMMAND = {}

function COMMAND:describe()
	self:set_cooldown(10)

	self:set_name("teleport")
	self:set_description("Teleport to someone or somewhere (username | x y z)")
end

function COMMAND:try_teleport(ply, destination)
	libbys.arguments.validate(2, "Player")
	destination = libbys.arguments.validate(3, "Vector", vector_origin)

	if not libbys.trace.run_hull_trace(destination, destination, nil, nil, ply:OBBMins(), ply:OBBMaxs()).Hit then
		ply:SetPos(destination)
		ply:SetVelocity(-ply:GetVelocity()) -- Awesome video game

		return true
	else
		return false
	end
end

function COMMAND:do_call(ply, x, y, z)
	if isnumber(tonumber(x)) and isnumber(tonumber(y)) and isnumber(tonumber(z)) then
		local destination = Vector(x, y, z)

		if self:try_teleport(ply, destination) then
			anarchy_bot.bot_say("Here we go!")
		else
			anarchy_bot.bot_say("Your fatass doesn't fit!")
			return true
		end
	else
		local target_player = libbys.util.find_player(x)

		if IsValid(target_player) then
			local target_pos = target_player:GetPos()
			local target_radius = target_player:BoundingRadius() * 2

			-- The 4 cardinal directions
			local destinations = {
				Vector(target_pos.x + target_radius, target_pos.y, target_pos.z),
				Vector(target_pos.x - target_radius, target_pos.y, target_pos.z),
				Vector(target_pos.x, target_pos.y + target_radius, target_pos.z),
				Vector(target_pos.x, target_pos.y - target_radius, target_pos.z)
			}

			for _, destination in ipairs(destinations) do
				if self:try_teleport(ply, destination) then
					anarchy_bot.bot_say("Be nice to each other!")
					return
				end
			end

			anarchy_bot.bot_say("Your fatass doesn't fit!")
			return true
		else
			anarchy_bot.bot_say("You can't teleport to imaginary friends, take your meds")
			return true
		end
	end
end

return libbys.objects.define_subclass("anarchy_bot_TeleportCommand", "anarchy_bot_BaseCommand", COMMAND)
