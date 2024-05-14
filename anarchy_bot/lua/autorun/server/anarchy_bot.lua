local function libbys_init()
	include("anarchy_bot/init.lua")
end

-- Wait for the SDK
if not istable(libbys) then
	hook.Add("libbys_sdk_loaded", "anarchy_bot_init", libbys_init)
else
	libbys_init()
end
