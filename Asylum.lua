--OLMS
local breathReadyAt = 0
local kiteReadyAt = 0
local exhaustiveReadyAt = 0
--LLOTHIS
local llothisJumpReadyAt = 0
local coneReadyAt = 0
local interruptReadyAt = 0
--FELMS
local manifestReadyAt = 0
local felmsJumpReadyAt = 0

local llothisSpawned = true
local llothisDormant = false
local llothisEnrageAt = 9999999
local felmsSpawned = true
local felmsDormant = false
local felmsEnrageAt = 9999999

local function UpdateEvery100()
	--OLMS
	local OlmsBreath = HTTOlms:GetNamedChild("OlmsBreath")
	local BreathCounter = OlmsBreath:GetNamedChild("OlmsBreathNumber")
	local BreathOutline = OlmsBreath:GetNamedChild("OlmsBreathOutline")
	local OlmsKite = HTTOlms:GetNamedChild("OlmsKite")
	local OlmsKiteCounter = OlmsKite:GetNamedChild("OlmsKiteNumber")
	local OlmsKiteOutline = OlmsKite:GetNamedChild("OlmsKiteOutline")
	local OlmsExhaustive = HTTOlms:GetNamedChild("OlmsExhaustive")
	local OlmsExhaustiveCounter = OlmsExhaustive:GetNamedChild("OlmsExhaustiveNumber")
	local OlmsExhaustiveOutline = OlmsExhaustive:GetNamedChild("OlmsExhaustiveOutline")
	if breathReadyAt > GetGameTimeSeconds() then
		if breathReadyAt - 3 > GetGameTimeSeconds() then
			BreathCounter:SetText(math.floor(breathReadyAt-GetGameTimeSeconds()))
			BreathOutline:SetColor(1,0,0)
		else
			BreathCounter:SetText(HTT_functions.HTT_processTimer((math.floor((breathReadyAt-GetGameTimeSeconds())*10)/10)))
			BreathOutline:SetColor(1,1,0)
		end
	else
		BreathCounter:SetText("0")
		BreathOutline:SetColor(0,1,0)
	end
	if kiteReadyAt > GetGameTimeSeconds() then
		if kiteReadyAt - 3 > GetGameTimeSeconds() then
			OlmsKiteCounter:SetText(math.floor(kiteReadyAt-GetGameTimeSeconds()))
			OlmsKiteOutline:SetColor(1,0,0)
		else
			OlmsKiteCounter:SetText(HTT_functions.HTT_processTimer((math.floor((kiteReadyAt-GetGameTimeSeconds())*10)/10)))
			OlmsKiteOutline:SetColor(1,1,0)
		end
	else
		OlmsKiteCounter:SetText("0")
		OlmsKiteOutline:SetColor(0,1,0)
	end
	if exhaustiveReadyAt > GetGameTimeSeconds() then
		if exhaustiveReadyAt - 3 > GetGameTimeSeconds() then
			OlmsExhaustiveCounter:SetText(math.floor(exhaustiveReadyAt-GetGameTimeSeconds()))
			OlmsExhaustiveOutline:SetColor(1,0,0)
		else
			OlmsExhaustiveCounter:SetText(HTT_functions.HTT_processTimer((math.floor((exhaustiveReadyAt-GetGameTimeSeconds())*10)/10)))
			OlmsExhaustiveOutline:SetColor(1,1,0)
		end
	else
		OlmsExhaustiveCounter:SetText("0")
		OlmsExhaustiveOutline:SetColor(0,1,0)
	end
	--LLOTHIS
	local LlothisInterrupt = HTTLlothis:GetNamedChild("LlothisInterrupt")
	local interruptCounter = LlothisInterrupt:GetNamedChild("LlothisInterruptNumber")
	local interruptOutline = LlothisInterrupt:GetNamedChild("LlothisInterruptOutline")
	local LlothisCone = HTTLlothis:GetNamedChild("LlothisCone")
	local coneCounter = LlothisCone:GetNamedChild("LlothisConeNumber")
	local coneOutline = LlothisCone:GetNamedChild("LlothisConeOutline")
	local LlothisJump = HTTLlothis:GetNamedChild("LlothisJump")
	local jumpCounter = LlothisJump:GetNamedChild("LlothisJumpNumber")
	local jumpOutline = LlothisJump:GetNamedChild("LlothisJumpOutline")
	local LlothisIcon = HTTLlothis:GetNamedChild("LlothisIcon")
	local LlothisCounter = HTTLlothis:GetNamedChild("LlothisCounter")
	if llothisDormant then --llothis sleeping
		LlothisIcon:SetColor(0.2,0.2,0.2,1)
		LlothisCounter:SetText(math.floor(llothisEnrageAt-GetGameTimeSeconds()))
		LlothisCounter:SetHidden(false)
	elseif llothisSpawned then
		if llothisEnrageAt < GetGameTimeSeconds() then --llothis enraged
			LlothisCounter:SetHidden(true)
			LlothisIcon:SetColor(1,0,0,1)
		elseif llothisEnrageAt < GetGameTimeSeconds() + 30 then --llothis enrages in 30 sec
			LlothisCounter:SetText(math.floor(llothisEnrageAt-GetGameTimeSeconds()))
			LlothisCounter:SetHidden(false)
			LlothisIcon:SetColor(1,1,1,1)
		else -- llothis exists
			LlothisCounter:SetHidden(true)
			LlothisIcon:SetColor(1,1,1,1)
		end
	else --llothis didnt spawn YET
		LlothisCounter:SetText(math.floor(llothisEnrageAt-GetGameTimeSeconds()))
		LlothisIcon:SetColor(0.2,0.2,0.2,1)
	end
	if llothisJumpReadyAt > GetGameTimeSeconds() then
		if llothisJumpReadyAt - 3 > GetGameTimeSeconds() then
			jumpCounter:SetText(math.floor(llothisJumpReadyAt-GetGameTimeSeconds()))
			jumpOutline:SetColor(1,0,0)
		else
			jumpCounter:SetText(HTT_functions.HTT_processTimer((math.floor((llothisJumpReadyAt-GetGameTimeSeconds())*10)/10)))
			jumpOutline:SetColor(1,1,0)
		end
	else
		jumpCounter:SetText("0")
		jumpOutline:SetColor(0,1,0)
	end
	if coneReadyAt > GetGameTimeSeconds() then
		if coneReadyAt - 3 > GetGameTimeSeconds() then
			coneCounter:SetText(math.floor(coneReadyAt-GetGameTimeSeconds()))
			coneOutline:SetColor(1,0,0)
		else
			coneCounter:SetText(HTT_functions.HTT_processTimer((math.floor((coneReadyAt-GetGameTimeSeconds())*10)/10)))
			coneOutline:SetColor(1,1,0)
		end
	else
		coneCounter:SetText("0")
		coneOutline:SetColor(0,1,0)
	end
	if interruptReadyAt > GetGameTimeSeconds() then
		if interruptReadyAt - 3 > GetGameTimeSeconds() then
			interruptCounter:SetText(math.floor(interruptReadyAt-GetGameTimeSeconds()))
			interruptOutline:SetColor(1,0,0)
		else
			interruptCounter:SetText(HTT_functions.HTT_processTimer((math.floor((interruptReadyAt-GetGameTimeSeconds())*10)/10)))
			interruptOutline:SetColor(1,1,0)
		end
	else
		interruptCounter:SetText("0")
		interruptOutline:SetColor(0,1,0)
	end
	--FELMS
	local FelmsManifest = HTTFelms:GetNamedChild("FelmsManifest")
	local manifestCounter = FelmsManifest:GetNamedChild("FelmsManifestNumber")
	local manifestOutline = FelmsManifest:GetNamedChild("FelmsManifestOutline")
	local FelmsJump = HTTFelms:GetNamedChild("FelmsJump")
	local felmsJumpCounter = FelmsJump:GetNamedChild("FelmsJumpNumber")
	local felmsJumpOutline = FelmsJump:GetNamedChild("FelmsJumpOutline")
	local FelmsIcon = HTTFelms:GetNamedChild("FelmsIcon")
	local FelmsCounter = HTTFelms:GetNamedChild("FelmsCounter")
	if felmsDormant then --Felms sleeping
		FelmsIcon:SetColor(0.2,0.2,0.2,1)
		FelmsCounter:SetText(math.floor(felmsEnrageAt-GetGameTimeSeconds()))
		FelmsCounter:SetHidden(false)
	elseif felmsSpawned then
		if felmsEnrageAt < GetGameTimeSeconds() then --Felms enraged
			FelmsCounter:SetHidden(true)
			FelmsIcon:SetColor(1,0,0,1)
		elseif felmsEnrageAt < GetGameTimeSeconds() + 30 then --Felms enrages in 30 sec
			FelmsCounter:SetText(math.floor(felmsEnrageAt-GetGameTimeSeconds()))
			FelmsCounter:SetHidden(false)
			FelmsIcon:SetColor(1,1,1,1)
		else -- Felms exists
			FelmsCounter:SetHidden(true)
			FelmsIcon:SetColor(1,1,1,1)
		end
	else --Felms didnt spawn YET
		FelmsCounter:SetText(math.floor(felmsEnrageAt-GetGameTimeSeconds()))
		FelmsIcon:SetColor(0.2,0.2,0.2,1)
	end
	if manifestReadyAt > GetGameTimeSeconds() then
		if manifestReadyAt - 3 > GetGameTimeSeconds() then
			manifestCounter:SetText(math.floor(manifestReadyAt-GetGameTimeSeconds()))
			manifestOutline:SetColor(1,0,0)
		else
			manifestCounter:SetText(HTT_functions.HTT_processTimer((math.floor((manifestReadyAt-GetGameTimeSeconds())*10)/10)))
			manifestOutline:SetColor(1,1,0)
		end
	else
		manifestCounter:SetText("0")
		manifestOutline:SetColor(0,1,0)
	end
	if felmsJumpReadyAt > GetGameTimeSeconds() then
		if felmsJumpReadyAt - 3 > GetGameTimeSeconds() then
			felmsJumpCounter:SetText(math.floor(felmsJumpReadyAt-GetGameTimeSeconds()))
			felmsJumpOutline:SetColor(1,0,0)
		else
			felmsJumpCounter:SetText(HTT_functions.HTT_processTimer((math.floor((felmsJumpReadyAt-GetGameTimeSeconds())*10)/10)))
			felmsJumpOutline:SetColor(1,1,0)
		end
	else
		felmsJumpCounter:SetText("0")
		felmsJumpOutline:SetColor(0,1,0)
	end
