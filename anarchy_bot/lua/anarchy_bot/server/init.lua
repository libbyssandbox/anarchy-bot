if not include("binaries.lua") then return end

anarchy_bot = anarchy_bot or {}

-- Get rid of the old bot
if IsValid(anarchy_bot.bot_ref) then
	anarchy_bot.bot_ref:Kick("Reloading")
end

-- Utility
include("anarchy_bot.lua")

-- Hooks
include("hooks/playerinitialspawn.lua")

-- Commands
