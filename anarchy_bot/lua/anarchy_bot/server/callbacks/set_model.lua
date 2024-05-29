anarchy_bot:add_callback("PlayerSetModel", function(ply)
	if ply ~= anarchy_bot:get_bot() then return end

	local changemodel = anarchy_bot:find_command("changemodel")
	if not changemodel then return end

	ply:SetModel(changemodel.m_strModel)

	return true
end)
