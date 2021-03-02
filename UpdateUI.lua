HTT_updateUI = {}


function HTT_updateUI.UpdateAlways()

	if HTT_variables.scene~=SCENE_HIDDEN and HTTsavedVars[HTT_variables.currentlySelectedProfile].isAltResourceUIOn then
		HTTHealth:SetHidden(false)
		HTTStamina:SetHidden(false)
		HTTMagicka:SetHidden(false)

		-- HEALTH AND DAMAGE SHIELDS

		local healthBar = HTTHealth:GetNamedChild("healthBar")
		local healthText = HTTHealth:GetNamedChild("healthText")
		local healthTextPercentage = HTTHealth:GetNamedChild("healthTextPercentage")
		local health,maxHealth = GetUnitPower("player",POWERTYPE_HEALTH)
		local shieldBar = HTTHealth:GetNamedChild("shieldBar")
		local shield = GetUnitAttributeVisualizerEffectInfo("player",ATTRIBUTE_VISUAL_POWER_SHIELDING,STAT_MITIGATION,ATTRIBUTE_HEALTH,POWERTYPE_HEALTH) or 0
		if shield > maxHealth then shield = maxHealth end
		healthBar:SetDimensions(64,512*(health/maxHealth))
		healthBar:SetTextureCoords(0,1,1-(health/maxHealth),1)
		shieldBar:SetDimensions(64,512*(shield/maxHealth))
		shieldBar:SetTextureCoords(0,1,1-(shield/maxHealth),1)
		if shield ~= 0 then
			healthText:SetText(health.." ["..shield.."]")
		else
			healthText:SetText(health)
		end
		healthTextPercentage:SetText(math.floor((health/maxHealth)*100).."%")
		-- HEALTH AND DAMAGE SHIELDS

		-- BALANCE 

		local balanceBarIcon = HTTHealth:GetNamedChild("balanceBarIcon")
		local balanceBar = HTTHealth:GetNamedChild("balanceBar")
		local balanceBarOutline = HTTHealth:GetNamedChild("balanceBarOutline")
		local balanceBarOutlineOpaque = HTTHealth:GetNamedChild("balanceBarOutlineOpaque")
		local balanceBarIconFrame = HTTHealth:GetNamedChild("balanceBarIconFrame")
		local isBalanceSlotted,balanceSlotID = HTT_functions.checkIfSkillSlotted({40445,31642,40441})
		local balanceSkillID = HTT_variables.slotToAbilityID[balanceSlotID]
		local balanceRemainingDuration = HTT_functions.GetUnitInfo({balanceSkillID},"player")
		balanceRemainingDuration = balanceRemainingDuration/4

		if isBalanceSlotted then
			balanceBar:SetHidden(false)
			balanceBarIcon:SetHidden(false)
			balanceBarOutline:SetHidden(false)
			balanceBarOutlineOpaque:SetHidden(false)
			balanceBarIconFrame:SetHidden(false)
			balanceBar:SetDimensions(32,128*balanceRemainingDuration)
			balanceBar:SetTextureCoords(0,1,1-balanceRemainingDuration,1)
			balanceBarIcon:SetTexture(GetAbilityIcon(balanceSkillID))
		else
			balanceBar:SetHidden(true)
			balanceBarIcon:SetHidden(true)
			balanceBarOutline:SetHidden(true)
			balanceBarOutlineOpaque:SetHidden(true)
			balanceBarIconFrame:SetHidden(true)
		end

		-- BALANCE

		-- MAJOR MENDING 

		local majorMendingIcon = HTTHealth:GetNamedChild("majorMendingIcon")
		local majorMending = HTTHealth:GetNamedChild("majorMending")
		local majorMendingOutline = HTTHealth:GetNamedChild("majorMendingOutline")
		local majorMendingOutlineOpaque = HTTHealth:GetNamedChild("majorMendingOutlineOpaque")
		local majorMendingIconFrame = HTTHealth:GetNamedChild("majorMendingIconFrame")
		local isIgneousSlotted = HTT_functions.checkIfSkillSlotted({32673,29071,29224})
		local majorMendingRemainingDuration = HTT_functions.GetUnitInfo({61711},"player")
		majorMendingRemainingDuration = majorMendingRemainingDuration/HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["durations"][19]

		if isIgneousSlotted then
			majorMending:SetHidden(false)
			majorMendingIcon:SetHidden(false)
			majorMendingOutline:SetHidden(false)
			majorMendingOutlineOpaque:SetHidden(false)
			majorMendingIconFrame:SetHidden(false)
			majorMending:SetDimensions(32,128*majorMendingRemainingDuration)
			majorMending:SetTextureCoords(0,1,1-majorMendingRemainingDuration,1)
		else
			majorMending:SetHidden(true)
			majorMendingIcon:SetHidden(true)
			majorMendingOutline:SetHidden(true)
			majorMendingOutlineOpaque:SetHidden(true)
			majorMendingIconFrame:SetHidden(true)
		end

		-- MAJOR MENDING
		local staminaBarOutline = HTTStamina:GetNamedChild("staminaBarOutline")
		local staminaBar = HTTStamina:GetNamedChild("staminaBarFill")
		local staminaText = HTTStamina:GetNamedChild("staminaText")
		local staminaTextPercentage = HTTStamina:GetNamedChild("staminaTextPercentage")
		local staminaLine = HTTStamina:GetNamedChild("staminaBarLine")
		local dodgeRollCost = GetAbilityCost(28549)
		local stamina,maxStamina = GetUnitPower("player",POWERTYPE_STAMINA)
		local dodgeRollDuration = HTT_functions.GetUnitInfo({29721},"player")
		dodgeRollDuration = dodgeRollDuration - 2
		if dodgeRollDuration < 0 then
			staminaLine:SetHidden(false)
			local correction
			if stamina>dodgeRollCost then
				correction = (stamina-dodgeRollCost)/maxStamina
				staminaLine:SetColor(0,0.3,0)
			else
				correction = dodgeRollCost/maxStamina
				staminaLine:SetColor(1,0,0)
			end
			staminaLine:ClearAnchors()
			staminaLine:SetAnchor(BOTTOMLEFT,staminaBarOutline,BOTTOMLEFT,33-(30*correction*correction*correction),(-256)*correction)
		else
			staminaLine:SetHidden(true)
		end
		staminaBar:SetDimensions(64,256*(stamina/maxStamina))
		staminaBar:SetTextureCoords(0,1,1-(stamina/maxStamina),1)
		staminaText:SetText(stamina)
		staminaTextPercentage:SetText(math.floor((stamina/maxStamina)*100).."%")

		-- DODGE ROLL

		local dodgeRollBar = HTTStamina:GetNamedChild("dodgeRollBarFill")
		local dodgeRollStackCounter = HTTStamina:GetNamedChild("dodgeRollStackCounter")
		local dodgeRollRemainingDuration,dodgeRollStacks = HTT_functions.GetUnitInfo({69143},"player")
		dodgeRollRemainingDuration = dodgeRollRemainingDuration/4
		dodgeRollBar:SetDimensions(32,128*dodgeRollRemainingDuration)
		dodgeRollBar:SetTextureCoords(0,1,1-dodgeRollRemainingDuration,1)
		if dodgeRollStacks > 0 then
			dodgeRollStackCounter:SetHidden(false)
			dodgeRollStackCounter:SetText(dodgeRollStacks)
		else
			dodgeRollStackCounter:SetHidden(true)
		end
		-- DODGE ROLL

		local magickaBar = HTTMagicka:GetNamedChild("magickaBarFill")
		local magickaText = HTTMagicka:GetNamedChild("magickaText")
		local magickaTextPercentage = HTTMagicka:GetNamedChild("magickaTextPercentage")
		local magicka,maxMagicka = GetUnitPower("player",POWERTYPE_MAGICKA)
		magickaBar:SetDimensions(64,256*(magicka/maxMagicka))
		magickaBar:SetTextureCoords(0,1,0,magicka/maxMagicka)
		magickaText:SetText(magicka)
		magickaTextPercentage:SetText(math.floor((magicka/maxMagicka)*100).."%")




		local horseStaminaBar = HTTHealth:GetNamedChild("horseStamina")
		local horseStaminaOutline = HTTHealth:GetNamedChild("horseStaminaOutline")
		local horseStaminaOutlineOpaque = HTTHealth:GetNamedChild("horseStaminaOutlineOpaque")
		local horseStaminaIconFrame = HTTHealth:GetNamedChild("horseStaminaIconFrame")
		local horseStaminaIcon = HTTHealth:GetNamedChild("horseStaminaIcon")
		local horseStamina,horseMaxStamina = GetUnitPower("player",POWERTYPE_MOUNT_STAMINA)
		if IsMounted() then
			horseStaminaBar:SetDimensions(32,128*(horseStamina/horseMaxStamina))
			horseStaminaBar:SetTextureCoords(0,1,0,(horseStamina/horseMaxStamina))
			horseStaminaBar:SetHidden(false)
			horseStaminaOutline:SetHidden(false)
			horseStaminaOutlineOpaque:SetHidden(false)
			horseStaminaIconFrame:SetHidden(false)
			horseStaminaIcon:SetHidden(false)
		else
			horseStaminaBar:SetHidden(true)
			horseStaminaOutline:SetHidden(true)
			horseStaminaOutlineOpaque:SetHidden(true)
			horseStaminaIconFrame:SetHidden(true)
			horseStaminaIcon:SetHidden(true)
		end








	else
		HTTHealth:SetHidden(true)
		HTTStamina:SetHidden(true)
		HTTMagicka:SetHidden(true)
	end
	local reflect = HTTReflect:GetNamedChild("reflect")
	local reflectFill = HTTReflect:GetNamedChild("reflectFill")
	if HTT_variables.scene==SCENE_HIDDEN then
		reflect:SetHidden(true)
		reflectFill:SetHidden(true)
	elseif HTTsavedVars[HTT_variables.currentlySelectedProfile].isReflectIndicatorOn then
		reflect:SetHidden(not HTT_variables.isReflectActive)
		reflectFill:SetHidden(not HTT_variables.isReflectActive)
		reflectFill:SetDimensions(128*((HTT_variables.reflectExpiresAt-GetGameTimeSeconds())/6),64)
		reflectFill:SetTextureCoords(0.5+(HTT_variables.reflectExpiresAt-GetGameTimeSeconds())/12,0.5-((HTT_variables.reflectExpiresAt-GetGameTimeSeconds())/12),0,1)
	end
	

