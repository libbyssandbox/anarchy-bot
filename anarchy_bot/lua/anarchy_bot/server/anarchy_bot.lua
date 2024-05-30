function anarchy_bot:get_bot()
	return self.bot_ref or NULL
end

function anarchy_bot:call(func, ...)
	if not isfunction(func) then return end
	if not self:get_bot():IsValid() then return end

	return func(self.bot_ref, ...)
end

function anarchy_bot:say(format, ...)
	self:call(self.player.Say, tostring(format):format(...))
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

function anarchy_bot:find_player(data)
	data = tostring(data):Trim()

	-- Try simple lookups
	local ply = player.GetBySteamID(data)
	if ply then return ply end

	ply = player.GetBySteamID64(data)
	if ply then return ply end

	-- Find by username
	data = data:lower()

	for _, ply in player.Iterator() do
		if ply:GetName():lower():find(data) then
			return ply
		end
	end

	return NULL
end
