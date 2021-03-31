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
	icon:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].icon)
	icon:SetHidden(true)
	icon:SetDrawLayer(2)

	local bar = WM:CreateControl("$(parent)DurationBarReticle"..v, HTT, CT_STATUSBAR)	
	bar:SetScale(1.0)
	bar:SetAnchor(LEFT, icon, RIGHT, 0, 0)
	bar:SetDimensions(width*0.75,height)
	bar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].color))
	bar:SetHidden(true)		
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
	timer:SetHidden(true)

	local textInBar = WM:CreateControl("$(parent)TextInBarReticle"..v, HTT, CT_LABEL)
	textInBar:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffFont)
	textInBar:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffFont][1])
	textInBar:SetWrapMode(TEX_MODE_CLAMP)
	textInBar:SetDrawLayer(2)
	textInBar:SetColor(255,255,255, 1)
	textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].name)				
	textInBar:SetAnchor(LEFT, durationBar, LEFT, 0.03*width*scale, (-0.42)*height*scale)	
	textInBar:SetDimensions(width*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffFont][1]/20), 1)
	textInBar:SetHidden(true)
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
	bar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[v].color))
	bar:SetHidden(false)
	bar:SetDrawLayer(1)
	bar:SetTexture("HyperTankingTools/icons/gradientProgressBar.dds")

	local textInBar = WM:CreateControl("$(parent)SelfBuffTextInBar"..v, HTTSelfBuffs, CT_LABEL)
	textInBar:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffFont)
	textInBar:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].buffFont][1])
	textInBar:SetWrapMode(TEX_MODE_CLAMP)
	textInBar:SetDrawLayer(2)
	textInBar:SetColor(255,255,255, 1)
	textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[v].name)				
	textInBar:SetAnchor(TOPLEFT, background, TOPLEFT, height,-10)
	textInBar:SetDimensions(width*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].buffFont][1]/20), 1)
	textInBar:SetHidden(false)

	local icon = WM:CreateControl("$(parent)SelfBuffIcon"..v, HTTSelfBuffs, CT_TEXTURE,4)
	icon:SetDimensions(height,height)
	icon:SetAnchor(TOPLEFT,background,TOPLEFT,5,0)
	icon:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[v].icon)
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
	bar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[v].color))
	bar:SetHidden(false)		
	bar:SetDrawLayer(1)
	bar:SetTexture("HyperTankingTools/icons/gradientProgressBar.dds")

	local textInBar = WM:CreateControl("$(parent)CooldownTextInBar"..v, HTTCooldowns, CT_LABEL)
	textInBar:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownFont)
	textInBar:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownFont][1])
	textInBar:SetWrapMode(TEX_MODE_CLAMP)
	textInBar:SetDrawLayer(2)
	textInBar:SetColor(255,255,255, 1)
	textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[v].name)				
	textInBar:SetAnchor(TOPLEFT, background, TOPLEFT, 30,0)
	textInBar:SetDimensions(width*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownFont][1]/20), 1)
	textInBar:SetHidden(false)

	local icon = WM:CreateControl("$(parent)CooldownIcon"..v, HTTCooldowns, CT_TEXTURE,4)
	icon:SetDimensions(height,height)
	icon:SetAnchor(TOPLEFT,background,TOPLEFT,5,0)
	icon:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[v].icon)
	icon:SetHidden(false)
	icon:SetDrawLayer(2)
end


