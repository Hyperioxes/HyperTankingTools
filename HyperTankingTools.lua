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


local function test()
	convertTrackerToString(3,0)
end

SLASH_COMMANDS["/htttest"] = test



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
		if HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetMagickaStraight==nil then
			HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetHealthStraight = 0
			HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetHealthStraight = 0
			HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetStaminaStraight = 0
			HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetStaminaStraight = 0
			HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetMagickaStraight = 0
			HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetMagickaStraight = 0
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
		end
	end

	for _,v in pairs(HTTsavedVars["availableProfiles"]) do
		for k1,v1 in pairs(HTTsavedVars[v].orderOfDebuffs) do
			if type(HTTsavedVars[v].debuffTable[v1].itemSet) ~= "table" then
				HTTsavedVars[v].debuffTable[v1].itemSet = {[1] = {},[2] = 0}
			end
		end
	end


	for k,v in pairs(HTTsavedVars["availableProfiles"]) do
		if type(HTTsavedVars[v].debuffTable["names"]) == "table" then
			HTTsavedVars[v].debuffNameToID = {}
			for k1,v1 in pairs(HTTsavedVars[v].debuffTable["names"]) do
				HTTsavedVars[v].debuffTable[k1] = {
					name = v1,
					turnedOn = HTTsavedVars[v].debuffTable["isTurnedOn"][k1],
					turnedOnBoss = HTTsavedVars[v].debuffTable["isTurnedOnBoss"][k1],
					color = HTTsavedVars[v].debuffTable["colors"][k1],
					color2 = HTTsavedVars[v].debuffTable["colors2"][k1],
					color3 = HTTsavedVars[v].debuffTable["colors3"][k1],
					IDs = HTTsavedVars[v].debuffTable["IDs"][k1],
					icon = HTTsavedVars[v].debuffTable["icons"][k1],
					duration = HTTsavedVars[v].debuffTable["durations"][k1],
					expiresAt = HTTsavedVars[v].debuffTable["expiresAt"][k1],
					skill = HTTsavedVars[v].debuffTable["skill"][k1],
					itemSet = HTTsavedVars[v].debuffTable["itemSet"][k1],
					text = HTTsavedVars[v].debuffTable["texts"][k1],
					textWhenMissing = HTTsavedVars[v].debuffTable["textWhenMissing"][k1],
					onlyCastByPlayer = HTTsavedVars[v].debuffTable["onlyCastByPlayer"][k1]
				}
				HTTsavedVars[v].debuffNameToID[v1] = k1
			end
		end
			HTTsavedVars[v].debuffTable["none"] = {
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
			HTTsavedVars[v].debuffTable["names"] = nil
			HTTsavedVars[v].debuffTable["isTurnedOn"] = nil
			HTTsavedVars[v].debuffTable["isTurnedOnBoss"] = nil
			HTTsavedVars[v].debuffTable["colors"] = nil
			HTTsavedVars[v].debuffTable["colors2"] = nil
			HTTsavedVars[v].debuffTable["colors3"] = nil
			HTTsavedVars[v].debuffTable["IDs"] = nil
			HTTsavedVars[v].debuffTable["icons"] = nil
			HTTsavedVars[v].debuffTable["durations"] = nil
			HTTsavedVars[v].debuffTable["expiresAt"] = nil
			HTTsavedVars[v].debuffTable["skill"] = nil
			HTTsavedVars[v].debuffTable["itemSet"] = nil
			HTTsavedVars[v].debuffTable["texts"] = nil
			HTTsavedVars[v].debuffTable["textWhenMissing"] = nil
			HTTsavedVars[v].debuffTable["onlyCastByPlayer"] = nil
			HTTsavedVars[v].debuffTable["isPreMade"] = nil
	end

	for k,v in pairs(HTTsavedVars["availableProfiles"]) do
		if type(HTTsavedVars[v].buffTable["names"]) == "table" then
			HTTsavedVars[v].buffNameToID = {}
			for k1,v1 in pairs(HTTsavedVars[v].buffTable["names"]) do
				HTTsavedVars[v].buffTable[k1] = {
					name = v1,	
					turnedOn = HTTsavedVars[v].buffTable["isTurnedOn"][k1],
					color = HTTsavedVars[v].buffTable["colors"][k1],
					color2 = HTTsavedVars[v].buffTable["colors2"][k1],
					color3 = HTTsavedVars[v].buffTable["colors3"][k1],
					IDs = HTTsavedVars[v].buffTable["IDs"][k1],
					icon = HTTsavedVars[v].buffTable["icons"][k1],
					duration = HTTsavedVars[v].buffTable["durations"][k1],
					expiresAt = HTTsavedVars[v].buffTable["expiresAt"][k1],
					skill = HTTsavedVars[v].buffTable["skill"][k1],
					itemSet = HTTsavedVars[v].buffTable["itemSet"][k1],
					text = HTTsavedVars[v].buffTable["texts"][k1],
					textWhenMissing = HTTsavedVars[v].buffTable["textWhenMissing"][k1],
				}
				HTTsavedVars[v].buffNameToID[v1] = k1
			end
		end
		HTTsavedVars[v].buffTable["none"] = {
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
		HTTsavedVars[v].buffTable["names"] = nil
		HTTsavedVars[v].buffTable["isTurnedOn"] = nil
		HTTsavedVars[v].buffTable["colors"] = nil
		HTTsavedVars[v].buffTable["colors2"] = nil
		HTTsavedVars[v].buffTable["colors3"] = nil
		HTTsavedVars[v].buffTable["IDs"] = nil
		HTTsavedVars[v].buffTable["icons"] = nil
		HTTsavedVars[v].buffTable["durations"] = nil
		HTTsavedVars[v].buffTable["expiresAt"] = nil
		HTTsavedVars[v].buffTable["skill"] = nil
		HTTsavedVars[v].buffTable["itemSet"] = nil
		HTTsavedVars[v].buffTable["texts"] = nil
		HTTsavedVars[v].buffTable["textWhenMissing"] = nil
		HTTsavedVars[v].buffTable["isPreMade"] = nil
	end

	for k,v in pairs(HTTsavedVars["availableProfiles"]) do
		if type(HTTsavedVars[v].cooldownTable["names"]) == "table" then
			HTTsavedVars[v].cooldownNameToID = {}
			for k1,v1 in pairs(HTTsavedVars[v].cooldownTable["names"]) do
				HTTsavedVars[v].cooldownTable[k1] = {
					name = v1,	
					turnedOn = HTTsavedVars[v].cooldownTable["isTurnedOn"][k1],
					color = HTTsavedVars[v].cooldownTable["colors"][k1],
					color2 = HTTsavedVars[v].cooldownTable["colors2"][k1],
					color3 = HTTsavedVars[v].cooldownTable["colors3"][k1],
					IDs = HTTsavedVars[v].cooldownTable["IDs"][k1],
					icon = HTTsavedVars[v].cooldownTable["icons"][k1],
					duration = HTTsavedVars[v].cooldownTable["durations"][k1],
					expiresAt = HTTsavedVars[v].cooldownTable["expiresAt"][k1],
					skill = HTTsavedVars[v].cooldownTable["skill"][k1],
					itemSet = HTTsavedVars[v].cooldownTable["itemSet"][k1],
					text = HTTsavedVars[v].cooldownTable["texts"][k1],
					textWhenMissing = HTTsavedVars[v].cooldownTable["textWhenMissing"][k1],
				}
				HTTsavedVars[v].cooldownNameToID[v1] = k1
			end
		end
		HTTsavedVars[v].cooldownTable["none"] = {
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
		HTTsavedVars[v].cooldownTable["names"] = nil
		HTTsavedVars[v].cooldownTable["isTurnedOn"] = nil
		HTTsavedVars[v].cooldownTable["colors"] = nil
		HTTsavedVars[v].cooldownTable["colors2"] = nil
		HTTsavedVars[v].cooldownTable["colors3"] = nil
		HTTsavedVars[v].cooldownTable["IDs"] = nil
		HTTsavedVars[v].cooldownTable["icons"] = nil
		HTTsavedVars[v].cooldownTable["durations"] = nil
		HTTsavedVars[v].cooldownTable["expiresAt"] = nil
		HTTsavedVars[v].cooldownTable["skill"] = nil
		HTTsavedVars[v].cooldownTable["itemSet"] = nil
		HTTsavedVars[v].cooldownTable["texts"] = nil
		HTTsavedVars[v].cooldownTable["textWhenMissing"] = nil
		HTTsavedVars[v].cooldownTable["isPreMade"] = nil
	end

	for k,v in pairs(HTTsavedVars["availableProfiles"]) do
		if type(HTTsavedVars[v].synergiesTable["names"]) == "table" then
			HTTsavedVars[v].synergyNameToID = {}
			for k1,v1 in pairs(HTTsavedVars[v].synergiesTable["names"]) do
				HTTsavedVars[v].synergiesTable[k1] = {
					name = v1,	
					turnedOn = HTTsavedVars[v].synergiesTable["isTurnedOn"][k1],
					color = HTTsavedVars[v].synergiesTable["colors"][k1],
					IDs = HTTsavedVars[v].synergiesTable["IDs"][k1],
					icon = HTTsavedVars[v].synergiesTable["icons"][k1],
					expiresAt = HTTsavedVars[v].synergiesTable["expiresAt"][k1],
					text = HTTsavedVars[v].synergiesTable["texts"][k1],
					textWhenMissing = HTTsavedVars[v].synergiesTable["textWhenMissing"][k1],
				}
				HTTsavedVars[v].synergyNameToID[v1] = k1
			end
		end
		HTTsavedVars[v].synergiesTable["none"] = {
				name = "none",
				turnedOn = false,
				color = {0,0,0,0},
				IDs = {},
				icon = "none",
				expiresAt = 0,
				text = "none",
				textWhenMissing = "none",
			}
		HTTsavedVars[v].synergiesTable["names"] = nil
		HTTsavedVars[v].synergiesTable["isTurnedOn"] = nil
		HTTsavedVars[v].synergiesTable["colors"] = nil
		HTTsavedVars[v].synergiesTable["IDs"] = nil
		HTTsavedVars[v].synergiesTable["icons"] = nil
		HTTsavedVars[v].synergiesTable["expiresAt"] = nil
		HTTsavedVars[v].synergiesTable["texts"] = nil
		HTTsavedVars[v].synergiesTable["textWhenMissing"] = nil
		HTTsavedVars[v].synergiesTable["isPreMade"] = nil
	end


	for k,v in pairs(HTTsavedVars["availableProfiles"]) do
		if type(HTTsavedVars[v].xOffsetFelms) ~= "number" then
			HTTsavedVars[v].xOffsetLlothis = 0
			HTTsavedVars[v].yOffsetLlothis = 0
			HTTsavedVars[v].xOffsetFelms = 0
			HTTsavedVars[v].yOffsetFelms = 0
		end
	end



	-------- In case of old saved variables --------


	

	HTT_initializeUI.generateUI()
	HTT_InitializeStraightUI()
	HTT_DodgeRoll_Initialize()
	HTT_DodgeRoll_Events()
	HTT_functions.reanchorReticle() -- remove later by doing changes in Initialize
	HTT_functions.reanchorBuffs()
	HTT_functions.reanchorBoss()
	HTT_functions.reanchorCooldowns()
	HTT_functions.reanchorSynergies()

	AsylumInitializeUI()
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
		EVENT_MANAGER:RegisterForUpdate(HTT.name, 100,HTT_combatUpdate)
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



