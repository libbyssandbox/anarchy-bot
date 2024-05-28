local command = {}

function command:describe()
	self:set_description("yes Yes YES")

	self.m_Yes = { "yes", "Yes", "YES" }
end

function command:do_call(bot, ply, ...)
	local yes = self.m_Yes[math.random(1, #self.m_Yes)]

	if math.random() > 0.5 then
		yes = yes .. "!"
	end

	anarchy_bot:say(yes)
end

anarchy_bot:register_command(command, "yes")
