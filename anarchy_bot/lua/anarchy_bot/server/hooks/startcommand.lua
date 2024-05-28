local tr = {}
local td = { output = tr }

local function wander(bot, cmd)
	-- Styling
	if bot:HasWeapon("weapon_physcannon") then
		cmd:SelectWeapon(bot:GetWeapon("weapon_physcannon"))
	end

	-- Walk around
	cmd:SetForwardMove(bot:GetWalkSpeed())

	-- Check for collision with a wall
	local face_pos = bot:EyePos()
	local face_angles = bot:EyeAngles()

	local face_direction = face_angles:Forward()
	face_direction:Mul(bot:BoundingRadius())

	local face_forward = Vector(face_pos)
	face_forward:Add(face_direction)

	td.start = bot:EyePos()
	td.endpos = face_forward
	td.mask = MASK_SOLID
	td.filter = bot

	util.TraceLine(td)

	if tr.Hit then
		face_angles.yaw = math.random(-180, 180)

		bot:SetEyeAngles(face_angles)
	end
end

hook.Add("StartCommand", "anarchy_bot", function(ply, cmd)
	if ply ~= anarchy_bot:get_bot() then return end

	if ply:IsFrozen() or ply:IsEFlagSet(EFL_BOT_FROZEN) then return end

	if GetConVar("bot_crouch"):GetBool() then
		cmd:AddKey(IN_DUCK)
	else
		-- For some reason on 64bit IN_DUCK is always pressed by default
		cmd:RemoveKey(IN_DUCK)
	end

	-- TODO: Attack

	if ply:Health() >= ply:GetMaxHealth() then
		wander(ply, cmd)
	end
end)
