function anarchy_bot:get_bot()
	return self.bot_ref or NULL
end

function anarchy_bot:call(func, ...)
	if not isfunction(func) then return end
	if not self:get_bot():IsValid() then return end

	return func(self.bot_ref, ...)
end

function anarchy_bot:say(format, ...)
	self:call(libbys.metatables.Player.Say, tostring(format):format(...))
end

function anarchy_bot:spawn_bot()
	local existing = self:get_bot()

	if existing:IsValid() then
		existing:Remove()
	end

	self.bot_ref = player.CreateNextBot("AnarchyBOT")

	if not self:get_bot():IsValid() then
		print("No room to spawn AnarchyBot! Poor fella :(")
	end

	return self:get_bot()
end

function anarchy_bot:ensure_bot()
	if self:get_bot():IsValid() then return end

	self:spawn_bot()
end
