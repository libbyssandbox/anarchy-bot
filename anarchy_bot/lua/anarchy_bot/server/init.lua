if not include("binaries.lua") then return end

anarchy_bot = anarchy_bot or {}

anarchy_bot.player = anarchy_bot.player or FindMetaTable("Player")
anarchy_bot.bot_hooks = anarchy_bot.bot_hooks or {}

-- Get rid of the old bot
if IsValid(anarchy_bot.bot_ref) then
	anarchy_bot.bot_ref:Kick("Reloading")
end

-- Utility
include("anarchy_bot.lua")

-- Hooks & Callbacks
include("hooks/startcommand.lua")

include("callbacks/ensure_exists.lua")
include("callbacks/leave.lua")
include("callbacks/spawn_angles.lua")
include("callbacks/wander.lua")
include("callbacks/welcome.lua")

-- Commands