function HTT_functions.createSynergyControl(v)
	local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesUIWidth
	local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesUIHeight
	local background = HTTSynergies:GetNamedChild("SynergiesBackground")
	local WM = GetWindowManager()
	local timer = WM:CreateControl("$(parent)SynergiesDurationTimer"..v, HTTSynergies, CT_LABEL)			
	timer:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont)
	timer:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont][1])
	timer:SetWrapMode(TEX_MODE_CLAMP)
	timer:SetDrawLayer(2)
	timer:SetColor(255,255,255, 1)
	timer:SetText("0.0s")				
	timer:SetAnchor(TOPLEFT, background, TOPLEFT, 5, 0)
	timer:SetDimensions((HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont][1]/20)*width/4, 1)
	--timer:SetHorizontalAlignment(LEFT)
	timer:SetHidden(false)
			
			

	local bar = WM:CreateControl("$(parent)SynergiesDurationBar"..v, HTTSynergies, CT_STATUSBAR)	
	bar:SetScale(1.0)
	bar:SetAnchor(TOPLEFT, background, TOPLEFT, 5+HTTsavedVars[HTT_variables.currentlySelectedProfile].height/2,0)
	bar:SetDimensions(width*0.75,height)
	bar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[v].color))
	bar:SetHidden(false)		
	bar:SetDrawLayer(1)
	bar:SetTexture("HyperTankingTools/icons/gradientProgressBar.dds")

	local textInBar = WM:CreateControl("$(parent)SynergiesTextInBar"..v, HTTSynergies, CT_LABEL)
	textInBar:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont)
	textInBar:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont][1])
	textInBar:SetWrapMode(TEX_MODE_CLAMP)
	textInBar:SetDrawLayer(2)
	textInBar:SetColor(255,255,255, 1)
	textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[v].name)				
	textInBar:SetAnchor(TOPLEFT, background, TOPLEFT, 30,0)
	textInBar:SetDimensions(width*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont][1]/20), 1)
	textInBar:SetHidden(false)

	local icon = WM:CreateControl("$(parent)SynergiesIcon"..v, HTTSynergies, CT_TEXTURE,4)
	icon:SetDimensions(height,height)
	icon:SetAnchor(TOPLEFT,background,TOPLEFT,5,0)
	icon:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[v].icon)
	icon:SetHidden(false)
	icon:SetDrawLayer(2)
end

function HTT_functions.recreateControls()
	for k,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs) do
		if HTT:GetNamedChild("DurationTimerReticle"..v) == nil then
			HTT_functions.createDebuffControl(v)
            HTT_functions.createBossDebuffControl(v)
		end
	end
	for k,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs) do
		if HTTSelfBuffs:GetNamedChild("SelfBuffDurationTimer"..v) == nil then
			HTT_functions.createBuffControl(v)
		end
	end
	for k,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns) do
		if HTTCooldowns:GetNamedChild("CooldownDurationTimer"..v) == nil then
			HTT_functions.createCooldownControl(v)
		end
	end

	for k,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfSynergies) do
		if HTTSynergies:GetNamedChild("SynergiesDurationTimer"..v) == nil then
			HTT_functions.createSynergyControl(v)
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
		bar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].color))
		bar:SetHidden(false)		
		bar:SetDrawLayer(1)
		bar:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].currentlySelectedBarTexture)

		local textInBar = WM:CreateControl("$(parent)TextInBarBoss"..v..i, _G["HTTBoss"..i], CT_LABEL)
		textInBar:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].bossFont)
		textInBar:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].bossFont][1])
		textInBar:SetWrapMode(TEX_MODE_CLAMP)
		textInBar:SetDrawLayer(2)
		textInBar:SetColor(255,255,255, 1)
		textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].name)				
		textInBar:SetAnchor(TOPLEFT, background, TOPLEFT, 30,0)
		textInBar:SetDimensions(width*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].bossFont][1]/20), 1)
		textInBar:SetHidden(false)

		local icon = WM:CreateControl("$(parent)IconBoss"..v..i, _G["HTTBoss"..i], CT_TEXTURE,4)
		icon:SetDimensions(height,height)
		icon:SetAnchor(TOPLEFT,background,TOPLEFT,5,0)
		icon:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].icon)
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
		if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].turnedOn then
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
		if HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[v].turnedOn then
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
			if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].turnedOnBoss then
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
		if HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[v].turnedOn then
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
		if HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[v].turnedOn then
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
	return "none"
