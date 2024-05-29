local command = {}

function command:describe()
	self.m_strModel = "models/player/kleiner.mdl"

	self:set_description("Randomizes the bot's playermodel")
end

function command:do_call(bot, ply, ...)
	-- Eww table.Random ewww
	-- Shut up
	self.m_strModel = table.Random(player_manager.AllValidModels())

	bot:SetModel(self.m_strModel)
end

anarchy_bot:register_command(command, "changemodel")
anarchy_bot:register_command_alias("changemodel", "randommodel")
