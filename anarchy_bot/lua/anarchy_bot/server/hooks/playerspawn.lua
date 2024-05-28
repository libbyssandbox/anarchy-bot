hook.Add("PlayerSpawn", "anarchy_bot", function ply(arguments)
	if ply ~= anarchy_bot:get_bot() then return end

	local face_angles = ply:EyeAngles()
	face_angles.yaw = math.Rand(-180, 180)

	ply:SetEyeAngles(face_angles)
end)
