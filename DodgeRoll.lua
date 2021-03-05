
local debugCounter = {}
local bar = {}
for i=1,7 do
	bar[i] = {
		expiresAt = 0,
		duration = 0,
		dodgeDuration = 1,
		onlyBlock = false
	}
end



function HTT_DodgeRoll_Initialize()
	local WM = GetWindowManager()
	local HTTDodgeRoll = WM:CreateTopLevelWindow("HTTDodgeRoll")


	HTTDodgeRoll:SetResizeToFitDescendents(true)
    HTTDodgeRoll:SetMovable(true)
    HTTDodgeRoll:SetMouseEnabled(true)
	HTTDodgeRoll:SetHidden(false)

	for i=1,7 do

		local DodgeRollBarOutline = WM:CreateControl("$(parent)DodgeRollBarOutline"..i,HTTDodgeRoll,  CT_TEXTURE, 4)
		DodgeRollBarOutline:SetDimensions(256,32)
		DodgeRollBarOutline:SetAnchor(TOPLEFT,HTTDodgeRoll,TOPLEFT,0,-50*i)
		DodgeRollBarOutline:SetTexture("HyperTankingTools/icons/dodgeRollBarOutline.dds")
		DodgeRollBarOutline:SetHidden(false)
		DodgeRollBarOutline:SetColor(0,1,0,1)
		DodgeRollBarOutline:SetDrawLayer(2)

		local DodgeRollBarIcon = WM:CreateControl("$(parent)DodgeRollBarIcon"..i,HTTDodgeRoll,  CT_TEXTURE, 4)
		DodgeRollBarIcon:SetDimensions(28,28)
		DodgeRollBarIcon:SetAnchor(TOPLEFT,DodgeRollBarOutline,TOPLEFT,2,2)
		DodgeRollBarIcon:SetTexture("HyperTankingTools/icons/dodgeRollBarFill.dds")
		DodgeRollBarIcon:SetHidden(false)
		DodgeRollBarIcon:SetDrawLayer(2)

		local DodgeRollBarTimer = WM:CreateControl("$(parent)DodgeRollBarTimer"..i,HTTDodgeRoll,  CT_LABEL, 4)
		DodgeRollBarTimer:SetDimensions(64,32)
		DodgeRollBarTimer:SetAnchor(BOTTOMLEFT,DodgeRollBarIcon,BOTTOMRIGHT,8,-4)
		DodgeRollBarTimer:SetHidden(false)
		DodgeRollBarTimer:SetDrawLayer(3)
		DodgeRollBarTimer:SetText("0.0")	
		DodgeRollBarTimer:SetFont("ZoFontWindowTitle")
		DodgeRollBarTimer:SetScale(0.8)

		local DodgeRollBarName = WM:CreateControl("$(parent)DodgeRollBarName"..i,HTTDodgeRoll,  CT_LABEL, 4)
		DodgeRollBarName:SetDimensions(350,32)
		DodgeRollBarName:SetAnchor(BOTTOMLEFT,DodgeRollBarOutline,TOPLEFT,4,6)
		DodgeRollBarName:SetHidden(false)
		DodgeRollBarName:SetDrawLayer(3)
		DodgeRollBarName:SetText("imgonnashitmyself")	
		DodgeRollBarName:SetFont("ZoFontHeader")
		DodgeRollBarName:SetScale(0.75)
	
		local DodgeRollBarFill = WM:CreateControl("$(parent)DodgeRollBarFill"..i,HTTDodgeRoll,  CT_TEXTURE, 4)
		DodgeRollBarFill:SetDimensions(224,28)
		DodgeRollBarFill:SetAnchor(LEFT,DodgeRollBarIcon,RIGHT,2,0)
		DodgeRollBarFill:SetTexture("HyperTankingTools/icons/dodgeRollBarFill.dds")
		DodgeRollBarFill:SetHidden(false)
		DodgeRollBarFill:SetColor(1, 220/255, 43/255,1)
		DodgeRollBarFill:SetDrawLayer(2)

		local DodgeRollBarLine = WM:CreateControl("$(parent)DodgeRollBarLine"..i,HTTDodgeRoll,  CT_TEXTURE, 4)
		DodgeRollBarLine:SetDimensions(3,32)
		DodgeRollBarLine:SetAnchor(TOPLEFT,DodgeRollBarOutline,TOPLEFT,100,0)
		DodgeRollBarLine:SetHidden(false)
		DodgeRollBarLine:SetColor(1,1,0,1)
		DodgeRollBarLine:SetDrawLayer(3)

	end

	local Rwidth, Rheight = GuiRoot:GetDimensions()
	HTTDodgeRoll:ClearAnchors()
	HTTDodgeRoll:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,(Rwidth/2)-128,Rheight/3)

end


