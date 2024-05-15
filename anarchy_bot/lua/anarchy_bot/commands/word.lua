local COMMAND = {}

function COMMAND:describe()
	self:set_name("word")
	self:set_description("Says a random word")
end

function COMMAND.on_success(body)
	local data = util.JSONToTable(body)

	if not istable(data) or not isstring(data[1]) then
		anarchy_bot.bot_say("Fuck! I got a papercut!")
		return
	end

	anarchy_bot.bot_say("Your word is: '%s'", data[1])
end

function COMMAND.on_failure()
	anarchy_bot.bot_say("Fuck! I dropped my dictionary!")
end

function COMMAND:do_call()
	http.Fetch("https://random-word-api.herokuapp.com/word", self.on_success, self.on_failure)
end

return libbys.objects.define_subclass("anarchy_bot_WordCommand", "anarchy_bot_BaseCommand", COMMAND)
