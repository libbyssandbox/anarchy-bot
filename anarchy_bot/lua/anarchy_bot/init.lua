anarchy_bot = anarchy_bot or {}

if isfunction(anarchy_bot.kick_bot) then anarchy_bot.kick_bot("Reloading") end
anarchy_bot.m_pBot = NULL

libbys.state_include("sv_util.lua")

-- Hooks
libbys.state_include("hooks/sv_OnRequestFullUpdate.lua")
libbys.state_include("hooks/sv_player_disconnect.lua")

-- Commands
