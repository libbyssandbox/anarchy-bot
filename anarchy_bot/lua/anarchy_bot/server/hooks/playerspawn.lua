hook.Add("PlayerSpawn", "anarchy_bot", function(ply)
	if ply ~= anarchy_bot:get_bot() then return end

	-- Spawn facing a random direction
	local face_angles = ply:EyeAngles()
	face_angles.yaw = math.Rand(-180, 180)

	ply:SetEyeAngles(face_angles)
end)
