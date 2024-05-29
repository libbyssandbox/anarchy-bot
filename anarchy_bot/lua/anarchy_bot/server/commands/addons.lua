local command = {}

function command:describe()
	self:set_description("Shows the Steam addon collection link")
end

function command:do_call(bot, ply, ...)
	local host_workshop_collection = GetConVar("host_workshop_collection")

	if not host_workshop_collection then
		anarchy_bot:say("It appears collections no longer exist")
		return
	end

	local collection_id = host_workshop_collection:GetString()

	if not isstring(collection_id) or collection_id:len() < 1 then
		anarchy_bot:say("No addon collection is active at the moment!")
		return
	end

	anarchy_bot:say("YOU WANT ADDONS??? >>> https://steamcommunity.com/sharedfiles/filedetails/?id=%s <<<", collection_id)
end

anarchy_bot:register_command(command, "addons")
anarchy_bot:register_command_alias("addons", "collection")
anarchy_bot:register_command_alias("addons", "content")
