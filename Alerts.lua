HTT_Alerts = {
	StoneGarden = {
		weaponOnFireActive = false,
		lastUsedAt = {
			[1] = 0, --whop
			[2] = 0, --inflamableConcoction
			[3] = 0, --weapon on fire
			[4] = 0, --scalding stab
		},
		cooldown = {
			[1] = 15,
			[2] = 15,
			[3] = 15,
			[4] = 6,
		},
		text = {
			[1] = "Fiery Weapon",
			[2] = "Throw Fire",
			[3] = "Heavy Attack",
			[4] = "DoT Stab",
		},
		color = {
			[1] = {0.2,0.6,0.4},
			[2] = {0.9,0.9,0.1},
			[3] = {62/255, 41/255,1},
			[4] = {1,0,0},
		},
		icon = {
			[1] = "esoui/art/icons/ability_rogue_034.dds",
			[2] = "/esoui/art/icons/death_recap_fire_aoe2.dds",
			[3] = "/esoui/art/icons/death_recap_melee_heavy.dds",
			[4] = "/esoui/art/icons/death_recap_melee_heavy.dds",
		}








	}
















}
function HTT_Alerts.StoneGarden.initializeEvents()

	EVENT_MANAGER:RegisterForEvent("scaldingStab", EVENT_COMBAT_EVENT, function()  
	
		HTT_Alerts.StoneGarden.lastUsedAt[4] = GetGameTimeSeconds()
		HTT_Alerts.StoneGarden.cooldown[4] = 6

	end)
	EVENT_MANAGER:AddFilterForEvent("scaldingStab", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,133440)



	EVENT_MANAGER:RegisterForEvent("whop", EVENT_COMBAT_EVENT, function() 
	if HTT_Alerts.StoneGarden.lastUsedAt[3] + HTT_Alerts.StoneGarden.cooldown[3] <= GetGameTimeSeconds() then
		HTT_Alerts.StoneGarden.lastUsedAt[3] = GetGameTimeSeconds()
	end
	end)
	EVENT_MANAGER:AddFilterForEvent("whop", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,134308)

	EVENT_MANAGER:RegisterForEvent("inflamableConcoction", EVENT_COMBAT_EVENT, function() 
	if HTT_Alerts.StoneGarden.lastUsedAt[2] + HTT_Alerts.StoneGarden.cooldown[2] <= GetGameTimeSeconds() then
		HTT_Alerts.StoneGarden.lastUsedAt[2] = GetGameTimeSeconds()
	end
	end)
	EVENT_MANAGER:AddFilterForEvent("inflamableConcoction", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,134460)

	EVENT_MANAGER:RegisterForEvent("weaponOnFire", EVENT_EFFECT_CHANGED, function(_,_,_,_,_,check)  
	if check ~= 0 then
		HTT_Alerts.StoneGarden.lastUsedAt[1] = GetGameTimeSeconds()
		HTT_Alerts.StoneGarden.lastUsedAt[4] = GetGameTimeSeconds()
		HTT_Alerts.StoneGarden.cooldown[4] = 3
		HTT_Alerts.StoneGarden.cooldown[1] = 15
		HTT_Alerts.StoneGarden.weaponOnFireActive = true
	end
	end)
	EVENT_MANAGER:AddFilterForEvent("weaponOnFire", EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID,133423)

	EVENT_MANAGER:RegisterForEvent("weaponOnFireOver", EVENT_EFFECT_CHANGED, function(_,_,_,_,_,check)  
	if  check == 0 then
		HTT_Alerts.StoneGarden.lastUsedAt[1] = GetGameTimeSeconds()
		HTT_Alerts.StoneGarden.cooldown[1] = 10
		HTT_Alerts.StoneGarden.weaponOnFireActive = false
	end
	end)
	EVENT_MANAGER:AddFilterForEvent("weaponOnFireOver", EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID,133423)








end


function HTT_Alerts.UpdateDuration()

	local AlertBackground = HTTAlert:GetNamedChild("AlertsBackground")
	local countMembers = 0
	
