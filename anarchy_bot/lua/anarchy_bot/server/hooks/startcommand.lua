hook.Add("StartCommand", "anarchy_bot", function(ply, cmd)
	if ply ~= anarchy_bot:get_bot() then return end

	if ply:IsFrozen() or ply:IsEFlagSet(EFL_BOT_FROZEN) then return end

	if GetConVar("bot_crouch"):GetBool() then
		cmd:AddKey(IN_DUCK)
	else
		-- For some reason on 64bit IN_DUCK is always pressed by default
		cmd:RemoveKey(IN_DUCK)
	end

	return anarchy_bot:run_callbacks("StartCommand", ply, cmd)
end)