end

function HTT_functions.pickAnyKey(array)
	for k,_ in pairs(array) do
		return k
	end
	return "none"
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

function HTT_functions.createEmptyProfile(nameOfNewProfile)
	table.insert(HTTsavedVars["availableProfiles"],nameOfNewProfile)
	HTTsavedVars[nameOfNewProfile] = HTT_functions.deepcopy(HTTsavedVars["none"])
	HTTsavedVars[nameOfNewProfile].synergiesTable = {
        [1] = 
        {
            ["color"] = 
            {
                [4] = 1,
                [1] = 0.8117647171,
                [2] = 0,
                [3] = 0.2000000030,
            },
            ["text"] = "Sanguine Burst on cooldown",
            ["icon"] = "/esoui/art/icons/ability_u23_bloodball_chokeonit.dds",
            ["textWhenMissing"] = "Sanguine Burst ready",
            ["expiresAt"] = 0,
            ["name"] = "Sanguine Burst",
            ["IDs"] = 
            {
                [1] = 142305,
            },
            ["turnedOn"] = false,
        },
        [2] = 
        {
            ["color"] = 
            {
                [4] = 1,
                [1] = 0.2235294133,
                [2] = 0.8117647171,
                [3] = 0,
            },
            ["text"] = "Resource Restore on cooldown",
            ["icon"] = "/esoui/art/icons/ability_undaunted_004.dds",
            ["textWhenMissing"] = "Resource Restore ready",
            ["expiresAt"] = 0,
            ["name"] = "Resource Restore",
            ["IDs"] = 
            {
                [4] = 95928,
                [1] = 63507,
                [2] = 39301,
                [3] = 94973,
            },
            ["turnedOn"] = true,
        },
        [3] = 
        {
            ["color"] = 
            {
                [4] = 1,
                [1] = 0.4666666687,
                [2] = 0,
                [3] = 0.1137254909,
            },
            ["text"] = "Hidden Refresh on cooldown",
            ["icon"] = "/esoui/art/icons/ability_nightblade_015.dds",
            ["textWhenMissing"] = "Hidden Refresh ready",
            ["expiresAt"] = 0,
            ["name"] = "Hidden Refresh",
            ["IDs"] = 
            {
                [1] = 37729,
            },
            ["turnedOn"] = false,
        },
        [4] = 
        {
            ["color"] = 
            {
                [4] = 1,
                [1] = 0.9568627477,
                [2] = 1,
                [3] = 0.3607843220,
            },
            ["text"] = "Spiders on cooldown",
            ["icon"] = "/esoui/art/icons/ability_undaunted_003.dds",
            ["textWhenMissing"] = "Spiders ready",
            ["expiresAt"] = 0,
            ["name"] = "Spiders",
            ["IDs"] = 
            {
                [1] = 41994,
                [2] = 39429,
                [3] = 42016,
            },
            ["turnedOn"] = false,
        },
        [5] = 
        {
            ["color"] = 
            {
                [4] = 1,
                [1] = 0.8235294223,
                [2] = 1,
                [3] = 0.6156862974,
            },
            ["text"] = "Bone Shield on cooldown",
            ["icon"] = "/esoui/art/icons/ability_undaunted_005.dds",
            ["textWhenMissing"] = "Bone Shield ready",
            ["expiresAt"] = 0,
            ["name"] = "Bone Shield",
            ["IDs"] = 
            {
                [2] = 42198,
                [1] = 39379,
            },
            ["turnedOn"] = false,
        },
        [6] = 
        {
            ["color"] = 
            {
                [4] = 1,
                [1] = 1,
                [2] = 0,
                [3] = 0.1607843190,
            },
            ["text"] = "Blood Altar on cooldown",
            ["icon"] = "/esoui/art/icons/ability_undaunted_001.dds",
            ["textWhenMissing"] = "Blood Altar ready",
            ["expiresAt"] = 0,
            ["name"] = "Blood Altar",
            ["IDs"] = 
            {
                [2] = 39501,
                [1] = 41964,
            },
            ["turnedOn"] = true,
        },
        [7] = 
        {
            ["color"] = 
            {
                [4] = 1,
                [1] = 1,
                [2] = 0.5019608140,
                [3] = 0,
            },
            ["text"] = "Radiate on cooldown",
            ["icon"] = "/esoui/art/icons/ability_undaunted_002.dds",
            ["textWhenMissing"] = "Radiate ready",
            ["expiresAt"] = 0,
            ["name"] = "Radiate",
            ["IDs"] = 
            {
                [1] = 41838,
            },
            ["turnedOn"] = false,
        },
        [8] = 
        {
            ["color"] = 
            {
                [4] = 1,
                [1] = 1,
                [2] = 0.5176470876,
                [3] = 0.5098039508,
            },
            ["text"] = "Soul Leech on cooldown",
            ["icon"] = "/esoui/art/icons/ability_nightblade_018.dds",
            ["textWhenMissing"] = "Soul Leech ready",
            ["expiresAt"] = 0,
            ["name"] = "Soul Leech",
            ["IDs"] = 
            {
                [1] = 25170,
            },
            ["turnedOn"] = false,
        },
        [9] = 
        {
            ["color"] = 
            {
                [4] = 1,
                [1] = 0.1294117719,
                [2] = 0.4823529422,
                [3] = 0.8117647171,
            },
            ["text"] = "Conduit on cooldown",
            ["icon"] = "/esoui/art/icons/ability_sorcerer_lightning_splash.dds",
            ["textWhenMissing"] = "Conduit ready",
            ["expiresAt"] = 0,
            ["name"] = "Conduit",
            ["IDs"] = 
            {
                [1] = 43769,
            },
            ["turnedOn"] = true,
        },
        [10] = 
        {
            ["color"] = 
            {
                [4] = 1,
                [1] = 0.1450980455,
                [2] = 0,
                [3] = 1,
            },
            ["text"] = "Attronach on cooldown",
            ["icon"] = "/esoui/art/icons/ability_sorcerer_storm_atronach.dds",
            ["textWhenMissing"] = "Attronach ready",
            ["expiresAt"] = 0,
            ["name"] = "Attronach",
            ["IDs"] = 
            {
                [1] = 121059,
            },
            ["turnedOn"] = false,
        },
        [11] = 
        {
            ["color"] = 
            {
                [4] = 1,
                [1] = 1,
                [2] = 0.9686274529,
                [3] = 0.4078431427,
            },
            ["text"] = "Supernova on cooldown",
            ["icon"] = "/esoui/art/icons/ability_templar_nova.dds",
            ["textWhenMissing"] = "Supernova ready",
            ["expiresAt"] = 0,
            ["name"] = "Supernova",
            ["IDs"] = 
            {
                [2] = 48938,
                [1] = 48939,
            },
            ["turnedOn"] = false,
        },
        [12] = 
        {
            ["color"] = 
            {
                [4] = 1,
                [1] = 1,
                [2] = 0.2666666806,
                [3] = 0,
            },
            ["text"] = "Ignite on cooldown",
            ["icon"] = "/esoui/art/icons/ability_dragonknight_010.dds",
            ["textWhenMissing"] = "Ignite ready",
            ["expiresAt"] = 0,
            ["name"] = "Ignite",
            ["IDs"] = 
            {
                [1] = 32974,
            },
            ["turnedOn"] = false,
        },
        [13] = 
        {
            ["color"] = 
            {
                [4] = 1,
                [1] = 1,
                [2] = 0.4470588267,
                [3] = 0,
            },
            ["text"] = "Shackle on cooldown",
            ["icon"] = "/esoui/art/icons/ability_dragonknight_006.dds",
            ["textWhenMissing"] = "Shackle ready",
            ["expiresAt"] = 0,
            ["name"] = "Shackle",
            ["IDs"] = 
            {
                [1] = 32910,
            },
            ["turnedOn"] = false,
        },
        [14] = 
        {
            ["color"] = 
            {
                [4] = 1,
                [1] = 0.3882353008,
                [2] = 0.8313725591,
                [3] = 0.4196078479,
            },
            ["text"] = "Harvest on cooldown",
            ["icon"] = "/esoui/art/icons/ability_warden_007.dds",
            ["textWhenMissing"] = "Harvest ready",
            ["expiresAt"] = 0,
            ["name"] = "Harvest",
            ["IDs"] = 
            {
                [1] = 85572,
            },
            ["turnedOn"] = true,
        },
        [15] = 
        {
            ["color"] = 
            {
                [4] = 1,
                [1] = 0.6156862974,
                [2] = 0.9647058845,
                [3] = 1,
            },
            ["text"] = "Gate on cooldown",
            ["icon"] = "/esoui/art/icons/ability_warden_005_b.dds",
            ["textWhenMissing"] = "Gate ready",
            ["expiresAt"] = 0,
            ["name"] = "Gate",
            ["IDs"] = 
            {
                [1] = 88892,
            },
            ["turnedOn"] = false,
        },
        [16] = 
        {
            ["color"] = 
            {
                [4] = 1,
                [1] = 0.4078431427,
                [2] = 0.2392156869,
                [3] = 0.8117647171,
            },
            ["text"] = "Grave Robber on cooldown",
            ["icon"] = "/esoui/art/icons/ability_necromancer_004.dds",
            ["textWhenMissing"] = "Grave Robber ready",
            ["expiresAt"] = 0,
            ["name"] = "Grave Robber",
            ["IDs"] = 
            {
                [1] = 115567,
            },
            ["turnedOn"] = true,
        },
        [17] = 
        {
            ["color"] = 
            {
                [4] = 1,
                [1] = 0.1529411823,
                [2] = 0,
                [3] = 1,
            },
            ["text"] = "Pure Agony on cooldown",
            ["icon"] = "/esoui/art/icons/ability_necromancer_010_b.dds",
            ["textWhenMissing"] = "Pure Agony ready",
            ["expiresAt"] = 0,
            ["name"] = "Pure Agony",
            ["IDs"] = 
            {
                [1] = 118610,
            },
            ["turnedOn"] = false,
        },
    }
    
    HTTsavedVars[nameOfNewProfile].orderOfSynergies = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17}
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
		EVENT_MANAGER:RegisterForUpdate("UIPreview", 200,HTT_PreviewUI)
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
	for k,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns) do
		if not HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[v].itemSet[1]) or not HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[v].skill) then
			if (HTT_functions.TurnOnForWornSets(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[v].itemSet) or HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[v].itemSet[1])) and (HTT_functions.TurnOnForEquipppedSkills(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[v].skill) or HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[v].skill)) then
				HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[v].turnedOn = true
			else
				HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[v].turnedOn = false
			end
		end
	end
