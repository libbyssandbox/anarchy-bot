local COMMAND = {}
COMMAND.__index = COMMAND

function COMMAND:init()
	self.m_bEnabled = true
	self.m_bAdminOnly = false

	self.m_iCooldownDuration = 0
	self.m_Cooldowns = {}
	self.m_bUseGlobalCooldown = false

	self:describe()
end

function COMMAND:describe()
	-- For override
	self:set_name("BASE_COMMAND")
	self:set_description("BASE_COMMAND")
end

function COMMAND:set_name(name)
	libbys.arguments.validate(2, "string")

	self.m_strName = name:lower()
end

function COMMAND:set_description(description)
	libbys.arguments.validate(2, "string")

	self.m_strDescription = description:lower()
end

function COMMAND:set_admin_only(state)
	libbys.arguments.validate(2, "boolean")

	self.m_bAdminOnly = state
end

function COMMAND:set_enabled(state)
	libbys.arguments.validate(2, "boolean")

	self.m_bEnabled = state
end

function COMMAND:set_cooldown(amount)
	libbys.arguments.validate(2, "number")

	self.m_iCooldownDuration = math.Round(math.abs(amount))
end

function COMMAND:set_global_cooldown(state)
	libbys.arguments.validate(2, "boolean")

	self.m_bUseGlobalCooldown = state
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

function COMMAND:get_cooldown_for(ply)
	if not self:in_cooldown() then
		return nil
	end

	if self.m_bUseGlobalCooldown then
		return self.m_Cooldowns["_GLOB"]
	else
		return self.m_Cooldowns[ply]
	end
end

function COMMAND:has_cooldown_for(ply)
	return get_cooldown_for(ply) ~= nil
end

function COMMAND:apply_cooldown(ply)
	if self.m_iCooldownDuration <= 0 then return end

	self.m_Cooldowns[self.m_bUseGlobalCooldown and "_GLOB" or ply] = CurTime() + self.m_iCooldownDuration
end

function COMMAND:can_call(ply, ...)
	if not self.m_bEnabled then return false end
	if self.m_bAdminOnly and not ply:IsAdmin() then return false end

	if self:has_cooldown_for(ply) then
		local cooldown = CurTime() - self:get_cooldown_for(ply)
		cooldown = math.ceil(cooldown)

		anarchy_bot.bot_say("You can't run this command yet! Wait %s!", string.NiceTime(cooldown))

		return false
	end

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

return libbys.objects.define_class("anarchy_bot_BaseCommand", COMMAND)
