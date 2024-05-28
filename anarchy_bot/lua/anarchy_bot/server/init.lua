if not include("binaries.lua") then return end

anarchy_bot = anarchy_bot or {}

anarchy_bot.entity = anarchy_bot.entity or FindMetaTable("Entity")
anarchy_bot.player = anarchy_bot.player or FindMetaTable("Player")

anarchy_bot.bot_hooks = anarchy_bot.bot_hooks or {}
anarchy_bot.bot_commands = {}

-- Utility
include("anarchy_bot.lua")

-- Cleanup old stuff
anarchy_bot:call(anarchy_bot.player.Kick, "Reloading")
anarchy_bot:empty_callbacks()

-- Hooks & Callbacks
include("hooks/startcommand.lua")

include("callbacks/ensure_exists.lua")
include("callbacks/leave.lua")
include("callbacks/spawn_angles.lua")
include("callbacks/wander.lua")
include("callbacks/welcome.lua")

-- Commands
