libbys.hook.create_unique("PlayerSpawn", function(ply)
	if ply ~= anarchy_bot.get_bot() then return end

	local face_angle = ply:EyeAngles()
	face_angle.yaw = math.random(-180, 180)

	ply:SetEyeAngles(face_angle)
end)
