HTT_functions = {}



function HTT_functions.HTT_processTimer(time)
	if time%1 == 0 then
		return time..".0"
	end
	return time
end

function HTT_functions.GetLesserValue(value1,value2)
	if value1>value2 then
		return value2
	end
	return value1
end


function HTT_functions.hideEverythingOnSwitch()
	for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs) do
		local textInBar = HTT:GetNamedChild("TextInBarReticle"..v)
		local durationTimer = HTT:GetNamedChild("DurationTimerReticle"..v)
		local durationBar = HTT:GetNamedChild("DurationBarReticle"..v)
		local icon = HTT:GetNamedChild("IconReticle"..v)
		durationTimer:SetHidden(true)
		durationBar:SetHidden(true)
		icon:SetHidden(true)
		textInBar:SetHidden(true)
	end
	for i=1, MAX_BOSSES do
		for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs) do
			local textInBar = _G["HTTBoss"..i]:GetNamedChild("TextInBarBoss"..v..i)
			local durationTimer = _G["HTTBoss"..i]:GetNamedChild("DurationTimerBoss"..v..i)
			local durationBar = _G["HTTBoss"..i]:GetNamedChild("DurationBarBoss"..v..i)
			local icon = _G["HTTBoss"..i]:GetNamedChild("IconBoss"..v..i)
			durationTimer:SetHidden(true)
			durationBar:SetHidden(true)
			icon:SetHidden(true)
			textInBar:SetHidden(true)
		end
	end
	for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns) do
		local textInBar = HTTCooldowns:GetNamedChild("CooldownTextInBar"..v)
		local durationTimer = HTTCooldowns:GetNamedChild("CooldownDurationTimer"..v)
		local durationBar = HTTCooldowns:GetNamedChild("CooldownsDurationBar"..v)
		local icon = HTTCooldowns:GetNamedChild("CooldownIcon"..v)
		durationTimer:SetHidden(true)
		durationBar:SetHidden(true)
		icon:SetHidden(true)
		textInBar:SetHidden(true)
	end
	for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs) do
		local textInBar = HTTSelfBuffs:GetNamedChild("SelfBuffTextInBar"..v)
		local durationTimer = HTTSelfBuffs:GetNamedChild("SelfBuffDurationTimer"..v)
		local durationBar = HTTSelfBuffs:GetNamedChild("SelfBuffDurationBar"..v)
		local icon = HTTSelfBuffs:GetNamedChild("SelfBuffIcon"..v)
		durationTimer:SetHidden(true)
		durationBar:SetHidden(true)
		icon:SetHidden(true)
		textInBar:SetHidden(true)
	end

end


function HTT_functions.createDebuffControl(v)
	local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIWidth
	local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIHeight
	local scale = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIScale
	local background = HTT:GetNamedChild("BackgroundReticle")
	local WM = GetWindowManager()
	
			
	

	local icon = WM:CreateControl("$(parent)IconReticle"..v, HTT, CT_TEXTURE,4)
	icon:SetDimensions(height,height)
	icon:SetAnchor(TOPLEFT, background, TOPLEFT, (width*(3/100))*scale,0)
	icon:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["icons"][v])
	icon:SetHidden(false)
	icon:SetDrawLayer(2)

	local bar = WM:CreateControl("$(parent)DurationBarReticle"..v, HTT, CT_STATUSBAR)	
	bar:SetScale(1.0)
	bar:SetAnchor(LEFT, icon, RIGHT, 0, 0)
	bar:SetDimensions(width*0.75,height)
	bar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors"][v]))
	bar:SetHidden(false)		
	bar:SetDrawLayer(1)
	bar:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].currentlySelectedBarTexture)

	local timer = WM:CreateControl("$(parent)DurationTimerReticle"..v, HTT, CT_LABEL)			
	timer:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffFont)
	timer:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffFont][1])
	timer:SetWrapMode(TEX_MODE_CLAMP)
	timer:SetDrawLayer(2)
	timer:SetColor(255,255,255, 1)
	timer:SetText("0.0s")				
	timer:SetAnchor(LEFT, durationBar, RIGHT, 0.01*width*scale, (-0.42)*height*scale)
	timer:SetDimensions((HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffFont][1]/20)*width/4, 1)
	--timer:SetHorizontalAlignment(LEFT)
	timer:SetHidden(false)

	local textInBar = WM:CreateControl("$(parent)TextInBarReticle"..v, HTT, CT_LABEL)
	textInBar:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffFont)
	textInBar:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffFont][1])
	textInBar:SetWrapMode(TEX_MODE_CLAMP)
	textInBar:SetDrawLayer(2)
	textInBar:SetColor(255,255,255, 1)
	textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][v])				
	textInBar:SetAnchor(LEFT, durationBar, LEFT, 0.03*width*scale, (-0.42)*height*scale)	
	textInBar:SetDimensions(width*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffFont][1]/20), 1)
	textInBar:SetHidden(false)
end

