anarchy_bot:add_callback("PlayerInitialSpawn", function(ply)
	if ply:IsBot() then return end

	anarchy_bot:ensure_bot()
end)

anarchy_bot:add_callback("player_disconnect", function(data)
	if data.bot ~= 1 then return end

	timer.Simple(0, function()
		anarchy_bot:ensure_bot()
	end)
end)
