local COMMAND = {}

function COMMAND:describe()
	self.m_strName = "test"
	self.m_strDescription = "Test command"
end

function COMMAND:call(ply, arg1)
	anarchy_bot.bot_say("hello %s! you gave me %s", ply:GetName(), arg1)
end

anarchy_bot.commands.register(COMMAND)