end

function HTT_functions.adjustDebuffs()
	for k,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs) do
		if not HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].itemSet[1]) or not HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].skill) then
			if (HTT_functions.TurnOnForWornSets(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].itemSet) or HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].itemSet[1])) and (HTT_functions.TurnOnForEquipppedSkills(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].skill) or HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].itemSet)) then
				HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].turnedOn = true
			else
				HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].turnedOn = false
			end
		end
	end
end

function HTT_functions.adjustBuffs()
	for k,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs) do
		if not HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[v].itemSet[1]) or not HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[v].skill) then
			if (HTT_functions.TurnOnForWornSets(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[v].itemSet) or HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[v].itemSet[1])) and (HTT_functions.TurnOnForEquipppedSkills(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[v].skill) or HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[v].skill)) then
				HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[v].turnedOn = true
			else
				HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[v].turnedOn = false
			end
		end
	end
end

function HTT_functions.adjustBoss()
	for k,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs) do
		if not HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].itemSet[1]) or not HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].skill) then
			if (HTT_functions.TurnOnForWornSets(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].itemSet) or HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].itemSet[1])) and (HTT_functions.TurnOnForEquipppedSkills(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].skill) or HTT_functions.checkIfTableIsEmpty(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].skill)) then
				HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].turnedOnBoss = true
			else
				HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].turnedOnBoss = false
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

