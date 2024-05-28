if not include("binaries.lua") then return end

anarchy_bot = anarchy_bot or {}

anarchy_bot.entity = anarchy_bot.entity or FindMetaTable("Entity")
anarchy_bot.player = anarchy_bot.player or FindMetaTable("Player")

anarchy_bot.callbacks = anarchy_bot.callbacks or {}
anarchy_bot.commands = {}

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
include("callbacks/run_command.lua")

-- Commands
include("commands/base.lua")
include("commands/config_base.lua")
include("command_manager.lua")

include("commands/test.lua")
include("commands/uptime.lua")
include("commands/yes.lua")
