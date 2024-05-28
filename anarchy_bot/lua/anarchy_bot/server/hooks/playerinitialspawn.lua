hook.Add("PlayerInitialSpawn", "anarchy_bot", function(ply)
	if ply:IsBot() then return end

	anarchy_bot:ensure_bot()
end)