--[[
function HTT_functions.adjustDefaultsToClass(defaultTable,classID)
	for _,v in pairs(HTT_variables.classSettings[classID]["buffs"]) do
		defaultTable.buffTable[v].turnedOn = true
	end
	for _,v in pairs(HTT_variables.classSettings[classID]["debuffs"]) do
		defaultTable.debuffTable[v].turnedOn = true
		defaultTable.debuffTable[v].turnedOnBoss = true
	end
	for _,v in pairs(HTT_variables.classSettings[classID]["cooldowns"]) do
		defaultTable.cooldownTable[v].turnedOn = true
	end

end
]]


function HTT_functions.removeGender(name)
	b = string.find(name,"%^")
	if b then
		name = string.sub(name,1,b-1)
	end
	return name
end







function HTT_functions.addBuff(nameOfTracker,abilityID,tableSlot,text,textWhenMissing,color,color2,color3,skill,itemSet,itemSetNumber,icon)
	if HTT_functions.findPositionOfElementInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable,nameOfTracker) then
		d("Duplicate tracker name")
	else
		HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[tableSlot] = {
			name = nameOfTracker,	
			turnedOn = true,
			turnedOnBoss = true,
			color = {unpack(color or {})},
			color2 = {unpack(color2 or {})},
			color3 = {unpack(color3 or {})},
			IDs = abilityID,
			icon = icon or GetAbilityIcon(abilityID[1]),
			duration = 0,
			expiresAt =0,
			skill = skill or {},
			itemSet = {[1] = itemSet,[2] = itemSetNumber} or {},
			text = text,
			textWhenMissing = textWhenMissing,






		}
		table.insert(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs,tableSlot)
		HTTsavedVars[HTT_variables.currentlySelectedProfile].buffNameToID[nameOfTracker] = tableSlot
		if HTTSelfBuffs:GetNamedChild("SelfBuffDurationTimer"..freeSlot) == nil then
			HTT_functions.createBuffControl(tableSlot)
		end
		if nameOfTracker == "Dragon Blood" then
			for k,v in pairs(abilityID) do
				HTT_functions.initializeEventsBuffsCombatEvent(v,tableSlot,23)
			end
		else
			for k,v in pairs(abilityID) do
				HTT_functions.initializeEventsBuffs(v,tableSlot)
			end
		end
		HTT_functions.reanchorBuffs()
	end
