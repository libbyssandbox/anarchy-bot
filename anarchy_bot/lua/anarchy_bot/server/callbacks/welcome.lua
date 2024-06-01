anarchy_bot:add_callback("PlayerInitialSpawn", function(ply)
	if ply:IsBot() then return end

	-- "Console"
	anarchy_bot:call(libbys.metatables.Player.Say, ("Welcome to Garry's Mod, %s!"):format(ply:GetName()))
end)
