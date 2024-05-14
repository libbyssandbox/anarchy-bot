libbys.hook.create_unique("PlayerSay", function(ply, text, is_team_chat)
	if not text:StartsWith("!") then return end

	local args = text:sub(2):Split(" ")
	local command_name = args[1]

	for k, command in next, anarchy_bot.commands.list do
		if k == command_name then
			timer.Simple(0, function()
				if is_team_chat then
					anarchy_bot.bot_say("I don't run commands in team chat, %s. Stop being a bitch!", ply:GetName())
				else
					command:call(ply, unpack(args, 2))
				end
			end)

			break
		end
	end
end)