end

function HTT_updateUI.UpdateCombat()

	
	--d(GetPlayerStat(STAT_ARMOR_RATING, STAT_BONUS_OPTION_APPLY_BONUS))










	------------------- Initialize backgrounds --------------------
	currentBar,_ = GetActiveWeaponPairInfo()
	_,HTT_variables.maxMag = GetUnitPower("player",POWERTYPE_MAGICKA)
	engulfingPower = HTT_functions.GetTrueEngulfingValue()

	local reticleName = HTT:GetNamedChild("TextReticle")
	local reticleBackground = HTT:GetNamedChild("BackgroundReticle")

	if DoesUnitExist("reticleover") and IsUnitAttackable("reticleover") then
		reticleName:SetHidden(false)
		reticleName:SetText(GetUnitName("reticleover"))
		reticleBackground:SetHidden(false)
	else
		reticleName:SetHidden(true)
		reticleBackground:SetHidden(true)
	end


	------------------- Initialize backgrounds --------------------



	------------------ Self Buffs --------------------------------
	if HTTsavedVars[HTT_variables.currentlySelectedProfile].isBuffUIOn and HTT_variables.scene~=SCENE_HIDDEN  then
		local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffUIWidth
		local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffUIHeight
		local scale = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffUIScale
		HTTSelfBuffs:SetHidden(false)




		for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs) do
			local textInBar = HTTSelfBuffs:GetNamedChild("SelfBuffTextInBar"..v)
			local durationTimer = HTTSelfBuffs:GetNamedChild("SelfBuffDurationTimer"..v)
			local durationBar = HTTSelfBuffs:GetNamedChild("SelfBuffDurationBar"..v)
			local icon = HTTSelfBuffs:GetNamedChild("SelfBuffIcon"..v)
			if HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["isTurnedOn"][v] then
			if v==3 then
				remainingTime = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["expiresAt"][3] - GetGameTimeSeconds()
				if remainingTime > 0 then
					isActive = true
				else
					isActive = false
				end
			else
				remainingTime,_,isActive = HTT_functions.GetUnitInfo(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["IDs"][v],"player")
			end
			duration = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["durations"][n]


			

				 
			
				durationTimer:SetHidden(false)
				durationBar:SetHidden(false)
				icon:SetHidden(false)
				textInBar:SetHidden(false)


			
			

			if remainingTime > 0 then
				durationTimer:SetText(HTT_functions.HTT_processTimer((math.floor(remainingTime*10)/10)).."s")
			else
				durationTimer:SetText("0.0s")
			end

			if isActive then
				if HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["names"][v] == "Immovable" then
					HTT_variables.immovableOn = true
				end
				if HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["names"][v] == "Bound Aegis" then
					HTT_variables.isBoundAegisOn = true
				end
				if HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["names"][v] == "Sacred Ground" then
					HTT_variables.isSacredGroundOn = true
				end
				durationBar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["colors"][v]))
				if remainingTime > 0 then
					durationBar:SetDimensions(width*0.75*(remainingTime/HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["durations"][v]),height)
					durationBar:SetTextureCoords(0,remainingTime/HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["durations"][v],0,1)
				else
					durationBar:SetDimensions(width*0.75,height)
				end
			end

			if  remainingTime <= 0 and not isActive then
				if HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["names"][v] == "Immovable" then
					HTT_variables.immovableOn = false
				end
				if HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["names"][v] == "Bound Aegis" then
					HTT_variables.isBoundAegisOn = false
				end
				if HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["names"][v] == "Sacred Ground" then
					HTT_variables.isSacredGroundOn = false
				end
				textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["textWhenMissing"][v])
				durationBar:SetColor(50,50,51,0.5)
				durationBar:SetTextureCoords(0,1,0,1)
				durationBar:SetDimensions(width*0.75,height)
			else
				if HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["names"][v] == "Puncturing Remedy" and HTT_variables.masterSnB ~= nil then
					textInBar:SetText("+"..HTT_variables.masterSnB.." armor")
				else
					textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["texts"][v])
				end
			end


			else
				durationTimer:SetHidden(true)
				durationBar:SetHidden(true)
				icon:SetHidden(true)
				textInBar:SetHidden(true)
			end


		end


	else
		HTTSelfBuffs:SetHidden(true)
	end
		




	------------------ Self Buffs --------------------------------


	---------------- Block UI -------------------------------------------

	if HTTsavedVars[HTT_variables.currentlySelectedProfile].isBlockUIOn and HTT_variables.scene~=SCENE_HIDDEN  then
		HTTBlock:SetHidden(false)
		local block = HTTBlock:GetNamedChild("Block")
		if IsBlockActive() then
			block:SetAlpha(1)
		else
			block:SetAlpha(0.2)
		end
		local blockCost = HTTBlock:GetNamedChild("blockCost")
		local blockMitigation = HTTBlock:GetNamedChild("blockMitigation")
		blockCost:SetText(HTT_blockFormula.GetBlockCost())
		blockMitigation:SetText(HTT_blockFormula.GetBlockMitigation().."%")
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
	
	if HTTsavedVars[HTT_variables.currentlySelectedProfile].classSpecialIsOn and (GetUnitClassId("player") == 1 or GetUnitClassId("player") == 4) and HTT_variables.scene~=SCENE_HIDDEN  then
		HTTOwnStacks:SetHidden(false)
		local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].specialUIWidth
		local ownStacksTimerBar = HTTOwnStacks:GetNamedChild("StackTimerBar")
		local ownStacksTimerText = HTTOwnStacks:GetNamedChild("StackTimerText")
		local circle1 = HTTOwnStacks:GetNamedChild("CircleInner-1")
		local circle2 = HTTOwnStacks:GetNamedChild("CircleInner0")
		local circle3 = HTTOwnStacks:GetNamedChild("CircleInner1")
		local ownRemainingTime = HTT_variables.specialExpireTime[GetUnitClassId("player")]-GetGameTimeSeconds()
		local ownStacks = HTT_variables.specialStacks[GetUnitClassId("player")]
		if ownRemainingTime < 0 then
			ownRemainingTime = 0
		end
		ownStacksTimerText:SetText(HTT_functions.HTT_processTimer((math.floor(ownRemainingTime*10)/10)).."s")

		if ownRemainingTime ~= 0 then
			ownStacksTimerBar:SetDimensions(math.floor(width * 0.77)*(ownRemainingTime/HTT_variables.specialDuration[GetUnitClassId("player")]),10)
			ownStacksTimerBar:SetTextureCoords(0,ownRemainingTime/HTT_variables.specialDuration[GetUnitClassId("player")],0,1)
		else
			ownStacksTimerBar:SetDimensions(0,10)
			ownStacksTimerBar:SetTextureCoords(0,1,0,1)
		end
		if ownStacks == 3 then
			circle3:SetHidden(false)
		else
			circle3:SetHidden(true)
		end
		if ownStacks >= 2 then
			circle2:SetHidden(false)
		else
			circle2:SetHidden(true)
		end
		if ownStacks >= 1 then
			circle1:SetHidden(false)
		else
			circle1:SetHidden(true)
		end



	elseif HTTsavedVars[HTT_variables.currentlySelectedProfile].classSpecialIsOn and GetUnitClassId("player") == 5 and HTT_variables.scene~=SCENE_HIDDEN  then
		HTTOwnStacks:SetHidden(false)
		local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].specialUIWidth
		local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].specialUIHeight
		local countMembers = 0
		local background = HTTOwnStacks:GetNamedChild("EmpowerBackground")
		for i=1, 12 do

			local searchBy = "group"..i
			if not IsUnitGrouped("player") then
				searchBy = "player"
			end
			local bar = HTTOwnStacks:GetNamedChild("EmpowerBar"..i)
			local textInBar = HTTOwnStacks:GetNamedChild("EmpowerTextInBar"..i)
			local icon = HTTOwnStacks:GetNamedChild("EmpowerRoleIcon"..i)
			local timer = HTTOwnStacks:GetNamedChild("EmpowerTimer"..i)
			if (DoesUnitExist("group"..i) and (GetGroupMemberSelectedRole(searchBy) == 1 or (not HTTsavedVars[HTT_variables.currentlySelectedProfile].trackOnlyDD))) or (i==1 and not IsUnitGrouped("player")) then
				bar:SetHidden(false)
				textInBar:SetHidden(false)
				icon:SetHidden(false)
				timer:SetHidden(false)
				countMembers = countMembers + 1
			else
				bar:SetHidden(true)
				textInBar:SetHidden(true)
				icon:SetHidden(true)
				timer:SetHidden(true)
			end
			icon:SetTexture(HTT_variables.roleIcons[GetGroupMemberSelectedRole(searchBy)])
			textInBar:SetText(GetUnitName(searchBy))
			timeRemaining = HTT_functions.GetUnitInfo({61737},searchBy)
			if timeRemaining > 5 then
				timeRemaining = 5
			end
			timer:SetText((math.floor(timeRemaining*10)/10).."s")
			if timeRemaining <= 0 then
				bar:SetDimensions(width*0.75,height/3)
				bar:SetTextureCoords(0,1,0,1)
				bar:SetColor(50,50,51,0.5)
			else
				bar:SetDimensions(width*(0.75)*(timeRemaining/5),height/3)
				bar:SetTextureCoords(0,timeRemaining/5,0,1)
				bar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].classSpecialColor))
			end
		end
		background:SetDimensions(width,(countMembers*(height/2.7))+(height/1.6))
	else
		HTTOwnStacks:SetHidden(true)
	end


	--------------- Stonefist stacks on yourself --------------------- 

	--------------- Reticle Debuffs ----------------------------


	if HTTsavedVars[HTT_variables.currentlySelectedProfile].isDebuffUIOn and HTT_variables.scene~=SCENE_HIDDEN  then
		HTT:SetHidden(false)
		local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIWidth
		local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIHeight
		local scale = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIScale
		local minorMaimEndingAt = 0
		for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs) do
				local textInBar = HTT:GetNamedChild("TextInBarReticle"..v)
				local durationTimer = HTT:GetNamedChild("DurationTimerReticle"..v)
				local durationBar = HTT:GetNamedChild("DurationBarReticle"..v)
				local icon = HTT:GetNamedChild("IconReticle"..v)
				if DoesUnitExist("reticleover") and IsUnitAttackable("reticleover") and HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["isTurnedOn"][v] then
					if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][v] == "Weapon Skill" then
						remainingTime = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["expiresAt"][v] - GetGameTimeSeconds()
						stacks = 1
						duration = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["durations"][v]
					else
						remainingTime,stacks,_,abilityID = HTT_functions.GetUnitInfo(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["IDs"][v],"reticleover")
						if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][v] == "Minor Maim" then
							minorMaimEndingAt = remainingTime+GetGameTimeSeconds()
						end
						duration = (HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["durations"][v][GetUnitName("reticleover")] or 0)
					end
					if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][v] == "Weapon Skill" then
						if (HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["expiresAt"][HTT_functions.findPositionOfElementInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"],"Crusher")][GetUnitName("reticleover")] or 0) > GetGameTimeSeconds() then
							HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["texts"][v] = HTT_functions.crushersLeft(remainingTime,(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["expiresAt"][HTT_functions.findPositionOfElementInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"],"Crusher")][GetUnitName("reticleover")] or 0) - GetGameTimeSeconds()).." crushers left"
						else
							HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["texts"][v] = HTT_functions.crushersLeft(remainingTime,0).." crushers left"
						end
					end	
					durationTimer:SetHidden(false)
					durationBar:SetHidden(false)
					icon:SetHidden(false)
					textInBar:SetHidden(false)
					if remainingTime > 0 then
						durationTimer:SetText(HTT_functions.HTT_processTimer((math.floor(remainingTime*10)/10)).."s")
					else
						durationTimer:SetText("0.0s")
					end
					if remainingTime ~= 0 then
						durationBar:SetDimensions(width*0.75*(remainingTime/duration),height)
						durationBar:SetTextureCoords(0,remainingTime/duration,0,1)
						if stacks == 3 then
							durationBar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors3"][v]))
						elseif stacks == 2 or (HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][v] == "Off-Balance/Off-Balance Immunity" and abilityID==134599) then
							durationBar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors2"][v]))
						else
							durationBar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors"][v]))
						end
					end
					if  remainingTime <= 0 then
						textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["textWhenMissing"][v])
						durationBar:SetColor(50,50,51,0.5)
						durationBar:SetTextureCoords(0,1,0,1)
						durationBar:SetDimensions(width*0.75,height)
					elseif HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][v] == "Engulfing Flames" then
						textInBar:SetText(engulfingPower.."% fire damage")
					elseif HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][v] == "Alkosh" and HTT_variables.alkoshHits[HTT_variables.targetNameUnitID[GetUnitName("reticleover")]] then
						textInBar:SetText(HTT_variables.alkoshHits[HTT_variables.targetNameUnitID[GetUnitName("reticleover")]].." penetration")
					elseif HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][v] == "Alkosh" then
						textInBar:SetText("unknown penetration")
					elseif HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][v] == "Stagger" then
						textInBar:SetText((stacks*65).." damage increase")
					elseif HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][v] == "Off-Balance/Off-Balance Immunity" and abilityID==134599 then
						textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].offBalanceImmunityText)
					else
						textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["texts"][v])
					end
				
					if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][v] == "Minor Brittle" and (minorMaimEndingAt-4)>GetGameTimeSeconds() then
						textInBar:SetText("Minor Brittle Impossible")
						durationBar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors2"][v]))
					end
				else
					if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][v] == "Minor Maim" then
						remainingTime = HTT_functions.GetUnitInfo(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["IDs"][v],"reticleover")
						minorMaimEndingAt = remainingTime+GetGameTimeSeconds()
					end
					durationTimer:SetHidden(true)
					durationBar:SetHidden(true)
					icon:SetHidden(true)
					textInBar:SetHidden(true)
				end
		end
	else
		HTT:SetHidden(true)
	end
	

	--------------- Reticle Debuffs ----------------------------

	--------------- Boss Debuffs ----------------------

	if HTTsavedVars[HTT_variables.currentlySelectedProfile].isBossDebuffUIOn and HTT_variables.scene~=SCENE_HIDDEN  then
		local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffBossUIWidth
		local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffBossUIHeight
		local scale = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffBossUIScale

		for i=1, MAX_BOSSES do
			_G["HTTBoss"..i]:SetHidden(false)
			local bossName = _G["HTTBoss"..i]:GetNamedChild("TextBoss"..i)
			local bossBackground = _G["HTTBoss"..i]:GetNamedChild("BackgroundBoss"..i)
			if DoesUnitExist("boss"..i) then
				_G["HTTBoss"..i]:SetHidden(false)
				bossName:SetHidden(false)
				bossName:SetText(GetUnitName("boss"..i))
				bossBackground:SetHidden(false)


				local minorMaimEndingAt = 0
				
				for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs) do
					local textInBar = _G["HTTBoss"..i]:GetNamedChild("TextInBarBoss"..v..i)
					local durationTimer = _G["HTTBoss"..i]:GetNamedChild("DurationTimerBoss"..v..i)
					local durationBar = _G["HTTBoss"..i]:GetNamedChild("DurationBarBoss"..v..i)
					local icon = _G["HTTBoss"..i]:GetNamedChild("IconBoss"..v..i)
					if  HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["isTurnedOnBoss"][v] then



					if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][v] == "Weapon Skill" then
						remainingTime = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["expiresAt"][v] - GetGameTimeSeconds()
						stacks = 1
						duration = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["durations"][v]
					else
						remainingTime,stacks,_,abilityID = HTT_functions.GetUnitInfo(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["IDs"][v],"boss"..i)
						duration = (HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["durations"][v][GetUnitName("boss"..i)] or 0)
					end
					if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][v] == "Weapon Skill" then
						if (HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["expiresAt"][HTT_functions.findPositionOfElementInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"],"Crusher")][GetUnitName("boss"..i)] or 0) > GetGameTimeSeconds() then
							HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["texts"][v] = HTT_functions.crushersLeft(remainingTime,(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["expiresAt"][HTT_functions.findPositionOfElementInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"],"Crusher")][GetUnitName("boss"..i)] or 0) - GetGameTimeSeconds()).." crushers left"
						else
							HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["texts"][v] = HTT_functions.crushersLeft(remainingTime,0).." crushers left"
						end
					end
					

				

		
		
					
					durationTimer:SetHidden(false)
					durationBar:SetHidden(false)
					icon:SetHidden(false)
					textInBar:SetHidden(false)


					
					

			
					if remainingTime > 0 then
						durationTimer:SetText(HTT_functions.HTT_processTimer((math.floor(remainingTime*10)/10)).."s")
					else
						durationTimer:SetText("0.0s")
					end

		

			

					if remainingTime ~= 0 then
					durationBar:SetDimensions(width*0.75*(remainingTime/duration),height)
					durationBar:SetTextureCoords(0,remainingTime/duration,0,1)
						if stacks == 3 then
							durationBar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors3"][v]))

						elseif stacks == 2 or (HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][v] == "Off-Balance/Off-Balance Immunity" and abilityID==134599) then
							durationBar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors2"][v]))
						else
							durationBar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors"][v]))

						end
					end

					if  remainingTime <= 0 then
						textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["textWhenMissing"][v])
						durationBar:SetTextureCoords(0,1,0,1)
						durationBar:SetColor(50,50,51,0.5)
						durationBar:SetDimensions(width*0.75,height)
						elseif HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][v] == "Engulfing Flames" then
							textInBar:SetText(engulfingPower.."% fire damage")
						elseif HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][v] == "Alkosh" and HTT_variables.alkoshHits[HTT_variables.targetNameUnitID[GetUnitName("boss"..i)]] then
							textInBar:SetText(HTT_variables.alkoshHits[HTT_variables.targetNameUnitID[GetUnitName("boss"..i)]].." penetration")
						elseif HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][v] == "Alkosh" then
							textInBar:SetText("unknown penetration")
						elseif HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][v] == "Stagger" then
							textInBar:SetText((stacks*65).." damage increase")
						elseif HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][v] == "Off-Balance/Off-Balance Immunity" and abilityID==134599 then
							textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].offBalanceImmunityText)
						else
							textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["texts"][v])
					end
				
					if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][v] == "Minor Brittle" and (minorMaimEndingAt-4)>GetGameTimeSeconds() then
						textInBar:SetText("Minor Brittle Impossible")
						durationBar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors2"][v]))
					end

					else
						if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][v] == "Minor Maim" then
							remainingTime = HTT_functions.GetUnitInfo(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["IDs"][v],"reticleover")
							minorMaimEndingAt = remainingTime+GetGameTimeSeconds()
						end
						durationTimer:SetHidden(true)
						durationBar:SetHidden(true)
						icon:SetHidden(true)
						textInBar:SetHidden(true)
					end

				end



			
			else
				bossName:SetHidden(true)
				bossBackground:SetHidden(true)
				_G["HTTBoss"..i]:SetHidden(true)
			end
		



			
			
			



		end
		
	else
		for i=1, MAX_BOSSES do
			_G["HTTBoss"..i]:SetHidden(true)
		end
	end


	--------------- Boss Debuffs ----------------------




	------------------ Cooldowns --------------------------------
	if HTTsavedVars[HTT_variables.currentlySelectedProfile].isCooldownUIOn and HTT_variables.scene~=SCENE_HIDDEN  then
		local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownUIWidth
		local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownUIHeight
		local scale = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownUIScale
		HTTCooldowns:SetHidden(false)
		
		for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns) do
			local textInBar = HTTCooldowns:GetNamedChild("CooldownTextInBar"..v)
			local durationTimer = HTTCooldowns:GetNamedChild("CooldownDurationTimer"..v)
			local durationBar = HTTCooldowns:GetNamedChild("CooldownsDurationBar"..v)
			local icon = HTTCooldowns:GetNamedChild("CooldownIcon"..v)
			if HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["isTurnedOn"][v] then
			remainingTime = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["expiresAt"][v] - GetGameTimeSeconds()
			duration = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["durations"][v]


			

				 
			
			durationTimer:SetHidden(false)
			durationBar:SetHidden(false)
			icon:SetHidden(false)
			textInBar:SetHidden(false)



			

			if remainingTime > 0 then
				durationTimer:SetText(HTT_functions.HTT_processTimer((math.floor(remainingTime*10)/10)).."s")
			else
				durationTimer:SetText("0.0s")
			end

			
			durationBar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["colors"][v]))
			if remainingTime > 0 then
				durationBar:SetTextureCoords(0,remainingTime/HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["durations"][v],0,1)
				durationBar:SetDimensions(width*0.75*(remainingTime/HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["durations"][v]),height)
			else
				durationBar:SetDimensions(width*0.75,height)
			end


			if  remainingTime <= 0 then
				textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["textWhenMissing"][v])
				durationBar:SetTextureCoords(0,1,0,1)
				durationBar:SetColor(50,50,51,0.5)
				durationBar:SetDimensions(width*0.75,height)
			else
				textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["texts"][v])
			end
			else
				durationTimer:SetHidden(true)
				durationBar:SetHidden(true)
				icon:SetHidden(true)
				textInBar:SetHidden(true)
			end
		end

	else
		HTTCooldowns:SetHidden(true)
	end
		




	------------------ Cooldowns --------------------------------


	------------------- Synergies ----------------------------------

	if HTTsavedVars[HTT_variables.currentlySelectedProfile].isSynergiesUIOn and HTT_variables.scene~=SCENE_HIDDEN  then
		local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesUIWidth
		local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesUIHeight
		local scale = HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesUIScale
		HTTSynergies:SetHidden(false)

		for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfSynergies) do
			local textInBar = HTTSynergies:GetNamedChild("SynergiesTextInBar"..v)
			local durationTimer = HTTSynergies:GetNamedChild("SynergiesDurationTimer"..v)
			local durationBar = HTTSynergies:GetNamedChild("SynergiesDurationBar"..v)
			local icon = HTTSynergies:GetNamedChild("SynergiesIcon"..v)
			if HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable["isTurnedOn"][v] then
			remainingTime = HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable["expiresAt"][v] - GetGameTimeSeconds()


			

				 
			
			durationTimer:SetHidden(false)
			durationBar:SetHidden(false)
			icon:SetHidden(false)
			textInBar:SetHidden(false)


			
			

			if remainingTime > 0 then
				durationTimer:SetText(HTT_functions.HTT_processTimer((math.floor(remainingTime*10)/10)).."s")
			else
				durationTimer:SetText("0.0s")
			end

			
			durationBar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable["colors"][v]))
			if remainingTime > 0 then
				durationBar:SetTextureCoords(0,remainingTime/20,0,1)
				durationBar:SetDimensions(width*0.75*(remainingTime/20),height)
			else
				durationBar:SetDimensions(width*0.75,height)
			end


			if  remainingTime <= 0 then
				textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable["textWhenMissing"][v])
				durationBar:SetTextureCoords(0,1,0,1)
				durationBar:SetColor(50,50,51,0.5)
				durationBar:SetDimensions(width*0.75,height)
			else
				textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable["texts"][v])
			end
			else
				durationTimer:SetHidden(true)
				durationBar:SetHidden(true)
				icon:SetHidden(true)
				textInBar:SetHidden(true)
			end
		end

	else
		HTTSynergies:SetHidden(true)
	end


	----------------------- Synergies -----------------------------------



end