function HTT_functions.createBuffControl(v)
	local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffUIWidth
	local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffUIHeight
	local background = HTTSelfBuffs:GetNamedChild("BackgroundReticle")
	local WM = GetWindowManager()
	local timer = WM:CreateControl("$(parent)SelfBuffDurationTimer"..v, HTTSelfBuffs, CT_LABEL)			
	timer:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffFont)
	timer:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].buffFont][1])
	timer:SetWrapMode(TEX_MODE_CLAMP)
	timer:SetDrawLayer(2)
	timer:SetColor(255,255,255, 1)
	timer:SetText("0.0s")				
	timer:SetAnchor(TOPLEFT, background, TOPLEFT, 5, 0)
	timer:SetDimensions((HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].buffFont][1]/20)*width/4, 1)
	--timer:SetHorizontalAlignment(LEFT)
	timer:SetHidden(false)
			
			

	local bar = WM:CreateControl("$(parent)SelfBuffDurationBar"..v, HTTSelfBuffs, CT_STATUSBAR)	
	bar:SetAnchor(TOPLEFT, background, TOPLEFT, 5+HTTsavedVars[HTT_variables.currentlySelectedProfile].height/2,0)
	bar:SetDimensions(width *0.75, height)
	bar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["colors"][v]))
	bar:SetHidden(false)
	bar:SetDrawLayer(1)
	bar:SetTexture("HyperTankingTools/icons/gradientProgressBar.dds")

	local textInBar = WM:CreateControl("$(parent)SelfBuffTextInBar"..v, HTTSelfBuffs, CT_LABEL)
	textInBar:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffFont)
	textInBar:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].buffFont][1])
	textInBar:SetWrapMode(TEX_MODE_CLAMP)
	textInBar:SetDrawLayer(2)
	textInBar:SetColor(255,255,255, 1)
	textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["names"][v])				
	textInBar:SetAnchor(TOPLEFT, background, TOPLEFT, height,-10)
	textInBar:SetDimensions(width*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].buffFont][1]/20), 1)
	textInBar:SetHidden(false)

	local icon = WM:CreateControl("$(parent)SelfBuffIcon"..v, HTTSelfBuffs, CT_TEXTURE,4)
	icon:SetDimensions(height,height)
	icon:SetAnchor(TOPLEFT,background,TOPLEFT,5,0)
	icon:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["icons"][v])
	icon:SetHidden(false)
	icon:SetDrawLayer(2)
end

function HTT_functions.createCooldownControl(v)
	local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownUIWidth
	local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownUIHeight
	local background = HTTCooldowns:GetNamedChild("CooldownsBackground")
	local WM = GetWindowManager()
	local timer = WM:CreateControl("$(parent)CooldownDurationTimer"..v, HTTCooldowns, CT_LABEL)			
	timer:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownFont)
	timer:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownFont][1])
	timer:SetWrapMode(TEX_MODE_CLAMP)
	timer:SetDrawLayer(2)
	timer:SetColor(255,255,255, 1)
	timer:SetText("0.0s")				
	timer:SetAnchor(TOPLEFT, background, TOPLEFT, 5, 0)
	timer:SetDimensions((HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownFont][1]/20)*width/4, 1)
	--timer:SetHorizontalAlignment(LEFT)
	timer:SetHidden(false)
			
			

	local bar = WM:CreateControl("$(parent)CooldownsDurationBar"..v, HTTCooldowns, CT_STATUSBAR)	
	bar:SetScale(1.0)
	bar:SetAnchor(TOPLEFT, background, TOPLEFT, 5+HTTsavedVars[HTT_variables.currentlySelectedProfile].height/2,0)
	bar:SetDimensions(width*0.75,height)
	bar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["colors"][v]))
	bar:SetHidden(false)		
	bar:SetDrawLayer(1)
	bar:SetTexture("HyperTankingTools/icons/gradientProgressBar.dds")

	local textInBar = WM:CreateControl("$(parent)CooldownTextInBar"..v, HTTCooldowns, CT_LABEL)
	textInBar:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownFont)
	textInBar:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownFont][1])
	textInBar:SetWrapMode(TEX_MODE_CLAMP)
	textInBar:SetDrawLayer(2)
	textInBar:SetColor(255,255,255, 1)
	textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["names"][v])				
	textInBar:SetAnchor(TOPLEFT, background, TOPLEFT, 30,0)
	textInBar:SetDimensions(width*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownFont][1]/20), 1)
	textInBar:SetHidden(false)

	local icon = WM:CreateControl("$(parent)CooldownIcon"..v, HTTCooldowns, CT_TEXTURE,4)
	icon:SetDimensions(height,height)
	icon:SetAnchor(TOPLEFT,background,TOPLEFT,5,0)
	icon:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["icons"][v])
	icon:SetHidden(false)
	icon:SetDrawLayer(2)
end

function HTT_functions.recreateControls()
	for k,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"]) do
		if HTT:GetNamedChild("DurationTimerReticle"..k) == nil then
			HTT_functions.createDebuffControl(k)
            HTT_functions.createBossDebuffControl(k)
		end
	end
	for k,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["names"]) do
		if HTTSelfBuffs:GetNamedChild("SelfBuffDurationTimer"..k) == nil then
			HTT_functions.createBuffControl(k)
		end
	end
	for k,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["names"]) do
		if HTTCooldowns:GetNamedChild("CooldownDurationTimer"..k) == nil then
			HTT_functions.createCooldownControl(k)
		end
	end
end

function HTT_functions.createBossDebuffControl(v)
	local WM = GetWindowManager()
	local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffBossUIWidth
	local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffBossUIHeight
     for i=1, MAX_BOSSES do

		local background = _G["HTTBoss"..i]:GetNamedChild("BackgroundBoss"..i)  




	
		local WM = GetWindowManager()
		local timer = WM:CreateControl("$(parent)DurationTimerBoss"..v..i, _G["HTTBoss"..i], CT_LABEL)			
		timer:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].bossFont)
		timer:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].bossFont][1])
		timer:SetWrapMode(TEX_MODE_CLAMP)
		timer:SetDrawLayer(2)
		timer:SetColor(255,255,255, 1)
		timer:SetText("0.0s")				
		timer:SetAnchor(TOPLEFT, background, TOPLEFT, 5, 0)
		timer:SetDimensions((HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].bossFont][1]/20)*width/4, 1)
		--timer:SetHorizontalAlignment(LEFT)
		timer:SetHidden(false)
			
			

		local bar = WM:CreateControl("$(parent)DurationBarBoss"..v..i, _G["HTTBoss"..i], CT_STATUSBAR)	
		bar:SetScale(1.0)
		bar:SetAnchor(TOPLEFT, background, TOPLEFT, 5+HTTsavedVars[HTT_variables.currentlySelectedProfile].height/2,0)
		bar:SetDimensions(width*0.75,height)
		bar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors"][v]))
		bar:SetHidden(false)		
		bar:SetDrawLayer(1)
		bar:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].currentlySelectedBarTexture)

		local textInBar = WM:CreateControl("$(parent)TextInBarBoss"..v..i, _G["HTTBoss"..i], CT_LABEL)
		textInBar:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].bossFont)
		textInBar:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].bossFont][1])
		textInBar:SetWrapMode(TEX_MODE_CLAMP)
		textInBar:SetDrawLayer(2)
		textInBar:SetColor(255,255,255, 1)
		textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][v])				
		textInBar:SetAnchor(TOPLEFT, background, TOPLEFT, 30,0)
		textInBar:SetDimensions(width*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].bossFont][1]/20), 1)
		textInBar:SetHidden(false)

		local icon = WM:CreateControl("$(parent)IconBoss"..v..i, _G["HTTBoss"..i], CT_TEXTURE,4)
		icon:SetDimensions(height,height)
		icon:SetAnchor(TOPLEFT,background,TOPLEFT,5,0)
		icon:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["icons"][v])
		icon:SetHidden(false)
		icon:SetDrawLayer(2)


	end
