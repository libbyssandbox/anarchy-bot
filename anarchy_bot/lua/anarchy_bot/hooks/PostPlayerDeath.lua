local function respawn_bot()
	if anarchy_bot.run_on_bot(libbys.metatables.Player.Alive) then return end -- If something else respawned him, bail

	anarchy_bot.run_on_bot(libbys.metatables.Entity.Spawn)
end

libbys.hook.create_unique("PostPlayerDeath", function(ply)
	if ply ~= anarchy_bot.get_bot() then return end

	timer.Create("anarchy_bot_RespawnTimer", 4, 1, respawn_bot)
end)
