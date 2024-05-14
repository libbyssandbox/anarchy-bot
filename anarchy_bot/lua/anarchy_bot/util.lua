function anarchy_bot.kick_bot(reason)
	anarchy_bot.run_on_bot(libbys.metatables.Player.Kick, reason)
end

function anarchy_bot.spawn_bot()
	anarchy_bot.kick_bot("Respawning")

	anarchy_bot.m_pBot = player.CreateNextBot("AnarchyBot")
	return anarchy_bot.m_pBot
end

function anarchy_bot.get_bot()
	return anarchy_bot.m_pBot
end

function anarchy_bot.ensure_bot()
	local bot = anarchy_bot.get_bot()

	if not IsValid(bot) then
		return anarchy_bot.spawn_bot()
	end

	return bot
end

function anarchy_bot.run_on_bot(callback, ...)
	libbys.arguments.validate(1, "function")

	local bot = anarchy_bot.get_bot()
	if not IsValid(bot) then return nil end

	return callback(bot, ...)
end

function anarchy_bot.split_message(message)
	libbys.arguments.validate(1, "string")

	local splits = {}

	for i = 1, message:len(), 126 do
		splits[#splits + 1] = message:sub(i, i + 126)
	end

	return splits
end

function anarchy_bot.bot_say(message, ...)
	libbys.arguments.validate(1, "string")

	message = message:format(...):Trim()
	local splits = anarchy_bot.split_message(message)

	for i = 1, #splits do
		anarchy_bot.run_on_bot(libbys.metatables.Player.Say, splits[i])
	end
end