function HTT_DodgeRoll_Events()

	EVENT_MANAGER:RegisterForEvent("DodgeRollCastBeginDebug", EVENT_COMBAT_EVENT, function( eventCode, result, isError, abilityName, abilityGraphic, 
	abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
	if (result == ACTION_RESULT_BEGIN) then
		debugCounter[abilityId] = GetGameTimeSeconds()
		--d(eventCode.."-"..result.."-"..abilityName.."-"..abilityId.."-"..targetType.."-"..hitValue)
	end
	end)
	--EVENT_MANAGER:AddFilterForEvent("DodgeRollCastBeginDebug", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,17046)
	EVENT_MANAGER:RegisterForEvent("DodgeRollCastCompleteDebug", EVENT_COMBAT_EVENT, function( eventCode, result, isError, abilityName, abilityGraphic, 
	abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
	if ((result == 2250 or result == 2151 or result == 2140) --[[and targetType == COMBAT_UNIT_TYPE_PLAYER]] and debugCounter[abilityId] ~= nil) then
		--d(abilityName.." has a duration of:"..GetGameTimeSeconds()-debugCounter[abilityId])
	end
	end)
	--EVENT_MANAGER:AddFilterForEvent("DodgeRollCastCompleteDebug", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,17046)
	
	--[[
	2200 begin
	2250 unblocked
	2151 blocked
	2140 dodged
	]]
	
	EVENT_MANAGER:RegisterForEvent("coneDebug", EVENT_COMBAT_EVENT, function( eventCode, result, isError, abilityName, abilityGraphic, 
	abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)

	--d(eventCode.."-"..result.."-"..GetAbilityName(abilityId).."-"..abilityId.."-"..targetType.."-"..powerType.."-"..hitValue)
	end)
	--EVENT_MANAGER:AddFilterForEvent("coneDebug", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,17228)


	for _,v in pairs(HTT_DodgeRollData) do
		for k1,v1 in pairs(v) do
			if HTTsavedVars[HTT_variables.currentlySelectedProfile].alertNotifications[k1] then
				HTT_DodgeRoll_RegisterEvent(k1,v1.duration,v1.notOnlyPlayer,v1.sound,v1.texture,v1.dodgeDurationOverride,v1.onlyBlock,v1.preventDouble,v1.nameOverride,v1.sourceNameOverride,v1.notBeginning)
			end
		end
	end

end

local function findFreeBar()
	for i=1,7 do
		if bar[i].expiresAt < GetGameTimeSeconds() then
			return i
		end
	end
	return 8
end


function HTT_DodgeRoll_SendAlert(abilityID,abilityName,duration,sourceName,texture,dodgeDurationOverride,onlyBlock)
	local i = findFreeBar()
	if i == 8 then
		return true
	end
	bar[i].duration = duration
	bar[i].expiresAt = GetGameTimeSeconds()+duration
	bar[i].dodgeDuration = dodgeDurationOverride or 1
	bar[i].onlyBlock = onlyBlock or false
	local Line = HTTDodgeRoll:GetNamedChild("DodgeRollBarLine"..i)
	local Outline = HTTDodgeRoll:GetNamedChild("DodgeRollBarOutline"..i)
	local Icon = HTTDodgeRoll:GetNamedChild("DodgeRollBarIcon"..i)
	local Name = HTTDodgeRoll:GetNamedChild("DodgeRollBarName"..i)
	if sourceName then
		Name:SetText(abilityName.." - "..HTT_functions.removeGender(sourceName))
		Name:SetHidden(false)
	else
		Name:SetHidden(true)
	end
	if bar[i].duration > bar[i].dodgeDuration and not bar[i].onlyBlock then
		Line:SetHidden(false)
		Line:ClearAnchors()
		Line:SetAnchor(TOPLEFT,Outline,TOPLEFT,((1-(bar[i].dodgeDuration/bar[i].duration))*224)+32,0)
	else
		Line:SetHidden(true)
	end
	Icon:SetTexture(texture or GetAbilityIcon(abilityID))
end

function HTT_DodgeRoll_Update()
	for i=1,7 do
		local Outline = HTTDodgeRoll:GetNamedChild("DodgeRollBarOutline"..i)
		local Icon = HTTDodgeRoll:GetNamedChild("DodgeRollBarIcon"..i)
		local Fill = HTTDodgeRoll:GetNamedChild("DodgeRollBarFill"..i)
		local Line = HTTDodgeRoll:GetNamedChild("DodgeRollBarLine"..i)
		local Timer = HTTDodgeRoll:GetNamedChild("DodgeRollBarTimer"..i)
		local Name = HTTDodgeRoll:GetNamedChild("DodgeRollBarName"..i)
		if bar[i].expiresAt > GetGameTimeSeconds() then
			Outline:SetHidden(false)
			Icon:SetHidden(false)
			Fill:SetHidden(false)
			Timer:SetHidden(false)
			remainingTime = bar[i].expiresAt - GetGameTimeSeconds()
			aspectRatio = remainingTime/bar[i].duration
			Fill:SetDimensions(224*(1-aspectRatio),28)
			Timer:SetText(HTT_functions.HTT_processTimer((math.floor(remainingTime*10)/10)).."s")
			if bar[i].onlyBlock then
				Fill:SetColor(0.5,0,1)
			elseif remainingTime < bar[i].dodgeDuration then
				Fill:SetColor(1,0,0)
			else
				Fill:SetColor(1, 220/255, 43/255)
			end
		else
			Outline:SetHidden(true)
			Icon:SetHidden(true)
			Fill:SetHidden(true)
			Line:SetHidden(true)
			Timer:SetHidden(true)
			Name:SetHidden(true)
		end
	end
end

function HTT_DodgeRoll_RegisterEvent(abilityID,duration,notOnlyPlayer,sound,texture,dodgeDurationOverride,onlyBlock,preventDouble,nameOverride,sourceNameOverride,notBeginning)
	EVENT_MANAGER:RegisterForEvent("HTT"..abilityID..duration, EVENT_COMBAT_EVENT, function( _, result, _, abilityName, _, 
	_, sourceName, _, _, targetType, hitValue, _, _, _, _, _, _)

	if ((result == ACTION_RESULT_BEGIN or result == notBeginning) and ((targetType == COMBAT_UNIT_TYPE_PLAYER) or notOnlyPlayer) and (preventDouble==nil or preventDouble==hitValue)) then
		HTT_DodgeRoll_SendAlert(abilityID,nameOverride or abilityName,duration,sourceNameOverride or sourceName,texture,dodgeDurationOverride,onlyBlock)
		if sound  then
			PlaySound(sound)
		end
	end
	end)
	EVENT_MANAGER:AddFilterForEvent("HTT"..abilityID..duration, EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,abilityID)

end
