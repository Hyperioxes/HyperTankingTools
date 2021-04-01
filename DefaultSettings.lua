	HTT.defaultPreset = {
	specialUIHeight = 70,
	specialUIWidth = 210,
	specialUIScale = 1,

	buffUIHeight = 20,
	buffUIWidth = 210,
	buffUIScale = 1,

	debuffUIHeight = 20,
	debuffUIWidth = 210,
	debuffUIScale = 1,

	debuffBossUIHeight = 20,
	debuffBossUIWidth = 210,
	debuffBossUIScale = 1,

	cooldownUIHeight = 20,
	cooldownUIWidth = 210,
	cooldownUIScale = 1,

	synergiesUIHeight = 20,
	synergiesUIWidth = 210,
	synergiesUIScale = 1,

	alertUIHeight = 20,
	alertUIWidth = 210,
	alertUIScale = 1,

	alertNotifications = {},

	trackOnlyDD = false,

	isReflectIndicatorOn = true,
	reflectIndicatorColor = {
		[1] = 1,
		[2] = 1,
		[3] = 1,
		[4] = 1,
	},

	debuffFont = "ZoFontGameSmall",
	buffFont = "ZoFontGameSmall",
	bossFont = "ZoFontGameSmall",
	cooldownFont = "ZoFontGameSmall",
	synergiesFont = "ZoFontGameSmall",
	specialFont = "ZoFontGameSmall",

	shieldTextureHeight = 170,
	shieldTextureWidth = 170,
	isBlockUIOn = true,
	isBlockCostOn = true,
	isDebuffUIOn = true,
	isBuffUIOn = true,
	isSpecialUIOn = true,
	isBossDebuffUIOn = false,
	isCooldownUIOn = true,
	isAltResourceUIOn = false,
	isBaseGameUIOn = true,
	isAutoCooldownTurnedOn = true,
	isAlertUIOn = true,
	isSynergiesUIOn = true,
	isStoneFistCustomIconOn = true,
	isStraightResourceOn = false,
	xOffset = 200,
	yOffset = 200,
	xOffsetBosses = 200,
	yOffsetBosses = 200,
	xOffsetOwnStacks = 200,
	yOffsetOwnStacks = 200,
	xOffsetBlock = 200,
	yOffsetBlock = 200,
	xOffsetSelfBuffs = 200,
	yOffsetSelfBuffs = 200,
	xOffsetBoss1 = 200,
	yOffsetBoss1 = 200,
	xOffsetBoss2 = 200,
	yOffsetBoss2 = 200,
	xOffsetBoss3 = 200,
	yOffsetBoss3 = 200,
	xOffsetBoss4 = 200,
	yOffsetBoss4 = 200,
	xOffsetBoss5 = 200,
	yOffsetBoss5 = 200,
	xOffsetBoss6 = 200,
	yOffsetBoss6 = 200,
	xOffsetAlert = 200,
	yOffsetBoss6 = 200,
	xOffsetCooldowns = 200,
	yOffsetCooldowns = 200,
	xOffsetHealth = 200,
	yOffsetHealth = 200,
	xOffsetStamina = 200,
	yOffsetStamina = 200,
	xOffsetMagicka = 200,
	yOffsetMagicka = 200,
	xOffsetHealthStraight = 0,
	yOffsetHealthStraight = 0,
	xOffsetStaminaStraight = 0,
	yOffsetStaminaStraight = 0,
	xOffsetMagickaStraight = 0,
	yOffsetMagickaStraight = 0,
	xOffsetSynergies = 200,
	yOffsetSynergies = 200,
	width=200,
	height=40,
	currentlySelectedBarTexture = "HyperTankingTools/icons/gradientProgressBar.dds",
	customShield = "HyperTankingTools/icons/customShield3.dds",
	classSpecialColor = {1,0.84, 0.19, 1},
	classSpecialIsOn = true,
	reticleBackgroundColor = {
                [4] = 1,
                [1] = 0,
                [2] = 0,
                [3] = 0,
	},
	buffBackgroundColor = {
                [4] = 1,
                [1] = 0,
                [2] = 0,
                [3] = 0,
	},
	specialBackgroundColor = {
                [4] = 1,
                [1] = 0,
                [2] = 0,
                [3] = 0,
	},
	cooldownBackgroundColor = {
                [4] = 1,
                [1] = 0,
                [2] = 0,
                [3] = 0,
	},
	synergiesBackgroundColor = {
                [4] = 1,
                [1] = 0,
                [2] = 0,
                [3] = 0,
	},
	bossBackgroundColor = {
				[4] = 1,
                [1] = 0,
                [2] = 0,
                [3] = 0,
	},
	offBalanceImmunityText = "Off-Balance Immunity",
	debuffTable = {
		["none"] = {
			name = "none",
			turnedOn = false,
			turnedOnBoss = false,
			color = {0,0,0,0},
			color2 = {0,0,0,0},
			color3 = {0,0,0,0},
			IDs = {},
			icon = "none",
			duration = {},
			expiresAt = {},
			skill = {},
			itemSet = {},
			text = "none",
			textWhenMissing = "none",
			onlyCastByPlayer = false
		}
	},
	orderOfDebuffs = {},
	debuffNameToID = {},
	buffTable = {
		["none"] = {
			name = "none",
			turnedOn = false,
			color = {0,0,0,0},
			IDs = {},
			icon = "none",
			duration = 0,
			expiresAt = 0,
			skill = {},
			itemSet = {},
			text = "none",
			textWhenMissing = "none",
		}
	},
	orderOfBuffs = {},
	buffNameToID = {},
	cooldownTable = {
		["none"] = {
			name = "none",
			turnedOn = false,
			color = {0,0,0,0},
			IDs = {},
			icon = "none",
			duration = 0,
			expiresAt = 0,
			skill = {},
			itemSet = {},
			text = "none",
			textWhenMissing = "none",
		}
	},
	orderOfCooldowns = {},
	cooldownNameToID = {},
	synergiesTable = {
		["none"] = {
			name = "none",
			turnedOn = false,
			color = {0,0,0,0},
			IDs = {},
			icon = "none",
			expiresAt = 0,
			text = "none",
			textWhenMissing = "none",
		},
    },
    
	orderOfSynergies = {},
	synergyNameToID = {},
}


for k,v in pairs(HTT_DodgeRollData) do
	for k1,v1 in pairs(v) do
		HTT.defaultPreset["alertNotifications"][k1] = v1.isOnByDefault or false
	end
end



HTT_defaultSettingsCharacterSpecific = {

	

	["currentlySelectedProfile"] = "test1",
}

HTT_defaultSettingsAccountWideNonProfile = {
	xOffsetAlertBoss1 = 0,
	yOffsetAlertBoss1 = 0,
	xOffsetAlertBoss2 = 0,
	yOffsetAlertBoss2 = 0,
	xOffsetAlertBoss3 = 0,
	yOffsetAlertBoss3 = 0,

	--ASYLUM
	Asylum = true,
	Olms = true,
	OlmsBreath = true,
	OlmsKite = true,
	OlmsExhaustive = true,
	Llothis = true,
	LlothisInterrupt = true,
	LlothisInterruptSound = SOUNDS.DUEL_START,
	LlothisCone = true,
	LlothisJump = true,
	Felms = true,
	FelmsManifest = true,
	FelmsJump = true,

}

HTT_defaultSettings = {
	["availableProfiles"] = {
	},
	
	["none"] = HTT.defaultPreset,
}

