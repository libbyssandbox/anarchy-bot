local COMMAND = {}

function COMMAND:describe()
	self:set_name("generate")
	self:set_description("!generate (number | string) (min | length <= 100) (max | allow_symbols)")
end

function COMMAND:do_call(_, desired, min, max)
	if not isstring(desired) then
		return anarchy_bot.bot_say("What do you want me to generate?")
	end

	desired = desired:lower()

	if desired == "number" then
		min = tonumber(min)
		max = tonumber(max)

		if not isnumber(min) or not isnumber(max) then
			return anarchy_bot.bot_say("I need a range!")
		end

		anarchy_bot.bot_say("%i", math.random(min, max))
	elseif desired == "string" then
		local length = tonumber(min)

		if isnumber(length) then
			if length <= 100 then
				local allow_symbols = isstring(max) and tobool(max) or false

				anarchy_bot.bot_say("\"%s\"", libbys.random.random_string(length, allow_symbols))
			else
				anarchy_bot.bot_say("Strings can only be 100 characters or less!")
			end
		else
			anarchy_bot.bot_say("How long do you want the string?")
		end
	else
		anarchy_bot.bot_say("What the FUCK is a %s", desired)
	end
end

return libbys.objects.define_subclass("anarchy_bot_GenerateCommand", "anarchy_bot_BaseCommand", COMMAND)
