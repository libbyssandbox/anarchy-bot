function anarchy_bot.kick_bot(reason)
	if anarchy_bot.m_pBot:IsValid() then
		anarchy_bot.m_pBot:Kick(reason)
	end
end

function anarchy_bot.spawn_bot()
	anarchy_bot.kick_bot("Respawning")

	anarchy_bot.m_pBot = player.CreateNextBot("AnarchyBot")
	return anarchy_bot.m_pBot
end

function anarchy_bot.get_bot()
	if anarchy_bot.m_pBot:IsValid() then
		return anarchy_bot.m_pBot
	else
		return anarchy_bot.spawn_bot()
	end
end

function anarchy_bot.split_message(message)
	local splits = {}
	local buffer = ""
	local length = 0

	if not message:EndsWith(" ") then
		message = message .. " " -- Ensure the last word gets matched
	end

	for _, split in message:gmatch("(%s?[%S]+)") do
		if length + split:len() >= 127 then
			if split:StartsWith(" ") then
				split = split:sub(2)
			end

			table.insert(splits, buffer)

			buffer = split
			length = split:len()
		else
			buffer = buffer .. split
			length = length + split:len()
		end
	end

	table.insert(splits, buffer)

	return splits
end

function anarchy_bot.bot_say(message, ...)
	libbys.arguments.validate(1, "string")

	local bot = anarchy_bot.get_bot()
	if not IsValid(bot) then return end

	message = message:format(...)

	for _, split in ipairs(anarchy_bot.split_message(message)) do
		bot:Say(split)
	end
end
