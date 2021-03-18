HTT = {
    name            = "HyperTankingTools",          
    author          = "Hyperioxes",
    color           = "DDFFEE",            
    menuName        = "HyperTankingTools",          
}

_G["HyperTankingTools"] = {}

local function StonefistStompIconHook()
    local old = _G["GetSlotTexture"]
    _G["HyperTankingTools"]["GetSlotTexture"] = old
    _G["GetSlotTexture"] = function(...)
		if GetSlotBoundId(...) == 31816 then
		return "HyperTankingTools/icons/stonefistStomp.dds"
		end
		return old(...)
    end
end


local function resetSkillTables()
	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		for k,_ in pairs(HTTsavedVars[v].debuffTable["names"]) do
			 HTTsavedVars[v].debuffTable["skill"][k] = {}
		end
	end
end

local function resetItemSetTables()
	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		for k,_ in pairs(HTTsavedVars[v].cooldownTable["names"]) do
			 HTTsavedVars[v].cooldownTable["itemSet"][k] = {}
		end
	end
end

SLASH_COMMANDS["/httresetskills"] = resetSkillTables
SLASH_COMMANDS["/httresetitemsets"] = resetItemSetTables


function OnAddOnLoaded(event, addonName)
    if addonName ~= HTT.name then return end
    EVENT_MANAGER:UnregisterForEvent(HTT.name, EVENT_ADD_ON_LOADED)




	HTTsavedVars = ZO_SavedVars:NewAccountWide("HyperTankingToolsSV",57, nil, HTT_defaultSettings)
	HTTsavedVarsCharacterSpecific = ZO_SavedVars:New("HyperTankingToolsSV",57, nil, HTT_defaultSettingsCharacterSpecific)
	HTT_variables.currentlySelectedProfile = HTTsavedVarsCharacterSpecific["currentlySelectedProfile"]
	if type(HTTsavedVars[HTT_variables.currentlySelectedProfile]) ~= "table" then
		HTT_variables.currentlySelectedProfile = HTT_functions.pickAnyElement(HTTsavedVars["availableProfiles"])
	end
	
	-------- In case of old saved variables --------
	
	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		if type(HTTsavedVars[v].debuffTable["skill"]) ~= "table" then
			HTTsavedVars[v].debuffTable["skill"] = {}
		end
	end

	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		if type(HTTsavedVars[v].buffTable["skill"]) ~= "table" then
			HTTsavedVars[v].buffTable["skill"] = {}
		end
	end

	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		if type(HTTsavedVars[v].cooldownTable["skill"]) ~= "table" then
			HTTsavedVars[v].cooldownTable["skill"] = {}
		end
	end

	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		if type(HTTsavedVars[v].debuffTable["itemSet"]) ~= "table" then
			HTTsavedVars[v].debuffTable["itemSet"] = {}
		end
	end

	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		if type(HTTsavedVars[v].buffTable["itemSet"]) ~= "table" then
			HTTsavedVars[v].buffTable["itemSet"] = {}
		end
	end

	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		if type(HTTsavedVars[v].cooldownTable["itemSet"]) ~= "table" then
			HTTsavedVars[v].cooldownTable["itemSet"] = {}
		end
	end

	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		if type(HTTsavedVars[v].cooldownTable["itemSet"]) == "table" then
			for k,_ in pairs(HTTsavedVars[v].cooldownTable["itemSet"]) do
				if type(HTTsavedVars[v].cooldownTable["itemSet"][k][2]) ~= "number" then
					HTTsavedVars[v].cooldownTable["itemSet"][k][2] = 0
				end
			end
		end
	end
	
	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		if type(HTTsavedVars[v].debuffTable["colors2"]) ~= "table" then
			HTTsavedVars[v].debuffTable["colors2"] = {}
		end
	end



	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		if type(HTTsavedVars[v].debuffTable["colors3"]) ~= "table" then
			HTTsavedVars[v].debuffTable["colors3"] = {}
		end
	end

	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		if HTTsavedVars[v].currentlySelectedBarTexture == nil then
			HTTsavedVars[v].currentlySelectedBarTexture = "HyperTankingTools/icons/gradientProgressBar.dds"
		end
	end

	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		if HTTsavedVars[v].isStoneFistCustomIconOn == nil then
			HTTsavedVars[v].isStoneFistCustomIconOn = true
		end
	end

	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		if type(HTTsavedVars[v].bossBackgroundColor) ~= "table" then
			HTTsavedVars[v].bossBackgroundColor = HTTsavedVars[v].reticleBackgroundColor
		end
	end

	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		if type(HTTsavedVars[v].reflectIndicatorColor) ~= "table" then
			HTTsavedVars[v].reflectIndicatorColor = {
				[1] = 1,
				[2] = 1,
				[3] = 1,
				[4] = 1,
			}
		end
	end

	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		if HTTsavedVars[v].isReflectIndicatorOn == nil then
			HTTsavedVars[v].isReflectIndicatorOn = true
		end
	end

	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		if HTTsavedVars[v].trackOnlyDD == nil then
			HTTsavedVars[v].trackOnlyDD = false
		end
	end

	for _,profile in pairs(HTTsavedVars["availableProfiles"]) do
		if type(HTTsavedVars[profile].alertNotifications) ~= "table" then
			HTTsavedVars[profile].alertNotifications = {}
		end
		for k,v in pairs(HTT_DodgeRollData) do
			for k1,v1 in pairs(v) do
				if HTTsavedVars[profile].alertNotifications[k1] == nil then
					HTTsavedVars[profile].alertNotifications[k1] = v1.isOnByDefault or false
				end
			end
		end
		
	end


	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		if HTTsavedVars[v].cooldownFont == nil then
			HTTsavedVars[v].specialUIHeight = 70
			HTTsavedVars[v].specialUIWidth = 210
			HTTsavedVars[v].buffUIHeight = 20
			HTTsavedVars[v].buffUIWidth = 210
			HTTsavedVars[v].buffUIScale = 1
			HTTsavedVars[v].specialUIScale = 1
			HTTsavedVars[v].debuffUIHeight = 20
			HTTsavedVars[v].debuffUIWidth = 210
			HTTsavedVars[v].debuffUIScale = 1
			HTTsavedVars[v].debuffBossUIHeight =20
			HTTsavedVars[v].debuffBossUIWidth = 210
			HTTsavedVars[v].debuffBossUIScale = 1
			HTTsavedVars[v].cooldownUIHeight =20
			HTTsavedVars[v].cooldownUIWidth = 210
			HTTsavedVars[v].cooldownUIScale = 1
			HTTsavedVars[v].synergiesUIHeight =20
			HTTsavedVars[v].synergiesUIWidth = 210
			HTTsavedVars[v].synergiesUIScale = 1
			HTTsavedVars[v].alertUIHeight =20
			HTTsavedVars[v].alertUIWidth = 210
			HTTsavedVars[v].alertUIScale = 1
			HTTsavedVars[v].synergiesFont = "ZoFontGameSmall"
			HTTsavedVars[v].buffFont = "ZoFontGameSmall"
			HTTsavedVars[v].debuffFont = "ZoFontGameSmall"
			HTTsavedVars[v].bossFont = "ZoFontGameSmall"
			HTTsavedVars[v].cooldownFont = "ZoFontGameSmall"
			HTTsavedVars[v].specialFont = "ZoFontGameSmall"
		end
	end

	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		if HTTsavedVars[v].specialFont == nil then
			HTTsavedVars[v].specialFont = "ZoFontGameSmall"
		end
	end

	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		for k,_ in pairs(HTTsavedVars[v].cooldownTable["names"]) do
			if type(HTTsavedVars[v].cooldownTable["itemSet"][k]) ~= "table" then
				HTTsavedVars[v].cooldownTable["itemSet"][k] = {}
			end
			if type(HTTsavedVars[v].cooldownTable["itemSet"][k][1] or nil) == "string" then
				HTTsavedVars[v].cooldownTable["itemSet"][k][1] = {HTTsavedVars[v].cooldownTable["itemSet"][k][1]}
			end
			if type(HTTsavedVars[v].cooldownTable["itemSet"][k][1] or nil) == "nil" then
				HTTsavedVars[v].cooldownTable["itemSet"][k][1] = {}
			end
		end
		for k,_ in pairs(HTTsavedVars[v].debuffTable["names"]) do
			if type(HTTsavedVars[v].debuffTable["itemSet"][k]) ~= "table" then
				HTTsavedVars[v].debuffTable["itemSet"][k] = {}
			end
			if type(HTTsavedVars[v].debuffTable["itemSet"][k][1] or nil) == "string" then
				HTTsavedVars[v].debuffTable["itemSet"][k][1] = {HTTsavedVars[v].debuffTable["itemSet"][k][1]}
			end
			if type(HTTsavedVars[v].debuffTable["itemSet"][k][1] or nil) == "nil" then
				HTTsavedVars[v].debuffTable["itemSet"][k][1] = {}
			end
		end
		for k,_ in pairs(HTTsavedVars[v].buffTable["names"]) do
			if type(HTTsavedVars[v].buffTable["itemSet"][k]) ~= "table" then
				HTTsavedVars[v].buffTable["itemSet"][k] = {}
			end
			if type(HTTsavedVars[v].buffTable["itemSet"][k][1] or nil) == "string" then
				HTTsavedVars[v].buffTable["itemSet"][k][1] = {HTTsavedVars[v].buffTable["itemSet"][k][1]}
			end
			if type(HTTsavedVars[v].buffTable["itemSet"][k][1] or nil) == "nil" then
				HTTsavedVars[v].buffTable["itemSet"][k][1] = {}
			end
		end
	end

	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		for k,_ in pairs(HTTsavedVars[v].cooldownTable["names"]) do
			if type(HTTsavedVars[v].cooldownTable["skill"][k]) ~= "table" then
				HTTsavedVars[v].cooldownTable["skill"][k] = {}
			end
		end
		for k,_ in pairs(HTTsavedVars[v].debuffTable["names"]) do
			if type(HTTsavedVars[v].debuffTable["skill"][k]) ~= "table" then
				HTTsavedVars[v].debuffTable["skill"][k] = {}
			end
		end
		for k,_ in pairs(HTTsavedVars[v].buffTable["names"]) do
			if type(HTTsavedVars[v].buffTable["skill"][k]) ~= "table" then
				HTTsavedVars[v].buffTable["skill"][k] = {}
			end
		end
	end



	
	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		for k,_ in pairs(HTTsavedVars[v].cooldownTable["names"]) do
			if type(HTTsavedVars[v].cooldownTable["colors2"]) ~= "table" then
				HTTsavedVars[v].cooldownTable["colors2"] = {}
			end
		end
		for k,_ in pairs(HTTsavedVars[v].buffTable["names"]) do
			if type(HTTsavedVars[v].buffTable["colors2"]) ~= "table" then
				HTTsavedVars[v].buffTable["colors2"] = {}
			end
		end
		for k,_ in pairs(HTTsavedVars[v].debuffTable["names"]) do
			if type(HTTsavedVars[v].debuffTable["colors2"]) ~= "table" then
				HTTsavedVars[v].debuffTable["colors2"] = {}
			end
		end
		for k,_ in pairs(HTTsavedVars[v].cooldownTable["names"]) do
			if type(HTTsavedVars[v].cooldownTable["colors3"]) ~= "table" then
				HTTsavedVars[v].cooldownTable["colors3"] = {}
			end
		end
		for k,_ in pairs(HTTsavedVars[v].buffTable["names"]) do
			if type(HTTsavedVars[v].buffTable["colors3"]) ~= "table" then
				HTTsavedVars[v].buffTable["colors3"] = {}
			end
		end
		for k,_ in pairs(HTTsavedVars[v].debuffTable["names"]) do
			if type(HTTsavedVars[v].debuffTable["colors3"]) ~= "table" then
				HTTsavedVars[v].debuffTable["colors3"] = {}
			end
		end
	end

	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		for k,_ in pairs(HTTsavedVars[v].debuffTable["names"]) do
			if HTTsavedVars[v].debuffTable["names"][k] == "Weapon Skill" then
				HTTsavedVars[v].debuffTable["IDs"][k] = {39018,39028,39012,38695,28876,38689,28807,28849,28854,39067,39073,39053}
			end
		end
		for k,_ in pairs(HTTsavedVars[v].buffTable["names"]) do
			if HTTsavedVars[v].buffTable["names"][k] == "Dragon Blood" then
				HTTsavedVars[v].buffTable["IDs"][k] = {32745}
			end
		end
	end

	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		if type(HTTsavedVars[v].synergiesBackgroundColor) ~= "table" then
			HTTsavedVars[v].isSynergiesUIOn = true
			HTTsavedVars[v].xOffsetSynergies = 200
			HTTsavedVars[v].yOffsetSynergies = 200
			HTTsavedVars[v].synergiesBackgroundColor = {
                [4] = 1,
                [1] = 0,
                [2] = 0,
                [3] = 0,
			}
			HTTsavedVars[v].orderOfSynergies = {
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
			}
			HTTsavedVars[v].synergiesTable = {
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

	
	
	
	
	
	
	
	
	
	
	
	}
		end
	end



	-------- In case of old saved variables --------


	

	HTT_initializeUI.generateUI()
	--HTT_InitializeStraightUI()
	HTT_DodgeRoll_Initialize()
	HTT_DodgeRoll_Events()
	HTT_functions.reanchorReticle() -- remove later by doing changes in Initialize
	HTT_functions.reanchorBuffs()
	HTT_functions.reanchorBoss()
	HTT_functions.reanchorCooldowns()
	HTT_functions.reanchorSynergies()

	
	HTT_LoadSettings()
	HTT_LoadSettingsPremadeTrackers()
	if HTTsavedVars[HTT_variables.currentlySelectedProfile].isStoneFistCustomIconOn then
		StonefistStompIconHook()
	end
	HTT_events.generateEvents()
	HTT_Alerts.StoneGarden.initializeEvents()
	EVENT_MANAGER:RegisterForUpdate("HTTalwaysUpdate", 100,HTT_updateUI.UpdateAlways)
	EVENT_MANAGER:RegisterForUpdate("HTTupdateDodgeRolls", 50,HTT_DodgeRoll_Update)
	HTT_functions.UpdateBaseGameUI(HTTsavedVars[HTT_variables.currentlySelectedProfile].isBaseGameUIOn)
