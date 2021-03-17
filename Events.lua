HTT_events = {}
function HTT_events.generateEvents()
	
	
	
	EVENT_MANAGER:RegisterForEvent("AlkoshCheckName", EVENT_EFFECT_CHANGED, function(_,_,_,_,_,_,_,_,_,_,_,_,_,targetName,targetUnitID)
		HTT_variables.targetNameUnitID[HTT_functions.removeGender(targetName)] = targetUnitID 
	end)
	EVENT_MANAGER:AddFilterForEvent("AlkoshCheckName", EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID,75753)

	EVENT_MANAGER:RegisterForEvent("AlkoshApplied", EVENT_COMBAT_EVENT, function(_,_,_,_,_,_,_,_,_,_,hitValue,_,_,_,_,targetUnitID) 
		local value = GetPlayerStat(STAT_POWER, STAT_BONUS_OPTION_APPLY_BONUS)
		if value > 3000 then
			value = 3000
		end
		HTT_variables.alkoshHits[targetUnitID] = value
	end)
	EVENT_MANAGER:AddFilterForEvent("AlkoshApplied", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,75752)

	EVENT_MANAGER:RegisterForEvent("MasterSnB", EVENT_COMBAT_EVENT, function(_, _, _, _, _, _, _, _, _, _, hitValue, _, _, _, _, _, _, overflow) 
		HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["expiresAt"][100] = GetGameTimeSeconds() + 5
		HTT_variables.masterSnB = hitValue+overflow
		HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["durations"][100] = 5
	end)
	EVENT_MANAGER:AddFilterForEvent("MasterSnB", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,99761)
	






	EVENT_MANAGER:RegisterForEvent("MajorMendingBackup", EVENT_EFFECT_CHANGED, function(_,_,_,_,_,_,expireTime) 
	if expireTime > HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["expiresAt"][19] then
		HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["expiresAt"][19] = expireTime
		HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["durations"][19] = expireTime-GetGameTimeSeconds()
	end
	end)
	EVENT_MANAGER:AddFilterForEvent("MajorMendingBackup", EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID,61711)
	EVENT_MANAGER:AddFilterForEvent("MajorMendingBackup", EVENT_EFFECT_CHANGED, REGISTER_FILTER_TARGET_COMBAT_UNIT_TYPE,1)





	--[[EVENT_MANAGER:RegisterForEvent("test", EVENT_COMBAT_EVENT, function(one,two,three,four,five,six,seven,eight,nine,ten,eleven,twelve,thirteen,fourteen,fifteen,sixteen,seventeen,eighteen) 
	d(one.."  "..two.."  "..four.."  "..five.."  "..six.."  "..seven.."  "..eight.."  "..nine.."  "..ten.."  "..eleven.."  "..twelve.."  "..thirteen.."  "..fifteen.."  "..sixteen.."  "..seventeen.."  "..eighteen)
	end)]]




	--[[EVENT_MANAGER:RegisterForEvent("Shield", EVENT_UNIT_ATTRIBUTE_VISUAL_UPDATED, function(one,two,type,three,four,five,six,shieldValue)
	if type == ATTRIBUTE_VISUAL_POWER_SHIELDING then
		HTT_variables.playerShield = shieldValue
	end
	d(type.."    "..shieldValue)
	end)]]


	
	--[[
	--EVENT_MANAGER:AddFilterForEvent("debug", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,133440)

	EVENT_MANAGER:RegisterForEvent("debugWhop", EVENT_COMBAT_EVENT, function()  

	HTT_variables.whopCooldown = GetGameTimeSeconds()
	end)
	EVENT_MANAGER:AddFilterForEvent("debugWhop", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,134308)

	EVENT_MANAGER:RegisterForEvent("debugScal", EVENT_COMBAT_EVENT, function()  

	HTT_variables.scaldingSolutionCooldown = GetGameTimeSeconds()
	end)
	EVENT_MANAGER:AddFilterForEvent("debugScal", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,134460)

	EVENT_MANAGER:RegisterForEvent("debug2", EVENT_EFFECT_CHANGED, function()  

	local alertText2 = HTTAlert:GetNamedChild("AlertText2")
	alertText2:SetText("Weapon Set On Fire")
	HTT_variables.scaldingStabCooldown = GetGameTimeSeconds() + 3
	zo_callLater(function () alertText2:SetText("Not on fire") end, 15000)
	end)
	EVENT_MANAGER:AddFilterForEvent("debug2", EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID,133423)]]	



	EVENT_MANAGER:RegisterForEvent("ShimmeringShieldIsHit", EVENT_COMBAT_EVENT, function(_,_,_,_,_,_,_,_,targetName,_,hitValue) -- event when shimmering shield gets hit
	if hitValue == 1 then
		HTT_variables.specialStacks[4] = 2
	elseif hitValue == 2 then
		HTT_variables.specialStacks[4] = 1
	elseif hitValue == 3 then
		HTT_variables.specialStacks[4] = 0
		HTT_variables.specialExpireTime[4] = GetGameTimeSeconds()
	end
	end)
	EVENT_MANAGER:AddFilterForEvent("ShimmeringShieldIsHit", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,88774)
	EVENT_MANAGER:AddFilterForEvent("ShimmeringShieldIsHit", EVENT_COMBAT_EVENT, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE ,1)

	EVENT_MANAGER:RegisterForEvent("ShimmeringCastOrExpired",EVENT_EFFECT_CHANGED, function(_,_,_,_,_,_,expireTime) -- event when shimmering shield is cast or expires
	if expireTime==0 then
		HTT_variables.specialExpireTime[4] = GetGameTimeSeconds()
		HTT_variables.specialStacks[4] = 0
	else 
		HTT_variables.specialExpireTime[4] = expireTime
		HTT_variables.specialStacks[4] = 3
	end
	end)
	EVENT_MANAGER:AddFilterForEvent("ShimmeringCastOrExpired", EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID,86143)
	EVENT_MANAGER:AddFilterForEvent("ShimmeringCastOrExpired", EVENT_EFFECT_CHANGED, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE ,1)


	EVENT_MANAGER:RegisterForEvent("Stonefist",EVENT_EFFECT_CHANGED, function(_,_,_,_,_,_,expireTime,stacks) -- stonefist stacks on the player
	if expireTime==0 then
		HTT_variables.specialExpireTime[1] = GetGameTimeSeconds()
		HTT_variables.specialStacks[1] = 0
	else 
		HTT_variables.specialExpireTime[1] = expireTime
		HTT_variables.specialStacks[1] = stacks
	end

	end)
	EVENT_MANAGER:AddFilterForEvent("Stonefist", EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID,31816)
	EVENT_MANAGER:AddFilterForEvent("Stonefist", EVENT_EFFECT_CHANGED, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE ,1)

	EVENT_MANAGER:RegisterForEvent("DefensiveStanceDebug", EVENT_COMBAT_EVENT, function(eventCode, result, _, name, _, _, _, _, _, _, hitValue, _, _, _, _, _, abilityName, overflow) 
	if result == 2250 then
		HTT_variables.isReflectActive = false
		HTT_variables.reflectExpiresAt = GetGameTimeSeconds()
	else
		HTT_variables.isReflectActive = true
		HTT_variables.reflectExpiresAt = GetGameTimeSeconds()+6
	end
	end)
	EVENT_MANAGER:AddFilterForEvent("DefensiveStanceDebug", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,126608)

	






	for k,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["IDs"]) do -- generate all regular debuff events
		if type(v) == "table" then
			if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][k] == "Weapon Skill" then
				for _,v1 in pairs(v) do
					HTT_functions.GenerateWeaponEvent(v1,k)
				end
			else
			for _,v1 in pairs(v) do
				HTT_functions.initializeEventsDebuffs(v1,k)
			end
			end
		else
			HTT_functions.initializeEventsDebuffs(v,k)
		end
	end

	for k,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["IDs"]) do -- generate all regular buff events
		if type(v) == "table" then
			if HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["names"][k] == "Dragon Blood" then
				for _,v1 in pairs(v) do
					HTT_functions.initializeEventsBuffsCombatEvent(v1,k,23)
				end
			else
				for _,v1 in pairs(v) do
					HTT_functions.initializeEventsBuffs(v1,k)
				end
			end
		else
			if HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["names"][k] == "Dragon Blood" then
				HTT_functions.initializeEventsBuffsCombatEvent(v,k,23)
			else
				HTT_functions.initializeEventsBuffs(v,k)
			end
		end
	end
			



	for k,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["IDs"]) do
		for _,v1 in pairs(v) do
			HTT_functions.GenerateCooldownEvent(v1,k)
		end
	end

	for k,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable["IDs"]) do
		for _,v1 in pairs(v) do
			HTT_functions.GenerateSynergyEvent(v1,k)
		end
	end


	HTT_events.nullifyRemainingTimes()

	
