libbys.hook.create_unique("player_disconnect", function(data)
	anarchy_bot.connect_cache[data.userid] = nil

	-- Everyone left
	if player.GetCount() - 1 <= 0 then
		anarchy_bot.kick_bot("Punting bot, server is hibernating")
	end
end)
