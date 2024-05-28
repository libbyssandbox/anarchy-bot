local command = {}

function command:describe()
	self:set_description("no No NO")

	self.m_No = { "no", "No", "NO" }
end

function command:do_call(bot, ply, ...)
	local no = self.m_No[math.random(1, #self.m_No)]

	if math.random() > 0.5 then
		no = no .. "!"
	end

	anarchy_bot:say(no)
end

anarchy_bot:register_command(command, "no")