end

function HTT_functions.reanchorReticle()
	local scale = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIScale
	local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIWidth
	local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIHeight
	local countMembers = 0
	local reticleBackground = HTT:GetNamedChild("BackgroundReticle")
	for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs) do
		
		local textInBar = HTT:GetNamedChild("TextInBarReticle"..v)
		local durationTimer = HTT:GetNamedChild("DurationTimerReticle"..v)
		local durationBar = HTT:GetNamedChild("DurationBarReticle"..v)
		local icon = HTT:GetNamedChild("IconReticle"..v)
		
		icon:ClearAnchors()
		icon:SetAnchor(TOPLEFT, reticleBackground, TOPLEFT, (width*(3/100))*scale, (((height*1.1)*countMembers)+(height*0.9))*scale)
		durationBar:ClearAnchors()
		durationBar:SetAnchor(LEFT, icon, RIGHT, 0, 0)
		durationTimer:ClearAnchors()
		durationTimer:SetAnchor(LEFT, icon, RIGHT, 0.76*width*scale, (-0.42)*height*scale)
		textInBar:ClearAnchors()
		textInBar:SetAnchor(LEFT, durationBar, LEFT, 0.03*width*scale, (-0.42)*height*scale)	
		if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["isTurnedOn"][v] then
			countMembers = countMembers+1
		end
	end
	reticleBackground:SetDimensions(width, ((height*1.13)*countMembers)+height)
end

function HTT_functions.reanchorBuffs()
	local scale = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffUIScale
	local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffUIWidth
	local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffUIHeight
	local countMembers = 0
	local SelfBuffsBackground = HTTSelfBuffs:GetNamedChild("SelfBuffsBackground")
	for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs) do
		
		local textInBar = HTTSelfBuffs:GetNamedChild("SelfBuffTextInBar"..v)
		local durationTimer = HTTSelfBuffs:GetNamedChild("SelfBuffDurationTimer"..v)
		local durationBar = HTTSelfBuffs:GetNamedChild("SelfBuffDurationBar"..v)
		local icon = HTTSelfBuffs:GetNamedChild("SelfBuffIcon"..v)
		

		icon:ClearAnchors()
		icon:SetAnchor(TOPLEFT, SelfBuffsBackground, TOPLEFT, (width*(3/100))*scale, (((height*1.1)*countMembers)+(height*0.9))*scale)
		durationBar:ClearAnchors()
		durationBar:SetAnchor(LEFT, icon, RIGHT, 0, 0)
		durationTimer:ClearAnchors()
		durationTimer:SetAnchor(LEFT, icon, RIGHT, 0.76*width*scale, (-0.42)*height*scale)
		textInBar:ClearAnchors()
		textInBar:SetAnchor(LEFT, durationBar, LEFT, 0.03*width*scale, (-0.42)*height*scale)	
		if HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["isTurnedOn"][v] then
			countMembers = countMembers+1
		end
	end
	SelfBuffsBackground:SetDimensions(width, ((height*1.13)*countMembers)+height)
end

function HTT_functions.reanchorBoss()
	local scale = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffBossUIScale
	local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffBossUIWidth
	local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffBossUIHeight
	for i=1, MAX_BOSSES do
		local bossBackground = _G["HTTBoss"..i]:GetNamedChild("BackgroundBoss"..i)
		local countMembers = 0
		for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs) do
			
			local textInBar = _G["HTTBoss"..i]:GetNamedChild("TextInBarBoss"..v..i)
			local durationTimer = _G["HTTBoss"..i]:GetNamedChild("DurationTimerBoss"..v..i)
			local durationBar = _G["HTTBoss"..i]:GetNamedChild("DurationBarBoss"..v..i)
			local icon = _G["HTTBoss"..i]:GetNamedChild("IconBoss"..v..i)
		
			icon:ClearAnchors()
			icon:SetAnchor(TOPLEFT, SelfBuffsBackground, TOPLEFT, (width*(3/100))*scale, (((height*1.1)*countMembers)+(height*0.9))*scale)
			durationBar:ClearAnchors()
			durationBar:SetAnchor(LEFT, icon, RIGHT, 0, 0)
			durationTimer:ClearAnchors()
			durationTimer:SetAnchor(LEFT, icon, RIGHT, 0.76*width*scale, (-0.42)*height*scale)
			textInBar:ClearAnchors()
			textInBar:SetAnchor(LEFT, durationBar, LEFT, 0.03*width*scale, (-0.42)*height*scale)	
			if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["isTurnedOnBoss"][v] then
				countMembers = countMembers+1
			end
		end
		bossBackground:SetDimensions(width, ((height*1.13)*countMembers)+height)
	end
end

