
function HTT_PreviewUI()



	if HTTsavedVars[HTT_variables.currentlySelectedProfile].isAlertUIOn then
		HTTAlert:SetHidden(false)
	else
		HTTAlert:SetHidden(true)
	end

	

	------------------- Initialize backgrounds --------------------
	currentBar,_ = GetActiveWeaponPairInfo()
	local reticleName = HTT: GetNamedChild("TextReticle")
	local reticleBackground = HTT:GetNamedChild("BackgroundReticle")
	reticleName:SetHidden(false)
	reticleName:SetText("Current Target")
	reticleBackground:SetHidden(false)

	------------------- Initialize backgrounds --------------------



	------------------ Self Buffs --------------------------------
	if HTTsavedVars[HTT_variables.currentlySelectedProfile].isBuffUIOn then
		local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffUIWidth
		local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffUIHeight
		HTTSelfBuffs:SetHidden(false)
		for _,trackerID in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs) do
			local tracker = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[trackerID]
			local textInBar = HTTSelfBuffs:GetNamedChild("SelfBuffTextInBar"..trackerID)
			local durationTimer = HTTSelfBuffs:GetNamedChild("SelfBuffDurationTimer"..trackerID)
			local durationBar = HTTSelfBuffs:GetNamedChild("SelfBuffDurationBar"..trackerID)
			local icon = HTTSelfBuffs:GetNamedChild("SelfBuffIcon"..trackerID)			 
			if tracker.turnedOn then
				durationTimer:SetHidden(false)
				durationBar:SetHidden(false)
				icon:SetHidden(false)
				textInBar:SetHidden(false)
			else
				durationTimer:SetHidden(true)
				durationBar:SetHidden(true)
				icon:SetHidden(true)
				textInBar:SetHidden(true)
			end
			durationTimer:SetText("0.0s")
			durationBar:SetDimensions(width *0.75, height)
			durationBar:SetColor(unpack(tracker.color))
		end
	else
		HTTSelfBuffs:SetHidden(true)
	end


	------------------ Self Buffs --------------------------------


	---------------- Block UI -------------------------------------------

	if HTTsavedVars[HTT_variables.currentlySelectedProfile].isBlockUIOn then
		HTTBlock:SetHidden(false)
		local block = HTTBlock:GetNamedChild("Block")
		if IsBlockActive() then
			block:SetAlpha(1)
		else
			block:SetAlpha(0.2)
		end
		local blockCost = HTTBlock:GetNamedChild("blockCost")
		local blockMitigation = HTTBlock:GetNamedChild("blockMitigation")
		local _,blockCostValue = GetAdvancedStatValue(1)
		local _,_,blockMitigationValue = GetAdvancedStatValue(7)
		blockCost:SetText(math.floor(blockCostValue))
		blockMitigation:SetText(math.floor(blockMitigationValue).."%")
		if (GetItemWeaponType(BAG_WORN,EQUIP_SLOT_MAIN_HAND) == WEAPONTYPE_FROST_STAFF and GetActiveWeaponPairInfo() == ACTIVE_WEAPON_PAIR_MAIN) or (GetItemWeaponType(BAG_WORN,EQUIP_SLOT_BACKUP_MAIN) == WEAPONTYPE_FROST_STAFF and GetActiveWeaponPairInfo() == ACTIVE_WEAPON_PAIR_BACKUP) then
			blockCost:SetColor(24/255,0,242/255)
			blockMitigation:SetColor(24/255,0,242/255)
		else
			blockCost:SetColor(52/255, 235/255, 70/255)
			blockMitigation:SetColor(52/255, 235/255, 70/255)
		end
	else
		HTTBlock:SetHidden(true)
	end
	-------------------- Block UI ----------------------------------------




	--------------- Stonefist stacks on yourself // Shimmering ---------------------
	
	if HTTsavedVars[HTT_variables.currentlySelectedProfile].classSpecialIsOn and (GetUnitClassId("player") == 1 or GetUnitClassId("player") == 4) then
		local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].specialUIWidth
		local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].specialUIHeight
		HTTOwnStacks:SetHidden(false)
		local ownStacksTimerBar = HTTOwnStacks:GetNamedChild("StackTimerBar")
		local ownStacksTimerText = HTTOwnStacks:GetNamedChild("StackTimerText")
		local circle1 = HTTOwnStacks:GetNamedChild("CircleInner-1")
		local circle2 = HTTOwnStacks:GetNamedChild("CircleInner0")
		local circle3 = HTTOwnStacks:GetNamedChild("CircleInner1")
		ownStacksTimerText:SetText("0.0s")
		ownStacksTimerBar:SetDimensions(width*0.75,height/6)
		circle3:SetHidden(false)
		circle2:SetHidden(false)
		circle1:SetHidden(false)
	elseif HTTsavedVars[HTT_variables.currentlySelectedProfile].classSpecialIsOn and GetUnitClassId("player") == 5 then
		HTTOwnStacks:SetHidden(false)
		local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].specialUIWidth
		local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].specialUIHeight
		local background = HTTOwnStacks:GetNamedChild("EmpowerBackground")
		for i=1, 12 do
			local bar = HTTOwnStacks:GetNamedChild("EmpowerBar"..i)
			local textInBar = HTTOwnStacks:GetNamedChild("EmpowerTextInBar"..i)
			local icon = HTTOwnStacks:GetNamedChild("EmpowerRoleIcon"..i)
			local timer = HTTOwnStacks:GetNamedChild("EmpowerTimer"..i)
			bar:SetHidden(false)
			textInBar:SetHidden(false)
			icon:SetHidden(false)
			timer:SetHidden(false)
			icon:SetTexture(HTT_variables.roleIcons[1])
			textInBar:SetText("Group"..i)
			timer:SetText("0.0s")
			bar:SetDimensions(width*(0.75),height/3)
			bar:SetTextureCoords(0,1,0,1)
			bar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].classSpecialColor))
		end
		background:SetDimensions(width,(12*(height/2.7))+(height/1.6))
	else
		HTTOwnStacks:SetHidden(true)
	end
	--------------- Stonefist stacks on yourself --------------------- 

	--------------- Reticle Debuffs ----------------------------


	if HTTsavedVars[HTT_variables.currentlySelectedProfile].isDebuffUIOn then
		HTT:SetHidden(false)
		local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIWidth
		local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIHeight
		for _,trackerID in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs) do
			local tracker = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[trackerID]
			local textInBar = HTT:GetNamedChild("TextInBarReticle"..trackerID)
			local durationTimer = HTT:GetNamedChild("DurationTimerReticle"..trackerID)
			local durationBar = HTT:GetNamedChild("DurationBarReticle"..trackerID)
			local icon = HTT:GetNamedChild("IconReticle"..trackerID)
			if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[trackerID].turnedOn then
				durationTimer:SetHidden(false)
				durationBar:SetHidden(false)
				icon:SetHidden(false)
				textInBar:SetHidden(false)
			else
				durationTimer:SetHidden(true)
				durationBar:SetHidden(true)
				icon:SetHidden(true)
				textInBar:SetHidden(true)
			end
			durationTimer:SetText("0.0s")
			durationBar:SetDimensions(width *0.75, height)		
			durationBar:SetColor(unpack(tracker.color))
			textInBar:SetText(tracker.name)
		end
	else
		HTT:SetHidden(true)
	end
	

	--------------- Reticle Debuffs ----------------------------

	--------------- Boss Debuffs ----------------------

	if HTTsavedVars[HTT_variables.currentlySelectedProfile].isBossDebuffUIOn then
	local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffBossUIWidth
	local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffBossUIHeight
		for i=1, MAX_BOSSES do
			_G["HTTBoss"..i]:SetHidden(false)
			local bossName = _G["HTTBoss"..i]:GetNamedChild("TextBoss"..i)
			local bossBackground = _G["HTTBoss"..i]:GetNamedChild("BackgroundBoss"..i)
				bossName:SetHidden(false)
				bossName:SetText("boss"..i)
				bossBackground:SetHidden(false)
			for _,trackerID in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs) do
				local tracker = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[trackerID]
				local textInBar = _G["HTTBoss"..i]:GetNamedChild("TextInBarBoss"..trackerID..i)
				local durationTimer = _G["HTTBoss"..i]:GetNamedChild("DurationTimerBoss"..trackerID..i)
				local durationBar = _G["HTTBoss"..i]:GetNamedChild("DurationBarBoss"..trackerID..i)
				local icon = _G["HTTBoss"..i]:GetNamedChild("IconBoss"..trackerID..i)
				if tracker.turnedOnBoss then
					durationTimer:SetHidden(false)
					durationBar:SetHidden(false)
					icon:SetHidden(false)
					textInBar:SetHidden(false)
				else
					durationTimer:SetHidden(true)
					durationBar:SetHidden(true)
					icon:SetHidden(true)
					textInBar:SetHidden(true)
				end
				durationTimer:SetText("0.0s")
				durationBar:SetDimensions(width *0.75, height)		
				durationBar:SetColor(unpack(tracker.color))
				textInBar:SetText(tracker.name)
			end
		end
		
	else
		for i=1, MAX_BOSSES do
			_G["HTTBoss"..i]:SetHidden(true)
		end
	end


	--------------- Boss Debuffs ----------------------

	------------------ Cooldowns --------------------------------
	if HTTsavedVars[HTT_variables.currentlySelectedProfile].isCooldownUIOn then
		local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownUIWidth
		local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownUIHeight
		HTTCooldowns:SetHidden(false)
		for _,trackerID in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns) do
			local tracker = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[trackerID]
			local textInBar = HTTCooldowns:GetNamedChild("CooldownTextInBar"..trackerID)
			local durationTimer = HTTCooldowns:GetNamedChild("CooldownDurationTimer"..trackerID)
			local durationBar = HTTCooldowns:GetNamedChild("CooldownsDurationBar"..trackerID)
			local icon = HTTCooldowns:GetNamedChild("CooldownIcon"..trackerID)
			if tracker.turnedOn then
				durationTimer:SetHidden(false)
				durationBar:SetHidden(false)
				icon:SetHidden(false)
				textInBar:SetHidden(false)
			else
				durationTimer:SetHidden(true)
				durationBar:SetHidden(true)
				icon:SetHidden(true)
				textInBar:SetHidden(true)
			end
			durationTimer:SetText("0.0s")
			durationBar:SetColor(unpack(tracker.color))
			durationBar:SetDimensions(width*0.75,height)
			textInBar:SetText(tracker.name)
		end
	else
		HTTCooldowns:SetHidden(true)
	end
		

	------------------ Cooldowns --------------------------------


	------------------ Synergies --------------------------------
	if HTTsavedVars[HTT_variables.currentlySelectedProfile].isSynergiesUIOn then
		local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesUIWidth
		local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesUIHeight
		HTTSynergies:SetHidden(false)
		for _,trackerID in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfSynergies) do
			local tracker = HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[trackerID]
			local textInBar = HTTSynergies:GetNamedChild("SynergiesTextInBar"..trackerID)
			local durationTimer = HTTSynergies:GetNamedChild("SynergiesDurationTimer"..trackerID)
			local durationBar = HTTSynergies:GetNamedChild("SynergiesDurationBar"..trackerID)
			local icon = HTTSynergies:GetNamedChild("SynergiesIcon"..trackerID)	 
			if tracker.turnedOn then
				durationTimer:SetHidden(false)
				durationBar:SetHidden(false)
				icon:SetHidden(false)
				textInBar:SetHidden(false)
			else
				durationTimer:SetHidden(true)
				durationBar:SetHidden(true)
				icon:SetHidden(true)
				textInBar:SetHidden(true)
			end
			durationTimer:SetText("0.0s")
			durationBar:SetColor(unpack(tracker.color))
			durationBar:SetDimensions(width*0.75,height)
			textInBar:SetText(tracker.name)
		end
	else
		HTTSynergies:SetHidden(true)
	end


	------------------ Synergies --------------------------------


end