local config = {}
config.__index = config

function config:init()
	self.m_bEnabled = true
	self.m_bAdminOnly = false
	self.m_bUseGlobalCooldown = false

	self.m_iCooldownDuration = 0
end

-- Getters and Setters
function config:get_enabled()
	return self.m_bEnabled
end

function config:set_enabled(state)
	self.m_bEnabled = tobool(state)
end

function config:get_admin_only()
	return self.m_bAdminOnly
end

function config:set_admin_only(state)
	self.m_bAdminOnly = tobool(state)
end

function config:get_use_global_cooldown()
	return self.m_bUseGlobalCooldown
end

function config:set_use_global_cooldown(state)
	self.m_bUseGlobalCooldown = tobool(state)
end

function config:get_cooldown_duration()
	return self.m_iCooldownDuration
end

function config:set_cooldown_duration(duration)
	self.m_iCooldownDuration = math.Round(math.abs(tonumber(duration) or 0))
end

anarchy_bot.commands._BASE_CONFIG = config
