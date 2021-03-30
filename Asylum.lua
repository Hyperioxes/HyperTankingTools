--LLOTHIS
local llothisJumpReadyAt = 0
local coneReadyAt = 0
local interruptReadyAt = 0
--FELMS
local manifestReadyAt = 0
local felmsJumpReadyAt = 0

local function UpdateEvery100()
	--LLOTHIS
	local jumpCounter = HTTLlothis:GetNamedChild("LlothisJumpNumber")
	local jumpOutline = HTTLlothis:GetNamedChild("LlothisJumpOutline")
	local coneCounter = HTTLlothis:GetNamedChild("LlothisConeNumber")
	local coneOutline = HTTLlothis:GetNamedChild("LlothisConeOutline")
	local interruptCounter = HTTLlothis:GetNamedChild("LlothisInterruptNumber")
	local interruptOutline = HTTLlothis:GetNamedChild("LlothisInterruptOutline")
	if llothisJumpReadyAt > GetGameTimeSeconds() then
		if llothisJumpReadyAt - 3 > GetGameTimeSeconds() then
			jumpCounter:SetText(math.floor(llothisJumpReadyAt-GetGameTimeSeconds()))
			jumpOutline:SetColor(1,0,0)
		else
			jumpCounter:SetText(HTT_functions.HTT_processTimer((math.floor((llothisJumpReadyAt-GetGameTimeSeconds())*10)/10)))
			jumpOutline:SetColor(1,1,0)
		end
	else
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
		interruptOutline:SetColor(0,1,0)
	end
	--FELMS
	local manifestCounter = HTTFelms:GetNamedChild("FelmsManifestNumber")
	local manifestOutline = HTTFelms:GetNamedChild("FelmsManifestOutline")
	local felmsJumpCounter = HTTFelms:GetNamedChild("FelmsJumpNumber")
	local felmsJumpOutline = HTTFelms:GetNamedChild("FelmsJumpOutline")
	if manifestReadyAt > GetGameTimeSeconds() then
		if manifestReadyAt - 3 > GetGameTimeSeconds() then
			manifestCounter:SetText(math.floor(manifestReadyAt-GetGameTimeSeconds()))
			manifestOutline:SetColor(1,0,0)
		else
			manifestCounter:SetText(HTT_functions.HTT_processTimer((math.floor((manifestReadyAt-GetGameTimeSeconds())*10)/10)))
			manifestOutline:SetColor(1,1,0)
		end
	else
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
		felmsJumpOutline:SetColor(0,1,0)
	end
end