end




------------------- COMBAT / OUT OF COMBAT SWITCHING ---------------------

local function onCursorMode(_,Newscene)
	HTT_variables.scene = Newscene
end


SCENE_MANAGER:GetScene("hud"):RegisterCallback("StateChange", onCursorMode )
SCENE_MANAGER:GetScene("hudui"):RegisterCallback("StateChange", onCursorMode)
EVENT_MANAGER:RegisterForEvent(HTT.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)
EVENT_MANAGER:RegisterForEvent(HTT.name, EVENT_PLAYER_COMBAT_STATE, function() 

	if IsUnitInCombat("player") then
		EVENT_MANAGER:RegisterForUpdate(HTT.name, 100,HTT_updateUI.UpdateCombat)
		if GetUnitName("boss1") == "Arkasis the Mad Alchemist" and HTTsavedVars[HTT_variables.currentlySelectedProfile].isAlertUIOn then
			EVENT_MANAGER:RegisterForUpdate("HTT_AlertUpdate", 100,HTT_Alerts.UpdateDuration)
		end
		if HTTsavedVars[HTT_variables.currentlySelectedProfile].isAutoCooldownTurnedOn then
			HTT_functions.adjustCooldowns()
			HTT_functions.adjustDebuffs()
			HTT_functions.adjustBuffs()
			HTT_functions.adjustBoss()
			HTT_functions.reanchorCooldowns()
			HTT_functions.reanchorReticle()
			HTT_functions.reanchorBoss()
			HTT_functions.reanchorBuffs()
		end
	else
		EVENT_MANAGER:UnregisterForUpdate(HTT.name, 100)
		EVENT_MANAGER:UnregisterForUpdate("HTT_AlertUpdate", 100)
		HTT:SetHidden(true)
		HTTOwnStacks:SetHidden(true)
		HTTBlock:SetHidden(true)
		HTTSelfBuffs:SetHidden(true)
		HTTBoss1:SetHidden(true)
		HTTBoss2:SetHidden(true)
		HTTBoss3:SetHidden(true)
		HTTBoss4:SetHidden(true)
		HTTBoss5:SetHidden(true)
		HTTBoss6:SetHidden(true)
		HTTCooldowns:SetHidden(true)
		HTTSynergies:SetHidden(true)
		HTTAlert:SetHidden(true)
	end
end)

------------------- COMBAT / OUT OF COMBAT SWITCHING ---------------------



