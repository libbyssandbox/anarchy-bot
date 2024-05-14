anarchy_bot = anarchy_bot or {}

if isfunction(anarchy_bot.kick_bot) then anarchy_bot.kick_bot("Reloading") end
anarchy_bot.m_pBot = NULL

include("sv_util.lua")

-- Hooks
include("hooks/sv_OnRequestFullUpdate.lua")
include("hooks/sv_player_disconnect.lua")

-- Commands