local function generateEvents()

	EVENT_MANAGER:RegisterForUpdate("HTT_Asylum_UpdateEvery100", 100,UpdateEvery100)

	EVENT_MANAGER:RegisterForEvent("LlothisInterrupt", EVENT_COMBAT_EVENT, function(_, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType,
	targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
		if result == ACTION_RESULT_INTERRUPT then
			interruptReadyAt = GetGameTimeSeconds() + 12
		end
	end)
	EVENT_MANAGER:RegisterForEvent("LlothisNotInterrupted", EVENT_COMBAT_EVENT, function(_, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType,
	targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
		if result == 2250 then
			interruptReadyAt = GetGameTimeSeconds() + 12
		end
	end)
	EVENT_MANAGER:AddFilterForEvent("LlothisNotInterrupted", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,95585)
	EVENT_MANAGER:RegisterForEvent("LlothisJump", EVENT_COMBAT_EVENT, function()
		llothisJumpReadyAt = GetGameTimeSeconds() + 20


	end)
	EVENT_MANAGER:AddFilterForEvent("LlothisJump", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,99819)

	EVENT_MANAGER:RegisterForEvent("LlothisCone", EVENT_COMBAT_EVENT, function(_, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType,
	targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
		if hitValue == 2000 then
			coneReadyAt = GetGameTimeSeconds() + 20
		end

	end)
	EVENT_MANAGER:AddFilterForEvent("LlothisCone", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,95545)

	EVENT_MANAGER:RegisterForEvent("FelmsManifestWrath", EVENT_COMBAT_EVENT, function(_, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType,
	targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
		if result == 2200 then
			manifestReadyAt = GetGameTimeSeconds() + 6
		end

	end)
	EVENT_MANAGER:AddFilterForEvent("FelmsManifestWrath", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,99027)
	


end

local function removeEvents()
	EVENT_MANAGER:UnregisterForEvent("LlothisInterrupt", EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent("LlothisNotInterrupted", EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent("LlothisJump", EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent("LlothisCone", EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForUpdate("HTT_Asylum_UpdateEvery100", 100)
end





function AsylumInitializeUI()
	local WM = GetWindowManager()
	local HTTOlms = WM:CreateTopLevelWindow("HTTOlms")
	local HTTLlothis = WM:CreateTopLevelWindow("HTTLlothis")
	local HTTFelms = WM:CreateTopLevelWindow("HTTFelms")


	HTTOlms:SetResizeToFitDescendents(true)
    HTTOlms:SetMovable(true)
    HTTOlms:SetMouseEnabled(true)
	HTTOlms:SetHidden(false)

	HTTLlothis:SetResizeToFitDescendents(true)
    HTTLlothis:SetMovable(true)
    HTTLlothis:SetMouseEnabled(true)
	HTTLlothis:SetHidden(false)

	HTTFelms:SetResizeToFitDescendents(true)
    HTTFelms:SetMovable(true)
    HTTFelms:SetMouseEnabled(true)
	HTTFelms:SetHidden(false)

	local Rwidth, Rheight = GuiRoot:GetDimensions()
	HTTOlms:SetHandler("OnMoveStop", function(control)
        HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetOlms = HTTOlms:GetLeft() - (Rwidth*0.421875)
	    HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetOlms  = HTTOlms:GetTop() - (Rheight/1.1125)
    end)

	HTTLlothis:SetHandler("OnMoveStop", function(control)
        HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetLlothis = HTTLlothis:GetLeft() - (Rwidth*0.63)
	    HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetLlothis  = HTTLlothis:GetTop() - (Rheight/1.1125)
    end)

	HTTFelms:SetHandler("OnMoveStop", function(control)
        HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetFelms = HTTFelms:GetLeft() - (Rwidth*0.213541)
	    HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetFelms  = HTTFelms:GetTop() - (Rheight/1.1125)
    end)

	------------------ OLMS -----------------------------

	------------------ OLMS -----------------------------
	
	------------------ LLOTHIS -----------------------------

	local LlothisIcon = WM:CreateControl("$(parent)LlothisIcon",HTTLlothis,  CT_TEXTURE, 4)
	LlothisIcon:SetDimensions(128,128)
	LlothisIcon:SetAnchor(TOPLEFT,HTTLlothis,TOPLEFT,0,0)
	LlothisIcon:SetTexture("HyperTankingTools/icons/Llothis.dds")
	LlothisIcon:SetColor(1,1,1)
	LlothisIcon:SetHidden(false)
	LlothisIcon:SetDrawLayer(0)

	local LlothisInterrupt = WM:CreateControl("$(parent)LlothisInterrupt",HTTLlothis,  CT_TEXTURE, 4)
	LlothisInterrupt:SetDimensions(64,64)
	LlothisInterrupt:SetAnchor(TOPLEFT,LlothisIcon,BOTTOMLEFT,0,0)
	LlothisInterrupt:SetTexture("/esoui/art/icons/ability_destructionstaff_001a.dds")
	LlothisInterrupt:SetColor(1,1,1)
	LlothisInterrupt:SetHidden(false)
	LlothisInterrupt:SetDrawLayer(0)

	local LlothisInterruptNumber = WM:CreateControl("$(parent)LlothisInterruptNumber",HTTLlothis,CT_LABEL)
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

	local LlothisInterruptOutline = WM:CreateControl("$(parent)LlothisInterruptOutline",HTTLlothis,  CT_TEXTURE, 4)
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
	LlothisCone:SetHidden(false)
	LlothisCone:SetDrawLayer(0)

	local LlothisConeNumber = WM:CreateControl("$(parent)LlothisConeNumber",HTTLlothis,CT_LABEL)
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

	local LlothisConeOutline = WM:CreateControl("$(parent)LlothisConeOutline",HTTLlothis,  CT_TEXTURE, 4)
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
	LlothisJump:SetHidden(false)
	LlothisJump:SetDrawLayer(0)

	local LlothisJumpNumber = WM:CreateControl("$(parent)LlothisJumpNumber",HTTLlothis,CT_LABEL)
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

	local LlothisJumpOutline = WM:CreateControl("$(parent)LlothisJumpOutline",HTTLlothis,  CT_TEXTURE, 4)
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
	FelmsIcon:SetTexture("HyperTankingTools/icons/Llothis.dds")
	FelmsIcon:SetColor(1,1,1)
	FelmsIcon:SetHidden(false)
	FelmsIcon:SetDrawLayer(0)

	local FelmsManifest = WM:CreateControl("$(parent)FelmsManifest",HTTFelms,  CT_TEXTURE, 4)
	FelmsManifest:SetDimensions(64,64)
	FelmsManifest:SetAnchor(TOPLEFT,FelmsIcon,BOTTOMLEFT,0,0)
	FelmsManifest:SetTexture("/esoui/art/icons/ability_destructionstaff_001a.dds")
	FelmsManifest:SetColor(1,1,1)
	FelmsManifest:SetHidden(false)
	FelmsManifest:SetDrawLayer(0)

	local FelmsManifestNumber = WM:CreateControl("$(parent)FelmsManifestNumber",HTTFelms,CT_LABEL)
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

	local FelmsManifestOutline = WM:CreateControl("$(parent)FelmsManifestOutline",HTTFelms,  CT_TEXTURE, 4)
	FelmsManifestOutline:SetDimensions(128,128)
	FelmsManifestOutline:SetAnchor(CENTER,FelmsManifest,CENTER,0,0)
	FelmsManifestOutline:SetTexture("/esoui/art/hud/gamepad/gp_skillglow.dds")
	FelmsManifestOutline:SetColor(1,0,0)
	FelmsManifestOutline:SetHidden(false)
	FelmsManifestOutline:SetDrawLayer(1)

	local FelmsJump = WM:CreateControl("$(parent)FelmsJump",HTTFelms,  CT_TEXTURE, 4)
	FelmsJump:SetDimensions(64,64)
	FelmsJump:SetAnchor(TOPLEFT,FelmsManifest,TOPRIGHT,4,0)
	FelmsJump:SetTexture("/esoui/art/icons/ability_healer_032.dds")
	FelmsJump:SetColor(1,1,1)
	FelmsJump:SetHidden(false)
	FelmsJump:SetDrawLayer(0)

	local FelmsJumpNumber = WM:CreateControl("$(parent)FelmsJumpNumber",HTTFelms,CT_LABEL)
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

	local FelmsJumpOutline = WM:CreateControl("$(parent)FelmsJumpOutline",HTTFelms,  CT_TEXTURE, 4)
	FelmsJumpOutline:SetDimensions(128,128)
	FelmsJumpOutline:SetAnchor(CENTER,FelmsJump,CENTER,0,0)
	FelmsJumpOutline:SetTexture("/esoui/art/hud/gamepad/gp_skillglow.dds")
	FelmsJumpOutline:SetColor(1,0,0)
	FelmsJumpOutline:SetHidden(false)
	FelmsJumpOutline:SetDrawLayer(1)



	------------------ FELMS -----------------------------


	--HTTOlms:ClearAnchors()
	--HTTOlms:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,(Rwidth*0.421875)+HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetOlms,(Rheight/1.1125)+HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetOlms)
	HTTLlothis:ClearAnchors()
	HTTLlothis:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,(Rwidth*0.63)+HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetLlothis,(Rheight/1.1125)+HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetLlothis)
	HTTFelms:ClearAnchors()
	HTTFelms:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,(Rwidth*0.213541)+HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetFelms,(Rheight/1.1125)+HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetFelms)








	HTT_switchAsylumUI(true)








end

local function onSceneChange(_,scene)
	if scene == SCENE_SHOWN then
		HTTOlms:SetHidden(false)
		HTTLlothis:SetHidden(false)
		HTTFelms:SetHidden(false)
	else
		HTTOlms:SetHidden(true)
		HTTLlothis:SetHidden(true)
		HTTFelms:SetHidden(true)
	end
end

function HTT_switchAsylumUI(turnedOn)
	if turnedOn then
		HTTOlms:SetHidden(false)
		HTTLlothis:SetHidden(false)
		HTTFelms:SetHidden(false)
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
end