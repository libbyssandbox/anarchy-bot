local function respawn_bot()
	if anarchy_bot:call(anarchy_bot.player.Alive) then return end -- Don't respawn him if he's alive

	anarchy_bot:call(anarchy_bot.entity.Spawn)
end

anarchy_bot:add_callback("PostPlayerDeath", function(ply)
	if ply ~= anarchy_bot:get_bot() then return end

	timer.Create("anarchy_bot_respawn", 4, 1, respawn_bot)
end)
