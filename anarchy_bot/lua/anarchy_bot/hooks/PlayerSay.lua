libbys.hook.create_unique("PlayerSay", function(ply, text, is_team_chat)
	if not text:StartsWith("!") then return end

	local args = text:sub(2):Split(" ")

	local command_name = args[1]
	local command = anarchy_bot.commands.find(command_name)

	if command then
		timer.Simple(0, function()
			if not IsValid(ply) then return end

			if is_team_chat then
				anarchy_bot.bot_say("I don't run commands in team chat, %s. Stop being a bitch!", ply:GetName())
			else
				command:call(ply, unpack(args, 2))
			end
		end)
	end
end)
