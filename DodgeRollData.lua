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
	[140031] = {duration = 2,notOnlyPlayer = true,texture = "/esoui/art/icons/ability_u26_vampire_02_b.dds",isOnByDefault = true,resultOverride = 2240}, -- Rive
	[140035] = {duration = 2,notOnlyPlayer = true,texture = "/esoui/art/icons/ability_u26_vampire_02_b.dds",isOnByDefault = true,resultOverride = 2240}, -- Rive
	},
	["Stone Garden"] = {
		[135953] = {duration = 2,notOnlyPlayer = true,nameOverride = "Stomp", sourceNameOverride = "Exarch Kraglen",texture="esoui/art/icons/ability_u27_behemothtremor.dds",isOnByDefault = true}, -- Exarch Kraglen Stomp
		[133440] = {duration = 0.25,sound = SOUNDS.DUEL_START,isOnByDefault = true}, -- Scalding Stab
	},
	["Asylum Sanctorium"] = {
		[95428] = {duration = 1,isOnByDefault = true}, --Swipe
		[95545] = {duration = 2,isOnByDefault = true,alertRepeat = {2000,4000},preventDouble = 2000,onlyBlock = true,texture = "/esoui/art/icons/ability_healer_032.dds"}, --Llothis Cone
		[99974] = {duration = 2.5,notOnlyPlayer = true,resultOverride=2240} --Gusts of Steam
	},
	["Black Drake Villa"] = {
		[142717] = {duration = 2.15,isOnByDefault = true}, --Clobber, Kinras Ironeye
		[142612] = {duration = 2,isOnByDefault = true}, --Fiery Blast, Kinras Ironeye
		[141958] = {duration = 1.5,isOnByDefault = true}, --Knuckle Duster, Captain Geminus
		[151647] = {duration = 1.8,isOnByDefault = true}, --Slice, Air Atronach
		[141427] = {duration = 1.4,isOnByDefault = true}, --Heartsfire Spear, Pyroturge Encratis
		[150380] = {duration = 0.6,isOnByDefault = true,sound = SOUNDS.DUEL_START}, --Glacial Gash, Sentinel Aksalaz
		[150366] = {duration = 2,isOnByDefault = true}, --Ravaging Blow, Sentinel Aksalaz
	},
	["Icereach"] = {
		[125690] = {duration = 1,isOnByDefault = true}, --Frigid Swing, Gohlla's Giant
	},
	["Cauldron"] = {
		[146179] = {duration = 1,isOnByDefault = true}, --Galvanic Blow, Baron Zaudrus
		[146142] = {duration = 2.5,isOnByDefault = true}, --Hammer Down, Baron Zaudrus
		[146747] = {duration = 2,isOnByDefault = true}, --Bludgeon, Oxblood the Depraved
		[146677] = {duration = 1.6,isOnByDefault = true}, --Uppercut, Taskmaster Viccia
		[146681] = {duration = 1.4, isOnByDefault = true}, --Crush, Molten Guardian
	},
	["Sunspire"] = {
		[119283] = {duration = 2.9,windup = 1300,texture = "/esoui/art/icons/achievement_els_sunspire_flavor_2.dds"}, --Lokkestiz Breath
		[115723] = {duration = 1.32}, --Lokkestiz Bite
		[123099] = {duration = 0.27}, --Lokkestiz Snap
		[121723] = {duration = 2.9,windup = 2933,texture = "/esoui/art/icons/achievement_els_sunspire_flavor_1.dds"}, --Yolnahkriin Breath
		[122124] = {duration = 1.32}, --Yolnahkriin Bite
		[115589] = {duration = 0.27}, --Yolnahkriin Snap
		[121833] = {duration = 1}, --Yolnahkriin Wing Slap

	}
}