function HTT_functions.reanchorCooldowns()
	local scale = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownUIScale
	local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownUIWidth
	local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownUIHeight
	local countMembers = 0
	local CooldownsBackground = HTTCooldowns:GetNamedChild("CooldownsBackground")
	for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns) do
		
		local textInBar = HTTCooldowns:GetNamedChild("CooldownTextInBar"..v)
		local durationTimer = HTTCooldowns:GetNamedChild("CooldownDurationTimer"..v)
		local durationBar = HTTCooldowns:GetNamedChild("CooldownsDurationBar"..v)
		local icon = HTTCooldowns:GetNamedChild("CooldownIcon"..v)
		
		icon:ClearAnchors()
		icon:SetAnchor(TOPLEFT, reticleBackground, TOPLEFT, (width*(3/100))*scale, (((height*1.1)*countMembers)+(height*0.9))*scale)
		durationBar:ClearAnchors()
		durationBar:SetAnchor(LEFT, icon, RIGHT, 0, 0)
		durationTimer:ClearAnchors()
		durationTimer:SetAnchor(LEFT, icon, RIGHT, 0.76*width*scale, (-0.42)*height*scale)
		textInBar:ClearAnchors()
		textInBar:SetAnchor(LEFT, durationBar, LEFT, 0.03*width*scale, (-0.42)*height*scale)	
		if HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["isTurnedOn"][v] then
			countMembers = countMembers+1
		end
	end
	
	CooldownsBackground:SetDimensions(width, ((height*1.13)*countMembers)+height)


end

function HTT_functions.reanchorSynergies()
	local scale = HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesUIScale
	local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesUIWidth
	local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesUIHeight
	local countMembers = 0
	local SynergiesBackground = HTTSynergies:GetNamedChild("SynergiesBackground")
	for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfSynergies) do
		local textInBar = HTTSynergies:GetNamedChild("SynergiesTextInBar"..v)
		local durationTimer = HTTSynergies:GetNamedChild("SynergiesDurationTimer"..v)
		local durationBar = HTTSynergies:GetNamedChild("SynergiesDurationBar"..v)
		local icon = HTTSynergies:GetNamedChild("SynergiesIcon"..v)
		
		icon:ClearAnchors()
		icon:SetAnchor(TOPLEFT, reticleBackground, TOPLEFT, (width*(3/100))*scale, (((height*1.1)*countMembers)+(height*0.9))*scale)
		durationBar:ClearAnchors()
		durationBar:SetAnchor(LEFT, icon, RIGHT, 0, 0)
		durationTimer:ClearAnchors()
		durationTimer:SetAnchor(LEFT, icon, RIGHT, 0.76*width*scale, (-0.42)*height*scale)
		textInBar:ClearAnchors()
		textInBar:SetAnchor(LEFT, durationBar, LEFT, 0.03*width*scale, (-0.42)*height*scale)	
		if HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable["isTurnedOn"][v] then
			countMembers = countMembers+1
		end
	end
	SynergiesBackground:SetDimensions(width, ((height*1.13)*countMembers)+height)


end

function HTT_functions.checkIfSkillSlotted(skillIDTable)
		--if next(skillIDTable) == nil then
		--	return true,0
		--end
		for _,skillID in pairs(skillIDTable) do
			for i = 3, 8 do
				local slot1 = GetSlotBoundId(i, HOTBAR_CATEGORY_PRIMARY)
				local slot2 = GetSlotBoundId(i, HOTBAR_CATEGORY_BACKUP)
				if skillID == slot1 or skillID == slot2 then
					return true,skillID
				end
			end
		end
		return false,0
end



function HTT_functions.GetTrueEngulfingValue()
	local fullText = GetAbilityDescription(20930)
	fullText = string.gsub(fullText,"%D","")
	fullText = string.sub(fullText,-2)
	if string.sub(fullText,1,1) == "0" then
		return string.sub(fullText,-1)
	end
	return fullText
end






function HTT_functions.ProcessAnchors()
	HTT:ClearAnchors()
	HTT:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffset,HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffset)	
	HTTOwnStacks:ClearAnchors()
	HTTOwnStacks:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetOwnStacks,HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetOwnStacks)	
	HTTBlock:ClearAnchors()
	HTTBlock:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetBlock,HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetBlock)
	HTTSelfBuffs:ClearAnchors()
	HTTSelfBuffs:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetSelfBuffs,HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetSelfBuffs)
	HTTBoss1:ClearAnchors()
	HTTBoss1:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetBoss1,HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetBoss1)
	HTTBoss2:ClearAnchors()
	HTTBoss2:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetBoss2,HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetBoss2)
	HTTBoss3:ClearAnchors()
	HTTBoss3:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetBoss3,HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetBoss3)
	HTTBoss4:ClearAnchors()
	HTTBoss4:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetBoss4,HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetBoss4)
	HTTBoss5:ClearAnchors()
	HTTBoss5:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetBoss5,HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetBoss5)
	HTTBoss6:ClearAnchors()
	HTTBoss6:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetBoss6,HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetBoss6)
	HTTCooldowns:ClearAnchors()
	HTTCooldowns:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetCooldowns,HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetCooldowns)
	HTTAlert:ClearAnchors()
	HTTAlert:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetAlert,HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetAlert)
	HTTHealth:ClearAnchors()
	HTTHealth:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetHealth,HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetHealth)
	HTTStamina:ClearAnchors()
	HTTStamina:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetStamina,HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetStamina)
	HTTMagicka:ClearAnchors()
	HTTMagicka:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetMagicka,HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetMagicka)
	HTTSynergies:ClearAnchors()
	HTTSynergies:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetSynergies,HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetSynergies)
	HTTReflect:ClearAnchors()
	HTTReflect:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,0,0)
	
end

function HTT_functions.pickAnyElement(array)
	for _,v in pairs(array) do
		return v
	end
end

function HTT_functions.pickAnyKey(array)
	for k,_ in pairs(array) do
		return k
	end
end

function HTT_functions.checkIfTableIsEmpty(table)
	for _,_ in pairs(table) do
		return false
	end
	return true
end

function HTT_functions.removeEmptySpacesInTable(array)
	local holder = {}
	for _,v in pairs(array) do
		table.insert(holder,v)
	end
	return holder
end


