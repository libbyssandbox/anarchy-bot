local command = {}

function command:describe()
	self.m_iMinStringLength = 10
	self.m_iMaxStringLength = 100

	self.m_AlphanumericSets = {
		{ 65, 90 }, -- A-Z
		{ 97, 122 }, -- a-z
		{ 48, 57 } -- 0-9
	}

	self.m_SymbolSets = {
		{ 33, 47 }, -- ! - /
		{ 58, 64 }, -- : - @
		{ 91, 96 }, -- [ - `
		{ 123, 126 } -- { - ~
	}

	self:set_description("!generate (number | string) (min | length >= %i & <= %i) (max | allow_symbols = false)", self:get_min_string_length(), self:get_max_string_length())
end

function command:get_min_string_length()
	return self.m_iMinStringLength
end

function command:get_max_string_length()
	return self.m_iMaxStringLength
end

function command:generate_number(min, max)
	min = tonumber(min)
	max = tonumber(max)

	if not isnumber(min) or not isnumber(max) then
		anarchy_bot:say("I need a valid min and max!")
		return true
	end

	local value

	-- Only give decimals if they enter a decimal
	if min % 1 ~= 0 or max % 1 ~= 0 then
		value = math.Rand(min, max)
	else
		value = math.random(min, max)
	end

	anarchy_bot:say("%G", value)
end

function command:generate_string(length, allow_symbols)
	length = tonumber(length)

	if not isnumber(length) then
		anarchy_bot:say("How long do you want the string to be?")
		return true
	end

	if length < self:get_min_string_length() or length > self:get_max_string_length() then
		anarchy_bot:say("The length must be between %i and %i", self:get_min_string_length(), self:get_max_string_length())
		return true
	end

	local generated = {}

	for _ = 1, length do
		local master_set = (allow_symbols and math.random() > 0.5) and self.m_SymbolSets or self.m_AlphanumericSets

		local sub_index = math.random(1, #master_set)
		local sub_set = master_set[sub_index]

		local character = math.random(sub_set[1], sub_set[2])

		table.insert(generated, string.char(character))
	end

	anarchy_bot:say("Your string is: %s", table.concat(generated))
end

function command:do_call(bot, ply, desired, a, b)
	if not isstring(desired) then
		anarchy_bot:say("What do you want me to generate?")
		return true
	end

	desired = desired:lower()

	if desired == "number" then
		return self:generate_number(a, b)
	elseif desired == "string" then
		return self:generate_string(a, b)
	end

	anarchy_bot:say("What the FUCK is a %s", desired)
	return true
end

anarchy_bot:register_command(command, "generate")
