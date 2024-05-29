local command = {}

function command:describe()
	self.m_Taunts = {
		ACT_GMOD_GESTURE_AGREE,
		ACT_GMOD_GESTURE_BECON,
		ACT_GMOD_GESTURE_BOW,
		ACT_GMOD_GESTURE_DISAGREE,
		ACT_GMOD_TAUNT_SALUTE,
		ACT_GMOD_GESTURE_WAVE,
		ACT_GMOD_TAUNT_PERSISTENCE,
		ACT_GMOD_TAUNT_MUSCLE,
		ACT_GMOD_TAUNT_LAUGH,
		-- ACT_GMOD_GESTURE_POINT, -- Doesn't seem to work
		ACT_GMOD_TAUNT_CHEER,
		ACT_GMOD_TAUNT_DANCE,
		ACT_GMOD_TAUNT_ROBOT
	}

	self:set_description("!taunt | !taunt (^)")
end

function command:do_call(bot, ply, target)
	local taunt = self.m_Taunts[math.random(1, #self.m_Taunts)]

	-- This is horrible why is AnimRestartGesture not networked
	-- Truly one of the video games of all time
	local ent_index = 0
	local very_good_code = [[Entity(%i):AnimRestartGesture(GESTURE_SLOT_CUSTOM, %i, true)]]

	if target == "^" then
		ent_index = ply:EntIndex()
	else
		ent_index = bot:EntIndex()
	end

	very_good_code = very_good_code:format(ent_index, taunt)

	RunString(very_good_code)
	BroadcastLua(very_good_code)
end

anarchy_bot:register_command(command, "taunt")
