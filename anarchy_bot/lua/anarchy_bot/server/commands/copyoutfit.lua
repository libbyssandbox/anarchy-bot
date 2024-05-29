local command = {}

function command:describe()
	self:set_description("Copies your outfitter to the bot")

	self:get_config():set_cooldown_duration(10)
	self:get_config():set_use_global_cooldown(true)
end

function command:try_copy_outfit(bot, ply)
	local uid = ply:UserID()
	local net_table = GetNetDataTable()

	if not istable(net_table) or not istable(net_table[uid]) or not isstring(net_table[uid].OF) then
		anarchy_bot:say("I am no longer pretty... :(")
		return false
	end

	-- Bit of a wonky way of storing and networking this
	local player_net_data = util.JSONToTable(net_table[uid].OF)

	if not istable(player_net_data) then
		anarchy_bot:say("You aren't wearing anything, pervert")
		return false
	end

	local model = player_net_data[1]
	local workshop_id = player_net_data[2]

	outfitter.SHNetworkOutfit(bot, model, workshop_id)
	anarchy_bot:say("I'm so pretty!")

	return true
end

function command:do_call(bot, ply)
	if not isfunction(GetNetDataTable) then
		anarchy_bot:say("I don't think we have outfitter...")
		return true
	end

	if not self:try_copy_outfit(bot, ply) then
		-- Reset on failure
		outfitter.SHNetworkOutfit(bot, nil, nil)
	end
end

anarchy_bot:register_command(command, "copyoutfit")
anarchy_bot:register_command_alias("copyoutfit", "copyoutfitter")