------------------ Cooldowns --------------------------------
	if HTT_variables.scene~=SCENE_HIDDEN  then
		HTTAlert:SetHidden(false)
		for n=1, 4 do
			local effectIsOn = false
			remainingTime = HTT_Alerts.StoneGarden.lastUsedAt[n] + HTT_Alerts.StoneGarden.cooldown[n] - GetGameTimeSeconds()

				


			local textInBar = HTTAlert:GetNamedChild("AlertsTextInBar"..n)
			local durationTimer = HTTAlert:GetNamedChild("AlertsDurationTimer"..n)
			local durationBar = HTTAlert:GetNamedChild("AlertsDurationBar"..n)
			local icon = HTTAlert:GetNamedChild("AlertsIcon"..n)

				 

			durationTimer:SetHidden(false)
			durationBar:SetHidden(false)
			icon:SetHidden(false)
			textInBar:SetHidden(false)
			countMembers = countMembers+1


			durationBar:ClearAnchors()
			durationBar:SetAnchor(TOPLEFT, AlertBackground, TOPLEFT, 24, (countMembers*22))
			durationTimer:ClearAnchors()
			durationTimer:SetAnchor(TOPLEFT, AlertBackground, TOPLEFT, 5, (22*countMembers))
			textInBar:ClearAnchors()
			textInBar:SetAnchor(TOPLEFT, AlertBackground, TOPLEFT, 30, (22*countMembers)+1)
			icon:ClearAnchors()
			icon:SetAnchor(TOPLEFT, AlertBackground, TOPLEFT, 5, (22*countMembers))

			if remainingTime > 0 then
				durationTimer:SetText((math.floor(remainingTime*10)/10).."s")
			else
				durationTimer:SetText("0.0s")
			end

			
			durationBar:SetColor(HTT_Alerts.StoneGarden.color[n][1],HTT_Alerts.StoneGarden.color[n][2],HTT_Alerts.StoneGarden.color[n][3])
			if remainingTime > 0 then
				durationBar:SetDimensions(math.floor(HTTsavedVars[HTT_variables.currentlySelectedProfile].width * ( 1 - 0.2))*(remainingTime/HTT_Alerts.StoneGarden.cooldown[n]),HTTsavedVars[HTT_variables.currentlySelectedProfile].height/2)
				durationBar:SetTextureCoords(0,remainingTime/HTT_Alerts.StoneGarden.cooldown[n],0,1)
			else
				durationBar:SetDimensions(math.floor(HTTsavedVars[HTT_variables.currentlySelectedProfile].width * ( 1 - 0.2)),HTTsavedVars[HTT_variables.currentlySelectedProfile].height/2)
			end

			icon:SetTexture(HTT_Alerts.StoneGarden.icon[n])
			if n==4 and not HTT_Alerts.StoneGarden.weaponOnFireActive then
				durationBar:SetColor(0.9,0.1,0.9)
				textInBar:SetText(HTT_Alerts.StoneGarden.text[n].." impossible")
			elseif  remainingTime <= 0 then
				
				textInBar:SetText(HTT_Alerts.StoneGarden.text[n].." ready")
				durationBar:SetTextureCoords(0,1,0,1)
				durationBar:SetColor(50,50,51,0.5)
				durationBar:SetDimensions(math.floor(HTTsavedVars[HTT_variables.currentlySelectedProfile].width * ( 1 - 0.2)),HTTsavedVars[HTT_variables.currentlySelectedProfile].height/2)
			elseif n==1 and HTT_Alerts.StoneGarden.weaponOnFireActive then
				durationBar:SetColor(1, 80/255, 5/255)
				textInBar:SetText(HTT_Alerts.StoneGarden.text[n].." active")
			else
				textInBar:SetText(HTT_Alerts.StoneGarden.text[n].." on cooldown")
			end

		end
		AlertBackground:SetDimensions(210, 22*countMembers+26)
	else
		HTTAlert:SetHidden(true)
	end
		




	------------------ Cooldowns --------------------------------









end