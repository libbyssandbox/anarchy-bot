local command = {}

function command:describe()
	self:set_description("Randomizes the bot's playermodel")
end

function command:do_call(bot, ply, ...)
	-- Eww table.Random ewww
	-- Shut up
	bot:SetModel(table.Random(player_manager.AllValidModels()))
end

anarchy_bot:register_command(command, "changemodel")
anarchy_bot:register_command_alias("changemodel", "randommodel")
