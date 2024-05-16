local COMMAND = {}

function COMMAND:describe()
	self:set_cooldown(10)
	self:set_global_cooldown(true)

	self:set_name("gpt")
	self:set_description("Say something to ChatGPT")

	self.m_strToken = GetEnvironmentVariable("LIBBYS_GPT_TOKEN")

	if isstring(self.m_strToken) then
		self.m_Headers = {
			["Authorization"] = ("Bearer %s"):format(self.m_strToken),
			["Content-Type"] = "application/json"
		}
	else
		libbys.error.throw_no_halt("AnarchyBOT: Missing GPT token!")
	end
end

function COMMAND.on_success(...)
	print(...)
end

function COMMAND.on_fail(...)
	print(...)
end

-- TODO: Chat context
function COMMAND:get_parameters(...)
	local argstr = table.concat({ ... }, " ")

	return {
		["model"] = "pai-001-light-rp",
		["max_tokens"] = 50,
		["messages"] = { argstr }
	}
end

function COMMAND:do_call(ply, ...)
	if not isstring(self.m_strToken) or self.m_strToken:len() < 1 then
		anarchy_bot.bot_say("I need an API key hmmm")
		return true
	end

	if not istable(self.m_Headers) then
		anarchy_bot.bot_say("So no head?")
		return
	end

	if not isstring(select(1, ...)) then
		anarchy_bot.bot_say("You have to ask me something, dumbfuck")
		return
	end

	http.Post("https://api.pawan.krd/v1/chat/completions", self:get_parameters(...), self.on_success, self.on_fail, self.m_Headers)
end

return libbys.objects.define_subclass("anarchy_bot_GPTCommand", "anarchy_bot_BaseCommand", COMMAND)
