require("libbys")
libbys.util.require_binary("environment")

anarchy_bot = anarchy_bot or {}

anarchy_bot.callbacks = anarchy_bot.callbacks or {}
anarchy_bot.commands = {}
anarchy_bot.command_alias = {}

-- Utility
include("anarchy_bot.lua")
include("callback_manager.lua")
include("command_manager.lua")

-- Cleanup old stuff
anarchy_bot:call(anarchy_bot.player.Kick, "Reloading")
anarchy_bot:empty_callbacks()
anarchy_bot:drop_commands()

-- Try to come back in a bit if reloaded
timer.Simple(0, function()
	if player.GetCount() > 0 then
		anarchy_bot:ensure_bot()
	end
end)

-- Hooks & Callbacks
include("hooks/startcommand.lua")

include("callbacks/ensure_exists.lua")
include("callbacks/leave.lua")
include("callbacks/spawn_angles.lua")
include("callbacks/wander.lua")
include("callbacks/welcome.lua")
include("callbacks/run_command.lua")
include("callbacks/respawn.lua")
include("callbacks/set_model.lua")

-- Commands
include("commands/config_base.lua")
include("commands/base.lua")

include("commands/test.lua")
include("commands/uptime.lua")
include("commands/yes.lua")
include("commands/no.lua")
include("commands/generate.lua")
include("commands/help.lua")
include("commands/roll.lua")
include("commands/moveto.lua")
include("commands/addons.lua")
include("commands/calladmin.lua")
include("commands/reload.lua")
include("commands/taunt.lua")
include("commands/changemodel.lua")
include("commands/copyoutfit.lua")