end


function HTT_functions.addDebuff(nameOfTracker,abilityID,tableSlot,text,textWhenMissing,color,color2,color3,onlyCastByPlayer,skill,itemSet,itemSetNumber,icon)
	if HTT_functions.findPositionOfElementInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable,nameOfTracker) then
		d("Duplicate tracker name")
	else
		HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[tableSlot] = {
			name = nameOfTracker,	
			turnedOn = true,
			turnedOnBoss = true,
			color = {unpack(color or {})},
			color2 = {unpack(color2 or {})},
			color3 = {unpack(color3 or {})},
			IDs = abilityID,
			icon = icon or GetAbilityIcon(abilityID[1]),
			duration = {},
			expiresAt = {},
			skill = skill or {},
			itemSet = {[1] = itemSet,[2] = itemSetNumber} or {},
			text = text,
			textWhenMissing = textWhenMissing,
			onlyCastByPlayer = onlyCastByPlayer,






		}
		table.insert(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs,tableSlot)
		HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffNameToID[nameOfTracker] = tableSlot
		if HTT:GetNamedChild("DurationTimerReticle"..tableSlot) == nil then
			HTT_functions.createDebuffControl(tableSlot)
			HTT_functions.createBossDebuffControl(tableSlot)
		end
		if nameOfTracker == "Weapon Skill" then
			for k,v in pairs(abilityID) do
				HTT_functions.GenerateWeaponEvent(v,tableSlot)
			end
		else
			for k,v in pairs(abilityID) do
				HTT_functions.initializeEventsDebuffs(v,tableSlot)
			end
		end
		HTT_functions.reanchorReticle()
		HTT_functions.reanchorBoss()
	end
