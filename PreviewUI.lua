HTT_previewUI = {}
function HTT_previewUI.UpdateUIInSettings()



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

		for n=1, #HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs do
			
			


			local textInBar = HTTSelfBuffs:GetNamedChild("SelfBuffTextInBar"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs[n])
			local durationTimer = HTTSelfBuffs:GetNamedChild("SelfBuffDurationTimer"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs[n])
			local durationBar = HTTSelfBuffs:GetNamedChild("SelfBuffDurationBar"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs[n])
			local icon = HTTSelfBuffs:GetNamedChild("SelfBuffIcon"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs[n])

				 
			if HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["isTurnedOn"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs[n]] then
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
			durationBar:SetColor(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["colors"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs[n]][1],HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["colors"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs[n]][2], HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["colors"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs[n]][3])


			

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
		for n=1, #HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs do
	

				local textInBar = HTT:GetNamedChild("TextInBarReticle"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs[n])
				local durationTimer = HTT:GetNamedChild("DurationTimerReticle"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs[n])
				local durationBar = HTT:GetNamedChild("DurationBarReticle"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs[n])
				local icon = HTT:GetNamedChild("IconReticle"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs[n])

				

				if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["isTurnedOn"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs[n]] then
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
					durationBar:SetColor(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs[n]][1],HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs[n]][2], HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs[n]][3])



					textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs[n]])

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




			for n=1, #HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs do

				
				local textInBar = _G["HTTBoss"..i]:GetNamedChild("TextInBarBoss"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs[n]..i)
				local durationTimer = _G["HTTBoss"..i]:GetNamedChild("DurationTimerBoss"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs[n]..i)
				local durationBar = _G["HTTBoss"..i]:GetNamedChild("DurationBarBoss"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs[n]..i)
				local icon = _G["HTTBoss"..i]:GetNamedChild("IconBoss"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs[n]..i)

				

				if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["isTurnedOnBoss"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs[n]] then
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
						durationBar:SetColor(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs[n]][1],HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs[n]][2], HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs[n]][3])



					textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs[n]])
			


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

		for n=1, #HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns do




			local textInBar = HTTCooldowns:GetNamedChild("CooldownTextInBar"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns[n])
			local durationTimer = HTTCooldowns:GetNamedChild("CooldownDurationTimer"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns[n])
			local durationBar = HTTCooldowns:GetNamedChild("CooldownsDurationBar"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns[n])
			local icon = HTTCooldowns:GetNamedChild("CooldownIcon"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns[n])

				 
			if HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["isTurnedOn"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns[n]] then
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


			
			durationBar:SetColor(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["colors"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns[n]][1],HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["colors"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns[n]][2], HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["colors"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns[n]][3])

			durationBar:SetDimensions(width*0.75,height)





			textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["names"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns[n]])


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

		for n=1, #HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfSynergies do




			local textInBar = HTTSynergies:GetNamedChild("SynergiesTextInBar"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfSynergies[n])
			local durationTimer = HTTSynergies:GetNamedChild("SynergiesDurationTimer"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfSynergies[n])
			local durationBar = HTTSynergies:GetNamedChild("SynergiesDurationBar"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfSynergies[n])
			local icon = HTTSynergies:GetNamedChild("SynergiesIcon"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfSynergies[n])

				 
			if HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable["isTurnedOn"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfSynergies[n]] then
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


			
			durationBar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable["colors"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfSynergies[n]]))

			durationBar:SetDimensions(width*0.75,height)





			textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable["names"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfSynergies[n]])


		end

	else
		HTTSynergies:SetHidden(true)
	end
		




	------------------ Synergies --------------------------------




end