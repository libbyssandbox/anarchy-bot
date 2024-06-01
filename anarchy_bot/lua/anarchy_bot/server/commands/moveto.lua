local command = {}

function command:describe()
	self.m_TraceResult = {}
	self.m_TraceData = { output = self.m_TraceResult }

	self:set_description("!moveto (target | x) (y) (z)")

	self:get_config():set_cooldown_duration(10)
end

function command:run_trace(start_pos, end_pos, mins, maxs, ignore)
	self.m_TraceData.start = start_pos
	self.m_TraceData.endpos = end_pos
	self.m_TraceData.mins = mins
	self.m_TraceData.maxs = maxs
	self.m_TraceData.filter = ignore

	util.TraceHull(self.m_TraceData)

	return self.m_TraceResult
end

function command:try_teleport(ply, position)
	local tr = self:run_trace(position, position, ply:OBBMins(), ply:OBBMaxs(), ply)
	if tr.Hit then return false end

	ply:SetPos(position)
	ply:SetVelocity(-ply:GetVelocity())

	return true
end

function command:do_call(bot, ply, x, y, z)
	if not ply:Alive() then
		anarchy_bot:say("You're dead!")
		return true
	end

	-- Try x y z
	if isnumber(tonumber(x)) and isnumber(tonumber(y)) and isnumber(tonumber(z)) then
		local position = Vector(x, y, z)

		if self:try_teleport(ply, position) then
			anarchy_bot:say("Here we go!")
			return
		end

		anarchy_bot:say("Your fatass doesn't fit!")
		return true
	end

	-- Try a player
	local target = libbys.util.find_player(x)

	if IsValid(target) then
		local target_origin = target:GetPos()
		local target_radius = target:BoundingRadius()

		-- 4 cardinal directions
		local positions = {
			Vector(target_origin.x + target_radius, target_origin.y, target_origin.z),
			Vector(target_origin.x - target_radius, target_origin.y, target_origin.z),
			Vector(target_origin.x, target_origin.y + target_radius, target_origin.z),
			Vector(target_origin.x, target_origin.y - target_radius, target_origin.z)
		}

		for i = 1, #positions do
			if self:try_teleport(ply, positions[i]) then
				anarchy_bot:say("Here we go!")
				return
			end
		end

		anarchy_bot:say("Your fatass doesn't fit!")
		return true
	end

	-- Idiot
	anarchy_bot:say("You can't teleport to imaginary friends, take your meds")
	return true
end

anarchy_bot:register_command(command, "moveto")