end

function HTT_functions.addCooldown(nameOfTracker,abilityID,tableSlot,text,textWhenMissing,color,color2,color3,duration,skill,itemSet,itemSetNumber,icon)
	if HTT_functions.findPositionOfElementInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable,nameOfTracker) then
		d("Duplicate tracker name")
	else
		HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[tableSlot] = {
			name = nameOfTracker,	
			turnedOn = true,
			turnedOnBoss = true,
			color = {unpack(color or {})},
			color2 = {unpack(color2 or {})},
			color3 = {unpack(color3 or {})},
			IDs = abilityID,
			icon = icon or GetAbilityIcon(abilityID[1]),
			duration = duration,
			expiresAt = 0,
			skill = skill or {},
			itemSet = {[1] = itemSet,[2] = itemSetNumber} or {},
			text = text,
			textWhenMissing = textWhenMissing,






		}
		table.insert(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns,tableSlot)
		HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownNameToID[nameOfTracker] = tableSlot
		if HTTCooldowns:GetNamedChild("CooldownDurationTimer"..tableSlot) == nil then
			HTT_functions.createCooldownControl(tableSlot)
		end
		for k,v in pairs(abilityID) do
			HTT_functions.GenerateCooldownEvent(v,tableSlot)
		end
		HTT_functions.reanchorCooldowns()
	end
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
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffNameToID[HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[tableSlot].name] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[tableSlot] = nil
	table.remove(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs,HTT_functions.findPositionOfElementInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs,tableSlot))

end

function HTT_functions.removeBuff(tableSlot)
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffNameToID[HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[trackerID].name] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[tableSlot] = nil
	table.remove(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs,HTT_functions.findPositionOfElementInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs,tableSlot))

end

function HTT_functions.removeCooldown(tableSlot)
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownNameToID[HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[trackerID].name] = nil
	HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[tableSlot] = nil
	table.remove(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns,HTT_functions.findPositionOfElementInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns,tableSlot))

end

function HTT_functions.initializeEventsDebuffs(abilityID,trackerID)

	EVENT_MANAGER:RegisterForEvent("HTT"..abilityID, EVENT_EFFECT_CHANGED, function(_,_,_,_,_,_,expireTime,_,_,_,_,_,_,targetName) 
	targetName = HTT_functions.removeGender(targetName)
	if expireTime > (HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[trackerID].expiresAt[targetName] or 0) then
		HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[trackerID].expiresAt[targetName] = expireTime
		HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[trackerID].duration[targetName] = expireTime-GetGameTimeSeconds()
	end
	end)
	EVENT_MANAGER:AddFilterForEvent("HTT"..abilityID, EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID,abilityID)
	if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[trackerID].onlyCastByPlayer then
		EVENT_MANAGER:AddFilterForEvent("HTT"..abilityID, EVENT_EFFECT_CHANGED, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE,1)
	end
end

function HTT_functions.initializeEventsBuffs(abilityID,trackerID)

	EVENT_MANAGER:RegisterForEvent("HTT"..abilityID, EVENT_EFFECT_CHANGED, function(_,_,_,_,_,_,expireTime) 
	if expireTime > HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[trackerID].expiresAt then
		HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[trackerID].expiresAt = expireTime
		HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[trackerID].duration = expireTime-GetGameTimeSeconds()
	end
	end)
	EVENT_MANAGER:AddFilterForEvent("HTT"..abilityID, EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID,abilityID)
	EVENT_MANAGER:AddFilterForEvent("HTT"..abilityID, EVENT_EFFECT_CHANGED, REGISTER_FILTER_TARGET_COMBAT_UNIT_TYPE,1)