function HTT_functions.deleteProfile(nameOfDeletedProfile)
	local key = HTT_functions.findPositionOfElementInTable(HTTsavedVars["availableProfiles"],nameOfDeletedProfile)
	HTTsavedVars["availableProfiles"][key] = nil
	HTTsavedVars[nameOfDeletedProfile] = nil
end

function HTT_functions.createProfile(nameOfNewProfile)
	table.insert(HTTsavedVars["availableProfiles"],nameOfNewProfile)
	HTTsavedVars[nameOfNewProfile] = HTT_functions.deepcopy(HTTsavedVars[HTT_variables.currentlySelectedProfile]) 
end



function HTT_functions.deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[HTT_functions.deepcopy(orig_key)] = HTT_functions.deepcopy(orig_value)
        end
        setmetatable(copy, HTT_functions.deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function HTT_functions.GetTableSize(argTable)
	local counter = 0
	for _,_ in pairs(argTable) do
		counter = counter + 1
	end
	return counter
end

function HTT_functions.findFreeSlotInTable(searchedTable)
	for i=1, HTT_functions.GetTableSize(searchedTable)+999 do
		if (searchedTable[i] or 0) == 0  then
			
			return i
		end
	end
end

function HTT_functions.mergeTables(table1,table2) --unused atm
	local holder = {}
	for _,v in pairs(table1) do
		holder.insert(v)
	end
	for _,v in pairs(table2) do
		holder.insert(v)
	end
	return holder
end



--[[ function HTT_functions.unpackColor(tableOfColors)
	return tableOfColors[1],tableOfColors[2],tableOfColors[3],tableOfColors[4]      redundant
end
]] 

function HTT_functions.UpdateBaseGameUI(booleanValue)
	ZO_PlayerAttributeMagicka:SetHidden(not booleanValue)
	ZO_PlayerAttributeStamina:SetHidden(not booleanValue)
	ZO_PlayerAttributeHealth:SetHidden(not booleanValue)
	ZO_PlayerAttributeMountStamina:SetHidden(not booleanValue)
end





function HTT_functions.ToggleUI(_, newState)
	if newState == HTT_variables.scene_SHOWN and IsUnitInCombat("player") then
	HTT:SetHidden(false)
	HTTOwnStacks:SetHidden(false)
	HTTBlock:SetHidden(false)
	HTTSelfBuffs:SetHidden(false)
	HTTBoss1:SetHidden(false)
	HTTBoss2:SetHidden(false)
	HTTBoss3:SetHidden(false)
	HTTBoss4:SetHidden(false)
	HTTBoss5:SetHidden(false)
	HTTBoss6:SetHidden(false)
	HTTAlert:SetHidden(false)
	HTTCooldowns:SetHidden(false)
	HTTResources:SetHidden(false)
	HTTSynergies:SetHidden(false)
	HTTReflect:SetHidden(false)
	elseif newState == HTT_variables.scene_HIDDEN then
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
	HTTAlert:SetHidden(true)
	HTTCooldowns:SetHidden(true)
	HTTResources:SetHidden(true)
	HTTSynergies:SetHidden(true)
	HTTReflect:SetHidden(true)
	end
end

function HTT_functions.showUI()
	if HTT_variables.isUIPreviewOn then
		EVENT_MANAGER:UnregisterForUpdate("UIPreview", 200)
		HTT_variables.isUIPreviewOn = false
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
	else
		EVENT_MANAGER:RegisterForUpdate("UIPreview", 200,HTT_previewUI.UpdateUIInSettings)
		HTT_variables.isUIPreviewOn = true
	end
	
	

end


function HTT_functions.CheckIfNumberOfPiecesIsWorn(requiredNumberOfPieces,setLink)
	local numOfItems = 0
	_,_,_,numOfItems = GetItemLinkSetInfo(setLink,true)
	if numOfItems>=requiredNumberOfPieces then
		return true
	end
	return false

end




function HTT_functions.adjustCooldowns()
	for k,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["names"]) do
		if not HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["itemSet"][k][1]) or not HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["skill"][k]) then
			if (HTT_functions.TurnOnForWornSets(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["itemSet"][k]) or HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["itemSet"][k][1])) and (HTT_functions.TurnOnForEquipppedSkills(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["skill"][k]) or HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["skill"][k])) then
				HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["isTurnedOn"][k] = true
			else
				HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["isTurnedOn"][k] = false
			end
		end
	end
end

function HTT_functions.adjustDebuffs()
	for k,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"]) do
		if not HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["itemSet"][k][1]) or not HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["skill"][k]) then
			if (HTT_functions.TurnOnForWornSets(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["itemSet"][k]) or HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["itemSet"][k][1])) and (HTT_functions.TurnOnForEquipppedSkills(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["skill"][k]) or HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["itemSet"][k])) then
				HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["isTurnedOn"][k] = true
			else
				HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["isTurnedOn"][k] = false
			end
		end
	end
end

function HTT_functions.adjustBuffs()
	for k,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["names"]) do
		if not HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["itemSet"][k][1]) or not HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["skill"][k]) then
			if (HTT_functions.TurnOnForWornSets(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["itemSet"][k]) or HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["itemSet"][k][1])) and (HTT_functions.TurnOnForEquipppedSkills(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["skill"][k]) or HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["skill"][k])) then
				HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["isTurnedOn"][k] = true
			else
				HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["isTurnedOn"][k] = false
			end
		end
	end
end

function HTT_functions.adjustBoss()
	for k,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"]) do
		if not HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["itemSet"][k][1]) or not HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["skill"][k]) then
			if (HTT_functions.TurnOnForWornSets(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["itemSet"][k]) or HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["itemSet"][k][1])) and (HTT_functions.TurnOnForEquipppedSkills(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["skill"][k]) or HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["skill"][k])) then
				HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["isTurnedOnBoss"][k] = true
			else
				HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["isTurnedOnBoss"][k] = false
			end
		end
	end
end

