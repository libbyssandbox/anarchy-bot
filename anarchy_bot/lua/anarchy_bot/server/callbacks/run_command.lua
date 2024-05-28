anarchy_bot:add_callback("player_say", function(data)
	local ply = Player(data.userid)
	if not IsValid(ply) or ply:IsBot() then return end

	local msg = data.text
	if not msg:StartsWith("!") then return end

	local args = msg:sub(2):Split(" ")

	local command_name = args[1]
	local command = anarchy_bot.commands[command_name:lower()]

	if not command then return end

	if data.teamonly == 1 then
		anarchy_bot:say("I don't run commands in team chat, stop being a bitch %s!", ply:GetName())

		return
	end

	command:call(ply, unpack(args, 2))
end)
