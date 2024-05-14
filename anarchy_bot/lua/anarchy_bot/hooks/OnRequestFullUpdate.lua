anarchy_bot.connect_cache = {}

libbys.hook.create_unique("OnRequestFullUpdate", function(data)
	if data.userid == "BOT" then return end
	if anarchy_bot.connect_cache[data.userid] then return end

	anarchy_bot.ensure_bot() -- Ensure the bot is valid
end)
