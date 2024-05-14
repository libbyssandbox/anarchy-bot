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
