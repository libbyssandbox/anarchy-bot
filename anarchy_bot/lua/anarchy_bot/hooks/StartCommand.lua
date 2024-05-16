libbys.hook.create_unique("StartCommand", function(ply, cmd)
	if ply ~= anarchy_bot.get_bot() then return end

	if ply:IsFrozen() or ply:IsEFlagSet(EFL_BOT_FROZEN) then return end
	if ply:Health() < ply:GetMaxHealth() then return end

	-- Move our angles towards a cardinal
	local face_angles = ply:EyeAngles()

	local yaw = face_angles.yaw
	local nearest_cardinal = libbys.math.nearest_cardinal(yaw)

	yaw = math.ApproachAngle(yaw, nearest_cardinal, 0.5)

	face_angles.yaw = yaw
	ply:SetEyeAngles(face_angles)

	-- Run around
	cmd:SetForwardMove(ply:GetWalkSpeed())
	if GetConVar("bot_crouch"):GetBool() then
		cmd:AddKey(IN_DUCK)
	else
		cmd:RemoveKey(IN_DUCK)
	end

	-- Turn if we hit a wall
	local face_location = ply:EyePos()
	local face_direction = face_angles:Forward()

	local test_location = Vector(face_location)
	face_direction:Mul(ply:BoundingRadius() * 2)
	test_location:Add(face_direction)

	if libbys.trace.run_trace(face_location, test_location, nil, { ply }).Hit then
		local new_face_angles = Angle(face_angles)
		new_face_angles.yaw = math.random(-180, 180)

		ply:SetEyeAngles(new_face_angles)
	end
end)
