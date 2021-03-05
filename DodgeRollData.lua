HTT_DodgeRollData = { 
	-- [abilityID] = {duration,notOnlyPlayer,soundAlert,texture,dodgeDurationOverride,onlyBlock,preventDouble}
	
	["Fungal Grotto"] = {
		[17046] = {duration = 2}, --Haymaker, Warchief Ozozai
		[17228] = {duration = 1.8,preventDouble = 200}, --Frenzy of Blows, Tazkad the Packmaster shows double
		[17728] = {duration = 3, preventDouble = 300}, --Daedric Blast
	},
	["Ruins of Mazzatun"] = {
		[76538] = {duration = 1.6}, --Bash
		[76335] = {duration = 1.6}, --Rumbling Smash
	},
	["Cloudrest"] = {
		[105968] = {duration = 2}, --Corpulence
		[105975] = {duration = 1,sound = SOUNDS.DUEL_START}, --Baneful Barb
		[106375] = {duration = 2}, --Ravaging Blow
		[104755] = {duration = 2}, --Scalding Sunder
		[105780] = {duration = 2}, --Shocking Smash
		[104413] = {duration = 2.5,notOnlyPlayer = true,dodgeDurationOverride = 0.5}, --Shifting Shadows Cone
		[104535] = {duration = 2.5,onlyBlock = true}, --Nocturnal's Favor
	},
	["Castle Thorn"] = {
	[137544] = {duration = 2.5,notOnlyPlayer = true,texture = "/esoui/art/icons/ability_u26_vampire_02_b.dds",isOnByDefault = true}, -- Rive (moving)
	[137285] = {duration = 3,0,notOnlyPlayer = true,texture = "/esoui/art/icons/ability_u26_vampire_02_b.dds",isOnByDefault = true}, -- Rive (normal phase)
	[137833] = {duration = 2.5,notOnlyPlayer = true,texture = "/esoui/art/icons/ability_u26_vampire_02_b.dds",isOnByDefault = true}, -- Rive (boss flying phase)
	[140031] = {duration = 2.5,notOnlyPlayer = true,texture = "/esoui/art/icons/ability_u26_vampire_02_b.dds",isOnByDefault = true,notBeginning = 2240}, -- Rive
	[140035] = {duration = 2.5,notOnlyPlayer = true,texture = "/esoui/art/icons/ability_u26_vampire_02_b.dds",isOnByDefault = true,notBeginning = 2240}, -- Rive
	--missing rive id
	},
	["Stone Garden"] = {
		[135953] = {duration = 2,notOnlyPlayer = true,nameOverride = "Stomp", sourceNameOverride = "Exarch Kraglen",texture="esoui/art/icons/ability_u27_behemothtremor.dds",isOnByDefault = true}, -- Exarch Kraglen Stomp
		[133440] = {duration = 0.25,sound = SOUNDS.DUEL_START,isOnByDefault = true}, -- Scalding Stab
	},


}
