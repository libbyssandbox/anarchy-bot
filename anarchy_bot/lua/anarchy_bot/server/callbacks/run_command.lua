anarchy_bot:add_callback("player_say", function(data)
	local ply = Player(data.userid)
	if not IsValid(ply) or ply:IsBot() then return end

	local msg = data.text
	if not msg:StartsWith("!") then return end

	local args = msg:Split(" ")

	local command = anarchy_bot:find_command(args[1])
	if not command then return end

	if data.teamonly == 1 then
		anarchy_bot:say("I don't run commands in team chat, stop being a bitch %s!", ply:GetName())
		return
	end

	-- unpack city is slow, but it's only twice so it's fine
	-- :clueless:
	if not command:can_call(ply, unpack(args, 2)) then
		anarchy_bot:say("Noobens are not allowed to run this command, %s", ply:GetName())
		return
	end

	command:call(ply, unpack(args, 2))
end)
