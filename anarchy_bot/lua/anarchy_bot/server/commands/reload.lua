local command = {}

function command:describe()
	self:set_description("Reloads the bot")

	self:get_config():set_admin_only(true)
end

function command:do_call(bot, ply, ...)
	anarchy_bot:say("Reloading!")

	include("anarchy_bot/server/init.lua")
end

anarchy_bot:register_command(command, "reload")
