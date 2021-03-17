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
	orderOfDebuffs = {
                    [1] = 13,
                    [2] = 14,
                    [3] = 2,
                    [4] = 4,
                    [5] = 5,
                    [6] = 9,
                    [7] = 15,
                    [8] = 1,
                    [9] = 3,
                    [10] = 11,
                    [11] = 12,
                    [12] = 100,
                    [13] = 6,
                    [14] = 7,
                    [15] = 8,
                    [16] = 10,
                },
	orderOfBuffs = {
                    [1] = 4,
                    [2] = 17,
                    [3] = 15,
                    [4] = 16,
                    [5] = 18,
                    [6] = 19,
                    [7] = 20,
                    [8] = 21,
                    [9] = 2,
                    [10] = 1,
                    [11] = 3,
                    [12] = 5,
                    [13] = 6,
                    [14] = 7,
                    [15] = 8,
                    [16] = 9,
                    [17] = 10,
                    [18] = 11,
                    [19] = 12,
                    [20] = 13,
                    [21] = 14,
                    [22] = 100,
                },
	orderOfCooldowns = {
                    [1] = 1,
                    [2] = 2,
                    [3] = 3,
                    [4] = 4,
                    [5] = 5,
                    [6] = 6,
                    [7] = 7,
                    [8] = 8,
                    [9] = 9,
                },
	orderOfSynergies = {
		[1] = 1,
		[2] = 2,
		[3] = 3,
		[4] = 4,
		[5] = 5,
		[6] = 6,
		[7] = 7,
		[8] = 8,
		[9] = 9,
		[10] = 10,
		[11] = 11,
		[12] = 12,
		[13] = 13,
		[14] = 14,
		[15] = 15,
		[16] = 16,
		[17] = 17,
	},
	synergiesTable = {
		["names"] = {
			[1] = "Sanguine Burst",
			[2] = "Resource Restore",
			[3] = "Hidden Refresh",
			[4] = "Spiders",
			[5] = "Bone Shield",
			[6] = "Blood Altar",
			[7] = "Radiate",
			[8] = "Soul Leech",
			[9] = "Conduit",
			[10] = "Attronach",
			[11] = "Supernova",
			[12] = "Ignite",
			[13] = "Shackle",
			[14] = "Harvest",
			[15] = "Gate",
			[16] = "Grave Robber",
			[17] = "Pure Agony",
		},
		["icons"] = {
			[1] = GetAbilityIcon(142305),
			[2] = GetAbilityIcon(39301),
			[3] = GetAbilityIcon(37729),
			[4] = GetAbilityIcon(39429),
			[5] = GetAbilityIcon(39379),
			[6] = "/esoui/art/icons/ability_undaunted_001.dds",
			[7] = GetAbilityIcon(41838),
			[8] = GetAbilityIcon(25170),
			[9] = "/esoui/art/icons/ability_sorcerer_lightning_splash.dds",
			[10] = "/esoui/art/icons/ability_sorcerer_storm_atronach.dds",
			[11] = "/esoui/art/icons/ability_templar_nova.dds",
			[12] = GetAbilityIcon(32974),
			[13] = GetAbilityIcon(32910),
			[14] = GetAbilityIcon(85572),
			[15] = GetAbilityIcon(88892),
			[16] = "/esoui/art/icons/ability_necromancer_004.dds",
			[17] = "/esoui/art/icons/ability_necromancer_010_b.dds",
		},
		["IDs"] = {
			[1] = {142305}, -- Lady Thorn
			[2] = { -- Resource Restore

				[1] = 63507, -- Healing Combustion
				[2] = 39301, -- Combustion
				[3] = 94973, -- Blessed Shards
				[4] = 95928, -- Holy Shards

			}, 
			[3] = {37729}, -- Hidden Refresh
			[4] = { -- Spids

				[1] = 41994, -- Black Widow
				[2] = 39429, -- Spawn Broodling
				[3] = 42016, -- Arachnophobia

			},
			[5] = { -- Bone Shield
			
				[1] = 39379, -- Bone Wall
				[2] = 42198, -- Spinal Surge

			},
			[6] = {
			
				[1] = 41964, -- Blood Feast
				[2] = 39501, -- Blood Funnel

			},
			[7] = {41838}, -- Radiate
			[8] = {25170}, -- Soul Leech
			[9] = {43769}, -- Conduit
			[10] = {121059}, -- Charged Lightning
			[11] = { -- Nut
			
				[1] = 48939, -- Supernova
				[2] = 48938, -- Gravity Nut

			},
			[12] = {32974}, -- Ignite
			[13] = {32910}, -- Shackle
			[14] = {85572}, -- Harvest
			[15] = {88892}, -- Gate
			[16] = {115567}, -- Grave Robber
			[17] = {118610}, -- Pure Agony
		},
		["texts"] = {
			[1] = "Sanguine Burst on cooldown",
			[2] = "Resource Restore on cooldown",
			[3] = "Hidden Refresh on cooldown",
			[4] = "Spiders on cooldown",
			[5] = "Bone Shield on cooldown",
			[6] = "Blood Altar on cooldown",
			[7] = "Radiate on cooldown",
			[8] = "Soul Leech on cooldown",
			[9] = "Conduit on cooldown",
			[10] = "Attronach on cooldown",
			[11] = "Supernova on cooldown",
			[12] = "Ignite on cooldown",
			[13] = "Shackle on cooldown",
			[14] = "Harvest on cooldown",
			[15] = "Gate on cooldown",
			[16] = "Grave Robber on cooldown",
			[17] = "Pure Agony on cooldown",
		},
		["colors"] = 
        {
            [1] = 
            {
                [4] = 1,
                [1] = 0.8117647171,
                [2] = 0,
                [3] = 0.2000000030,
            },
            [2] = 
            {
                [4] = 1,
                [1] = 0.2235294133,
                [2] = 0.8117647171,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 1,
                [1] = 0.4666666687,
                [2] = 0,
                [3] = 0.1137254909,
            },
            [4] = 
            {
                [4] = 1,
                [1] = 0.9568627477,
                [2] = 1,
                [3] = 0.3607843220,
            },
            [5] = 
            {
                [4] = 1,
                [1] = 0.8235294223,
                [2] = 1,
                [3] = 0.6156862974,
            },
            [6] = 
            {
                [4] = 1,
                [1] = 1,
                [2] = 0,
                [3] = 0.1607843190,
            },
            [7] = 
            {
                [4] = 1,
                [1] = 1,
                [2] = 0.5019608140,
                [3] = 0,
            },
            [8] = 
            {
                [4] = 1,
                [1] = 1,
                [2] = 0.5176470876,
                [3] = 0.5098039508,
            },
            [9] = 
            {
                [4] = 1,
                [1] = 0.1294117719,
                [2] = 0.4823529422,
                [3] = 0.8117647171,
            },
            [10] = 
            {
                [4] = 1,
                [1] = 0.1450980455,
                [2] = 0,
                [3] = 1,
            },
            [11] = 
            {
                [4] = 1,
                [1] = 1,
                [2] = 0.9686274529,
                [3] = 0.4078431427,
            },
            [12] = 
            {
                [4] = 1,
                [1] = 1,
                [2] = 0.2666666806,
                [3] = 0,
            },
            [13] = 
            {
                [4] = 1,
                [1] = 1,
                [2] = 0.4470588267,
                [3] = 0,
            },
            [14] = 
            {
                [4] = 1,
                [1] = 0.3882353008,
                [2] = 0.8313725591,
                [3] = 0.4196078479,
            },
            [15] = 
            {
                [4] = 1,
                [1] = 0.6156862974,
                [2] = 0.9647058845,
                [3] = 1,
            },
            [16] = 
            {
                [4] = 1,
                [1] = 0.4078431427,
                [2] = 0.2392156869,
                [3] = 0.8117647171,
            },
            [17] = 
            {
                [4] = 1,
                [1] = 0.1529411823,
                [2] = 0,
                [3] = 1,
            },
        },
		["isTurnedOn"] = {
			[1] = false,
			[2] = true,
			[3] = false,
			[4] = false,
			[5] = false,
			[6] = true,
			[7] = false,
			[8] = false,
			[9] = true,
			[10] = false,
			[11] = false,
			[12] = false,
			[13] = false,
			[14] = true,
			[15] = false,
			[16] = true,
			[17] = false,
		},
		["textWhenMissing"] = {
			[1] = "Sanguine Burst ready",
			[2] = "Resource Restore ready",
			[3] = "Hidden Refresh ready",
			[4] = "Spiders ready",
			[5] = "Bone Shield ready",
			[6] = "Blood Altar ready",
			[7] = "Radiate ready",
			[8] = "Soul Leech ready",
			[9] = "Conduit ready",
			[10] = "Attronach ready",
			[11] = "Supernova ready",
			[12] = "Ignite ready",
			[13] = "Shackle ready",
			[14] = "Harvest ready",
			[15] = "Gate ready",
			[16] = "Grave Robber ready",
			[17] = "Pure Agony ready",
		},
		["expiresAt"] = {
			[1] = 0,
			[2] = 0,
			[3] = 0,
			[4] = 0,
			[5] = 0,
			[6] = 0,
			[7] = 0,
			[8] = 0,
			[9] = 0,
			[10] = 0,
			[11] = 0,
			[12] = 0,
			[13] = 0,
			[14] = 0,
			[15] = 0,
			[16] = 0,
			[17] = 0,
		},

	
	
	
	
	
	
	
	
	
	
	
	},
	cooldownTable = {
		["itemSet"] = {
			[1] = {
				[1] = "|H1:item:167116:364:50:68343:370:50:16:0:0:0:0:0:0:0:1:67:0:1:0:10000:0|h|h",
				[2] = 2,
			},
			[2] = {
				[1] = "|H1:item:94551:364:50:0:0:0:0:0:0:0:0:0:0:0:1:67:0:1:0:10000:0|h|h",
				[2] = 2,
			},
			[3] = {
				[1] = "|H1:item:150869:364:50:68343:370:50:13:0:0:0:0:0:0:0:1:86:0:1:0:8321:0|h|h",
				[2] = 3,
			},
			[4] = {
				[1] = "|H1:item:138531:364:50:26845:370:50:2:0:0:0:0:0:0:0:2049:73:0:1:0:406:0|h|h",
				[2] = 3,
			},
		},
		["isPreMade"] = {
			[1] = true,
			[2] = true,
			[3] = true,
			[4] = true,
			[5] = true,
			[6] = true,
			[7] = true,
			[8] = true,
			[9] = true,
		},
		["names"] = {
			[1] = "Lady Thorn",
			[2] = "Tremorscale",
			[3] = "Yolnahkriin",
			[4] = "Olorime",
			[5] = "Mountain's Blessing",
			[6] = "Savage Beast",
			[7] = "Transfer",
			[8] = "Corpse Consumption",
			[9] = "Prism",
		},
		["icons"] = {
			[1] = GetAbilityIcon(141972),
			[2] = GetAbilityIcon(80865),
			[3] = "/esoui/art/icons/gear_sunspire_heavy_helmet_a.dds",
			[4] = "/esoui/art/icons/gear_welkynar_light_head_a.dds",
			[5] = "/esoui/art/icons/ability_dragonknight_024.dds",
			[6] = "/esoui/art/icons/passive_warden_009.dds",
			[7] = "/esoui/art/icons/passive_sorcerer_002.dds",
			[8] = "/esoui/art/icons/passive_necromancer_011.dds",
			[9] = "/esoui/art/icons/ability_templar_031.dds",
		},
		["IDs"] = {
			[1] = {141905}, -- Lady Thorn
			[2] = {80865}, -- Tremorscale
			[3] = {121878}, -- Yolnahkriin
			[4] = {109084}, -- Olorime
			[5] = {45005}, -- Mountain's Blessing
			[6] = {88513}, -- Savage Beast
			[7] = {45146}, -- Transfer
			[8] = {120612}, --Corpse Consumption
			[9] = {45217}, -- Prism
		},
		["durations"] = {
			[1] = 10,
			[2] = 7,
			[3] = 8,
			[4] = 10,
			[5] = 6,
			[6] = 8,
			[7] = 4,
			[8] = 16,
			[9] = 6,
		},
		["texts"] = {
			[1] = "Lady Thorn on cooldown",
			[2] = "Tremorscale on cooldown",
			[3] = "Yolnahkriin on cooldown",
			[4] = "Olorime on cooldown",
			[5] = "+3 ultimate on cooldown",
			[6] = "+4 ultimate on cooldown",
			[7] = "+2 ultimate on cooldown",
			[8] = "+10 ultimate on cooldown",
			[9] = "+3 ultimate on cooldown",
		},
		["colors"] = 
                    {
                        [1] = 
                        {
                            [1] = 0.8117647171,
                            [2] = 0,
                            [3] = 0.2000000030,
                            [4] = 1,
                        },
                        [2] = 
                        {
                            [1] = 0.6980392337,
                            [2] = 0.5411764979,
                            [3] = 0.3490196168,
                            [4] = 1,
                        },
                        [3] = 
                        {
                            [1] = 1,
                            [2] = 0.4980392158,
                            [3] = 0,
                            [4] = 1,
                        },
                        [4] = 
                        {
                            [1] = 0.0078431377,
                            [2] = 1,
                            [3] = 0,
                            [4] = 1,
                        },
						[5] = 
                        {
                            [1] = 0.7176470757,
                            [2] = 0.1450980455,
                            [3] = 0,
                            [4] = 1,
                        },
						[6] = 
                        {
                            [1] = 0,
                            [2] = 0.2431372553,
                            [3] = 0.7176470757,
                            [4] = 1,
                        },
                        [7] = 
                        {
                            [1] = 0.6627451181,
                            [2] = 0.2039215714,
                            [3] = 0.8235294223,
                            [4] = 1,
                        },
                        [8] = 
                        {
                            [1] = 0.7176470757,
                            [2] = 0,
                            [3] = 0.1254902035,
                            [4] = 1,
                        },
                        [9] = 
                        {
                            [1] = 1,
                            [2] = 0.8588235378,
                            [3] = 0.4745098054,
                            [4] = 1,
                        },
                    },
		["isTurnedOn"] = {
			[1] = false,
			[2] = false,
			[3] = false,
			[4] = false,
			[5] = false,
			[6] = false,
			[7] = false,
			[8] = false,
			[9] = false,
		},
		["textWhenMissing"] = {
			[1] = "Lady Thorn ready",
			[2] = "Tremorscale ready",
			[3] = "Yolnahkriin ready",
			[4] = "Olorime ready",
			[5] = "+3 ultimate ready",
			[6] = "+4 ultimate ready",
			[7] = "+2 ultimate ready",
			[8] = "+10 ultimate ready",
			[9] = "+3 ultimate ready",
		},
		["expiresAt"] = {
			[1] = 0,
			[2] = 0,
			[3] = 0,
			[4] = 0,
			[5] = 0,
			[6] = 0,
			[7] = 0,
			[8] = 0,
			[9] = 0,
		},

	},

	buffTable = {
		["isPreMade"] = {
			[1] = true,
			[2] = true,
			[3] = true,
			[4] = true,
			[5] = true,
			[6] = true,
			[7] = true,
			[8] = true,
			[9] = true,
			[10] = true,
			[11] = true,
			[12] = true,
			[13] = true,
			[14] = true,
			[15] = true,
			[16] = true,
			[17] = true,
			[18] = true,
			[19] = true,
			[20] = true,
			[21] = true,
			[100] = true,
		},
		["names"] = {
			[1] = "Immovable",
			[2] = "Minor Courage",
			[3] = "Dragon Blood",
			[4] = "Major Resolve",
			[5] = "Bull Netch",
			[6] = "Polar Wind",
			[7] = "Bound Aegis",
			[8] = "Dark Deal",
			[9] = "Crystal Weapon",
			[10] = "Sacred Ground",
			[11] = "Rune Focus bonus",
			[12] = "Spirit Guardian bonus",
			[13] = "Dark Cloak",
			[14] = "Leeching Strikes",
			[15] = "Minor Heroism",
			[16] = "Major Heroism",
			[17] = "Minor Resolve",
			[18] = "Minor Mending",
			[19] = "Major Mending",
			[20] = "Minor Vitality",
			[21] = "Major Vitality",
			[100] = "Puncturing Remedy",
		},
		["icons"] = {
			[1] = GetAbilityIcon(126583),
			[2] = GetAbilityIcon(147417),
			[3] = GetAbilityIcon(32745),
			[4] = GetAbilityIcon(61694),
			[5] = GetAbilityIcon(86058),
			[6] = GetAbilityIcon(90835),
			[7] = GetAbilityIcon(24163),
			[8] = GetAbilityIcon(114908),
			[9] = GetAbilityIcon(46331),
			[10] = GetAbilityIcon(77082),
			[11] = GetAbilityIcon(112145),
			[12] = GetAbilityIcon(118912),
			[13] = GetAbilityIcon(25377),
			[14] = GetAbilityIcon(36908),
			[15] = GetAbilityIcon(61708),
			[16] = GetAbilityIcon(61709),
			[17] = GetAbilityIcon(61693),
			[18] = GetAbilityIcon(61710),
			[19] = GetAbilityIcon(61711),
			[20] = GetAbilityIcon(61549),
			[21] = GetAbilityIcon(61713),
			[100] = GetAbilityIcon(100575),
		},
		["IDs"] = {
			[1] = {126583}, -- Immovable
			[2] = {147417}, -- Minor Courage
			[3] = {32745}, -- Dragon Blood
			[4] = {61694}, -- Major Resolve
			[5] = {86058}, -- Stamina Bull Netch
			[6] = {90835}, -- Polar Wind
			[7] = {24163}, -- Bound Aegis
			[8] = {114908}, -- Dark Deal
			[9] = {46331}, -- Crystal Weapon
			[10] = {77082,31759}, -- Sacred Ground
			[11] = {112145}, -- Rune Focus
			[12] = {118912}, -- Spirit Guardian
			[13] = {25377}, -- Dark Cloak
			[14] = {36908}, -- Leeching Strikes
			[15] = {61708}, -- Minor Heroism
			[16] = {61709}, -- Major Heroism
			[17] = {61693}, -- Minor Resolve
			[18] = {61710}, -- Minor Mending
			[19] = {61711}, -- Major Mending
			[20] = {61549}, -- Minor Vitality
			[21] = {61713}, -- Major Vitality
			[100] = {100575}, -- Puncturing Remedy
		},
		["durations"] = {
			[1] = 6,
			[2] = 15,
			[3] = 23,
			[4] = 0,
			[5] = 25,
			[6] = 5,
			[7] = 3,
			[8] = 20,
			[9] = 4,
			[10] = 4,
			[11] = 20,
			[12] = 16,
			[13] = 8,
			[14] = 20,
			[15] = 12,
			[16] = 9,
			[17] = 0,
			[18] = 0,
			[19] = 0,
			[20] = 0,
			[21] = 0,
			[100] = 5,
		},
		["texts"] = {
			[1] = "Block mitigation increased",
			[2] = "+215 WD & SD",
			[3] = "+12% healing received",
			[4] = "+5948 armor",
			[5] = "Bull Netch active",
			[6] = "Polar Wind active",
			[7] = "+40% block mitigation",
			[8] = "Dark Deal active",
			[9] = "Crystal Weapon ready",
			[10] = "+10% block mitigation",
			[11] = "+2974 armor",
			[12] = "Spirit Guardian active",
			[13] = "Dark Cloak active",
			[14] = "Leeching Strikes active",
			[15] = "+1 ultimate every 1.5 second",
			[16] = "+3 ultimate every 1.5 second",
			[17] = "+2974 armor",
			[18] = "+8% healing done",
			[19] = "+16% healing done",
			[20] = "+8% healing received",
			[21] = "+16% healing received",
			[100] = "custom text",
		},
		["colors"] = 
                    {
                        [1] = 
                        {
                            [1] = 0,
                            [2] = 0.3000000000,
                            [3] = 1,
                        },
                        [2] = 
                        {
                            [1] = 0.1000000000,
                            [2] = 0.7000000000,
                            [3] = 0.1000000000,
                        },
                        [3] = 
                        {
                            [1] = 1,
                            [2] = 0.4000000000,
                            [3] = 0.7000000000,
                        },
                        [4] = 
                        {
                            [4] = 1,
                            [1] = 1,
                            [2] = 0.5215686560,
                            [3] = 0.2196078449,
                        },
                        [5] = 
                        {
                            [4] = 1,
                            [1] = 0.2313725501,
                            [2] = 1,
                            [3] = 0,
                        },
                        [6] = 
                        {
                            [4] = 1,
                            [1] = 0.7725490332,
                            [2] = 0.8509804010,
                            [3] = 0.7294117808,
                        },
                        [7] = 
                        {
                            [4] = 1,
                            [1] = 0.5568627715,
                            [2] = 0,
                            [3] = 0.8000000119,
                        },
                        [8] = 
                        {
                            [4] = 1,
                            [1] = 0,
                            [2] = 0.1254902035,
                            [3] = 0.5490196347,
                        },
                        [9] = 
                        {
                            [4] = 1,
                            [1] = 0.3490196168,
                            [2] = 0.1098039225,
                            [3] = 0.9137254953,
                        },
                        [10] = 
                        {
                            [4] = 1,
                            [1] = 1,
                            [2] = 0.9372549057,
                            [3] = 0.5764706135,
                        },
                        [11] = 
                        {
                            [4] = 1,
                            [1] = 0.9725490212,
                            [2] = 0.8274509907,
                            [3] = 0.2274509817,
                        },
                        [12] = 
                        {
                            [4] = 1,
                            [1] = 0.6705882549,
                            [2] = 0.5294117928,
                            [3] = 0.8117647171,
                        },
                        [13] = 
                        {
                            [4] = 1,
                            [1] = 0.8000000119,
                            [2] = 0,
                            [3] = 0.1607843190,
                        },
                        [14] = 
                        {
                            [4] = 1,
                            [1] = 0.5882353187,
                            [2] = 0.1254902035,
                            [3] = 0.1215686277,
                        },
                        [15] = 
                        {
                            [4] = 1,
                            [1] = 1,
                            [2] = 0.9803921580,
                            [3] = 0.5019608140,
                        },
                        [16] = 
                        {
                            [4] = 1,
                            [1] = 0.7450980544,
                            [2] = 0.5882353187,
                            [3] = 0,
                        },
                        [17] = 
                        {
                            [4] = 1,
                            [1] = 1,
                            [2] = 0.7215686440,
                            [3] = 0.5490196347,
                        },
                        [18] = 
                        {
                            [4] = 1,
                            [1] = 0.6431372762,
                            [2] = 1,
                            [3] = 0.6745098233,
                        },
                        [19] = 
                        {
                            [4] = 1,
                            [1] = 0,
                            [2] = 1,
                            [3] = 0.0823529437,
                        },
                        [20] = 
                        {
                            [4] = 1,
                            [1] = 1,
                            [2] = 0.5098039508,
                            [3] = 0.4509803951,
                        },
                        [21] = 
                        {
                            [4] = 1,
                            [1] = 1,
                            [2] = 0.0549019612,
                            [3] = 0,
                        },
						[100] = {
							[4] = 1,
							[3] = 0.4,
							[2] = 0.8,
							[1] = 0.1,
						},
                },
		["isTurnedOn"] = {
			[1] = true,
			[2] = true,
			[3] = false,
			[4] = true,
			[5] = false,
			[6] = false,
			[7] = false,
			[8] = false,
			[9] = false,
			[10] = false,
			[11] = false,
			[12] = false,
			[13] = false,
			[14] = false,
			[15] = true,
			[16] = false,
			[17] = false,
			[18] = false,
			[19] = false,
			[20] = false,
			[21] = false,
			[100] = false,
		},
		["textWhenMissing"] = {
			[1] = "Immovable missing",
			[2] = "Minor Courage missing",
			[3] = "Dragon Blood missing",
			[4] = "Major Resolve missing",
			[5] = "Bull Netch missing",
			[6] = "Polar Wind missing",
			[7] = "Bound Aegis missing",
			[8] = "Dark Deal missing",
			[9] = "Crystal Weapon missing",
			[10] = "Sacred Ground missing",
			[11] = "Rune Focus bonus missing",
			[12] = "Spirit Guardian missing",
			[13] = "Dark Cloak missing",
			[14] = "Leeching Strikes missing",
			[15] = "Minor Heroism missing",
			[16] = "Major Heroism missing",
			[17] = "Minor Resolve missing",
			[18] = "Minor Mending missing",
			[19] = "Major Mending missing",
			[20] = "Minor Vitality missing",
			[21] = "Major Vitality missing",
			[100] = "Puncturing Remedy missing",
		},
		["expiresAt"] = {
			[1] = 0,
			[2] = 0,
			[3] = 0,
			[4] = 0,
			[5] = 0,
			[6] = 0,
			[7] = 0,
			[8] = 0,
			[9] = 0,
			[10] = 0,
			[11] = 0,
			[12] = 0,
			[13] = 0,
			[14] = 0,
			[15] = 0,
			[16] = 0,
			[17] = 0,
			[18] = 0,
			[19] = 0,
			[20] = 0,
			[21] = 0,
			[100] = 0,
		},
	},
	debuffTable = {
		["skill"] = {
			[1] = {31816,133027},
			[3] = {20930},
		},
		["itemSet"] = {
			[2] = {[1] = "|H1:item:73360:364:50:26845:370:50:4:0:0:0:0:0:0:0:1:45:0:1:0:421:0|h|h", [2] = 3},
			[12] = {[1] = "|H1:item:94551:364:50:0:0:0:0:0:0:0:0:0:0:0:1:67:0:1:0:10000:0|h|h", [2] = 2}
		},
		["isPreMade"] = {
			[1] = true,
			[2] = true,
			[3] = true,
			[4] = true,
			[5] = true,
			[6] = true,
			[7] = true,
			[8] = true,
			[9] = true,
			[10] = true,
			[11] = true,
			[12] = true,
			[13] = true,
			[14] = true,
			[15] = true,
			[100] = true,
		},
		["names"] = {
			[1] = "Stagger",
			[2] = "Alkosh",
			[3] = "Engulfing Flames",
			[4] = "Crusher",
			[5] = "Weapon Skill",
			[6] = "Minor Vulnerability",
			[7] = "Minor Magickasteal",
			[8] = "Minor Brittle",
			[9] = "Minor Maim",
			[10] = "Minor Mangle",
			[11] = "Crystal Weapon",
			[12] = "Tremorscale",
			[13] = "Major Breach",
			[14] = "Minor Breach",
			[15] = "Major Maim",
			[100] = "Off-Balance/Off-Balance Immunity",
			
		},
		["icons"] = {
			[1] = "/esoui/art/icons/ability_dragonknight_013_a.dds",
			[2] = "/esoui/art/icons/gear_dromathra_medium_head_a.dds",
			[3] = "/esoui/art/icons/ability_dragonknight_004_b.dds",
			[4] = "/esoui/art/icons/ava_artifact_004.dds",
			[5] = "/esoui/art/icons/ability_destructionstaff_003_b.dds",
			[6] = "/esoui/art/icons/ability_debuff_minor_vulnerability.dds",
			[7] = "/esoui/art/icons/ability_buff_minor_magickasteal.dds",
			[8] = GetAbilityIcon(145975),
			[9] = GetAbilityIcon(61723),
			[10] = GetAbilityIcon(61733),
			[11] = GetAbilityIcon(143808),
			[12] = GetAbilityIcon(80866),
			[13] = GetAbilityIcon(61743),
			[14] = GetAbilityIcon(61742),
			[15] = GetAbilityIcon(61725),
			[100] = "/esoui/art/icons/ability_debuff_offbalance.dds",


		},
		["IDs"] = {
			[1] = {
				[1] = 134336, -- Stagger
			}, 
			[2] = {
				[1] = 75753, -- Alkosh
			},
			[3] = {31104}, -- Engulfing
			[4] = {17906}, -- Crusher
			[5] = {39018,39028,39012,38695,28876,38689,28807,28849,28854,39067,39073,39053}, -- Weapon Skill applying Crusher
			[6] = {79717}, -- Minor Vulnerability
			[7] = {88401}, -- Minor Magickasteal
			[8] = {145975}, -- Minor Brittle
			[9] = {61723}, -- Minor Maim
			[10] = {61733}, -- Minor Mangle
			[11] = {143808}, -- Crystal Weapon
			[12] = {80866}, -- Tremorscale
			[13] = {61743}, -- Major Breach
			[14] = {61742}, -- Minor Breach
			[15] = {61725}, -- Major Maim
			[100] = {
				[1] = 62988, --long wall
				[2] = 63108, --dodge roll
				[3] = 130145, --mag birb
				[4] = 23808, --lava whip
				[5] = 20806, --molten whip
				[6] = 34117, --flame lash
				[7] = 45902, --generic off balance (interrupting with deep breath, heavy block etc)
				[8] = 120014, --iron atronach
				[9] = 25256, --veiled strike
				[10] = 34733, --surprise attack
				[11] = 34737, --concealed weapon
				[12] = 49205, --focused charge
				[13] = 49213, --explosive charge
				[14] = 130129, --unmorphed birb
				[15] = 130145, --stam birb
				[16] = 125750, --ruinous scythe
				[17] = 131562, --dizzy swing
				[18] = 62968, --unmorphed wall
				[19] = 39077, --explosive wall
				[20] = 134599, --Off-Balance immunity
			},
		},
		["durations"] = {
			[1] = {},
			[2] = {},
			[3] = {},
			[4] = {},
			[5] = 0,
			[6] = {},
			[7] = {},
			[8] = {},
			[9] = {},
			[10] = {},
			[11] = {},
			[12] = {},
			[13] = {},
			[14] = {},
			[15] = {},
			[100] = {},
		},
		["texts"] = {
			[1] = "",
			[2] = "",
			[3] = "",
			[4] = "2108 penetration",
			[5] = "",
			[6] = "5% damage increase",
			[7] = "168 magicka per second",
			[8] = "10% critical damage increase",
			[9] = "5% reduce damage done",
			[10] = "10% reduce max health",
			[11] = "1000 penetration",
			[12] = "2395 physical penetration",
			[13] = "5948 penetration",
			[14] = "2974 penetration",
			[15] = "10% reduce damage done",
			[100] = "Off-Balance applied",
		},
		["colors"] = 
                    {
                        [100] = 
                        {
                            [4] = 1,
                            [1] = 0,
                            [2] = 0.6980392337,
                            [3] = 0.5137255192,
                        },
                        [1] = 
                        {
                            [1] = 1,
                            [2] = 0,
                            [3] = 0,
                        },
                        [2] = 
                        {
                            [1] = 0.6200000000,
                            [2] = 0,
                            [3] = 1,
                        },
                        [3] = 
                        {
                            [1] = 1,
                            [2] = 0.4000000000,
                            [3] = 0,
                        },
                        [4] = 
                        {
                            [1] = 0,
                            [2] = 1,
                            [3] = 1,
                        },
                        [5] = 
                        {
                            [1] = 0,
                            [2] = 0.5000000000,
                            [3] = 0.7000000000,
                        },
                        [6] = 
                        {
                            [1] = 0.4000000000,
                            [2] = 0.1000000000,
                            [3] = 0.9000000000,
                        },
                        [7] = 
                        {
                            [1] = 0.2000000000,
                            [2] = 0.6000000000,
                            [3] = 0.7000000000,
                        },
                        [8] = 
                        {
                            [4] = 1,
                            [1] = 0.7490196228,
                            [2] = 1,
                            [3] = 0.5019608140,
                        },
                        [9] = 
                        {
                            [4] = 1,
                            [1] = 0.8000000119,
                            [2] = 0.2901960909,
                            [3] = 0.4470588267,
                        },
                        [10] = 
                        {
                            [4] = 1,
                            [1] = 0.3647058904,
                            [2] = 0,
                            [3] = 0.0470588244,
                        },
                        [11] = 
                        {
                            [4] = 1,
                            [1] = 0.2352941185,
                            [2] = 0.3529411852,
                            [3] = 0.6901960969,
                        },
                        [12] = 
                        {
                            [4] = 1,
                            [1] = 0.6901960969,
                            [2] = 0.5803921819,
                            [3] = 0.3450980484,
                        },
                        [13] = 
                        {
                            [4] = 1,
                            [1] = 0.3176470697,
                            [2] = 0.0901960805,
                            [3] = 0.6627451181,
                        },
                        [14] = 
                        {
                            [4] = 1,
                            [1] = 0.7294117808,
                            [2] = 0.5686274767,
                            [3] = 1,
                        },
                        [15] = 
                        {
                            [4] = 1,
                            [1] = 0.5607843399,
                            [2] = 0,
                            [3] = 0.1607843190,
                        },
                    },
		["colors2"] = {
			[1] =  {1,1,0,1},
			[100] = {
                [4] = 1,
                [1] = 1,
                [2] = 0.0196078438,
                [3] = 0,
            },
			[8] = {1,0,0,1}

		},
		["colors3"] = {
			[1] = {0,1,0},


		},
		["isTurnedOn"] = {
			[1] = false,
			[2] = true,
			[3] = false,
			[4] = true,
			[5] = true,
			[6] = false,
			[7] = false,
			[8] = false,
			[9] = true,
			[10] = false,
			[11] = false,
			[12] = false,
			[13] = true,
			[14] = false,
			[15] = false,
			[100] = true,
		},
		["isTurnedOnBoss"] = {
			[1] = false,
			[2] = true,
			[3] = false,
			[4] = true,
			[5] = true,
			[6] = false,
			[7] = false,
			[8] = false,
			[9] = true,
			[10] = false,
			[11] = false,
			[12] = false,
			[13] = true,
			[14] = false,
			[15] = false,
			[100] = true,
		},
		["textWhenMissing"] = {
			[1] = "Stagger missing",
			[2] = "Alkosh missing",
			[3] = "Engulfing missing",
			[4] = "Crusher missing",
			[5] = "Blockade missing",
			[6] = "Minor Vulnerability missing",
			[7] = "Minor Magickasteal missing",
			[8] = "Minor Brittle missing",
			[9] = "Minor Maim missing",
			[10] = "Minor Mangle missing",
			[11] = "Crystal Weapon missing",
			[12] = "Tremorscale missing",
			[13] = "Major Breach missing",
			[14] = "Minor Breach missing",
			[15] = "Major Maim missing",
			[100] = "Off-Balance ready",
		},
		["expiresAt"] = {
			[1] = {},
			[2] = {},
			[3] = {},
			[4] = {},
			[5] = 0,
			[6] = {},
			[7] = {},
			[8] = {},
			[9] = {},
			[10] = {},
			[11] = {},
			[12] = {},
			[13] = {},
			[14] = {},
			[15] = {},
			[100] = {},
		},
		["onlyCastByPlayer"] = {
			[1] = false,
			[2] = false,
			[3] = false,
			[4] = false,
			[5] = false,
			[6] = false,
			[7] = false,
			[8] = false,
			[9] = false,
			[10] = false,
			[11] = false,
			[12] = false,
			[13] = false,
			[14] = false,
			[15] = false,
			[100] = false,
		},
	}
}


