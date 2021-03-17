HTT_variables = {
	isUIPreviewOn = false,

	immovableOn = false,
	isBoundAegisOn = false,
	isSacredGroundOn = false,

	eventWindowVisibility = false,
	buffWindowVisibility = false,
	debuffWindowVisibility = false,
	abilityWindowVisibility = false,
	eventWindowListening = false,
	alternativeUIMovable = false,
	isReflectActive = false,
	reflectExpiresAt = 0,
	currentlySelectedProfile,
	alkoshHits = {},
	targetNameUnitID = {},
	scene,
	maxMag,effectiveSpellDamage,
	engulfingMagCoefficient = 0.00015873,
	engulfingSpellCoefficient = 0.00145, --needs adjustment

	roleIcons = {
	[0] = "/esoui/art/contacts/gamepad/gp_social_status_offline.dds",
	[1] = "/esoui/art/lfg/gamepad/lfg_roleicon_dps.dds",
	[2] = "/esoui/art/lfg/gamepad/lfg_roleicon_tank.dds",
	[4] = "/esoui/art/lfg/gamepad/lfg_roleicon_healer.dds",
	},

	slotToAbilityID = {
		[40445] = 48136, -- Spell Symmetry
		[31642] = 48131, -- Equilibrium
		[40441] = 48141, -- Balance
	},

	anchorsByNumber = {
	[-1] = BOTTOMLEFT,
	[0] = BOTTOM,
	[1] = BOTTOMRIGHT
	},

	fontMultipliers = {
		["ZoFontGameSmall"] = {
			[1] = 20,
		},
		["ZoFontCallout3"] = {
			[1] = 80,
		},
	},

	targetsWithOffBalanceImmunity = {},

	classSettings = {
		[1] = { -- DK
			["buffs"] = {3},
			["debuffs"] = {1,3},
			["cooldowns"] = {5},
		},
		[2] = { -- Sorcerer
			["buffs"] = {7,8,9},
			["debuffs"] = {11},
			["cooldowns"] = {},
		},
		[3] = { -- Nightblade
			["buffs"] = {13,14},
			["debuffs"] = {6},
			["cooldowns"] = {7},
		},
		[4] = { -- Warden
			["buffs"] = {5,6},
			["debuffs"] = {6},
			["cooldowns"] = {6},
		},
		[5] = { -- Necro
			["buffs"] = {12},
			["debuffs"] = {},
			["cooldowns"] = {8},
		},
		[6] = { -- Templar
			["buffs"] = {10,11},
			["debuffs"] = {},
			["cooldowns"] = {9},
		},




	},


	specialTextures = {
		[1] = "HyperTankingTools/icons/assfist.dds",
		[4] = "HyperTankingTools/icons/shimmering.dds",
	},

	specialID = {
		[1] = 31816,
		[4] = 86143,
	},

	specialDuration = {
		[1] = 12,
		[4] = 6,
	},

	specialExpireTime = {
		[1] = 0,
		[4] = 0,
	},

	specialStacks = {
		[1] = 0,
		[4] = 0,
	},



	exceptionsToEvents = {},

	weaponSkills = {
		[39018] = "Blockade of Lightning",
		[39028] = "Blockade of Frost",
		[39012] = "Blockade of Fire",
		[38695] = "Arrow Barrage",
		[28876] = "Volley",
		[38689] = "Endless Hail",
		[28807] = "Wall of Fire",
		[28849] = "Wall of Frost",
		[28854] = "Wall of Lightning",
		[39067] = "Unstable wall of Frost",
		[39073] = "Unstable wall of Lightning",
		[39053] = "Unstable wall of Fire",
	},
}
