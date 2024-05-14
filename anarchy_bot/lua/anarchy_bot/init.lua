anarchy_bot = anarchy_bot or {}

include("util.lua")

do
	if IsValid(anarchy_bot.m_pBot) then
		anarchy_bot.kick_bot("Reloading")

		timer.Simple(0, anarchy_bot.spawn_bot)
	else
		anarchy_bot.m_pBot = NULL
	end
end

-- Commands
include("obj_command.lua")
include("commands.lua")

-- Hooks
include("hooks/PlayerSay.lua")
include("hooks/OnRequestFullUpdate.lua")
include("hooks/player_disconnect.lua")
include("hooks/PostPlayerDeath.lua")

-- Init
anarchy_bot.commands.load_static()