end



function HTT_events.nullifyRemainingTimes()
	for k,_ in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["expiresAt"]) do -- nullify all expiration times for debuffs
		if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][k] == "Weapon Skill" then
			HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["expiresAt"][k] = 0
		else
			HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["expiresAt"][k] = {}
		end
	end
	

	for k,_ in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["durations"]) do -- nullify all duration times for debuffs
		if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][k] == "Weapon Skill" then
			HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["durations"][k] = 0
		else
			HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["durations"][k] = {}
		end
	end

	for k,_ in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["durations"]) do -- nullify all duration times for buffs
		if HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["names"][k] == "Dragon Blood" then
			HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["durations"][k] = 23
		else
			HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["durations"][k] = 0
		end
	end

	for k,_ in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["expiresAt"]) do -- nullify all expiration times for buffs
		HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["expiresAt"][k] = 0
	end

	for k,_ in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["expiresAt"]) do -- nullify all expiration times for cooldowns
		HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["expiresAt"][k] = 0
	end

	for k,_ in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable["expiresAt"]) do -- nullify all expiration times for synergies
		HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable["expiresAt"][k] = 0
	end


end



function HTT_events.unregisterEvents()
	for k,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["IDs"]) do 
		if type(v) == "table" then
			for _,v1 in pairs(v) do
				EVENT_MANAGER:UnregisterForEvent("HTT"..v1, EVENT_EFFECT_CHANGED)
			end
		else
			EVENT_MANAGER:UnregisterForEvent("HTT"..v, EVENT_EFFECT_CHANGED)
		end
	end

	for k,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["IDs"]) do 
		if type(v) == "table" then
			for _,v1 in pairs(v) do
				EVENT_MANAGER:UnregisterForEvent("HTT"..v1, EVENT_EFFECT_CHANGED)
			end
		else
			EVENT_MANAGER:UnregisterForEvent("HTT"..v, EVENT_EFFECT_CHANGED)
		end
	end
			
	for k,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["IDs"]) do
		for _,v1 in pairs(v) do
			EVENT_MANAGER:UnregisterForEvent("HTT"..v1, EVENT_COMBAT_EVENT)
		end
	end

	for k,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable["IDs"]) do
		for _,v1 in pairs(v) do
			EVENT_MANAGER:UnregisterForEvent("HTT"..v1, EVENT_COMBAT_EVENT)
		end
	end
end