for k,v in pairs(HTT_DodgeRollData) do
	for k1,v1 in pairs(v) do
		HTT.defaultPreset["alertNotifications"][k1] = v1.isOnByDefault or false
	end
end



HTT_defaultSettingsCharacterSpecific = {
	["currentlySelectedProfile"] = "Default Preset",
}


HTT_defaultSettings = {
	["availableProfiles"] = {
		[1] = "Default Preset",
		[2] = "Dragonknight Preset",
		[3] = "Sorcerer Preset",
		[4] = "Nightblade Preset",
		[5] = "Warden Preset",
		[6] = "Necromancer Preset",
		[7] = "Templar Preset",
	},
	
	["Default Preset"] = HTT.defaultPreset,
}
DKPreset = HTT_functions.deepcopy(HTT.defaultPreset)
HTT_functions.adjustDefaultsToClass(DKPreset,1)
HTT_defaultSettings["Dragonknight Preset"] = DKPreset
SorcPreset = HTT_functions.deepcopy(HTT.defaultPreset)
HTT_functions.adjustDefaultsToClass(SorcPreset,2)
HTT_defaultSettings["Sorcerer Preset"] = SorcPreset
NightbladePreset = HTT_functions.deepcopy(HTT.defaultPreset)
HTT_functions.adjustDefaultsToClass(NightbladePreset,3)
HTT_defaultSettings["Nightblade Preset"] = NightbladePreset
WardenPreset = HTT_functions.deepcopy(HTT.defaultPreset)
HTT_functions.adjustDefaultsToClass(WardenPreset,4)
HTT_defaultSettings["Warden Preset"] = WardenPreset
NecroPreset = HTT_functions.deepcopy(HTT.defaultPreset)
HTT_functions.adjustDefaultsToClass(NecroPreset,5)
HTT_defaultSettings["Necromancer Preset"] = NecroPreset
TemplarPreset = HTT_functions.deepcopy(HTT.defaultPreset)
HTT_functions.adjustDefaultsToClass(TemplarPreset,6)
HTT_defaultSettings["Templar Preset"] = TemplarPreset



