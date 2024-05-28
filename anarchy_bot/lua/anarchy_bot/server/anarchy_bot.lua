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

	return self:get_bot()
end

function anarchy_bot:ensure_bot()
	if self:get_bot():IsValid() then return end

	self:spawn_bot()
end

function anarchy_bot:run_callbacks(name, ...)
	local callbacks = self.callbacks[name]
	if not callbacks then return end

	for i = 1, #callbacks do
		local a, b, c, d, e, f = callbacks[i](...)

		if a ~= nil then
			return a, b, c, d, e, f
		end
	end
end

function anarchy_bot:add_callback(name, callback)
	if not isfunction(callback) then return end

	local callbacks = self.callbacks[name]

	if not callbacks then
		callbacks = {}
		self.callbacks[name] = callbacks

		-- Auto hook
		local existing_hooks = hook.GetTable()[name]

		if not istable(existing_hooks) or not isfunction(existing_hooks.anarchy_bot) then
			local CALLBACK_NAME = name

			gameevent.Listen(CALLBACK_NAME) -- Auto listen
			hook.Add(CALLBACK_NAME, "anarchy_bot", function(...)
				anarchy_bot.run_callbacks(anarchy_bot, CALLBACK_NAME, ...)
			end)
		end
	end

	table.insert(callbacks, callback)
end

function anarchy_bot:remove_callback(name, id)
	local callbacks = self.callbacks[name]
	if not callbacks or not callbacks[id] then return end

	table.remove(callbacks, id)
end

function anarchy_bot:empty_callbacks()
	for name, _ in next, self.callbacks do
		hook.Remove(name, "anarchy_bot")
	end

	table.Empty(self.callbacks)
end