end

function HTT_functions.GenerateWeaponEvent(AbilityID,trackerID)
	EVENT_MANAGER:RegisterForEvent("HTT"..AbilityID, EVENT_EFFECT_CHANGED, function(_,stage,_,_,_,_,_,_,iconName,_,_,_,_,_,_,abilityID) 
	if stage == 1 and (GetGameTimeSeconds() + (GetAbilityDuration(abilityID)/1000)) > HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[trackerID].duration then
		HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[trackerID].duration = GetAbilityDuration(abilityID)/1000
		HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[trackerID].expiresAt = GetGameTimeSeconds() + (GetAbilityDuration(abilityID)/1000)
		icon = HTT:GetNamedChild("IconReticle"..trackerID)
		icon:SetTexture(iconName)
	end
	end)
	EVENT_MANAGER:AddFilterForEvent("HTT"..AbilityID, EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID,AbilityID)
	EVENT_MANAGER:AddFilterForEvent("HTT"..AbilityID, EVENT_EFFECT_CHANGED, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE ,1)
end

function HTT_functions.GenerateCooldownEvent(abilityID,trackerID)
	EVENT_MANAGER:RegisterForEvent("HTT"..abilityID, EVENT_COMBAT_EVENT, function(_,_,_,name)   
	if HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[trackerID].expiresAt < GetGameTimeSeconds() then
		HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[trackerID].expiresAt = GetGameTimeSeconds() + HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[trackerID].duration
	end
	end)
	EVENT_MANAGER:AddFilterForEvent("HTT"..abilityID, EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,abilityID)
	EVENT_MANAGER:AddFilterForEvent("HTT"..abilityID, EVENT_COMBAT_EVENT, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE ,1)
end

function HTT_functions.initializeEventsBuffsCombatEvent(abilityID,trackerID,duration)
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[trackerID].duration = duration
	EVENT_MANAGER:RegisterForEvent("HTT"..abilityID, EVENT_COMBAT_EVENT, function() 
	HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[trackerID].expiresAt = GetGameTimeSeconds() + HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[trackerID].duration
	end)
	EVENT_MANAGER:AddFilterForEvent("HTT"..abilityID, EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,abilityID)
	EVENT_MANAGER:AddFilterForEvent("HTT"..abilityID, EVENT_COMBAT_EVENT, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE ,1)
end

function HTT_functions.GenerateSynergyEvent(abilityID,trackerID)
	EVENT_MANAGER:RegisterForEvent("HTT"..abilityID, EVENT_COMBAT_EVENT, function(_,_,_,name)   
	if HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[trackerID].expiresAt < GetGameTimeSeconds() then
		HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[trackerID].expiresAt = GetGameTimeSeconds() + 20
	end
	end)
	EVENT_MANAGER:AddFilterForEvent("HTT"..abilityID, EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,abilityID)
	EVENT_MANAGER:AddFilterForEvent("HTT"..abilityID, EVENT_COMBAT_EVENT, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE ,1)
end




function HTT_functions.CountTurnedOn(table)
	counter = 0
	for k,_ in pairs(table) do
		if table[k].turnedOn then
			counter = counter + 1
		end
	end
	return counter
end

function HTT_functions.CountTurnedOnBoss(table)
	counter = 0
	for k,_ in pairs(table) do
		if table[k].turnedOnBoss then
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



function HTT_functions.swapElementsInTable(table,e1,e2)
	pos1,pos2 = HTT_functions.findPositionOfElementInTable(table,e1),HTT_functions.findPositionOfElementInTable(table,e2)
	table[pos1],table[pos2] = table[pos2],table[pos1]
end

