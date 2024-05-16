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

		self.m_PostTemplate = {
			["url"] = "https://api.pawan.krd/v1/chat/completions",
			["method"] = "POST",
			["headers"] = self.m_Headers,
			["type"] = "application/json",

			["success"] = self.on_success,
			["failed"] = self.on_fail
		}
	else
		libbys.error.throw_no_halt("AnarchyBOT: Missing GPT token!")
	end
end

function COMMAND.on_success(code, body)
	if code ~= 200 then return self.on_fail() end

	local received = util.JSONToTable(body)
	if not istable(received) then return self.on_fail() end

	PrintTable(received)
end

function COMMAND.on_fail()
	anarchy_bot.bot_say("AI is busy taking over the world, please try later")
end

-- TODO: Chat context
function COMMAND:get_parameters(...)
	local argstr = table.concat({ ... }, " ")

	return {
		["model"] = "pai-001-light",
		["temperature"] = 0.7,
		["max_tokens"] = 50,
		["messages"] = {
			{
				["role"] = "user",
				["content"] = argstr
			}
		}
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

	self.m_PostTemplate.body = util.TableToJSON(self:get_parameters(...))

	HTTP(self.m_PostTemplate)
end

return libbys.objects.define_subclass("anarchy_bot_GPTCommand", "anarchy_bot_BaseCommand", COMMAND)