function HTT_functions.TurnOnForWornSets(itemSetTable)
	local noCheckHaveHappened = true
	if type(itemSetTable) == "table" then
		if type(itemSetTable[1]) == "table" and type(itemSetTable[2]) == "number" then
			for k1,v1 in pairs(itemSetTable[1]) do
				noCheckHaveHappened = false
				if HTT_functions.CheckIfNumberOfPiecesIsWorn(itemSetTable[2],v1) then
					return true
				end
			end
		end
	end
	return noCheckHaveHappened
end

function HTT_functions.TurnOnForEquipppedSkills(skillTable)
	if skillTable then
		if type(skillTable) == "table" then
			if skillTable == {} then
				return true
			end
			if HTT_functions.checkIfSkillSlotted(skillTable) then
				return true
			end
		end
		return false
	else
		return true
	end
end




function HTT_functions.crushersLeft(remainingTimeWall,remainingTimeCrusher)
	result = 0
	if remainingTimeWall > remainingTimeCrusher then
		result = result + 1
		remainingTimeWall = remainingTimeWall - remainingTimeCrusher
	end
	return result + math.floor(remainingTimeWall/5)
		
end


function HTT_functions.adjustDefaultsToClass(defaultTable,classID)
	for _,v in pairs(HTT_variables.classSettings[classID]["buffs"]) do
		defaultTable.buffTable["isTurnedOn"][v] = true
	end
	for _,v in pairs(HTT_variables.classSettings[classID]["debuffs"]) do
		defaultTable.debuffTable["isTurnedOn"][v] = true
		defaultTable.debuffTable["isTurnedOnBoss"][v] = true
	end
	for _,v in pairs(HTT_variables.classSettings[classID]["cooldowns"]) do
		defaultTable.cooldownTable["isTurnedOn"][v] = true
	end

end



function HTT_functions.removeGender(name)
	b = string.find(name,"%^")
	if b then
		name = string.sub(name,1,b-1)
	end
	return name
end