end


local function generateEvents()

	EVENT_MANAGER:RegisterForUpdate("HTT_Asylum_UpdateEvery100", 100,UpdateEvery100)

	--------------- OLMS ----------------------
	EVENT_MANAGER:RegisterForEvent("OlmsBreath", EVENT_COMBAT_EVENT, function(_, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType,
	targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
		if result == 2200 then
			breathReadyAt = GetGameTimeSeconds() + 26
		end

	end)
	EVENT_MANAGER:AddFilterForEvent("OlmsBreath", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,98683)

	EVENT_MANAGER:RegisterForEvent("OlmsKite", EVENT_COMBAT_EVENT, function(_, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType,
	targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
		if result == 2200 then
			kiteReadyAt = GetGameTimeSeconds() + 41
		end

	end)
	EVENT_MANAGER:AddFilterForEvent("OlmsKite", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,98535)

	EVENT_MANAGER:RegisterForEvent("OlmsExhaustive", EVENT_COMBAT_EVENT, function(_, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType,
	targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
		if result == 2200 then
			exhaustiveReadyAt = GetGameTimeSeconds() + 12
		end

	end)
	EVENT_MANAGER:AddFilterForEvent("OlmsExhaustive", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,95482)
	--------------- OLMS ----------------------
	--------------- LLOTHIS ----------------------
	EVENT_MANAGER:RegisterForEvent("LlothisInterrupt", EVENT_COMBAT_EVENT, function(_, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType,
	targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
		if result == ACTION_RESULT_INTERRUPT then
			interruptReadyAt = GetGameTimeSeconds() + 12
			zo_callLater(function () PlaySound(SVAW.LlothisInterruptSound) end, 10000)
			zo_callLater(function () PlaySound(SVAW.LlothisInterruptSound) end, 11000)
			zo_callLater(function () PlaySound(SVAW.LlothisInterruptSound) end, 12000)
		end
	end)
	EVENT_MANAGER:RegisterForEvent("LlothisNotInterrupted", EVENT_COMBAT_EVENT, function(_, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType,
	targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
		if result == 2250 then
			interruptReadyAt = GetGameTimeSeconds() + 12
			zo_callLater(function () PlaySound(SVAW.LlothisInterruptSound) end, 10000)
			zo_callLater(function () PlaySound(SVAW.LlothisInterruptSound) end, 11000)
			zo_callLater(function () PlaySound(SVAW.LlothisInterruptSound) end, 12000)
		end
	end)
	EVENT_MANAGER:AddFilterForEvent("LlothisNotInterrupted", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,95585)
	EVENT_MANAGER:RegisterForEvent("LlothisJump", EVENT_COMBAT_EVENT, function()
		llothisJumpReadyAt = GetGameTimeSeconds() + 25


	end)
	EVENT_MANAGER:AddFilterForEvent("LlothisJump", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,99819)

	EVENT_MANAGER:RegisterForEvent("LlothisCone", EVENT_COMBAT_EVENT, function(_, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType,
	targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
		if hitValue == 2000 then
			coneReadyAt = GetGameTimeSeconds() + 21
		end

	end)
	EVENT_MANAGER:AddFilterForEvent("LlothisCone", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,95545)
	--------------- LLOTHIS ----------------------
	--------------- FELMS ----------------------
	EVENT_MANAGER:RegisterForEvent("FelmsManifestWrath", EVENT_COMBAT_EVENT, function(_, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType,
	targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
		if result == 2200 then
			manifestReadyAt = GetGameTimeSeconds() + 10
		end

	end)
	EVENT_MANAGER:AddFilterForEvent("FelmsManifestWrath", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,99027)

	EVENT_MANAGER:RegisterForEvent("FelmsJump", EVENT_COMBAT_EVENT, function(_, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType,
	targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
		if result == 2200 then
			felmsJumpReadyAt = GetGameTimeSeconds() + 20
		end

	end)
	EVENT_MANAGER:AddFilterForEvent("FelmsJump", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,99138)
	--------------- FELMS ----------------------

	---------------- LLOTHIS AND FELMS SPAWN ---------------

	EVENT_MANAGER:RegisterForEvent("LlothisFelmsSpawn", EVENT_EFFECT_CHANGED, function(_, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType,
	abilityType, statusEffectType, unitName, unitId, abilityId, sourceType)
		if unitName:find("Llothis") or unitName:find("ロシス") or unitName:find("ллотис") then
			if not llothisSpawned then
				llothisSpawned = true
				interruptReadyAt = GetGameTimeSeconds() + 12
				zo_callLater(function () PlaySound(SVAW.LlothisInterruptSound) end, 10000)
				zo_callLater(function () PlaySound(SVAW.LlothisInterruptSound) end, 11000)
				zo_callLater(function () PlaySound(SVAW.LlothisInterruptSound) end, 12000)
				coneReadyAt = GetGameTimeSeconds() + 12
				llothisEnrageAt = GetGameTimeSeconds() + 180
			end
		elseif unitName:find("Felms") or unitName:find("フェルムス") or unitName:find("фелмс") then
			if not felmsSpawned then
				felmsSpawned = true
				felmsJumpReadyAt = GetGameTimeSeconds() + 12
				felmsEnrageAt = GetGameTimeSeconds() + 180
			end
		end
	end)

	EVENT_MANAGER:RegisterForEvent("LlothisFelmsDormant", EVENT_EFFECT_CHANGED, function(_, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType,
	abilityType, statusEffectType, unitName, unitId, abilityId, sourceType)
		if changeType == EFFECT_RESULT_GAINED then
              if unitName:find("Llothis") or unitName:find("ロシス") or unitName:find("ллотис") then
					llothisDormant = true
					llothisEnrageAt = GetGameTimeSeconds() + 45
					interruptReadyAt = GetGameTimeSeconds() + 45
					zo_callLater(function () PlaySound(SVAW.LlothisInterruptSound) end, 43000)
					zo_callLater(function () PlaySound(SVAW.LlothisInterruptSound) end, 44000)
					zo_callLater(function () PlaySound(SVAW.LlothisInterruptSound) end, 45000)
					coneReadyAt = GetGameTimeSeconds() + 45
					llothisJumpReadyAt = GetGameTimeSeconds() + 45
              elseif unitName:find("Felms") or unitName:find("フェルムス") or unitName:find("фелмс") then
					felmsDormant = true
					felmsEnrageAt = GetGameTimeSeconds() + 45
					felmsJumpReadyAt = GetGameTimeSeconds() + 45
					manifestReadyAt = GetGameTimeSeconds() + 45
              end
		elseif changeType == EFFECT_RESULT_FADED then
			if unitName:find("Llothis") or unitName:find("ロシス") or unitName:find("ллотис") then
				llothisDormant = false
				llothisEnrageAt = GetGameTimeSeconds() + 180
			elseif unitName:find("Felms") or unitName:find("フェルムス") or unitName:find("фелмс") then
				felmsDormant = false
				felmsEnrageAt = GetGameTimeSeconds() + 180
			end
		end
	end)
	EVENT_MANAGER:AddFilterForEvent("LlothisFelmsDormant", EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID,99990)

	---------------- LLOTHIS AND FELMS SPAWN ---------------

end

local function removeEvents()
	EVENT_MANAGER:UnregisterForUpdate("HTT_Asylum_UpdateEvery100", 100)
	--------------- OLMS ----------------------
	EVENT_MANAGER:UnregisterForEvent("OlmsBreath", EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent("OlmsKite", EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent("OlmsExhaustive", EVENT_COMBAT_EVENT)
	--------------- OLMS ----------------------
	--------------- LLOTHIS ----------------------
	EVENT_MANAGER:UnregisterForEvent("LlothisInterrupt", EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent("LlothisNotInterrupted", EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent("LlothisJump", EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent("LlothisCone", EVENT_COMBAT_EVENT)
	--------------- LLOTHIS ----------------------
	--------------- FELMS ----------------------
	EVENT_MANAGER:UnregisterForEvent("FelmsManifestWrath", EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent("FelmsJump", EVENT_COMBAT_EVENT)
	--------------- FELMS ----------------------
	---------------- LLOTHIS AND FELMS SPAWN ---------------
	EVENT_MANAGER:UnregisterForEvent("LlothisFelmsSpawn", EVENT_EFFECT_CHANGED)
	EVENT_MANAGER:UnregisterForEvent("LlothisFelmsDormant", EVENT_EFFECT_CHANGED)
	---------------- LLOTHIS AND FELMS SPAWN ---------------
end





function AsylumInitializeUI()
	local WM = GetWindowManager()
	local HTTOlms = WM:CreateTopLevelWindow("HTTOlms")
	local HTTLlothis = WM:CreateTopLevelWindow("HTTLlothis")
	local HTTFelms = WM:CreateTopLevelWindow("HTTFelms")


	HTTOlms:SetResizeToFitDescendents(true)
    HTTOlms:SetMovable(true)
    HTTOlms:SetMouseEnabled(true)
	HTTOlms:SetHidden(not SVAW.Olms)

	HTTLlothis:SetResizeToFitDescendents(true)
    HTTLlothis:SetMovable(true)
    HTTLlothis:SetMouseEnabled(true)
	HTTLlothis:SetHidden(not SVAW.Llothis)

	HTTFelms:SetResizeToFitDescendents(true)
    HTTFelms:SetMovable(true)
    HTTFelms:SetMouseEnabled(true)
	HTTFelms:SetHidden(not SVAW.Felms)

	local Rwidth, Rheight = GuiRoot:GetDimensions()
	HTTOlms:SetHandler("OnMoveStop", function(control)
        SVAW.xOffsetAlertBoss1 = HTTOlms:GetLeft() - Rwidth + 150
	    SVAW.yOffsetAlertBoss1  = HTTOlms:GetTop() - (Rheight/5)
    end)

	HTTLlothis:SetHandler("OnMoveStop", function(control)
        SVAW.xOffsetAlertBoss2 = HTTLlothis:GetLeft() - Rwidth + 150
	    SVAW.yOffsetAlertBoss2  = HTTLlothis:GetTop() - (Rheight/5) - 270
    end)

	HTTFelms:SetHandler("OnMoveStop", function(control)
        SVAW.xOffsetAlertBoss3 = HTTFelms:GetLeft() - Rwidth + 150
	    SVAW.yOffsetAlertBoss3  = HTTFelms:GetTop() - (Rheight/5) - 540
    end)

	------------------ OLMS -----------------------------

	local OlmsIcon = WM:CreateControl("$(parent)OlmsIcon",HTTOlms,  CT_TEXTURE, 4)
	OlmsIcon:SetDimensions(128,128)
	OlmsIcon:SetAnchor(TOPLEFT,HTTOlms,TOPLEFT,0,0)
	OlmsIcon:SetTexture("HyperTankingTools/icons/Olms.dds")
	OlmsIcon:SetColor(1,1,1)
	OlmsIcon:SetHidden(false)
	OlmsIcon:SetDrawLayer(0)

	local OlmsBreath = WM:CreateControl("$(parent)OlmsBreath",HTTOlms,  CT_TEXTURE, 4)
	OlmsBreath:SetDimensions(64,64)
	OlmsBreath:SetAnchor(TOPLEFT,OlmsIcon,BOTTOMLEFT,0,0)
	OlmsBreath:SetTexture("/esoui/art/icons/achievement_update16_027.dds")
	OlmsBreath:SetColor(1,1,1)
	OlmsBreath:SetHidden(not SVAW.OlmsBreath)
	OlmsBreath:SetDrawLayer(0)

	local OlmsBreathNumber = WM:CreateControl("$(parent)OlmsBreathNumber",OlmsBreath,CT_LABEL)
	OlmsBreathNumber:SetFont("ZoFontCallout3")
	OlmsBreathNumber:SetScale(0.8)
	OlmsBreathNumber:SetDrawLayer(2)
	OlmsBreathNumber:SetText("0")				
	OlmsBreathNumber:SetAnchor(CENTER, OlmsBreath, CENTER,0,0)
	OlmsBreathNumber:SetDimensions(64,64)
	OlmsBreathNumber:SetHidden(false)
	OlmsBreathNumber:SetHorizontalAlignment(1)
	OlmsBreathNumber:SetVerticalAlignment(1)
	OlmsBreathNumber:SetColor(1,1,1,1)

	local OlmsBreathOutline = WM:CreateControl("$(parent)OlmsBreathOutline",OlmsBreath,  CT_TEXTURE, 4)
	OlmsBreathOutline:SetDimensions(128,128)
	OlmsBreathOutline:SetAnchor(CENTER,OlmsBreath,CENTER,0,0)
	OlmsBreathOutline:SetTexture("/esoui/art/hud/gamepad/gp_skillglow.dds")
	OlmsBreathOutline:SetColor(1,0,0)
	OlmsBreathOutline:SetHidden(false)
	OlmsBreathOutline:SetDrawLayer(1)

	local OlmsKite = WM:CreateControl("$(parent)OlmsKite",HTTOlms,  CT_TEXTURE, 4)
	OlmsKite:SetDimensions(64,64)
	OlmsKite:SetAnchor(TOPLEFT,OlmsBreath,TOPRIGHT,4,0)
	OlmsKite:SetTexture("/esoui/art/icons/death_recap_shock_aoe.dds")
	OlmsKite:SetColor(1,1,1)
	OlmsKite:SetHidden(not SVAW.OlmsKite)
	OlmsKite:SetDrawLayer(0)

	local OlmsKiteNumber = WM:CreateControl("$(parent)OlmsKiteNumber",OlmsKite,CT_LABEL)
	OlmsKiteNumber:SetFont("ZoFontCallout3")
	OlmsKiteNumber:SetScale(0.8)
	OlmsKiteNumber:SetDrawLayer(2)
	OlmsKiteNumber:SetText("0")				
	OlmsKiteNumber:SetAnchor(CENTER, OlmsKite, CENTER,0,0)
	OlmsKiteNumber:SetDimensions(64,64)
	OlmsKiteNumber:SetHidden(false)
	OlmsKiteNumber:SetHorizontalAlignment(1)
	OlmsKiteNumber:SetVerticalAlignment(1)
	OlmsKiteNumber:SetColor(1,1,1,1)

	local OlmsKiteOutline = WM:CreateControl("$(parent)OlmsKiteOutline",OlmsKite,  CT_TEXTURE, 4)
	OlmsKiteOutline:SetDimensions(128,128)
	OlmsKiteOutline:SetAnchor(CENTER,OlmsKite,CENTER,0,0)
	OlmsKiteOutline:SetTexture("/esoui/art/hud/gamepad/gp_skillglow.dds")
	OlmsKiteOutline:SetColor(1,0,0)
	OlmsKiteOutline:SetHidden(false)
	OlmsKiteOutline:SetDrawLayer(1)

	local OlmsExhaustive = WM:CreateControl("$(parent)OlmsExhaustive",HTTOlms,  CT_TEXTURE, 4)
	OlmsExhaustive:SetDimensions(64,64)
	OlmsExhaustive:SetAnchor(TOPLEFT,OlmsBreath,BOTTOMLEFT,0,4)
	OlmsExhaustive:SetTexture("/esoui/art/icons/death_recap_shock_ranged.dds")
	OlmsExhaustive:SetColor(1,1,1)
	OlmsExhaustive:SetHidden(not SVAW.OlmsExhaustive)
	OlmsExhaustive:SetDrawLayer(0)

	local OlmsExhaustiveNumber = WM:CreateControl("$(parent)OlmsExhaustiveNumber",OlmsExhaustive,CT_LABEL)
	OlmsExhaustiveNumber:SetFont("ZoFontCallout3")
	OlmsExhaustiveNumber:SetScale(0.8)
	OlmsExhaustiveNumber:SetDrawLayer(2)
	OlmsExhaustiveNumber:SetText("0")				
	OlmsExhaustiveNumber:SetAnchor(CENTER, OlmsExhaustive, CENTER,0,0)
	OlmsExhaustiveNumber:SetDimensions(64,64)
	OlmsExhaustiveNumber:SetHidden(false)
	OlmsExhaustiveNumber:SetHorizontalAlignment(1)
	OlmsExhaustiveNumber:SetVerticalAlignment(1)
	OlmsExhaustiveNumber:SetColor(1,1,1,1)

	local OlmsExhaustiveOutline = WM:CreateControl("$(parent)OlmsExhaustiveOutline",OlmsExhaustive,  CT_TEXTURE, 4)
	OlmsExhaustiveOutline:SetDimensions(128,128)
	OlmsExhaustiveOutline:SetAnchor(CENTER,OlmsExhaustive,CENTER,0,0)
	OlmsExhaustiveOutline:SetTexture("/esoui/art/hud/gamepad/gp_skillglow.dds")
	OlmsExhaustiveOutline:SetColor(1,0,0)
	OlmsExhaustiveOutline:SetHidden(false)
	OlmsExhaustiveOutline:SetDrawLayer(1)



	------------------ OLMS -----------------------------
	
	------------------ LLOTHIS -----------------------------

	local LlothisIcon = WM:CreateControl("$(parent)LlothisIcon",HTTLlothis,  CT_TEXTURE, 4)
	LlothisIcon:SetDimensions(128,128)
	LlothisIcon:SetAnchor(TOPLEFT,HTTLlothis,TOPLEFT,0,0)
	LlothisIcon:SetTexture("HyperTankingTools/icons/Llothis.dds")
	LlothisIcon:SetColor(1,1,1)
	LlothisIcon:SetHidden(false)
	LlothisIcon:SetDrawLayer(0)

	local LlothisCounter = WM:CreateControl("$(parent)LlothisCounter",HTTLlothis,CT_LABEL)
	LlothisCounter:SetFont("ZoFontCallout3")
	LlothisCounter:SetScale(0.8)
	LlothisCounter:SetDrawLayer(2)
	LlothisCounter:SetText("0")				
	LlothisCounter:SetAnchor(CENTER, LlothisIcon, CENTER,0,0)
	LlothisCounter:SetDimensions(64,64)
	LlothisCounter:SetHidden(true)
	LlothisCounter:SetHorizontalAlignment(1)
	LlothisCounter:SetVerticalAlignment(1)
	LlothisCounter:SetColor(1,1,1,1)

	local LlothisInterrupt = WM:CreateControl("$(parent)LlothisInterrupt",HTTLlothis,  CT_TEXTURE, 4)
	LlothisInterrupt:SetDimensions(64,64)
	LlothisInterrupt:SetAnchor(TOPLEFT,LlothisIcon,BOTTOMLEFT,0,0)
	LlothisInterrupt:SetTexture("/esoui/art/icons/ability_destructionstaff_001a.dds")
	LlothisInterrupt:SetColor(1,1,1)
	LlothisInterrupt:SetHidden(not SVAW.LlothisInterrupt)
	LlothisInterrupt:SetDrawLayer(0)

	local LlothisInterruptNumber = WM:CreateControl("$(parent)LlothisInterruptNumber",LlothisInterrupt,CT_LABEL)
	LlothisInterruptNumber:SetFont("ZoFontCallout3")
	LlothisInterruptNumber:SetScale(0.8)
	LlothisInterruptNumber:SetDrawLayer(2)
	LlothisInterruptNumber:SetText("0")				
	LlothisInterruptNumber:SetAnchor(CENTER, LlothisInterrupt, CENTER,0,0)
	LlothisInterruptNumber:SetDimensions(64,64)
	LlothisInterruptNumber:SetHidden(false)
	LlothisInterruptNumber:SetHorizontalAlignment(1)
	LlothisInterruptNumber:SetVerticalAlignment(1)
	LlothisInterruptNumber:SetColor(1,1,1,1)

	local LlothisInterruptOutline = WM:CreateControl("$(parent)LlothisInterruptOutline",LlothisInterrupt,  CT_TEXTURE, 4)
	LlothisInterruptOutline:SetDimensions(128,128)
	LlothisInterruptOutline:SetAnchor(CENTER,LlothisInterrupt,CENTER,0,0)
	LlothisInterruptOutline:SetTexture("/esoui/art/hud/gamepad/gp_skillglow.dds")
	LlothisInterruptOutline:SetColor(1,0,0)
	LlothisInterruptOutline:SetHidden(false)
	LlothisInterruptOutline:SetDrawLayer(1)

	local LlothisCone = WM:CreateControl("$(parent)LlothisCone",HTTLlothis,  CT_TEXTURE, 4)
	LlothisCone:SetDimensions(64,64)
	LlothisCone:SetAnchor(TOPLEFT,LlothisInterrupt,TOPRIGHT,4,0)
	LlothisCone:SetTexture("/esoui/art/icons/ability_healer_032.dds")
	LlothisCone:SetColor(1,1,1)
	LlothisCone:SetHidden(not SVAW.LlothisCone)
	LlothisCone:SetDrawLayer(0)

	local LlothisConeNumber = WM:CreateControl("$(parent)LlothisConeNumber",LlothisCone,CT_LABEL)
	LlothisConeNumber:SetFont("ZoFontCallout3")
	LlothisConeNumber:SetScale(0.8)
	LlothisConeNumber:SetDrawLayer(2)
	LlothisConeNumber:SetText("0")				
	LlothisConeNumber:SetAnchor(CENTER, LlothisCone, CENTER,0,0)
	LlothisConeNumber:SetDimensions(64,64)
	LlothisConeNumber:SetHidden(false)
	LlothisConeNumber:SetHorizontalAlignment(1)
	LlothisConeNumber:SetVerticalAlignment(1)
	LlothisConeNumber:SetColor(1,1,1,1)

	local LlothisConeOutline = WM:CreateControl("$(parent)LlothisConeOutline",LlothisCone,  CT_TEXTURE, 4)
	LlothisConeOutline:SetDimensions(128,128)
	LlothisConeOutline:SetAnchor(CENTER,LlothisCone,CENTER,0,0)
	LlothisConeOutline:SetTexture("/esoui/art/hud/gamepad/gp_skillglow.dds")
	LlothisConeOutline:SetColor(1,0,0)
	LlothisConeOutline:SetHidden(false)
	LlothisConeOutline:SetDrawLayer(1)

	local LlothisJump = WM:CreateControl("$(parent)LlothisJump",HTTLlothis,  CT_TEXTURE, 4)
	LlothisJump:SetDimensions(64,64)
	LlothisJump:SetAnchor(TOPLEFT,LlothisInterrupt,BOTTOMLEFT,0,4)
	LlothisJump:SetTexture("/esoui/art/icons/ability_mage_025.dds")
	LlothisJump:SetColor(1,1,1)
	LlothisJump:SetHidden(not SVAW.LlothisJump)
	LlothisJump:SetDrawLayer(0)

	local LlothisJumpNumber = WM:CreateControl("$(parent)LlothisJumpNumber",LlothisJump,CT_LABEL)
	LlothisJumpNumber:SetFont("ZoFontCallout3")
	LlothisJumpNumber:SetScale(0.8)
	LlothisJumpNumber:SetDrawLayer(2)
	LlothisJumpNumber:SetText("0")				
	LlothisJumpNumber:SetAnchor(CENTER, LlothisJump, CENTER,0,0)
	LlothisJumpNumber:SetDimensions(64,64)
	LlothisJumpNumber:SetHidden(false)
	LlothisJumpNumber:SetHorizontalAlignment(1)
	LlothisJumpNumber:SetVerticalAlignment(1)
	LlothisJumpNumber:SetColor(1,1,1,1)

	local LlothisJumpOutline = WM:CreateControl("$(parent)LlothisJumpOutline",LlothisJump,  CT_TEXTURE, 4)
	LlothisJumpOutline:SetDimensions(128,128)
	LlothisJumpOutline:SetAnchor(CENTER,LlothisJump,CENTER,0,0)
	LlothisJumpOutline:SetTexture("/esoui/art/hud/gamepad/gp_skillglow.dds")
	LlothisJumpOutline:SetColor(1,0,0)
	LlothisJumpOutline:SetHidden(false)
	LlothisJumpOutline:SetDrawLayer(1)

	------------------ LLOTHIS -----------------------------

	------------------ FELMS -----------------------------

	local FelmsIcon = WM:CreateControl("$(parent)FelmsIcon",HTTFelms,  CT_TEXTURE, 4)
	FelmsIcon:SetDimensions(128,128)
	FelmsIcon:SetAnchor(TOPLEFT,HTTFelms,TOPLEFT,0,0)
	FelmsIcon:SetTexture("HyperTankingTools/icons/Felms.dds")
	FelmsIcon:SetColor(1,1,1)
	FelmsIcon:SetHidden(false)
	FelmsIcon:SetDrawLayer(0)

	local FelmsCounter = WM:CreateControl("$(parent)FelmsCounter",HTTFelms,CT_LABEL)
	FelmsCounter:SetFont("ZoFontCallout3")
	FelmsCounter:SetScale(0.8)
	FelmsCounter:SetDrawLayer(2)
	FelmsCounter:SetText("0")				
	FelmsCounter:SetAnchor(CENTER, FelmsIcon, CENTER,0,0)
	FelmsCounter:SetDimensions(64,64)
	FelmsCounter:SetHidden(true)
	FelmsCounter:SetHorizontalAlignment(1)
	FelmsCounter:SetVerticalAlignment(1)
	FelmsCounter:SetColor(1,1,1,1)

	local FelmsManifest = WM:CreateControl("$(parent)FelmsManifest",HTTFelms,  CT_TEXTURE, 4)
	FelmsManifest:SetDimensions(64,64)
	FelmsManifest:SetAnchor(TOPLEFT,FelmsIcon,BOTTOMLEFT,0,0)
	FelmsManifest:SetTexture("/esoui/art/icons/death_recap_magic_aoe.dds")
	FelmsManifest:SetColor(1,1,1)
	FelmsManifest:SetHidden(not SVAW.FelmsManifest)
	FelmsManifest:SetDrawLayer(0)

	local FelmsManifestNumber = WM:CreateControl("$(parent)FelmsManifestNumber",FelmsManifest,CT_LABEL)
	FelmsManifestNumber:SetFont("ZoFontCallout3")
	FelmsManifestNumber:SetScale(0.8)
	FelmsManifestNumber:SetDrawLayer(2)
	FelmsManifestNumber:SetText("0")				
	FelmsManifestNumber:SetAnchor(CENTER, FelmsManifest, CENTER,0,0)
	FelmsManifestNumber:SetDimensions(64,64)
	FelmsManifestNumber:SetHidden(false)
	FelmsManifestNumber:SetHorizontalAlignment(1)
	FelmsManifestNumber:SetVerticalAlignment(1)
	FelmsManifestNumber:SetColor(1,1,1,1)

	local FelmsManifestOutline = WM:CreateControl("$(parent)FelmsManifestOutline",FelmsManifest,  CT_TEXTURE, 4)
	FelmsManifestOutline:SetDimensions(128,128)
	FelmsManifestOutline:SetAnchor(CENTER,FelmsManifest,CENTER,0,0)
	FelmsManifestOutline:SetTexture("/esoui/art/hud/gamepad/gp_skillglow.dds")
	FelmsManifestOutline:SetColor(1,0,0)
	FelmsManifestOutline:SetHidden(false)
	FelmsManifestOutline:SetDrawLayer(1)

	local FelmsJump = WM:CreateControl("$(parent)FelmsJump",HTTFelms,  CT_TEXTURE, 4)
	FelmsJump:SetDimensions(64,64)
	FelmsJump:SetAnchor(TOPLEFT,FelmsManifest,TOPRIGHT,4,0)
	FelmsJump:SetTexture("/esoui/art/icons/ability_nightblade_008.dds")
	FelmsJump:SetColor(1,1,1)
	FelmsJump:SetHidden(not SVAW.FelmsJump)
	FelmsJump:SetDrawLayer(0)

	local FelmsJumpNumber = WM:CreateControl("$(parent)FelmsJumpNumber",FelmsJump,CT_LABEL)
	FelmsJumpNumber:SetFont("ZoFontCallout3")
	FelmsJumpNumber:SetScale(0.8)
	FelmsJumpNumber:SetDrawLayer(2)
	FelmsJumpNumber:SetText("0")				
	FelmsJumpNumber:SetAnchor(CENTER, FelmsJump, CENTER,0,0)
	FelmsJumpNumber:SetDimensions(64,64)
	FelmsJumpNumber:SetHidden(false)
	FelmsJumpNumber:SetHorizontalAlignment(1)
	FelmsJumpNumber:SetVerticalAlignment(1)
	FelmsJumpNumber:SetColor(1,1,1,1)

	local FelmsJumpOutline = WM:CreateControl("$(parent)FelmsJumpOutline",FelmsJump,  CT_TEXTURE, 4)
	FelmsJumpOutline:SetDimensions(128,128)
	FelmsJumpOutline:SetAnchor(CENTER,FelmsJump,CENTER,0,0)
	FelmsJumpOutline:SetTexture("/esoui/art/hud/gamepad/gp_skillglow.dds")
	FelmsJumpOutline:SetColor(1,0,0)
	FelmsJumpOutline:SetHidden(false)
	FelmsJumpOutline:SetDrawLayer(1)



	------------------ FELMS -----------------------------


	HTTOlms:ClearAnchors()
	HTTOlms:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,Rwidth-150+SVAW.xOffsetAlertBoss1,(Rheight/5)+SVAW.yOffsetAlertBoss1)
	HTTLlothis:ClearAnchors()
	HTTLlothis:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,Rwidth-150+SVAW.xOffsetAlertBoss2,(Rheight/5)+270+SVAW.yOffsetAlertBoss2)
	HTTFelms:ClearAnchors()
	HTTFelms:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,Rwidth-150+SVAW.xOffsetAlertBoss3,(Rheight/5)+540+SVAW.yOffsetAlertBoss3)








	HTT_AsylumUIUpdate()








end

local function onSceneChange(_,scene)
	if scene == SCENE_SHOWN then
		HTTOlms:SetHidden(not SVAW.Olms)
		HTTLlothis:SetHidden(not SVAW.Llothis)
		HTTFelms:SetHidden(not SVAW.Felms)
	else
		HTTOlms:SetHidden(true)
		HTTLlothis:SetHidden(true)
		HTTFelms:SetHidden(true)
	end
end

EVENT_MANAGER:RegisterForEvent(HTT.name, EVENT_PLAYER_COMBAT_STATE, function() 

	if not IsUnitInCombat("player") then
		--OLMS
		breathReadyAt = 0
		kiteReadyAt = 0
		exhaustiveReadyAt = 0
		--LLOTHIS
		llothisJumpReadyAt = 0
		coneReadyAt = 0
		interruptReadyAt = 0
		llothisSpawned = false
		llothisDormant = false
		llothisEnrageAt = 0
		--FELMS
		manifestReadyAt = 0
		felmsJumpReadyAt = 0
		felmsSpawned = false
		felmsDormant = false
		felmsEnrageAt = 0
	end
end)


function HTT_AsylumUIUpdate()
	if SVAW.Asylum and GetUnitZone("player") == "Asylum Sanctorium" then
		HTTOlms:SetHidden(not SVAW.Olms)
		HTTLlothis:SetHidden(not SVAW.Llothis)
		HTTFelms:SetHidden(not SVAW.Felms)
		SCENE_MANAGER:GetScene("hud"):RegisterCallback("StateChange", onSceneChange)
		SCENE_MANAGER:GetScene("hudui"):RegisterCallback("StateChange", onSceneChange)
		generateEvents()
	else
		HTTOlms:SetHidden(true)
		HTTLlothis:SetHidden(true)
		HTTFelms:SetHidden(true)
		SCENE_MANAGER:GetScene("hud"):UnregisterCallback("StateChange", onSceneChange)
		SCENE_MANAGER:GetScene("hudui"):UnregisterCallback("StateChange", onSceneChange)
		removeEvents()
	end

	local OlmsBreath = HTTOlms:GetNamedChild("OlmsBreath")
	local OlmsKite = HTTOlms:GetNamedChild("OlmsKite")
	local OlmsExhaustive = HTTOlms:GetNamedChild("OlmsExhaustive")
	local LlothisInterrupt = HTTLlothis:GetNamedChild("LlothisInterrupt")
	local LlothisCone = HTTLlothis:GetNamedChild("LlothisCone")
	local LlothisJump = HTTLlothis:GetNamedChild("LlothisJump")
	local FelmsManifest = HTTFelms:GetNamedChild("FelmsManifest")
	local FelmsJump = HTTFelms:GetNamedChild("FelmsJump")
	OlmsBreath:SetHidden(not SVAW.OlmsBreath)
	OlmsKite:SetHidden(not SVAW.OlmsKite)
	OlmsExhaustive:SetHidden(not SVAW.OlmsExhaustive)
	LlothisInterrupt:SetHidden(not SVAW.LlothisInterrupt)
	LlothisCone:SetHidden(not SVAW.LlothisCone)
	LlothisJump:SetHidden(not SVAW.LlothisJump)
	FelmsManifest:SetHidden(not SVAW.FelmsManifest)
	FelmsJump:SetHidden(not SVAW.FelmsJump)

end