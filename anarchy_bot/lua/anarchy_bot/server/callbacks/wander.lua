local tr = {}
local td = { output = tr }

anarchy_bot:add_callback("StartCommand", function(ply, cmd)
	if ply:Health() < ply:GetMaxHealth() then return end

	-- Walk around
	cmd:SetForwardMove(ply:GetWalkSpeed())

	-- Check for collision with a wall
	local face_pos = ply:EyePos()
	local face_angles = ply:EyeAngles()

	local face_direction = face_angles:Forward()
	face_direction:Mul(ply:BoundingRadius())

	local face_forward = Vector(face_pos)
	face_forward:Add(face_direction)

	td.start = ply:EyePos()
	td.endpos = face_forward
	td.mask = MASK_SOLID
	td.filter = ply

	util.TraceLine(td)

	if tr.Hit then
		face_angles.yaw = math.random(-180, 180)

		ply:SetEyeAngles(face_angles)
	end
end)
