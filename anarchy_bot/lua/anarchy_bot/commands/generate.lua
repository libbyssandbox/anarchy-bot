local COMMAND = {}

function COMMAND:describe()
	self:set_name("generate")
	self:set_description("!generate (number | string) (min | length <= 100) (max | allow_symbols)")
end

function COMMAND.generate_number(min, max)
	min = tonumber(min)
	max = tonumber(max)

	if not isnumber(min) or not isnumber(max) then
		return anarchy_bot.bot_say("I need a range!")
	end

	anarchy_bot.bot_say("%i", math.random(min, max))
end

function COMMAND.generate_string(length, allow_symbols)
	length = tonumber(length)

	if isnumber(length) then
		if length <= 100 then
			allow_symbols = isstring(allow_symbols) and tobool(allow_symbols) or false

			anarchy_bot.bot_say("\"%s\"", libbys.random.random_string(length, allow_symbols))
		else
			anarchy_bot.bot_say("Strings can only be 100 characters or less!")
		end

		return
	end

	anarchy_bot.bot_say("How long do you want the string?")
end

function COMMAND:do_call(_, desired, x, y)
	if not isstring(desired) then
		return anarchy_bot.bot_say("What do you want me to generate?")
	end

	desired = desired:lower()

	if desired == "number" then
		self.generate_number(x, y)
	elseif desired == "string" then
		self.generate_string(x, y)
	else
		anarchy_bot.bot_say("What the FUCK is a %s", desired)
	end
end

return libbys.objects.define_subclass("anarchy_bot_GenerateCommand", "anarchy_bot_BaseCommand", COMMAND)
