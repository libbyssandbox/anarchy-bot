local COMMAND = {}
COMMAND.__index = COMMAND

function COMMAND:init()
	self.m_bEnabled = true
	self.m_bAdminOnly = false

	self.m_iCooldownDuration = 0
	self.m_Cooldowns = {}
	self.m_bUseGlobalCooldown = false
end

function COMMAND:cleanup_cooldowns()
	local time = CurTime()
	local remove = {}

	for k, v in next, self.m_Cooldowns do
		if v <= time then -- Remove expired cooldowns
			remove[#remove + 1] = k
			continue
		end

		if k ~= "_GLOB" and not IsValid(k) then -- Remove invalid players
			remove[#remove + 1] = k
		end
	end

	for i = 1, #remove do
		table.remove(self.m_Cooldowns, remove[i])
	end

	collectgarbage("step")
end

function COMMAND:in_cooldown()
	if self.m_iCooldownDuration > 0 then
		self:cleanup_cooldowns()

		return not table.IsEmpty(self.m_Cooldowns)
	end

	return false
end

function COMMAND:has_cooldown_for(ply)
	if not self:in_cooldown() then
		return false
	end

	if self.m_bUseGlobalCooldown then
		return true
	else
		return self.m_Cooldowns[ply] ~= nil
	end
end

function COMMAND:apply_cooldown(ply)
	if self.m_iCooldownDuration <= 0 then return end

	self.m_Cooldowns[self.m_bUseGlobalCooldown and "_GLOB" or ply] = CurTime() + self.m_iCooldownDuration
end

function COMMAND:can_call(ply, ...)
	if not self.m_bEnabled then return false, true end
	if self:has_cooldown_for(ply) then return false, true end
	if self.m_bAdminOnly and not ply:IsAdmin() then return false, true end

	return self:should_call(ply, ...)
end

function COMMAND:should_call(ply, ...)
	-- For override
	return true
end

function COMMAND:call(ply, ...)
	if not self:can_call(ply, ...) then return end

	self:do_call(ply, ...)

	self:apply_cooldown(ply)
end

function COMMAND:do_call(ply, ...)
	-- For override
end

return COMMAND
