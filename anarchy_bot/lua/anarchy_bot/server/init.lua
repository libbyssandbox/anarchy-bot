if not include("binaries.lua") then return end

anarchy_bot = anarchy_bot or {}
anarchy_bot.player = anarchy_bot.player or FindMetaTable("Player")

-- Get rid of the old bot
if IsValid(anarchy_bot.bot_ref) then
	anarchy_bot.bot_ref:Kick("Reloading")
end

-- Utility
include("anarchy_bot.lua")

-- Hooks
include("hooks/playerinitialspawn.lua")
include("hooks/player_disconnect.lua")
include("hooks/playerspawn.lua")

-- Commands
