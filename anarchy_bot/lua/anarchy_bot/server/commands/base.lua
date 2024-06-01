local command = {}
command.__index = command

function command:init()
	self.m_strName = "base"
	self.m_strDescription = "A very cool command"

	self.m_flCooldowns = {}
end

function command:describe()
	-- For override
end

function command:get_description()
	return self.m_strDescription
end

function command:set_description(description, ...)
	self.m_strDescription = tostring(description):format(...):Trim()
end

function command:get_name()
	return self.m_strName
end

function command:get_config()
	return self.m_Config
end

function command:cleanup_cooldowns()
	local current_time = CurTime()

	for holder, time in next, self.m_flCooldowns do
		-- Remove expired cooldowns
		if time <= current_time then
			self.m_flCooldowns[holder] = nil
			continue
		end

		-- Remove invalid cooldowns
		if holder ~= "_GLOB" and not IsValid(holder) then
			self.m_flCooldowns[holder] = nil
		end
	end
end

function command:in_cooldown()
	if self:get_config():get_cooldown_duration() > 0 then
		self:cleanup_cooldowns()

		return not table.IsEmpty(self.m_flCooldowns)
	end

	return false
end

function command:get_cooldown_for(ply)
	if not self:in_cooldown() then return 0 end

	local cooldown

	if self:get_config():get_use_global_cooldown() then
		cooldown = self.m_flCooldowns._GLOB
	else
		cooldown = self.m_flCooldowns[ply]
	end

	return tonumber(cooldown) or 0
end

function command:has_cooldown_for(ply)
	return self:get_cooldown_for(ply) > 0
end

function command:apply_cooldown(ply)
	local cooldown = CurTime() + self:get_config():get_cooldown_duration()

	if self:get_config():get_use_global_cooldown() then
		self.m_flCooldowns._GLOB = cooldown
	else
		self.m_flCooldowns[ply] = cooldown
	end
end

function command:should_call(ply, ...)
	-- For override
	return true
end

function command:check_permissions(ply)
	if not self:get_config():get_enabled() then return false end
	if self:get_config():get_admin_only() and not ply:IsAdmin() then return false end

	return true
end

function command:can_call(ply, ...)
	if not self:check_permissions(ply, ...) then return false end
	if not self:should_call(ply, ...) then return false end

	if self:has_cooldown_for(ply) then
		local cooldown_duration = math.ceil(self:get_cooldown_for(ply) - CurTime())

		anarchy_bot:say("You can't run this command for another %s!", string.NiceTime(cooldown_duration))

		return false
	end

	return true
end

function command:call(ply, ...)
	if not self:can_call(ply, ...) then return end

	local bot = anarchy_bot:get_bot()

	if not IsValid(bot) or not IsValid(ply) then return end
	if bot == ply then return end -- Should never happen

	if not self:do_call(bot, ply, ...) then
		self:apply_cooldown(ply)
	end
end

function command:do_call(bot, ply, ...)
	-- For override
	-- Return true to prevent cooldown
end

anarchy_bot.commands._BASE = command