function HTT_functions.AddIDtoBuff(abilityID,tableSlot)
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["IDs"][tableSlot] = {[#HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["IDs"][tableSlot]+1] = abilityID}
end






function HTT_functions.addBuff(nameOfTracker,abilityID,tableSlot,text,textWhenMissing,color,color2,color3,skill,itemSet,itemSetNumber,icon)
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["names"][tableSlot] = nameOfTracker
	if type(abilityID) == "table" then
		HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["IDs"][tableSlot] = abilityID
	else
		HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["IDs"][tableSlot] = {[1] = abilityID}
	end
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["icons"][tableSlot] = icon or GetAbilityIcon(abilityID)
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["texts"][tableSlot] = text
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["durations"][tableSlot] = 0
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["colors"][tableSlot] = {}
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["colors"][tableSlot][1] = color[1]
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["colors"][tableSlot][2] = color[2]
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["colors"][tableSlot][3] = color[3]
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["colors"][tableSlot][4] = color[4]
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["colors2"][tableSlot] = {unpack(color2 or {})}
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["colors3"][tableSlot] = {unpack(color3 or {})}
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["isTurnedOn"][tableSlot] = true
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["textWhenMissing"][tableSlot] = textWhenMissing
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["expiresAt"][tableSlot] = 0
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["isPreMade"][tableSlot] = false
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["skill"][tableSlot] = skill or {}
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["itemSet"][tableSlot] = {[1] = itemSet,[2] = itemSetNumber} or {}
	table.insert(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs,tableSlot)


end

function HTT_functions.AddIDtoDebuff(abilityID,tableSlot)
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["IDs"][tableSlot] = {[#HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["IDs"][tableSlot]+1] = abilityID}
end

function HTT_functions.addDebuff(nameOfTracker,abilityID,tableSlot,text,textWhenMissing,color,color2,color3,onlyCastByPlayer,skill,itemSet,itemSetNumber,icon)

	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][tableSlot] = nameOfTracker
	if type(abilityID) == "table" then
		HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["IDs"][tableSlot] = abilityID
	else
		HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["IDs"][tableSlot] = {[1] = abilityID}
	end
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["icons"][tableSlot] = icon or GetAbilityIcon(abilityID)
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["texts"][tableSlot] = text
	if nameOfTracker =="Weapon Skill" then
		HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["durations"][tableSlot] = 0
	else
		HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["durations"][tableSlot] = {}
	end
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors"][tableSlot] = {}
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors"][tableSlot][1] = color[1]
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors"][tableSlot][2] = color[2]
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors"][tableSlot][3] = color[3]
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors"][tableSlot][4] = color[4]
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors2"][tableSlot] = {unpack(color2 or {})}
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors3"][tableSlot] = {unpack(color3 or {})}
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["isTurnedOn"][tableSlot] = true
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["isTurnedOnBoss"][tableSlot] = true
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["textWhenMissing"][tableSlot] = textWhenMissing
	if nameOfTracker =="Weapon Skill" then
		HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["expiresAt"][tableSlot] = 0
	else
		HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["expiresAt"][tableSlot] = {}
	end
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["skill"][tableSlot] = skill or {}
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["itemSet"][tableSlot] = {[1] = itemSet,[2] = itemSetNumber} or {}
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["onlyCastByPlayer"][tableSlot] = onlyCastByPlayer
	table.insert(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs,tableSlot)


end

function HTT_functions.addCooldown(nameOfTracker,abilityID,tableSlot,text,textWhenMissing,color,color2,color3,duration,skill,itemSet,itemSetNumber,icon)
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["names"][tableSlot] = nameOfTracker
	if type(abilityID) == "table" then
		HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["IDs"][tableSlot] = abilityID
	else
		HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["IDs"][tableSlot] = {[1] = abilityID}
	end
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["icons"][tableSlot] = icon or GetAbilityIcon(abilityID)
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["texts"][tableSlot] = text
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["durations"][tableSlot] = duration
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["colors"][tableSlot] = {}
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["colors"][tableSlot][1] = color[1]
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["colors"][tableSlot][2] = color[2]
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["colors"][tableSlot][3] = color[3]
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["colors"][tableSlot][4] = color[4]
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["isTurnedOn"][tableSlot] = true
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["textWhenMissing"][tableSlot] = textWhenMissing
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["expiresAt"][tableSlot] = 0
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["isPreMade"][tableSlot] = false
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["skill"][tableSlot] = skill or {}
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["itemSet"][tableSlot] = {[1] = itemSet,[2] = itemSetNumber} or {}
	table.insert(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns,tableSlot)


end

--1 debuff
--2 buff
--3 cooldown

function HTT_functions.addTracker(type,nameOfTracker,abilityID,tableSlot,text,textWhenMissing,color,color2,color3,onlyCastByPlayer,skill,itemSet,itemSetNumber,duration,icon)
	if type == 1 then
		HTT_functions.addDebuff(nameOfTracker,abilityID,tableSlot,text,textWhenMissing,color,color2,color3,onlyCastByPlayer,skill,itemSet,itemSetNumber,icon)
	elseif type == 2 then
		HTT_functions.addBuff(nameOfTracker,abilityID,tableSlot,text,textWhenMissing,color,color2,color3,skill,itemSet,itemSetNumber,icon)
	elseif type == 3 then
		HTT_functions.addCooldown(nameOfTracker,abilityID,tableSlot,text,textWhenMissing,color,color2,color3,duration,skill,itemSet,itemSetNumber,icon)
	end
end

function HTT_functions.findPositionOfElementInTable(table,elementToFind)
	for k,v in pairs(table) do
		if v==elementToFind then
			return k
		end
	end
	return nil
end

function HTT_functions.removeDebuff(tableSlot)
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["names"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["IDs"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["icons"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["texts"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["durations"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors2"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["colors3"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["isTurnedOn"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["textWhenMissing"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["expiresAt"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["onlyCastByPlayer"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["isPreMade"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["itemSet"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["skill"][tableSlot] = nil
	table.remove(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs,HTT_functions.findPositionOfElementInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs,tableSlot))

end

function HTT_functions.removeBuff(tableSlot)
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["names"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["IDs"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["icons"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["texts"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["durations"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["colors"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["isTurnedOn"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["textWhenMissing"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["expiresAt"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["isPreMade"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["itemSet"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["skill"][tableSlot] = nil
	table.remove(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs,HTT_functions.findPositionOfElementInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs,tableSlot))

end

function HTT_functions.removeCooldown(tableSlot)
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["names"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["IDs"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["icons"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["texts"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["durations"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["colors"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["isTurnedOn"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["textWhenMissing"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["expiresAt"][tableSlot] = 0
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["isPreMade"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["itemSet"][tableSlot] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["skill"][tableSlot] = nil
	table.remove(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns,HTT_functions.findPositionOfElementInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns,tableSlot))

end

function HTT_functions.initializeEventsDebuffs(abilityID,tableSlot)

	EVENT_MANAGER:RegisterForEvent("HTT"..abilityID, EVENT_EFFECT_CHANGED, function(_,_,_,_,_,_,expireTime,_,_,_,_,_,_,targetName) 
	targetName = HTT_functions.removeGender(targetName)
	if expireTime > (HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["expiresAt"][tableSlot][targetName] or 0) then
		HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["expiresAt"][tableSlot][targetName] = expireTime
		HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["durations"][tableSlot][targetName] = expireTime-GetGameTimeSeconds()
	end
	end)
	EVENT_MANAGER:AddFilterForEvent("HTT"..abilityID, EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID,abilityID)
	if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["onlyCastByPlayer"][tableSlot] then
		EVENT_MANAGER:AddFilterForEvent("HTT"..abilityID, EVENT_EFFECT_CHANGED, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE,1)
	end
end

function HTT_functions.initializeEventsBuffs(abilityID,tableSlot)

	EVENT_MANAGER:RegisterForEvent("HTT"..abilityID, EVENT_EFFECT_CHANGED, function(_,_,_,_,_,_,expireTime) 
	if expireTime > HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["expiresAt"][tableSlot] then
		HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["expiresAt"][tableSlot] = expireTime
		HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["durations"][tableSlot] = expireTime-GetGameTimeSeconds()
	end
	end)
	EVENT_MANAGER:AddFilterForEvent("HTT"..abilityID, EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID,abilityID)
	EVENT_MANAGER:AddFilterForEvent("HTT"..abilityID, EVENT_EFFECT_CHANGED, REGISTER_FILTER_TARGET_COMBAT_UNIT_TYPE,1)
end

function HTT_functions.GenerateWeaponEvent(AbilityID,tableSlot)
	EVENT_MANAGER:RegisterForEvent("HTT"..AbilityID, EVENT_EFFECT_CHANGED, function(_,stage,_,_,_,_,_,_,iconName,_,_,_,_,_,_,abilityID) 
	if stage == 1 and (GetGameTimeSeconds() + (GetAbilityDuration(abilityID)/1000)) > HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["expiresAt"][tableSlot] then
		HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["durations"][tableSlot] = GetAbilityDuration(abilityID)/1000
		HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["expiresAt"][tableSlot] = GetGameTimeSeconds() + (GetAbilityDuration(abilityID)/1000)
		icon = HTT:GetNamedChild("IconReticle"..tableSlot)
		icon:SetTexture(iconName)
	end
	end)
	EVENT_MANAGER:AddFilterForEvent("HTT"..AbilityID, EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID,AbilityID)
	EVENT_MANAGER:AddFilterForEvent("HTT"..AbilityID, EVENT_EFFECT_CHANGED, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE ,1)
end

function HTT_functions.GenerateCooldownEvent(abilityID,tableSlot)
	EVENT_MANAGER:RegisterForEvent("HTT"..abilityID, EVENT_COMBAT_EVENT, function(_,_,_,name)   
	if HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["expiresAt"][tableSlot] < GetGameTimeSeconds() then
		HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["expiresAt"][tableSlot] = GetGameTimeSeconds() + HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["durations"][tableSlot]
	end
	end)
	EVENT_MANAGER:AddFilterForEvent("HTT"..abilityID, EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,abilityID)
	EVENT_MANAGER:AddFilterForEvent("HTT"..abilityID, EVENT_COMBAT_EVENT, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE ,1)
end

function HTT_functions.initializeEventsBuffsCombatEvent(abilityID,tableSlot,duration)
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["durations"][tableSlot] = duration
	EVENT_MANAGER:RegisterForEvent("HTT"..abilityID, EVENT_COMBAT_EVENT, function() 
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["expiresAt"][tableSlot] = GetGameTimeSeconds() + HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["durations"][tableSlot]
	end)
	EVENT_MANAGER:AddFilterForEvent("HTT"..abilityID, EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,abilityID)
	EVENT_MANAGER:AddFilterForEvent("HTT"..abilityID, EVENT_COMBAT_EVENT, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE ,1)
end

function HTT_functions.GenerateSynergyEvent(abilityID,tableSlot)
	EVENT_MANAGER:RegisterForEvent("HTT"..abilityID, EVENT_COMBAT_EVENT, function(_,_,_,name)   
	if HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable["expiresAt"][tableSlot] < GetGameTimeSeconds() then
		HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable["expiresAt"][tableSlot] = GetGameTimeSeconds() + 20
	end
	end)
	EVENT_MANAGER:AddFilterForEvent("HTT"..abilityID, EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,abilityID)
	EVENT_MANAGER:AddFilterForEvent("HTT"..abilityID, EVENT_COMBAT_EVENT, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE ,1)
end


function HTT_functions.GetNumberOfDebuffs()
	counter = 0
	for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["isTurnedOn"]) do
		if v then
			counter = counter + 1
		end
	end
	return counter
end

function HTT_functions.GetNumberOfBuffs()
	counter = 0
	for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["isTurnedOn"]) do
		if v then
			counter = counter + 1
		end
	end
	return counter
end

function HTT_functions.CountTurnedOn(table)
	counter = 0
	for _,v in pairs(table) do
		if v then
			counter = counter + 1
		end
	end
	return counter
end



function HTT_functions.GetUnitInfo(ability,target)
	for _,v in pairs(ability) do
		for i=1, GetNumBuffs(target) do
			_, _, timeEnding, _, stacks, _, _, _, _, _, abilityId, _, _ = GetUnitBuffInfo(target, i)
			if abilityId == v then

				return (timeEnding-GetGameTimeSeconds()),stacks,true,abilityId
			end
		end
	end
	return 0,0,false,0
end

function HTT_functions.UpdateDebuffUI()
	countMembers = 0
	reticleBackground = HTT:GetNamedChild("BackgroundReticle")
	for n=1,#HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs do
		textInBar = HTT:GetNamedChild("TextInBarReticle"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs[n])
		durationTimer = HTT:GetNamedChild("DurationTimerReticle"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs[n])
		durationBar = HTT:GetNamedChild("DurationBarReticle"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs[n])
		icon = HTT:GetNamedChild("IconReticle"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs[n])
		if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["isTurnedOn"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs[n]] then
			countMembers = countMembers+1
			
			durationBar:ClearAnchors()
			durationBar:SetAnchor(TOPLEFT, reticleBackground, TOPLEFT, 24, (countMembers*22))
			durationTimer:ClearAnchors()
			durationTimer:SetAnchor(TOPLEFT, reticleBackground, TOPLEFT, 5, (22*countMembers))
			textInBar:ClearAnchors()
			textInBar:SetAnchor(TOPLEFT, reticleBackground, TOPLEFT, 30, (22*countMembers)+1)
			icon:ClearAnchors()
			icon:SetAnchor(TOPLEFT, reticleBackground, TOPLEFT, 5, (22*countMembers))
			textInBar:SetHidden(false)
			durationTimer:SetHidden(false)
			durationBar:SetHidden(false)
			icon:SetHidden(false)
		else
			textInBar:SetHidden(true)
			durationTimer:SetHidden(true)
			durationBar:SetHidden(true)
			icon:SetHidden(true)
		end
	end
	reticleBackground:SetDimensions(210, 22*countMembers+26)
end

function HTT_functions.UpdateBuffUI()
	countMembers = 0
	buffBackground = HTTSelfBuffs:GetNamedChild("SelfBuffsBackground")
	for n=1,#HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs do
		textInBar = HTTSelfBuffs:GetNamedChild("SelfBuffTextInBar"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs[n])
		durationTimer = HTTSelfBuffs:GetNamedChild("SelfBuffDurationTimer"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs[n])
		durationBar = HTTSelfBuffs:GetNamedChild("SelfBuffDurationBar"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs[n])
		icon = HTTSelfBuffs:GetNamedChild("SelfBuffIcon"..HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs[n])
		if HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable["isTurnedOn"][HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs[n]] then
			countMembers = countMembers+1
				
			durationBar:ClearAnchors()
			durationBar:SetAnchor(TOPLEFT, buffBackground, TOPLEFT, 24, (countMembers*22))
			durationTimer:ClearAnchors()
			durationTimer:SetAnchor(TOPLEFT, buffBackground, TOPLEFT, 5, (22*countMembers))
			textInBar:ClearAnchors()
			textInBar:SetAnchor(TOPLEFT, buffBackground, TOPLEFT, 30, (22*countMembers)+1)
			icon:ClearAnchors()
			icon:SetAnchor(TOPLEFT, buffBackground, TOPLEFT, 5, (22*countMembers))
			textInBar:SetHidden(false)
			durationTimer:SetHidden(false)
			durationBar:SetHidden(false)
			icon:SetHidden(false)
		else
			textInBar:SetHidden(true)
			durationTimer:SetHidden(true)
			durationBar:SetHidden(true)
			icon:SetHidden(true)
		end
	end
	buffBackground:SetDimensions(210, 22*countMembers+26)
end



function HTT_functions.swapElementsInTable(table,e1,e2)
	pos1,pos2 = HTT_functions.findPositionOfElementInTable(table,e1),HTT_functions.findPositionOfElementInTable(table,e2)
	table[pos1],table[pos2] = table[pos2],table[pos1]
end

