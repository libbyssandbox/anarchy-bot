anarchy_bot:add_callback("player_disconnect", function()
	if player.GetCount() - 1 > 0 then return end

	-- All our friends are gone
	anarchy_bot:call(anarchy_bot.player.Kick, "Punting bot, server is hibernating")
end)
