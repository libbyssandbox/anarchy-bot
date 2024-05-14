anarchy_bot = anarchy_bot or {}

if isfunction(anarchy_bot.kick_bot) then anarchy_bot.kick_bot("Reloading") end
anarchy_bot.m_pBot = NULL

include("util.lua")

-- Hooks
include("hooks/OnRequestFullUpdate.lua")
include("hooks/player_disconnect.lua")

-- Commands
