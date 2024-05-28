anarchy_bot:add_callback("PlayerInitialSpawn", function(ply)
	if ply:IsBot() then return end

	anarchy_bot:ensure_bot()
end)
