-- Settings menu.

local createNewDebuffSavedVariables = {
	["name"] = nil,
	["ID"] = nil,
	["text"] = nil,
	["textWhenMissing"] = nil,
	["color"] = {1,1,1,1},
	["onlyPlayer"] = false,
}

local createNewBuffSavedVariables = {
	["name"] = nil,
	["ID"] = nil,
	["text"] = nil,
	["textWhenMissing"] = nil,
	["color"] = {1,1,1,1},
}

local createNewCooldownSavedVariables = {
	["name"] = nil,
	["ID"] = nil,
	["text"] = nil,
	["textWhenMissing"] = nil,
	["color"] = {1,1,1,1},
    ["duration"] = nil,
}

local createNewProfileSavedVariables = {
    ["name"] = nil,
}



local shieldChoices = {
	[1] = "HyperTankingTools/icons/customShield1.dds",
	[2] = "HyperTankingTools/icons/customShield2.dds",
	[3] = "HyperTankingTools/icons/customShield3.dds",
	[4] = "HyperTankingTools/icons/customShield4.dds",
    [5] = "HyperTankingTools/icons/schlech.dds",
    [6] = "HyperTankingTools/icons/pakoShield.dds",
}


local barChoices = {
	[1] = "|t160:20:HyperTankingTools/icons/gradientProgressBar.dds|t",
	[2] = "|t160:20:HyperTankingTools/icons/gradientProgressBarFlipped.dds|t",
	[3] = "|t160:20:HyperTankingTools/icons/gradientProgressBar2.dds|t",
	[4] = "|t160:20:HyperTankingTools/icons/gradientProgressBar2Flipped.dds|t",
    [5] = "|t160:20:HyperTankingTools/icons/progressBar.dds|t",
}


local holdRemoveDebuffSkill, holdDebuffSwapValue1,holdDebuffSwapValue2,holdBuffSwapValue1,holdBuffSwapValue2,holdCooldownSwapValue1, 
    holdCooldownSwapValue2, holdRemoveDebuffID, holdRemoveBuffID, holdRemoveCooldownID, addNewIDToExistingDebuff,addNewIDToExistingBuff, addNewIDToExistingCooldown,
    addNewSkillToExistingSkills, currentlyEditedDebuffKey, holdRemoveDebuffItemSet, addNewItemSetToExistingItemSets, addNewItemSetToExistingItemSetsBuff, holdSynergySwapValue1,
	holdSynergySwapValue2, holdRemoveCooldownItemSet, addNewItemSetsToExistingItemSetsCooldown, holdRemoveBuffItemSet, addNewItemSetsToExistingItemSetsBuff, holdRemoveDebuffItemSet,
    addNewItemSetsToExistingItemSetsDebuff



local function checkIfNone(key)
    if key == "none" then
        return true
    end
    return false
end


local function rescaleCooldowns()
	local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownUIWidth
	local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownUIHeight
	local scale = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownUIScale
    local background = HTTCooldowns:GetNamedChild("CooldownsBackground")
	background:SetDimensions(width, ((height*1.13)*HTT_functions.CountTurnedOn(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable))+height)
    local text = HTTCooldowns:GetNamedChild("CooldownsText")		
	text:SetAnchor(TOPLEFT, background, TOPLEFT,(width*(3/100))*scale, 0)
	text:SetDimensions((HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownFont][1]/20)*width, 1)
	text:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownFont][1])
    text:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownFont)
    for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns) do
		local textInBar = HTTCooldowns:GetNamedChild("CooldownTextInBar"..v)
		local durationTimer = HTTCooldowns:GetNamedChild("CooldownDurationTimer"..v) --might be obsolete
		local durationBar = HTTCooldowns:GetNamedChild("CooldownsDurationBar"..v)
		local icon = HTTCooldowns:GetNamedChild("CooldownIcon"..v)
		icon:SetDimensions(height,height)
        textInBar:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownFont][1])
        textInBar:SetDimensions(width*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownFont][1]/20), 1)
        textInBar:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownFont)
        durationTimer:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownFont][1])
        durationTimer:SetDimensions((HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownFont][1]/20)*width/4, 1)
        durationTimer:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownFont)
	end
    HTTCooldowns:SetScale(scale)
end

local function rescaleSpecial()
    local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].specialUIWidth
	local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].specialUIHeight
    local scale = HTTsavedVars[HTT_variables.currentlySelectedProfile].specialUIScale
    if GetUnitClassId("player") == 1 or GetUnitClassId("player") == 4 then
        local StackCountBG = HTTOwnStacks:GetNamedChild("StackCountBG")
	    StackCountBG:SetDimensions(width, height)
	    local ballSize = HTT_functions.GetLesserValue(height,width/3)/2
	    for i=-1, 1 do
		    local circleOutline = HTTOwnStacks:GetNamedChild("CircleOutline"..i)
		    circleOutline:SetDimensions(ballSize, ballSize)
            circleOutline:ClearAnchors()
		    circleOutline:SetAnchor(HTT_variables.anchorsByNumber[i],StackCountBG,HTT_variables.anchorsByNumber[i],(width/(-10))*i,height/(-10))
		    local circle = HTTOwnStacks:GetNamedChild("CircleInner"..i)
		    circle:SetDimensions(ballSize*0.85, ballSize*0.85)
	    end
	    local stackTimerBarOutline = HTTOwnStacks:GetNamedChild("StackTimerBarTexture")
	    stackTimerBarOutline:SetDimensions(width*0.8,height/5)
	    stackTimerBarOutline:SetAnchor(TOPLEFT,StackCountBG,TOPLEFT,width/100,height/20)
	    local stackTimerBar = HTTOwnStacks:GetNamedChild("StackTimerBar")
        stackTimerBar:ClearAnchors()
	    stackTimerBar:SetAnchor(LEFT, stackTimerBarOutline, LEFT, width*0.025, 0)
	    stackTimerBar:SetDimensions(width*0.75,height/6)
	    local stackTimerText = HTTOwnStacks:GetNamedChild("StackTimerText")	
        stackTimerText:ClearAnchors()
	    stackTimerText:SetAnchor(TOPRIGHT, StackCountBG, TOPRIGHT,((2/15)*height)-(width/15),height/60)
	    --stackTimerText:SetDimensions(width/10,height/5)
        stackTimerText:SetScale(height/250)
    elseif GetUnitClassId("player") == 5 then
        local EmpowerBackground = HTTOwnStacks:GetNamedChild("EmpowerBackground")
        local EmpowerText = HTTOwnStacks:GetNamedChild("EmpowerText")
        local EmpowerIcon = HTTOwnStacks:GetNamedChild("EmpowerIcon")
        EmpowerText:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont)
        EmpowerText:SetScale((height/3)/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont][1])
        EmpowerText:SetDimensions(width*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont][1]/20), (height/3)*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont][1]/20))
        EmpowerIcon:SetDimensions(height/2.8, height/2.8)
        EmpowerIcon:SetAnchor(TOPLEFT,EmpowerBackground,TOPLEFT,width/40,height/12)
        for i=1,12 do
            local EmpowerBar = HTTOwnStacks:GetNamedChild("EmpowerBar"..i)
			local EmpowerTextInBar = HTTOwnStacks:GetNamedChild("EmpowerTextInBar"..i)
			local EmpowerRoleIcon = HTTOwnStacks:GetNamedChild("EmpowerRoleIcon"..i)
			local EmpowerTimer = HTTOwnStacks:GetNamedChild("EmpowerTimer"..i)
            EmpowerRoleIcon:SetDimensions(height/2.8, height/2.8)
            EmpowerRoleIcon:ClearAnchors()
			EmpowerRoleIcon:SetAnchor(TOPLEFT,EmpowerBackground,TOPLEFT,scale*width/40,((height/2.75*i)+height/6)*scale)
            EmpowerBar:ClearAnchors()
            EmpowerBar:SetAnchor(LEFT, EmpowerRoleIcon, RIGHT, scale*width/200, 0)
			EmpowerBar:SetDimensions(width*(0.75), height/3)
            EmpowerTimer:ClearAnchors()
            EmpowerTimer:SetAnchor(LEFT, EmpowerRoleIcon, RIGHT, scale*width*(0.75),0)
            EmpowerTimer:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont)
            EmpowerTimer:SetScale((height/3)/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont][1])
            EmpowerTimer:SetDimensions((width/8)*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont][1]/20),(height/3)*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont][1]/20))
			EmpowerTextInBar:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont)
            EmpowerTextInBar:SetScale((height/3)/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont][1])
            EmpowerTextInBar:SetDimensions(width*0.7*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont][1]/20),(height/3)*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont][1]/20))
            EmpowerTextInBar:ClearAnchors()
            EmpowerTextInBar:SetAnchor(LEFT, EmpowerBar, LEFT, scale*width/36,0)
        end
        EmpowerBackground:SetDimensions(width,(12*(height/2.7))+(height/1.6))
    end
    HTTOwnStacks:SetScale(scale)
end

local function rescaleBuffs()
    local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffUIWidth
	local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffUIHeight
	local scale = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffUIScale
    local SelfBuffsBackground = HTTSelfBuffs:GetNamedChild("SelfBuffsBackground")
	SelfBuffsBackground:SetDimensions(width, ((height*1.13)*HTT_functions.CountTurnedOn(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable))+height)
    local SelfBuffsText = HTTSelfBuffs:GetNamedChild("SelfBuffsText")
	SelfBuffsText:SetAnchor(TOPLEFT, SelfBuffsBackground, TOPLEFT,(width*(3/100))*scale, 0)
	SelfBuffsText:SetDimensions((HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].buffFont][1]/20)*width, 1)
	SelfBuffsText:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].buffFont][1])
    SelfBuffsText:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffFont)
    for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs) do
		local textInBar = HTTSelfBuffs:GetNamedChild("SelfBuffTextInBar"..v)
		local durationTimer = HTTSelfBuffs:GetNamedChild("SelfBuffDurationTimer"..v) --might be obsolete
		local durationBar = HTTSelfBuffs:GetNamedChild("SelfBuffDurationBar"..v)
		local icon = HTTSelfBuffs:GetNamedChild("SelfBuffIcon"..v)
		icon:SetDimensions(height,height)
        textInBar:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].buffFont][1])
        textInBar:SetDimensions(width*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].buffFont][1]/20), 1)
        textInBar:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffFont)
        durationTimer:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].buffFont][1])
        durationTimer:SetDimensions((HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].buffFont][1]/20)*width/4, 1)
        durationTimer:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffFont)
	end
    HTTSelfBuffs:SetScale(scale)
end

local function rescaleSynergies()
    local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesUIWidth
	local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesUIHeight
	local scale = HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesUIScale
    local background = HTTSynergies:GetNamedChild("SynergiesBackground")
	background:SetDimensions(width, ((height*1.13)*HTT_functions.CountTurnedOn(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable))+height)
    local text = HTTSynergies:GetNamedChild("SynergiesText")		
	text:SetAnchor(TOPLEFT, background, TOPLEFT,(width*(3/100))*scale, 0)
	text:SetDimensions((HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont][1]/20)*width, 1)
	text:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont][1])
    text:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont)
    for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfSynergies) do
		local textInBar = HTTSynergies:GetNamedChild("SynergiesTextInBar"..v)
		local durationTimer = HTTSynergies:GetNamedChild("SynergiesDurationTimer"..v) --might be obsolete
		local durationBar = HTTSynergies:GetNamedChild("SynergiesDurationBar"..v)
		local icon = HTTSynergies:GetNamedChild("SynergiesIcon"..v)
		icon:SetDimensions(height,height)
        textInBar:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont][1])
        textInBar:SetDimensions(width*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont][1]/20), 1)
        textInBar:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont)
        durationTimer:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont][1])
        durationTimer:SetDimensions((HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont][1]/20)*width/4, 1)
        durationTimer:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont)

	end
    HTTSynergies:SetScale(scale)
end

local function rescaleBoss()
    local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffBossUIWidth
	local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffBossUIHeight
	local scale = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffBossUIScale
	for i=1, MAX_BOSSES do
		local background = _G["HTTBoss"..i]:GetNamedChild("BackgroundBoss"..i)
		background:SetDimensions(width, ((height*1.13)*HTT_functions.CountTurnedOnBoss(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable))+height)
		local text = _G["HTTBoss"..i]:GetNamedChild("TextBoss"..i)		
		text:SetAnchor(TOPLEFT, background, TOPLEFT,(width*(3/100))*scale, 0)
		text:SetDimensions((HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].bossFont][1]/20)*width, 1)
	    text:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].bossFont][1])
        text:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].bossFont)
		for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs) do
			local textInBar = _G["HTTBoss"..i]:GetNamedChild("TextInBarBoss"..v..i)
			local durationTimer = _G["HTTBoss"..i]:GetNamedChild("DurationTimerBoss"..v..i) --might be obsolete
			local durationBar = _G["HTTBoss"..i]:GetNamedChild("DurationBarBoss"..v..i)
			local icon = _G["HTTBoss"..i]:GetNamedChild("IconBoss"..v..i)
			icon:SetDimensions(height,height)
            textInBar:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].bossFont)
            textInBar:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].bossFont][1])
            textInBar:SetDimensions(width*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].bossFont][1]/20), 1)
            durationTimer:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].bossFont)
            durationTimer:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].bossFont][1])
            durationTimer:SetDimensions((HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].bossFont][1]/20)*width/4, 1)
		end
		_G["HTTBoss"..i]:SetScale(scale)
	end
end

local function rescaleDebuffs()
    local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIWidth
	local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIHeight
	local scale = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIScale
    local BackgroundReticle = HTT:GetNamedChild("BackgroundReticle")
	BackgroundReticle:SetDimensions(width, ((height*1.13)*HTT_functions.CountTurnedOn(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable))+height)
    local TextReticle = HTT:GetNamedChild("TextReticle")		
	TextReticle:SetAnchor(TOPLEFT, BackgroundReticle, TOPLEFT,(width*(3/100))*scale, 0)
	TextReticle:SetDimensions((HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffFont][1]/20)*width, 1)
	TextReticle:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffFont][1])
    TextReticle:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffFont)
    for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs) do
		local textInBar = HTT:GetNamedChild("TextInBarReticle"..v)
		local durationTimer = HTT:GetNamedChild("DurationTimerReticle"..v) --might be obsolete
		local durationBar = HTT:GetNamedChild("DurationBarReticle"..v)
		local icon = HTT:GetNamedChild("IconReticle"..v)
        icon:SetDimensions(height,height)
        textInBar:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffFont][1])
        textInBar:SetDimensions(width*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffFont][1]/20), 1)
        textInBar:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffFont)
        durationTimer:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffFont][1])
        durationTimer:SetDimensions((HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffFont][1]/20)*width/4, 1)
        durationTimer:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffFont)
	end
    HTT:SetScale(scale)
end

local function ShowColor2(number)
    if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[number].name == "Off-Balance/Off-Balance Immunity" or HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[number].name == "Stagger" or HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[number].name == "Minor Brittle" then
        return false
    end
    return true
end

local function ShowColor3(number)
    if HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[number].name == "Stagger" then
        return false
    end
    return true
end

local function BuffViewerUpdate()
    buffViewerWindow:ClearText()
	for i=1, GetNumBuffs("player") do
		name, _, _, _, _, _, _, _, _, _, abilityId, _, _ = GetUnitBuffInfo("player", i)
		buffViewerWindow:AddText(name.." - "..abilityId)
	end
end

local function DebuffViewerUpdate()
    debuffViewerWindow:ClearText()
	for i=1, GetNumBuffs("reticleover") do
		name, _, _, _, _, _, _, _, _, _, abilityId, _, _ = GetUnitBuffInfo("reticleover", i)
		debuffViewerWindow:AddText(name.." - "..abilityId)
	end
end

local function AbilityViewerUpdate()
    abilitySlotViewer:ClearText()
    for i = 3, 8 do
        abilitySlotViewer:AddText("Frontbar "..(i-2)..": "..GetSlotBoundId(i, HOTBAR_CATEGORY_PRIMARY))
	end
    for i = 3, 8 do
        abilitySlotViewer:AddText("Backbar "..(i-2)..": "..GetSlotBoundId(i, HOTBAR_CATEGORY_BACKUP))
	end
end

local function rearrangeTable(table,order)
	if order == nil then
		for i=1, #table do
			order[i] = i
		end
	end
    local holder = {}
    for k,v in pairs(order) do

        holder[#holder+1] = table[v]
    end
    return holder
end

local function generateDebuffOrderList()
    local counter = 1
    local text = ""
    for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs) do
        text = text..counter..".|t16:16:"..HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].icon.."|t"..HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[v].name.."\n"
        counter = counter + 1
    end
    return text
end


local function generateBuffOrderList()
    local counter = 1
    local text = ""
    for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs) do
        text = text..counter..".|t16:16:"..HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[v].icon.."|t"..HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[v].name.."\n"
        counter = counter + 1
    end
    return text
end

local function generateCooldownOrderList()
    local counter = 1
    local text = ""
    for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns) do
        text = text..counter..".|t16:16:"..HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[v].icon.."|t"..HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[v].name.."\n"
        counter = counter + 1
    end
    return text
end

local function generateSynergyOrderList()
    local counter = 1
    local text = ""
    for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfSynergies) do
        text = text..counter..".|t16:16:"..HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[v].icon.."|t"..HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[v].name.."\n"
        counter = counter + 1
    end
    return text
end



local function createTableOfNames(table)
    local tableHolder = {}
    for trackerID,tracker in pairs(table) do
        if tracker.name ~= "none" then
            tableHolder[#tableHolder+1] = tracker.name
        end
    end
    return tableHolder
end

local function refreshAllDebuffTrackerInfo()
    if currentlyEditedDebuffKey == "none" then
        iconpickerDebuff.data.disabled = true
        swapDebuffsButton.data.disabled = true
        colorPicker1Debuff.data.disabled = true
        debuffDeleteIDButton.data.disabled = true
        debuffDeleteItemSetButton.data.disabled = true
        debuffDeleteSkillButton.data.disabled = true
        debuffDeleteTrackerButton.data.disabled = true
        debuffAddIDButton.data.disabled = true
        debuffAddItemSetButton.data.disabled = true
        debuffAddSkillButton.data.disabled = true
        pickDropdownDebuff.data.disabled = true
        IDdropdownDebuff.data.disabled = true
        SkillDebuffdropdown.data.disabled = true
        ItemSetDebuffdropdown.data.disabled = true
        debuffTrackingOnCurrentTargetCheckbox.data.disabled = true
        debuffTrackingOnBossCheckbox.data.disabled = true
        debuffAddNewIDEditbox.data.disabled = true
        debuffAddNewItemSetEditbox.data.disabled = true
        debuffAddNewSkillEditbox.data.disabled = true
        debuffSlider.data.disabled = true
        debuffTextEditbox.data.disabled = true
        debuffTextWhenMissingEditbox.data.disabled = true
        debuffSwapDropdown1.data.disabled = true
        debuffSwapDropdown2.data.disabled = true
    else
        iconpickerDebuff.data.disabled = false
        swapDebuffsButton.data.disabled = false
        colorPicker1Debuff.data.disabled = false
        debuffDeleteIDButton.data.disabled = false
        debuffDeleteItemSetButton.data.disabled = false
        debuffDeleteSkillButton.data.disabled = false
        debuffDeleteTrackerButton.data.disabled = false
        debuffAddIDButton.data.disabled = false
        debuffAddItemSetButton.data.disabled = false
        debuffAddSkillButton.data.disabled = false
        pickDropdownDebuff.data.disabled = false
        IDdropdownDebuff.data.disabled = false
        SkillDebuffdropdown.data.disabled = false
        ItemSetDebuffdropdown.data.disabled = false
        debuffTrackingOnCurrentTargetCheckbox.data.disabled = false
        debuffTrackingOnBossCheckbox.data.disabled = false
        debuffAddNewIDEditbox.data.disabled = false
        debuffAddNewItemSetEditbox.data.disabled = false
        debuffAddNewSkillEditbox.data.disabled = false
        debuffSlider.data.disabled = false
        debuffTextEditbox.data.disabled = false
        debuffTextWhenMissingEditbox.data.disabled = false
        debuffSwapDropdown1.data.disabled = false
        debuffSwapDropdown2.data.disabled = false
    end
    pickDropdownDebuff.data.choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable)  or {"No profiles"}
    pickDropdownDebuff:UpdateChoices()
    headerDebuff.data.name = ZO_HIGHLIGHT_TEXT:Colorize(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].name.." (ID:"..currentlyEditedDebuffKey ..")")
	headerDebuff:UpdateValue()
    IDdropdownDebuff.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].IDs  or {"No IDs"}
    IDdropdownDebuff:UpdateChoices()
    SkillDebuffdropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].skill  or {"No skills"}
    SkillDebuffdropdown:UpdateChoices()
    ListOfOrder.data.text = generateDebuffOrderList()
    ListOfOrder:UpdateValue()
    debuffSwapDropdown1.data.choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable) or {"Nothing to swap"}
    debuffSwapDropdown1:UpdateChoices()
    debuffSwapDropdown2.data.choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable)  or {"Nothing to swap"}
    debuffSwapDropdown2:UpdateChoices()
    ItemSetDebuffdropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].itemSet[1] or {"No item sets"}
    ItemSetDebuffdropdown:UpdateChoices()
    colorPicker2Debuff.data.disabled = ShowColor2(currentlyEditedDebuffKey)
    colorPicker3Debuff.data.disabled = ShowColor3(currentlyEditedDebuffKey)
end

local function refreshAllBuffTrackerInfo()
    if currentlyEditedBuffKey == "none" then
        iconpickerBuff.data.disabled = true
        swapBuffsButton.data.disabled = true
        buffColor.data.disabled = true
        buffDeleteIDButton.data.disabled = true
        buffDeleteItemSetButton.data.disabled = true
        buffDeleteSkillButton.data.disabled = true
        buffDeleteTrackerButton.data.disabled = true
        buffAddIDButton.data.disabled = true
        buffAddItemSetButton.data.disabled = true
        buffAddSkillButton.data.disabled = true
        pickDropdownBuff.data.disabled = true
        IDdropdownBuff.data.disabled = true
        SkillBuffdropdown.data.disabled = true
        ItemSetBuffdropdown.data.disabled = true
        buffTracking.data.disabled = true
        buffAddNewIDEditbox.data.disabled = true
        buffAddNewItemSetEditbox.data.disabled = true
        buffAddNewSkillEditbox.data.disabled = true
        buffSlider.data.disabled = true
        buffTextEditbox.data.disabled = true
        buffTextWhenMissingEditbox.data.disabled = true
        buffSwapDropdown1.data.disabled = true
        buffSwapDropdown2.data.disabled = true
    else
        iconpickerBuff.data.disabled = false
        swapBuffsButton.data.disabled = false
        buffColor.data.disabled = false
        buffDeleteIDButton.data.disabled = false
        buffDeleteItemSetButton.data.disabled = false
        buffDeleteSkillButton.data.disabled = false
        buffDeleteTrackerButton.data.disabled = false
        buffAddIDButton.data.disabled = false
        buffAddItemSetButton.data.disabled = false
        buffAddSkillButton.data.disabled = false
        pickDropdownBuff.data.disabled = false
        IDdropdownBuff.data.disabled = false
        SkillBuffdropdown.data.disabled = false
        ItemSetBuffdropdown.data.disabled = false
        buffTracking.data.disabled = false
        buffAddNewIDEditbox.data.disabled = false
        buffAddNewItemSetEditbox.data.disabled = false
        buffAddNewSkillEditbox.data.disabled = false
        buffSlider.data.disabled = false
        buffTextEditbox.data.disabled = false
        buffTextWhenMissingEditbox.data.disabled = false
        buffSwapDropdown1.data.disabled = false
        buffSwapDropdown2.data.disabled = false
    end
    pickDropdownBuff.data.choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable)  or {"No trackers"}
    pickDropdownBuff:UpdateChoices()
	headerBuff.data.name = ZO_HIGHLIGHT_TEXT:Colorize(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].name.." (ID:"..currentlyEditedBuffKey..")")
	headerBuff:UpdateValue()
    IDdropdownBuff.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].IDs  or {"No IDs"}
    IDdropdownBuff:UpdateChoices()
    ListOfOrderBuffs.data.text = generateBuffOrderList()
    ListOfOrderBuffs:UpdateValue()
    buffSwapDropdown1.data.choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable) or {"Nothing to swap"}
    buffSwapDropdown1:UpdateChoices()
    buffSwapDropdown2.data.choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable) or {"Nothing to swap"}
    buffSwapDropdown2:UpdateChoices()
    SkillBuffdropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].skill or {"No skills"}
    SkillBuffdropdown:UpdateChoices()
    ItemSetBuffdropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].itemSet[1] or {"No item sets"}
    ItemSetBuffdropdown:UpdateChoices()
end

local function refreshAllCooldownTrackerInfo()
	if currentlyEditedCooldownKey == "none" then
        iconpickerCooldown.data.disabled = true
        swapCooldownsButton.data.disabled = true
        cooldownColorPicker.data.disabled = true
        cooldownDeleteIDButton.data.disabled = true
        cooldownDeleteItemSetButton.data.disabled = true
        cooldownDeleteSkillButton.data.disabled = true
        cooldownDeleteTrackerButton.data.disabled = true
        cooldownAddIdButton.data.disabled = true
        cooldownAddItemSetButton.data.disabled = true
        cooldownAddSkillButton.data.disabled = true
        pickDropdownCooldown.data.disabled = true
        IDdropdownCooldown.data.disabled = true
        SkillCooldowndropdown.data.disabled = true
        ItemSetCooldowndropdown.data.disabled = true
        cooldownTracking.data.disabled = true
        cooldownAddNewIDEditbox.data.disabled = true
        cooldownAddNewItemSetEditbox.data.disabled = true
        cooldownAddNewSkillEditbox.data.disabled = true
        cooldownSlider.data.disabled = true
        cooldownText.data.disabled = true
        cooldownTextWhenMissing.data.disabled = true
        cooldownSwapDropdown1.data.disabled = true
        cooldownSwapDropdown2.data.disabled = true
	else
		iconpickerCooldown.data.disabled = false
        swapCooldownsButton.data.disabled = false
        cooldownColorPicker.data.disabled = false
        cooldownDeleteIDButton.data.disabled = false
        cooldownDeleteItemSetButton.data.disabled = false
        cooldownDeleteSkillButton.data.disabled = false
        cooldownDeleteTrackerButton.data.disabled = false
        cooldownAddIdButton.data.disabled = false
        cooldownAddItemSetButton.data.disabled = false
        cooldownAddSkillButton.data.disabled = false
        pickDropdownCooldown.data.disabled = false
        IDdropdownCooldown.data.disabled = false
        SkillCooldowndropdown.data.disabled = false
        ItemSetCooldowndropdown.data.disabled = false
        cooldownTracking.data.disabled = false
        cooldownAddNewIDEditbox.data.disabled = false
        cooldownAddNewItemSetEditbox.data.disabled = false
        cooldownAddNewSkillEditbox.data.disabled = false
        cooldownSlider.data.disabled = false
        cooldownText.data.disabled = false
        cooldownTextWhenMissing.data.disabled = false
        cooldownSwapDropdown1.data.disabled = false
        cooldownSwapDropdown2.data.disabled = false
    end
    pickDropdownCooldown.data.choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable)  or {"No trackers"}
    pickDropdownCooldown:UpdateChoices()
	headerCooldown.data.name = ZO_HIGHLIGHT_TEXT:Colorize(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].name.." (ID:"..currentlyEditedCooldownKey..")")
	headerCooldown:UpdateValue()
    IDdropdownCooldown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].IDs  or {"No IDs"}
    IDdropdownCooldown:UpdateChoices()
    ListOfOrderCooldowns.data.text = generateCooldownOrderList()
    ListOfOrderCooldowns:UpdateValue()
    cooldownSwapDropdown1.data.choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable) or {"Nothing to swap"}
    cooldownSwapDropdown1:UpdateChoices()
    cooldownSwapDropdown2.data.choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable) or {"Nothing to swap"}
    cooldownSwapDropdown2:UpdateChoices()
    ItemSetCooldowndropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].itemSet[1] or {"No item sets"}
    ItemSetCooldowndropdown:UpdateChoices()
    SkillCooldowndropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].skill or {"No skills"}
    SkillCooldowndropdown:UpdateChoices()
end



local function refreshAllSynergyTrackerInfo()
	if currentlyEditedSynergyKey == "none" then
        pickDropdownSynergies.data.disabled = true
        headerSynergy.data.disabled = true
        ListOfOrderSynergies.data.disabled = true
        synergySwapDropdown1.data.disabled = true
        synergySwapDropdown2.data.disabled = true
        swapSynergiesButton.data.disabled = true
        synergyIconPicker.data.disabled = true
        synergyTrackingCheckbox.data.disabled = true
        synergyColorPicker.data.disabled = true
        synergyTextEditbox.data.disabled = true
        synergyTextWhenMissingEditbox.data.disabled = true
	else
        pickDropdownSynergies.data.disabled = false
        headerSynergy.data.disabled = false
        ListOfOrderSynergies.data.disabled = false
        synergySwapDropdown1.data.disabled = false
        synergySwapDropdown2.data.disabled = false
        swapSynergiesButton.data.disabled = false
        synergyIconPicker.data.disabled = false
        synergyTrackingCheckbox.data.disabled = false
        synergyColorPicker.data.disabled = false
        synergyTextEditbox.data.disabled = false
        synergyTextWhenMissingEditbox.data.disabled = false
    end
    pickDropdownSynergies.data.choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable)  or {"No trackers"}
    pickDropdownSynergies:UpdateChoices()
	headerSynergy.data.name = ZO_HIGHLIGHT_TEXT:Colorize(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[currentlyEditedSynergyKey].name.." (ID:"..currentlyEditedSynergyKey..")")
	headerSynergy:UpdateValue()
    ListOfOrderSynergies.data.text = generateSynergyOrderList()
    ListOfOrderSynergies:UpdateValue()
    synergySwapDropdown1.data.choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable) or {"Nothing to swap"}
    synergySwapDropdown1:UpdateChoices()
    synergySwapDropdown2.data.choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable) or {"Nothing to swap"}
    synergySwapDropdown2:UpdateChoices()
end



function HTT_LoadSettings()
    local panelData = {
        type = "panel",
        name = "Hyper Tanking Tools",
        displayName = "Hyper Tanking Tools",
        author = "Hyperioxes",
        version = "1.18",
		website = "https://www.esoui.com/downloads/info2778-HyperTankingTools.html",
		feedback = "https://www.esoui.com/downloads/info2778-HyperTankingTools.html#comments",
		donation = "https://www.esoui.com/downloads/info2778-HyperTankingTools.html#donate",
        slashCommand = "/htt",
        registerForRefresh = true,
        registerForDefaults = true,
    }
    LibAddonMenu2:RegisterAddonPanel("Hyper Tanking Tools", panelData)

    local optionsTable = {}

      
	  table.insert(optionsTable, {
        type = "description",
        text = "You can report bugs and provide feedback on esoui website, by messaging me in game (EU) @Hyperioxes or by messaging me on Discord Hyperioxes#7894",
        width = "full",
    })
	  
	  
	  table.insert(optionsTable, {
        type = "button",
        name = "Preview UI",
        func = function() HTT_functions.showUI() end,
        width = "half",
        tooltip = "Allows you to preview and move UI without going into combat",
    })

	table.insert(optionsTable, {
        type = "header",
        name = "Profiles",
        width = "full",
    })
   table.insert(optionsTable, {
                type = "dropdown",
                name = "Selected Profile:",
                choices = HTT_functions.removeEmptySpacesInTable(HTTsavedVars["availableProfiles"]) or {"No profiles"},
                getFunc = function() return HTT_variables.currentlySelectedProfile end,
                setFunc = function(var) HTT_functions.hideEverythingOnSwitch()
                HTT_events.unregisterEvents()
                HTT_variables.currentlySelectedProfile = var
                SVCS["currentlySelectedProfile"] = var
                currentlyEditedDebuffKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable)
                currentlyEditedBuffKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable)
                currentlyEditedCooldownKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable)
                refreshAllDebuffTrackerInfo()
                refreshAllBuffTrackerInfo()
                refreshAllCooldownTrackerInfo()
                refreshAllSynergyTrackerInfo()
                HTT_functions.recreateControls()
				HTT_functions.ProcessAnchors()
                HTT_functions.reanchorReticle() 
                HTT_functions.reanchorBuffs()
                HTT_functions.reanchorBoss()
                HTT_functions.reanchorCooldowns()
                HTT_functions.reanchorSynergies()

                rescaleDebuffs()
                rescaleBuffs()
                rescaleBoss()
                rescaleCooldowns()
                rescaleSynergies()
                rescaleSpecial()
                HTT_events.nullifyRemainingTimes()
                HTT_events.generateEvents()
                local reflectiveControl = HTTReflect:GetNamedChild("reflectFill")
                reflectiveControl:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].reflectIndicatorColor))
                HTT_switchStraightUI(HTTsavedVars[HTT_variables.currentlySelectedProfile].isStraightResourceOn)
                end,
                width = "half",	--or "half" (optional)
                reference = "profileDropdown",
            })

     table.insert(optionsTable, {
				type = "button",
				name = "Delete Selected Profile",
				func = function()  HTT_functions.hideEverythingOnSwitch()
                HTT_events.unregisterEvents()
                HTT_functions.deleteProfile(HTT_variables.currentlySelectedProfile)
                SVCS["currentlySelectedProfile"] = HTT_functions.pickAnyElement(HTTsavedVars["availableProfiles"])
                HTT_variables.currentlySelectedProfile = HTT_functions.pickAnyElement(HTTsavedVars["availableProfiles"])
                currentlyEditedDebuffKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable)
                currentlyEditedBuffKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable)
                currentlyEditedCooldownKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable)
                profileDropdown.data.choices =  HTT_functions.removeEmptySpacesInTable(HTTsavedVars["availableProfiles"]) or {"No profiles"}
                profileDropdown:UpdateChoices()
                
                currentlyEditedDebuffKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable)
                currentlyEditedBuffKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable)
                currentlyEditedCooldownKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable)
                currentlyEditedSynergyKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable)
                refreshAllDebuffTrackerInfo()
                refreshAllBuffTrackerInfo()
                refreshAllCooldownTrackerInfo()
                refreshAllSynergyTrackerInfo()
                HTT_functions.recreateControls()
                HTT_functions.ProcessAnchors()
                HTT_functions.reanchorReticle() 
                HTT_functions.reanchorBuffs()
                HTT_functions.reanchorBoss()
                HTT_functions.reanchorCooldowns()
                HTT_functions.reanchorSynergies()
                rescaleDebuffs()
                rescaleBuffs()
                rescaleBoss()
                rescaleCooldowns()
                rescaleSynergies()
                rescaleSpecial()
                HTT_events.nullifyRemainingTimes()
                local reflectiveControl = HTTReflect:GetNamedChild("reflectFill")
                reflectiveControl:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].reflectIndicatorColor))
                HTT_switchStraightUI(HTTsavedVars[HTT_variables.currentlySelectedProfile].isStraightResourceOn)
                end,
				width = "half",
                })

    table.insert(optionsTable, {
                type = "editbox",
                name = "Name of new profile:",
                getFunc = function() return createNewProfileSavedVariables["name"]  end,
                setFunc = function(text) createNewProfileSavedVariables["name"] = text end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)

                default = "",	--(optional)
            })

   table.insert(optionsTable, {
				type = "button",
				name = "Copy Selected Profile",
				func = function()  if createNewProfileSavedVariables["name"] ~= nil then
                    HTT_events.unregisterEvents()
                    HTT_functions.hideEverythingOnSwitch()
                    HTT_functions.createProfile(createNewProfileSavedVariables["name"])
                    SVCS["currentlySelectedProfile"] = createNewProfileSavedVariables["name"]
                    HTT_variables.currentlySelectedProfile = createNewProfileSavedVariables["name"]
                    profileDropdown.data.choices =  HTT_functions.removeEmptySpacesInTable(HTTsavedVars["availableProfiles"]) or {"No profiles"}
                    profileDropdown:UpdateChoices()
                    currentlyEditedDebuffKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable)
                    currentlyEditedBuffKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable)
                    currentlyEditedCooldownKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable)
                    currentlyEditedSynergyKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable)
                    refreshAllDebuffTrackerInfo()
                    refreshAllBuffTrackerInfo()
                    refreshAllCooldownTrackerInfo()
                    refreshAllSynergyTrackerInfo()
                    HTT_functions.recreateControls()
                    HTT_functions.ProcessAnchors()
                    HTT_functions.reanchorReticle() 
                    HTT_functions.reanchorBuffs()
                    HTT_functions.reanchorBoss()
                    HTT_functions.reanchorCooldowns()
                    HTT_functions.reanchorSynergies()

                    rescaleDebuffs()
                    rescaleBuffs()
                    rescaleBoss()
                    rescaleCooldowns()
                    rescaleSynergies()
                    rescaleSpecial()
                    HTT_events.nullifyRemainingTimes()
                    HTT_events.generateEvents()
                    local reflectiveControl = HTTReflect:GetNamedChild("reflectFill")
                    reflectiveControl:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].reflectIndicatorColor))
                    HTT_switchStraightUI(HTTsavedVars[HTT_variables.currentlySelectedProfile].isStraightResourceOn)
                end
                end,
				width = "half",
                })

    table.insert(optionsTable, {
				type = "button",
				name = "Create New Empty Profile",
				func = function()  if createNewProfileSavedVariables["name"] ~= nil then
                    HTT_events.unregisterEvents()
                    HTT_functions.hideEverythingOnSwitch()
                    HTT_functions.createEmptyProfile(createNewProfileSavedVariables["name"])
                    SVCS["currentlySelectedProfile"] = createNewProfileSavedVariables["name"]
                    HTT_variables.currentlySelectedProfile = createNewProfileSavedVariables["name"]
                    profileDropdown.data.choices =  HTT_functions.removeEmptySpacesInTable(HTTsavedVars["availableProfiles"]) or {"No profiles"}
                    profileDropdown:UpdateChoices()
                    currentlyEditedDebuffKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable)
                    currentlyEditedBuffKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable)
                    currentlyEditedCooldownKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable)
                    currentlyEditedSynergyKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable)
                    refreshAllDebuffTrackerInfo()
                    refreshAllBuffTrackerInfo()
                    refreshAllCooldownTrackerInfo()
                    refreshAllSynergyTrackerInfo()
                    
                    HTT_functions.recreateControls()
                    HTT_functions.ProcessAnchors()
                    HTT_functions.reanchorReticle() 
                    HTT_functions.reanchorBuffs()
                    HTT_functions.reanchorBoss()
                    HTT_functions.reanchorCooldowns()
                    HTT_functions.reanchorSynergies()

                    rescaleDebuffs()
                    rescaleBuffs()
                    rescaleBoss()
                    rescaleCooldowns()
                    rescaleSynergies()
                    rescaleSpecial()
                    HTT_events.nullifyRemainingTimes()
                    HTT_events.generateEvents()
                    local reflectiveControl = HTTReflect:GetNamedChild("reflectFill")
                    reflectiveControl:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].reflectIndicatorColor))
                    HTT_switchStraightUI(HTTsavedVars[HTT_variables.currentlySelectedProfile].isStraightResourceOn)
                end
                end,
				width = "half",
                })
                

    table.insert(optionsTable, {
        type = "submenu",
        name = "General Settings",
        tooltip = "Turning on/off entire modules of this addon",	--(optional)
        controls = {
            [1] = {
                type = "checkbox",
                name = "Block UI",
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].isBlockUIOn end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].isBlockUIOn = value end,
                width = "half",	--or "half" (optional)
                tooltip = "Turns ON/OFF the shield icon that indicates whether you're blocking and shows current block cost and block mitigation",
            },
            [2] = {
                type = "checkbox",
                name = "Block Cost UI",
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].isBlockCostOn end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].isBlockCostOn = value end,
                width = "half",	--or "half" (optional)
                tooltip = "Turns ON/OFF the block cost and block mitigation number next to shield icon",
            },
            [3] = {
                type = "checkbox",
                name = "Debuff UI on current target",
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].isDebuffUIOn end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].isDebuffUIOn = value end,
                width = "half",	--or "half" (optional)
                tooltip = "Turns ON/OFF the window with debuffs on your current target",
            },
            [4] = {
                type = "checkbox",
                name = "Buff UI",
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].isBuffUIOn end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].isBuffUIOn = value end,
                width = "half",	--or "half" (optional)
                tooltip = "Turns ON/OFF the windows with your buffs"
            },
            [5] = {
                type = "checkbox",
                name = "Debuff UI on bosses",
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].isBossDebuffUIOn end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].isBossDebuffUIOn = value end,
                width = "half",	--or "half" (optional)
                tooltip = "Turns ON/OFF the window with debuffs on bosses",
            },



            [6] = {
                type = "checkbox",
                name = "Cooldown UI",
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].isCooldownUIOn end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].isCooldownUIOn = value end,
                width = "half",	--or "half" (optional)
                tooltip = "Turns ON/OFF the window with cooldowns",
            },
			[7] = {
                type = "checkbox",
                name = "Synergy UI",
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].isSynergiesUIOn end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].isSynergiesUIOn = value end,
                width = "half",	--or "half" (optional)
                tooltip = "Turns ON/OFF the window with synergies",
            },
            [8] = {
                type = "checkbox",
                name = "Auto Adjustments",
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].isAutoCooldownTurnedOn end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].isAutoCooldownTurnedOn = value end,
                width = "half",	--or "half" (optional)
                tooltip = "Automatically turns ON/OFF trackers if you added conditions in tracker's settings (like skills and item sets)",	--(optional)
            },

            [9] = {
                type = "checkbox",
                name = "(BETA) Attack Pattern UI visibility",
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].isAlertUIOn end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].isAlertUIOn = value end,
                width = "half",	--or "half" (optional)
                tooltip = "Turns ON/OFF the window with cooldowns of enemy's mechanics (currently only works on Arkasis)",
            },
            [10] = {
                type = "checkbox",
                name = "Custom Stonefist Icon",
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].isStoneFistCustomIconOn end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].isStoneFistCustomIconOn = value end,
                width = "half",	--or "half" (optional)
                tooltip = "Turns ON/OFF custom Stonefist icon (stomp)",
                warning = "Will need to reload UI"
            },
            [11] = {
                type = "checkbox",
                name = "Defensive Stance Reflect Indicator",
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].isReflectIndicatorOn end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].isReflectIndicatorOn = value 
                local control1 = HTTReflect:GetNamedChild("reflect")
                local control2 = HTTReflect:GetNamedChild("reflectFill")
                control1:SetHidden(not value)
                control2:SetHidden(not value)
                end,
                width = "half",	--or "half" (optional)
                tooltip = "Turns ON/OFF defensive stance reflect indicator above your reticle",
            },
            [12] = {
                type = "colorpicker",
                name = "Defensive Stance Reflect Color",
                getFunc = function() return unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].reflectIndicatorColor) end,	--(alpha is optional)
                setFunc = function(r,g,b,a) 
                HTTsavedVars[HTT_variables.currentlySelectedProfile].reflectIndicatorColor[1] = r 
                HTTsavedVars[HTT_variables.currentlySelectedProfile].reflectIndicatorColor[2] = g
                HTTsavedVars[HTT_variables.currentlySelectedProfile].reflectIndicatorColor[3] = b
                HTTsavedVars[HTT_variables.currentlySelectedProfile].reflectIndicatorColor[4] = a
                local control = HTTReflect:GetNamedChild("reflectFill")
                control:SetColor(r,g,b,a)
                end,	--(alpha is optional)
                width = "half",	--or "half" (optional)
            },
            [13] = {
                type = "iconpicker",
                name = "Shield Texture Icon",
                choices = shieldChoices,
                iconSize = 128,
                maxColumns = 3,
                visibleRows = 2,
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].customShield end,
                setFunc = function(var) HTTsavedVars[HTT_variables.currentlySelectedProfile].customShield = var
                shieldIcon = HTTBlock:GetNamedChild("Block")
                shieldIcon:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].customShield)
                end,
                width = "half",	--or "half" (optional)
            },
            [14] = {
                type = "slider",
                name = "Shield Texture Height",
                --tooltip = "Slider's tooltip text.",
                min = 1,
                max = 500,
                step = 1,	--(optional)
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].shieldTextureHeight end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].shieldTextureHeight = value 
                shieldIcon = HTTBlock:GetNamedChild("Block")
                shieldBlockCost = HTTBlock:GetNamedChild("blockCost")
                shieldBlockMitigation = HTTBlock:GetNamedChild("blockMitigation")
                shieldIcon:SetDimensions(HTTsavedVars[HTT_variables.currentlySelectedProfile].shieldTextureWidth,HTTsavedVars[HTT_variables.currentlySelectedProfile].shieldTextureHeight)
                shieldBlockCost:SetAnchor(BOTTOMLEFT, block, BOTTOMLEFT,HTTsavedVars[HTT_variables.currentlySelectedProfile].shieldTextureWidth,-20)
                shieldBlockMitigation:SetAnchor(BOTTOMLEFT, block, BOTTOMLEFT,HTTsavedVars[HTT_variables.currentlySelectedProfile].shieldTextureWidth,15)
                end,
                width = "half",	--or "half" (optional)

            },
            [15] = {
                type = "slider",
                name = "Shield Texture Width",
                --tooltip = "Slider's tooltip text.",
                min = 1,
                max = 500,
                step = 1,	--(optional)
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].shieldTextureWidth end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].shieldTextureWidth = value 
                shieldIcon = HTTBlock:GetNamedChild("Block")
                shieldBlockCost = HTTBlock:GetNamedChild("blockCost")
                shieldBlockMitigation = HTTBlock:GetNamedChild("blockMitigation")
                shieldIcon:SetDimensions(HTTsavedVars[HTT_variables.currentlySelectedProfile].shieldTextureWidth,HTTsavedVars[HTT_variables.currentlySelectedProfile].shieldTextureHeight)
                shieldBlockCost:SetAnchor(BOTTOMLEFT, block, BOTTOMLEFT,HTTsavedVars[HTT_variables.currentlySelectedProfile].shieldTextureWidth,-20)
                shieldBlockMitigation:SetAnchor(BOTTOMLEFT, block, BOTTOMLEFT,HTTsavedVars[HTT_variables.currentlySelectedProfile].shieldTextureWidth,15)
                end,
                width = "half",	--or "half" (optional)

            },
            [16] = {
                type = "dropdown",
                name = "Bar Texture",
                choices = barChoices,
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].currentlySelectedBarTexture end,
                setFunc = function(var) HTTsavedVars[HTT_variables.currentlySelectedProfile].currentlySelectedBarTexture = string.gsub(string.gsub(var,"|t",""),"160:20:","")
                for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs) do
                    local bar = HTTSelfBuffs:GetNamedChild("SelfBuffDurationBar"..v)
                    bar:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].currentlySelectedBarTexture)
                end
                for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs) do
                    local bar = HTT:GetNamedChild("DurationBarReticle"..v)
                    bar:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].currentlySelectedBarTexture)
                    for i=1, MAX_BOSSES do
                        local bar = _G["HTTBoss"..i]:GetNamedChild("DurationBarBoss"..v..i)
                        bar:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].currentlySelectedBarTexture)
                    end
                end
                for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns) do
                    local bar = HTTCooldowns:GetNamedChild("CooldownsDurationBar"..v)
                    bar:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].currentlySelectedBarTexture)
                end
                for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfSynergies) do
                    local bar = HTTSynergies:GetNamedChild("SynergiesDurationBar"..v)
                    bar:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].currentlySelectedBarTexture)
                end
                for n=1, 4 do
                    local bar = HTTAlert:GetNamedChild("AlertsDurationBar"..n)
                    bar:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].currentlySelectedBarTexture)
                end
                end,
                width = "half",	--or "half" (optional)
            },

        },
    })
	local positionCounter = 10

	table.insert(optionsTable, {
        type = "submenu",
        name = "Scale, Background Colors and Fonts",
        tooltip = "Change dimensions, scale, colors of background windows and fonts. If text is blurry after scaling try using a different font",	--(optional)
        controls = {},
		})

	table.insert(optionsTable[positionCounter].controls, {

                type = "header",
                name = ZO_HIGHLIGHT_TEXT:Colorize("Class Special Tracker Window"),
                width = "full",	--or "half" (optional)     
			})

	table.insert(optionsTable[positionCounter].controls, {
                type = "colorpicker",
                name = "Background color",
                getFunc = function() return unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].specialBackgroundColor) end,	--(alpha is optional)
                setFunc = function(r,g,b,a) 
                HTTsavedVars[HTT_variables.currentlySelectedProfile].specialBackgroundColor[1] = r 
                HTTsavedVars[HTT_variables.currentlySelectedProfile].specialBackgroundColor[2] = g
                HTTsavedVars[HTT_variables.currentlySelectedProfile].specialBackgroundColor[3] = b
                HTTsavedVars[HTT_variables.currentlySelectedProfile].specialBackgroundColor[4] = a
                local control = HTTOwnStacks:GetNamedChild("StackCountBG")
                control:SetColor(r,g,b,a)
                end,	--(alpha is optional)
                width = "half",	--or "half" (optional)

            })

        table.insert(optionsTable[positionCounter].controls, {
                type = "slider",
                name = "Scale",
                --tooltip = "Slider's tooltip text.",
                min = 0.1,
                max = 3,
                step = 0.1,	--(optional)
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].specialUIScale end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].specialUIScale = value 
                rescaleSpecial()
                end,
                width = "half",	--or "half" (optional)

            })

		

		table.insert(optionsTable[positionCounter].controls, {
                type = "slider",
                name = "Width",
                --tooltip = "Slider's tooltip text.",
                min = 80,
                max = 800,
                step = 1,	--(optional)
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].specialUIWidth end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].specialUIWidth = value 
                rescaleSpecial()
                end,
                width = "half",	--or "half" (optional)

            })


            table.insert(optionsTable[positionCounter].controls, {
                type = "slider",
                name = "Height",
                --tooltip = "Slider's tooltip text.",
                min = 20,
                max = 200,
                step = 1,	--(optional)
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].specialUIHeight end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].specialUIHeight = value 
                rescaleSpecial()
                end,
                width = "half",	--or "half" (optional)

            })

            table.insert(optionsTable[positionCounter].controls, {
                type = "dropdown",
                name = "Select Font:",
                choices = {"ZoFontGameSmall","ZoFontCallout3"},
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont end,
                setFunc = function(var) HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont = var
                rescaleSpecial()
                end,
                width = "half",	--or "half" (optional)
            })



	table.insert(optionsTable[positionCounter].controls, {

                type = "header",
                name = ZO_HIGHLIGHT_TEXT:Colorize("Debuffs on current target Window"),
                width = "full",	--or "half" (optional)     
			})

	table.insert(optionsTable[positionCounter].controls, {
                type = "colorpicker",
                name = "Background color",
                getFunc = function() return unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].reticleBackgroundColor) end,	--(alpha is optional)
                setFunc = function(r,g,b,a) 
                HTTsavedVars[HTT_variables.currentlySelectedProfile].reticleBackgroundColor[1] = r 
                HTTsavedVars[HTT_variables.currentlySelectedProfile].reticleBackgroundColor[2] = g
                HTTsavedVars[HTT_variables.currentlySelectedProfile].reticleBackgroundColor[3] = b
                HTTsavedVars[HTT_variables.currentlySelectedProfile].reticleBackgroundColor[4] = a
                local control = HTT:GetNamedChild("BackgroundReticle")
                control:SetColor(r,g,b,a)
                end,	--(alpha is optional)
                width = "half",	--or "half" (optional)
                tooltip = "Sets background color for Debuff window",

            })


		table.insert(optionsTable[positionCounter].controls, {
                type = "slider",
                name = "Scale",
                --tooltip = "Slider's tooltip text.",
                min = 0.1,
                max = 3,
                step = 0.1,	--(optional)
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIScale end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIScale = value 
                rescaleDebuffs()
				HTT_functions.reanchorReticle()
                end,
                width = "half",	--or "half" (optional)

            })



        table.insert(optionsTable[positionCounter].controls, {
                type = "slider",
                name = "Width",
                --tooltip = "Slider's tooltip text.",
                min = 40,
                max = 400,
                step = 1,	--(optional)
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIWidth end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIWidth = value 
                rescaleDebuffs()
                HTT_functions.reanchorReticle()
                end,
                width = "half",	--or "half" (optional)

            })

        table.insert(optionsTable[positionCounter].controls, {
                type = "slider",
                name = "Height",
                --tooltip = "Slider's tooltip text.",
                min = 1,
                max = 40,
                step = 1,	--(optional)
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIHeight end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIHeight = value 
                rescaleDebuffs()
                HTT_functions.reanchorReticle()
                end,
                width = "half",	--or "half" (optional)

            })

    table.insert(optionsTable[positionCounter].controls, {
                type = "dropdown",
                name = "Select Font:",
                choices = {"ZoFontGameSmall","ZoFontCallout3"},
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffFont end,
                setFunc = function(var) HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffFont = var
                rescaleDebuffs()
                HTT_functions.reanchorReticle()
                end,
                width = "half",	--or "half" (optional)
            })

	table.insert(optionsTable[positionCounter].controls, {

                type = "header",
                name = ZO_HIGHLIGHT_TEXT:Colorize("Debuffs on bosses Window"),
                width = "full",	--or "half" (optional)     
			})

	table.insert(optionsTable[positionCounter].controls, {
                type = "colorpicker",
                name = "Background color",
                getFunc = function() return unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].bossBackgroundColor) end,	--(alpha is optional)
                setFunc = function(r,g,b,a) 
                HTTsavedVars[HTT_variables.currentlySelectedProfile].bossBackgroundColor[1] = r 
                HTTsavedVars[HTT_variables.currentlySelectedProfile].bossBackgroundColor[2] = g
                HTTsavedVars[HTT_variables.currentlySelectedProfile].bossBackgroundColor[3] = b
                HTTsavedVars[HTT_variables.currentlySelectedProfile].bossBackgroundColor[4] = a
                for i=1, 6 do
                    local control = _G["HTTBoss"..i]:GetNamedChild("BackgroundBoss"..i)
                    control:SetColor(r,g,b,a)
                end
                end,	--(alpha is optional)
                width = "half",	--or "half" (optional)
                tooltip = "Sets background color for Debuff window",

            })


		table.insert(optionsTable[positionCounter].controls, {
                type = "slider",
                name = "Scale",
                --tooltip = "Slider's tooltip text.",
                min = 0.1,
                max = 3,
                step = 0.1,	--(optional)
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffBossUIScale end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffBossUIScale = value 
                rescaleBoss()
				HTT_functions.reanchorBoss()
                end,
                width = "half",	--or "half" (optional)

            })



        table.insert(optionsTable[positionCounter].controls, {
                type = "slider",
                name = "Width",
                --tooltip = "Slider's tooltip text.",
                min = 40,
                max = 400,
                step = 1,	--(optional)
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffBossUIWidth end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffBossUIWidth = value 
                rescaleBoss()
                HTT_functions.reanchorBoss()
                end,
                width = "half",	--or "half" (optional)

            })

        table.insert(optionsTable[positionCounter].controls, {
                type = "slider",
                name = "Height",
                --tooltip = "Slider's tooltip text.",
                min = 1,
                max = 40,
                step = 1,	--(optional)
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffBossUIHeight end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffBossUIHeight = value 
                rescaleBoss()
                HTT_functions.reanchorBoss()
                end,
                width = "half",	--or "half" (optional)

            })

        table.insert(optionsTable[positionCounter].controls, {
                type = "dropdown",
                name = "Select Font:",
                choices = {"ZoFontGameSmall","ZoFontCallout3"},
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].bossFont end,
                setFunc = function(var) HTTsavedVars[HTT_variables.currentlySelectedProfile].bossFont = var
                rescaleBoss()
                HTT_functions.reanchorBoss()
                end,
                width = "half",	--or "half" (optional)
            })

	table.insert(optionsTable[positionCounter].controls, {

                type = "header",
                name = ZO_HIGHLIGHT_TEXT:Colorize("Buffs Window"),
                width = "full",	--or "half" (optional)     
			})

	table.insert(optionsTable[positionCounter].controls, {
                type = "colorpicker",
                name = "Background color",
                getFunc = function() return unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffBackgroundColor) end,	--(alpha is optional)
                setFunc = function(r,g,b,a) 
                HTTsavedVars[HTT_variables.currentlySelectedProfile].buffBackgroundColor[1] = r 
                HTTsavedVars[HTT_variables.currentlySelectedProfile].buffBackgroundColor[2] = g
                HTTsavedVars[HTT_variables.currentlySelectedProfile].buffBackgroundColor[3] = b
                HTTsavedVars[HTT_variables.currentlySelectedProfile].buffBackgroundColor[4] = a
                local control = HTTSelfBuffs:GetNamedChild("SelfBuffsBackground")
                control:SetColor(r,g,b,a)
                end,	--(alpha is optional)
                width = "half",	--or "half" (optional)

            })

            table.insert(optionsTable[positionCounter].controls, {
                type = "slider",
                name = "Scale",
                --tooltip = "Slider's tooltip text.",
                min = 0.1,
                max = 3,
                step = 0.1,	--(optional)
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].buffUIScale end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].buffUIScale = value 
                rescaleBuffs()
				HTT_functions.reanchorBuffs()
                end,
                width = "half",	--or "half" (optional)

            })



        table.insert(optionsTable[positionCounter].controls, {
                type = "slider",
                name = "Width",
                --tooltip = "Slider's tooltip text.",
                min = 40,
                max = 400,
                step = 1,	--(optional)
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].buffUIWidth end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].buffUIWidth = value 
                rescaleBuffs()
                HTT_functions.reanchorBuffs()
                end,
                width = "half",	--or "half" (optional)

            })

        table.insert(optionsTable[positionCounter].controls, {
                type = "slider",
                name = "Height",
                --tooltip = "Slider's tooltip text.",
                min = 1,
                max = 40,
                step = 1,	--(optional)
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].buffUIHeight end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].buffUIHeight = value 
                rescaleBuffs()
                HTT_functions.reanchorBuffs()
                end,
                width = "half",	--or "half" (optional)

            })

        table.insert(optionsTable[positionCounter].controls, {
                type = "dropdown",
                name = "Select Font:",
                choices = {"ZoFontGameSmall","ZoFontCallout3"},
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].buffFont end,
                setFunc = function(var) HTTsavedVars[HTT_variables.currentlySelectedProfile].buffFont = var
                rescaleBuffs()
                HTT_functions.reanchorBuffs()
                end,
                width = "half",	--or "half" (optional)
            })




	table.insert(optionsTable[positionCounter].controls, {

                type = "header",
                name = ZO_HIGHLIGHT_TEXT:Colorize("Cooldowns Window"),
                width = "full",	--or "half" (optional)     
			})




	 table.insert(optionsTable[positionCounter].controls, {
                type = "colorpicker",
                name = "Background color",
                getFunc = function() return unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownBackgroundColor) end,	--(alpha is optional)
                setFunc = function(r,g,b,a) 
                HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownBackgroundColor[1] = r 
                HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownBackgroundColor[2] = g
                HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownBackgroundColor[3] = b
                HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownBackgroundColor[4] = a
                local control = HTTCooldowns:GetNamedChild("CooldownsBackground")
                control:SetColor(r,g,b,a)
                end,	--(alpha is optional)
                width = "half",	--or "half" (optional)

            })

	table.insert(optionsTable[positionCounter].controls, {
                type = "slider",
                name = "Scale",
                --tooltip = "Slider's tooltip text.",
                min = 0.1,
                max = 3,
                step = 0.1,	--(optional)
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownUIScale end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownUIScale = value 
				rescaleCooldowns()
				HTT_functions.reanchorCooldowns()
                end,
                width = "half",	--or "half" (optional)

            })



        table.insert(optionsTable[positionCounter].controls, {
                type = "slider",
                name = "Width",
                --tooltip = "Slider's tooltip text.",
                min = 40,
                max = 400,
                step = 1,	--(optional)
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownUIWidth end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownUIWidth = value 
                rescaleCooldowns()
                HTT_functions.reanchorCooldowns()
                end,
                width = "half",	--or "half" (optional)

            })

        table.insert(optionsTable[positionCounter].controls, {
                type = "slider",
                name = "Height",
                --tooltip = "Slider's tooltip text.",
                min = 1,
                max = 40,
                step = 1,	--(optional)
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownUIHeight end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownUIHeight = value 
                rescaleCooldowns()
                HTT_functions.reanchorCooldowns()
                end,
                width = "half",	--or "half" (optional)

            })

        table.insert(optionsTable[positionCounter].controls, {
                type = "dropdown",
                name = "Select Font:",
                choices = {"ZoFontGameSmall","ZoFontCallout3"},
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownFont end,
                setFunc = function(var) HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownFont = var
                rescaleCooldowns()
                HTT_functions.reanchorCooldowns()
                end,
                width = "half",	--or "half" (optional)
            })

	table.insert(optionsTable[positionCounter].controls, {

                type = "header",
                name = ZO_HIGHLIGHT_TEXT:Colorize("Synergies Window"),
                width = "full",	--or "half" (optional)     
			})




	 table.insert(optionsTable[positionCounter].controls, {
                type = "colorpicker",
                name = "Background color",
                getFunc = function() return unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesBackgroundColor) end,	--(alpha is optional)
                setFunc = function(r,g,b,a) 
                HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesBackgroundColor[1] = r 
                HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesBackgroundColor[2] = g
                HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesBackgroundColor[3] = b
                HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesBackgroundColor[4] = a
                local control = HTTSynergies:GetNamedChild("SynergiesBackground")
                control:SetColor(r,g,b,a)
                end,	--(alpha is optional)
                width = "half",	--or "half" (optional)

            })

	table.insert(optionsTable[positionCounter].controls, {
                type = "slider",
                name = "Scale",
                --tooltip = "Slider's tooltip text.",
                min = 0.1,
                max = 3,
                step = 0.1,	--(optional)
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesUIScale end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesUIScale = value 
                rescaleSynergies()
				HTT_functions.reanchorSynergies()
                end,
                width = "half",	--or "half" (optional)

            })



        table.insert(optionsTable[positionCounter].controls, {
                type = "slider",
                name = "Width",
                --tooltip = "Slider's tooltip text.",
                min = 40,
                max = 400,
                step = 1,	--(optional)
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesUIWidth end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesUIWidth = value 
                rescaleSynergies()
                HTT_functions.reanchorSynergies()
                end,
                width = "half",	--or "half" (optional)

            })

        table.insert(optionsTable[positionCounter].controls, {
                type = "slider",
                name = "Height",
                --tooltip = "Slider's tooltip text.",
                min = 1,
                max = 40,
                step = 1,	--(optional)
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesUIHeight end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesUIHeight = value 
                rescaleSynergies()
                HTT_functions.reanchorSynergies()
                end,
                width = "half",	--or "half" (optional)

            })


        table.insert(optionsTable[positionCounter].controls, {
                type = "dropdown",
                name = "Select Font:",
                choices = {"ZoFontGameSmall","ZoFontCallout3"},
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont end,
                setFunc = function(var) HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont = var
                rescaleSynergies()
                HTT_functions.reanchorSynergies()
                end,
                width = "half",	--or "half" (optional)
            })


    positionCounter = positionCounter+1

         table.insert(optionsTable, {
        type = "submenu",
        name = "Custom Resource UI",
        tooltip = "Settings of custom resource UI",	--(optional)
        controls = {

        },
    })


    table.insert(optionsTable[positionCounter].controls, {

                type = "checkbox",
                name = "Custom  Curved Resource UI",
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].isAltResourceUIOn end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].isAltResourceUIOn = value end,
                width = "half",	--or "half" (optional)
                tooltip = "Turns ON/OFF visibility of custom curved resource UI",
            })
    table.insert(optionsTable[positionCounter].controls, {

                type = "checkbox",
                name = "Custom Straight Resource UI",
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].isStraightResourceOn end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].isStraightResourceOn = value 
                HTT_switchStraightUI(value)
                end,
                width = "half",	--or "half" (optional)
                tooltip = "Turns ON/OFF visibility of custom straight resource UI",
            })
    table.insert(optionsTable[positionCounter].controls, {

                type = "checkbox",
                name = "Unlock Custom Resource UI",
                getFunc = function() return HTT_variables.alternativeUIMovable end,
                setFunc = function(value) HTT_variables.alternativeUIMovable = value 
                    HTTHealth:SetMovable(value)
                    HTTStamina:SetMovable(value)
                    HTTMagicka:SetMovable(value)
                    HTTHealthStraight:SetMovable(value)
                    HTTStaminaStraight:SetMovable(value)
                    HTTMagickaStraight:SetMovable(value)
                end,
                width = "half",	--or "half" (optional)
                tooltip = "Allows you to move custom resource UI around",
            })
    table.insert(optionsTable[positionCounter].controls, {

                type = "checkbox",
                name = "Base Game UI",
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].isBaseGameUIOn end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].isBaseGameUIOn = value 
                    HTT_functions.UpdateBaseGameUI(HTTsavedVars[HTT_variables.currentlySelectedProfile].isBaseGameUIOn)
                end,
                width = "half",	--or "half" (optional)
                tooltip = "Turns ON/OFF visibility of base game UI",
            })


    positionCounter = positionCounter + 1

		 table.insert(optionsTable, {
        type = "submenu",
        name = "Class Special Tracker",
        tooltip = "Settings of class special tracker (Stonefist for DK, Shimmering Shield for Warden and Empower for Necro)",	--(optional)
        controls = {

        },
    })

   

    table.insert(optionsTable[positionCounter].controls, {

                type = "checkbox",
                name = "Turned on",
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].classSpecialIsOn end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].classSpecialIsOn = value end,
                width = "half",	--or "half" (optional)

            })
    table.insert(optionsTable[positionCounter].controls, {
                type = "colorpicker",
                name = "Bar color",
                getFunc = function() return unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].classSpecialColor) end,
                setFunc = function(r,g,b,a) 
                HTTsavedVars[HTT_variables.currentlySelectedProfile].classSpecialColor[1] = r 
                HTTsavedVars[HTT_variables.currentlySelectedProfile].classSpecialColor[2] = g
                HTTsavedVars[HTT_variables.currentlySelectedProfile].classSpecialColor[3] = b
                HTTsavedVars[HTT_variables.currentlySelectedProfile].classSpecialColor[4] = a
                if GetUnitClassId("player") == 1 or GetUnitClassId("player") == 4 then
                    local durationBar = HTTOwnStacks:GetNamedChild("StackTimerBar")
                    durationBar:SetColor(r,g,b,a)
                elseif GetUnitClassId("player") == 5 then
                    for i=1,12 do
                        local durationBar = HTTOwnStacks:GetNamedChild("EmpowerBar"..i)
                        durationBar:SetColor(r,g,b,a)
                    end
                end
                end,	--(alpha is optional)
                width = "half",	--or "half" (optional)

            })

        










			 table.insert(optionsTable, {
        type = "submenu",
        name = "Debuffs",
        tooltip = "Settings of debuff tracking",	--(optional)
        controls = {

        },
    })

    positionCounter = positionCounter +1 


          


    table.insert(optionsTable[positionCounter].controls, {

                type = "header",
                name = ZO_HIGHLIGHT_TEXT:Colorize("Order of Debuffs"),
                width = "full",	--or "half" (optional)     
			})


       

    

        table.insert(optionsTable[positionCounter].controls, {
        type = "description",
        title = "Current order of debuffs:",
        title = nil,	--(optional)
        text = generateDebuffOrderList(),
        width = "full",	--or "half" (optional)
        reference = "ListOfOrder"
    })
    currentlyEditedDebuffKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable)

    table.insert(optionsTable[positionCounter].controls, {
         type = "dropdown",
         name = "Debuffs to swap",
         choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable),
         getFunc = function() return holdDebuffSwapValue1 end,
         setFunc = function(var) holdDebuffSwapValue1 = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffNameToID[var] end,
         width = "half",	--or "half" (optional)
         reference = "debuffSwapDropdown1",
         disabled = checkIfNone(currentlyEditedDebuffKey),
    })

    table.insert(optionsTable[positionCounter].controls, {
         type = "dropdown",
         --name = "",
         choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable),
         getFunc = function() return holdDebuffSwapValue2 end,
         setFunc = function(var) holdDebuffSwapValue2 = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffNameToID[var] end,
         width = "half",	--or "half" (optional)
         reference = "debuffSwapDropdown2",
         disabled = checkIfNone(currentlyEditedDebuffKey),
    })

     table.insert(optionsTable[positionCounter].controls, {
        type = "button",
        name = "Swap Debuffs",
        func = function() 
        if holdDebuffSwapValue1~= nil and holdDebuffSwapValue2 ~= nil then
            HTT_functions.swapElementsInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs,holdDebuffSwapValue1,holdDebuffSwapValue2) 
            ListOfOrder.data.text = generateDebuffOrderList()
            ListOfOrder:UpdateValue()
            debuffSwapDropdown1.data.choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable)
            debuffSwapDropdown1:UpdateChoices()
            debuffSwapDropdown2.data.choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable)
            debuffSwapDropdown2:UpdateChoices()
            HTT_functions.reanchorReticle()
            HTT_functions.reanchorBoss()
        end
        end,
        width = "half",
        disabled = checkIfNone(currentlyEditedDebuffKey),
        reference = "swapDebuffsButton",

    })



   

        

       table.insert(optionsTable[positionCounter].controls, {
                    type = "header",
                    name = ZO_HIGHLIGHT_TEXT:Colorize(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].name.." (ID:"..currentlyEditedDebuffKey..")"),
                    width = "full",	--or "half" (optional)
					reference = "headerDebuff"
			    })

          table.insert(optionsTable[positionCounter].controls, {
                         type = "dropdown",
                         name = "Pick Tracker to edit",
                         choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable),
                         getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].name or "none" end,
                         setFunc = function(var) currentlyEditedDebuffKey = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffNameToID[var]
						 headerDebuff.data.name = ZO_HIGHLIGHT_TEXT:Colorize(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].name.." (ID:"..currentlyEditedDebuffKey..")")
						 headerDebuff:UpdateValue()
                         IDdropdownDebuff.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].IDs  or {"No IDs"}
                        IDdropdownDebuff:UpdateChoices()
                        SkillDebuffdropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].skill  or {"No skills"}
                        SkillDebuffdropdown:UpdateChoices()
                        ItemSetDebuffdropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].itemSet[1] or {"No item sets"}
                        ItemSetDebuffdropdown:UpdateChoices()
                        if type(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].itemSet) ~= "table" then
                            HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].itemSet = {}
                        end
                        colorPicker2Debuff.data.disabled = ShowColor2(currentlyEditedDebuffKey)
                        colorPicker3Debuff.data.disabled = ShowColor3(currentlyEditedDebuffKey)
						end,
                        width = "half",	--or "half" (optional)
                        reference = "pickDropdownDebuff",
                        disabled = checkIfNone(currentlyEditedDebuffKey),
                    })



                table.insert(optionsTable[positionCounter].controls, {
                type = "iconpicker",
                name = "Icon",
                choices = HTT_TextureList,
                iconSize = 32,
                maxColumns = 10,
                visibleRows = 9,
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].icon end,
                setFunc = function(var) HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].itemSet.icon = var
                local icon = HTT:GetNamedChild("IconReticle"..currentlyEditedDebuffKey)
                icon:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].icon)
                for i=1, MAX_BOSSES do
                    local icon = _G["HTTBoss"..i]:GetNamedChild("IconBoss"..currentlyEditedDebuffKey..i)
                    icon:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].icon)
                end
                ListOfOrder.data.text = generateDebuffOrderList()
                ListOfOrder:UpdateValue()
                end,
                width = "half",	--or "half" (optional)
                reference = "iconpickerDebuff",
                disabled = checkIfNone(currentlyEditedDebuffKey),
            })


		
				table.insert(optionsTable[positionCounter].controls, {
                    type = "checkbox",
                    name =  "Tracking on current target",
                    getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].turnedOn end,
                    setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].turnedOn = value 
                    HTT_functions.reanchorReticle()
                    end,
                    width = "full",	--or "half" (optional)
                    disabled = checkIfNone(currentlyEditedDebuffKey),
                    reference = "debuffTrackingOnCurrentTargetCheckbox",
                })
                table.insert(optionsTable[positionCounter].controls, {
                    type = "checkbox",
                    name =  "Tracking on bosses",
                    getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].turnedOnBoss end,
                    setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].turnedOnBoss = value 
                    HTT_functions.reanchorBoss()
                    end,
                    width = "full",	--or "half" (optional)
                    disabled = checkIfNone(currentlyEditedDebuffKey),
                    reference = "debuffTrackingOnBossCheckbox"
                })
				table.insert(optionsTable[positionCounter].controls, {
                    type = "colorpicker",
                    name = "Bar color",
                    getFunc = function() 
                        return unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].color or {0,0,0,0})

                    end,	
                    setFunc = function(r,g,b,a) 
                    HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].color[1] = r 
                    HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].color[2] = g
                    HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].color[3] = b
                    HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].color[4] = a
                    local durationBar = HTT:GetNamedChild("DurationBarReticle"..currentlyEditedDebuffKey)
                    durationBar:SetColor(r,g,b,a)
                    end,	--(alpha is optional)
                    width = "full",	--or "half" (optional)
                    disabled = checkIfNone(currentlyEditedDebuffKey),
                    reference = "colorPicker1Debuff"
                })

                	


                table.insert(optionsTable[positionCounter].controls, {
                    type = "colorpicker",
                    name = "Bar color #2",
                    getFunc = function() 
                        
                       if type(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].color2) == "table"  then
                            return unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].color2)
                           
                       else
                            return 0,0,0,0
                        end
                    end,	
                    setFunc = function(r,g,b,a) 
                    HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].color2 = {
                    [1] = r,
                    [2] = g,
                    [3] = b,
                    [4] = a
                    }

                    end,	--(alpha is optional)
                    width = "full",	--or "half" (optional)
                    disabled = ShowColor2(currentlyEditedDebuffKey),
                    reference = "colorPicker2Debuff",
                })
                
                table.insert(optionsTable[positionCounter].controls, {
                    type = "colorpicker",
                    name = "Bar color #3",
                    getFunc = function() 
                        
                       if type(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].color3) == "table"  then
                            return unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].color3)
                           
                       else
                            return 0,0,0,0
                        end
                    end,	
                    setFunc = function(r,g,b,a) 
                    HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].color3 = {
                    [1] = r,
                    [2] = g,
                    [3] = b,
                    [4] = a
                    }

                    end,	--(alpha is optional)
                    width = "full",	--or "half" (optional)
                    reference = "colorPicker3Debuff",
                    disabled = ShowColor3(currentlyEditedDebuffKey),
                })
				--if not HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["isPreMade"][v] then
					

					

                    table.insert(optionsTable[positionCounter].controls, {
                         type = "dropdown",
                         name = "List of tracked IDs",
                         choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].IDs  or {"No IDs"},
                         getFunc = function() return holdRemoveDebuffID end,
                         setFunc = function(var) holdRemoveDebuffID = var end,
                         width = "half",	--or "half" (optional)
                         reference = "IDdropdownDebuff",
                         disabled = checkIfNone(currentlyEditedDebuffKey),
                    })

                    table.insert(optionsTable[positionCounter].controls, {
				type = "button",
				name = "Delete ID",
				func = function() 
                    if holdRemoveDebuffID ~= nil then
                        table.remove(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].IDs,HTT_functions.findPositionOfElementInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].IDs,holdRemoveDebuffID))
                        IDdropdownDebuff.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].IDs
                        IDdropdownDebuff:UpdateChoices()
                        EVENT_MANAGER:UnregisterForEvent("HTT"..holdRemoveDebuffID,EVENT_EFFECT_CHANGED)
                    end
                end,
				width = "half",
                disabled = checkIfNone(currentlyEditedDebuffKey),
                reference = "debuffDeleteIDButton",
			})

				table.insert(optionsTable[positionCounter].controls, {
                type = "editbox",
                name = "Add new ID",
                getFunc = function() return addNewIDToExistingDebuff end,
                setFunc = function(text) addNewIDToExistingDebuff = tonumber(text) end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)
                reference = "debuffAddNewIDEditbox",
                default = "",	--(optional)
                disabled = checkIfNone(currentlyEditedDebuffKey),
				})

				table.insert(optionsTable[positionCounter].controls, {
				type = "button",
				name = "Add ID",
				func = function() if addNewIDToExistingDebuff ~= nil then
                    HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].IDs[#HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].IDs+1] = addNewIDToExistingDebuff 
                    IDdropdownDebuff.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].IDs
                    IDdropdownDebuff:UpdateChoices()
                    HTT_functions.initializeEventsDebuffs(addNewIDToExistingDebuff,currentlyEditedDebuffKey)
                end
                end,
				width = "half",
                disabled = checkIfNone(currentlyEditedDebuffKey),
                reference = "debuffAddIDButton",
			})

            table.insert(optionsTable[positionCounter].controls, {
                type = "editbox",
                name = "Text displayed when effect is active",
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].text end,
                setFunc = function(text) HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].text = text 
				end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)
                disabled = checkIfNone(currentlyEditedDebuffKey),
                reference = "debuffTextEditbox",
                default = "",	--(optional)
            })
            table.insert(optionsTable[positionCounter].controls, {
                type = "editbox",
                name = "Text displayed when effect is missing",
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].textWhenMissing end,
                setFunc = function(text) HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].textWhenMissing = text 
				end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)
                disabled = checkIfNone(currentlyEditedDebuffKey),
                reference = "debuffTextWhenMissingEditbox",
                default = "",	--(optional)
            })
           table.insert(optionsTable[positionCounter].controls, {
                         type = "dropdown",
                         name = "List of tracked item sets",
                         choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].itemSet[1] or {"No item sets"},
                         getFunc = function() return holdRemoveDebuffItemSet end,
                         setFunc = function(var) holdRemoveDebuffItemSet = var end,
                         width = "half",	--or "half" (optional)
                         reference = "ItemSetDebuffdropdown",
                         disabled = checkIfNone(currentlyEditedDebuffKey),
                         tooltip = "If you want the tracker to automatically turn on/off based on if you have certain item set equipped, add the item set to this dropdown using the Add new item set checkbox(right click on any item from item set you want,choose Link in Chat and paste the item link here). Tracker will turn on if ANY of the added item sets is equipped",
                    })

                    table.insert(optionsTable[positionCounter].controls, {
				type = "button",
				name = "Delete Item Set",
				func = function() if holdRemoveDebuffItemSet ~= nil then
                        table.remove(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].itemSet[1],HTT_functions.findPositionOfElementInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].itemSet[1],holdRemoveDebuffItemSet))
                        ItemSetDebuffdropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].itemSet[1] or {"No item sets"}
                        ItemSetDebuffdropdown:UpdateChoices()
                    end
                end,
				width = "half",
                disabled = checkIfNone(currentlyEditedDebuffKey),
                reference = "debuffDeleteItemSetButton",
			})

				table.insert(optionsTable[positionCounter].controls, {
                type = "editbox",
                name = "Add new Item Set",
                getFunc = function() return addNewItemSetsToExistingItemSetsDebuff end,
                setFunc = function(text) addNewItemSetsToExistingItemSetsDebuff = text end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)
                disabled = checkIfNone(currentlyEditedDebuffKey),
                default = "",	--(optional)
                reference = "debuffAddNewItemSetEditbox",
				})

				table.insert(optionsTable[positionCounter].controls, {
				type = "button",
				name = "Add Item Set",
				func = function() 
                    if addNewItemSetsToExistingItemSetsDebuff ~= nil then
                        if type(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].itemSet[1]) ~= "table" then
                            HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].itemSet[1] = {}
                        end
                        table.insert(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].itemSet[1],addNewItemSetsToExistingItemSetsDebuff)
                        ItemSetDebuffdropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].itemSet[1] or {"No item sets"}
                        ItemSetDebuffdropdown:UpdateChoices()
                    end
                    --editbox.container:SetHidden(true)
                end,
				width = "half",
                disabled = checkIfNone(currentlyEditedDebuffKey),
                reference = "debuffAddItemSetButton",
                })

            table.insert(optionsTable[positionCounter].controls, {
                type = "slider",
                name = "Required item set pieces",
                tooltip = "Choose number of pieces that have to be equipped in order to turn on the tracker. The addon doesn't check your backbar so for 5-piece item sets that you have one-barred, choose 3 so the tracker gets turned on even if you start combat on the other bar",
                min = 0,
                max = 5,
                step = 1,	--(optional)
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].itemSet[2] or 0 end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].itemSet[2] = value end,
               -- end,
                width = "full",	--or "half" (optional)
                default = 5,	--(optional)
                disabled = checkIfNone(currentlyEditedDebuffKey),
                reference = "debuffSlider",
            })




            table.insert(optionsTable[positionCounter].controls, {
                         type = "dropdown",
                         name = "List of tracked skills",
                         choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].skill  or {"No skills"},
                         getFunc = function() return holdRemoveDebuffSkill end,
                         setFunc = function(var) holdRemoveDebuffSkill = var end,
                         width = "half",	--or "half" (optional)
                         reference = "SkillDebuffdropdown",
                         disabled = checkIfNone(currentlyEditedDebuffKey),
                         tooltip = "If you want the tracker to automatically turn on/off based on if you have certain skill equipped on any bar, add the skill's slot ID (you can find Ability Viewer further down in the settings)  to this dropdown using the Add new skill checkbox. Tracker will turn on if ANY of the added abilities is slotted",
                    })
                    disabled = checkIfNone(currentlyEditedDebuffKey),
                    table.insert(optionsTable[positionCounter].controls, {
				type = "button",
				name = "Delete Skill",
				func = function() if holdRemoveDebuffSkill ~= nil then
                        table.remove(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].skill,HTT_functions.findPositionOfElementInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].skill,holdRemoveDebuffSkill))
                        SkillDebuffdropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].skill 
                        SkillDebuffdropdown:UpdateChoices()
                    end
                end,
				width = "half",
                disabled = checkIfNone(currentlyEditedDebuffKey),
                reference = "debuffDeleteSkillButton",
			})

				table.insert(optionsTable[positionCounter].controls, {
                type = "editbox",
                name = "Add new skill",
                getFunc = function() return addNewSkillToExistingSkills end,
                setFunc = function(text) addNewSkillToExistingSkills = tonumber(text) end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)
                disabled = checkIfNone(currentlyEditedDebuffKey),
                default = "",	--(optional)
                reference = "debuffAddNewSkillEditbox",
				})

				table.insert(optionsTable[positionCounter].controls, {
				type = "button",
				name = "Add Skill",
				func = function() 
                    if addNewSkillToExistingSkills ~= nil then
                        if type(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].skill) ~= "table" then
                            HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].skill = {}
                        end
                        table.insert(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].skill,addNewSkillToExistingSkills)
                        SkillDebuffdropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].skill
                        SkillDebuffdropdown:UpdateChoices()
                    end
                    --colorPicker2Debuff.container:SetHidden(true)
                end,
				width = "half",
                disabled = checkIfNone(currentlyEditedDebuffKey),
                reference = "debuffAddSkillButton",
			})




				
					table.insert(optionsTable[positionCounter].controls, {
					type = "button",
					name = "Delete Tracker",
					func = function() 
                    for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[currentlyEditedDebuffKey].IDs) do
                        EVENT_MANAGER:UnregisterForEvent("HTT"..v,EVENT_EFFECT_CHANGED)
                    end
                    local textInBar = HTT:GetNamedChild("TextInBarReticle"..currentlyEditedDebuffKey)
				    local durationTimer = HTT:GetNamedChild("DurationTimerReticle"..currentlyEditedDebuffKey)
				    local durationBar = HTT:GetNamedChild("DurationBarReticle"..currentlyEditedDebuffKey)
				    local icon = HTT:GetNamedChild("IconReticle"..currentlyEditedDebuffKey)
                    durationTimer:SetHidden(true)
					durationBar:SetHidden(true)
					icon:SetHidden(true)
					textInBar:SetHidden(true)
                    for i=1, MAX_BOSSES do
                        local textInBar = _G["HTTBoss"..i]:GetNamedChild("TextInBarBoss"..currentlyEditedDebuffKey..i)
					    local durationTimer = _G["HTTBoss"..i]:GetNamedChild("DurationTimerBoss"..currentlyEditedDebuffKey..i)
					    local durationBar = _G["HTTBoss"..i]:GetNamedChild("DurationBarBoss"..currentlyEditedDebuffKey..i)
					    local icon = _G["HTTBoss"..i]:GetNamedChild("IconBoss"..currentlyEditedDebuffKey..i)
                        durationTimer:SetHidden(true)
					    durationBar:SetHidden(true)
					    icon:SetHidden(true)
					    textInBar:SetHidden(true)
                    end

                    HTT_functions.removeDebuff(currentlyEditedDebuffKey) 
                    HTT_functions.reanchorReticle()
                    HTT_functions.reanchorBoss()
                    currentlyEditedDebuffKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable)
                    refreshAllDebuffTrackerInfo()
					end,
					width = "half",
                    disabled = checkIfNone(currentlyEditedDebuffKey),
                    reference = "debuffDeleteTrackerButton",
					--warning = "Will reload the UI.",
				
				})
				--end
    table.insert(optionsTable[positionCounter].controls, {
        type = "submenu",
        name = "Add new debuff tracker",
        controls = {
			[1] = {
                type = "editbox",
                name = "Name of the tracker",
                getFunc = function() return createNewDebuffSavedVariables["name"]  end,
                setFunc = function(text) createNewDebuffSavedVariables["name"] = text end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)

                default = "",	--(optional)
            },
			[2] = {
                type = "editbox",
                name = "ID of tracked debuff",
                getFunc = function() return createNewDebuffSavedVariables["ID"] end,
                setFunc = function(text) createNewDebuffSavedVariables["ID"] = tonumber(text) end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)

                default = "",	--(optional)
            },
			[3] = {
                type = "editbox",
                name = "Text to display on the bar",
                getFunc = function() return createNewDebuffSavedVariables["text"] end,
                setFunc = function(text) createNewDebuffSavedVariables["text"] = text end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)

                default = "",	--(optional)
            },
			[4] = {
                type = "editbox",
                name = "Text to display when missing",
                getFunc = function() return createNewDebuffSavedVariables["textWhenMissing"] end,
                setFunc = function(text) createNewDebuffSavedVariables["textWhenMissing"] = text end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)

                default = "",	--(optional)
            },
			[5] = {
                type = "colorpicker",
                name = "My Color Picker",

                getFunc = function() return createNewDebuffSavedVariables["color"][1], createNewDebuffSavedVariables["color"][2], createNewDebuffSavedVariables["color"][3], createNewDebuffSavedVariables["color"][4] end,	--(alpha is optional)
                setFunc = function(r,g,b,a) createNewDebuffSavedVariables["color"][1] = r
				createNewDebuffSavedVariables["color"][2] = g
				createNewDebuffSavedVariables["color"][3] = b
				createNewDebuffSavedVariables["color"][4] = a
				end,	--(alpha is optional)
                width = "half",	--or "half" (optional)

            },
            [6] = {
                type = "checkbox",
                name = "Track debuffs only applied by you",

                getFunc = function() return createNewDebuffSavedVariables["onlyPlayer"] end,
                setFunc = function(value) createNewDebuffSavedVariables["onlyPlayer"]=value end,
                width = "half",	--or "half" (optional)

            },
            [7] = {
				type = "button",
				name = "Create Debuff Tracker",
				func = function() local freeSlot = HTT_functions.findFreeSlotInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable)
                HTT_functions.addDebuff(createNewDebuffSavedVariables["name"],{createNewDebuffSavedVariables["ID"]},freeSlot, createNewDebuffSavedVariables["text"],createNewDebuffSavedVariables["textWhenMissing"],createNewDebuffSavedVariables["color"],nil,nil,createNewDebuffSavedVariables["onlyPlayer"],{},{})  
				currentlyEditedDebuffKey = freeSlot
				refreshAllDebuffTrackerInfo()
				end,
				width = "half",

			},
            
        },
    })


	table.insert(optionsTable, {
        type = "submenu",
        name = "Buffs",
        tooltip = "Settings of buff tracking",	--(optional)
        controls = {

        },
    })

    positionCounter = positionCounter +1 

        



          



    table.insert(optionsTable[positionCounter].controls, {

                type = "header",
                name = ZO_HIGHLIGHT_TEXT:Colorize("Order of Buffs"),
                width = "full",	--or "half" (optional)     
			})


       

    

        table.insert(optionsTable[positionCounter].controls, {
        type = "description",
        title = "Current order of buffs:",
        title = nil,	--(optional)
        text = generateBuffOrderList(),
        width = "full",	--or "half" (optional)
        reference = "ListOfOrderBuffs"
    })

    currentlyEditedBuffKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable)


    table.insert(optionsTable[positionCounter].controls, {
         type = "dropdown",
         name = "Buffs to swap",
         choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable),
         getFunc = function() return holdBuffSwapValue1 end,
         setFunc = function(var) holdBuffSwapValue1 = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffNameToID[var] end,
         width = "half",	--or "half" (optional)
         reference = "buffSwapDropdown1",
         disabled = checkIfNone(currentlyEditedBuffKey),
    })

    table.insert(optionsTable[positionCounter].controls, {
         type = "dropdown",
         --name = "",
         choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable),
         getFunc = function() return holdBuffSwapValue2 end,
         setFunc = function(var) holdBuffSwapValue2 = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffNameToID[var] end,
         width = "half",	--or "half" (optional)
         reference = "buffSwapDropdown2",
         disabled = checkIfNone(currentlyEditedBuffKey),
    })

     table.insert(optionsTable[positionCounter].controls, {
        type = "button",
        name = "Swap Buffs",
        func = function() 
        if holdBuffSwapValue1~= nil and holdBuffSwapValue2 ~= nil then
            HTT_functions.swapElementsInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs,holdBuffSwapValue1,holdBuffSwapValue2) 
            ListOfOrderBuffs.data.text = generateBuffOrderList()
            ListOfOrderBuffs:UpdateValue()
            buffSwapDropdown1.data.choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable)
            buffSwapDropdown1:UpdateChoices()
            buffSwapDropdown2.data.choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable)
            buffSwapDropdown2:UpdateChoices()
            HTT_functions.reanchorBuffs()
        end
        end,
        width = "half",
        disabled = checkIfNone(currentlyEditedBuffKey),
        reference = "swapBuffsButton",

    })



   

        

       table.insert(optionsTable[positionCounter].controls, {
                    type = "header",
                    name = ZO_HIGHLIGHT_TEXT:Colorize(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].name.." (ID:"..currentlyEditedBuffKey..")"),
                    width = "full",	--or "half" (optional)
					reference = "headerBuff"
			    })

          table.insert(optionsTable[positionCounter].controls, {
                         type = "dropdown",
                         name = "Pick Tracker",
                         choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable)  or {"No trackers"},
                         getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].name end,
                         setFunc = function(var) currentlyEditedBuffKey = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffNameToID[var]
						 headerBuff.data.name = ZO_HIGHLIGHT_TEXT:Colorize(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].name.." (ID:"..currentlyEditedBuffKey..")")
						 headerBuff:UpdateValue()
                         IDdropdownBuff.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].IDs  or {"No IDs"}
                         IDdropdownBuff:UpdateChoices()
                         SkillBuffdropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].skill or {"No skills"}
                         SkillBuffdropdown:UpdateChoices()
                         ItemSetBuffdropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].itemSet[1] or {"No item sets"}
                         ItemSetBuffdropdown:UpdateChoices()
                         if type(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].itemSet) ~= "table" then
                             HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].itemSet = {}
                         end
						 end,
                         width = "half",	--or "half" (optional)
                         reference = "pickDropdownBuff",
                         disabled = checkIfNone(currentlyEditedBuffKey),
                    })


            table.insert(optionsTable[positionCounter].controls, {
                type = "iconpicker",
                name = "Icon",
                choices = HTT_TextureList,
                iconSize = 32,
                maxColumns = 10,
                visibleRows = 9,
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].icon end,
                setFunc = function(var) HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].icon = var
                local icon = HTTSelfBuffs:GetNamedChild("SelfBuffIcon"..currentlyEditedBuffKey)
                icon:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].icon)
                ListOfOrderBuffs.data.text = generateBuffOrderList()
                ListOfOrderBuffs:UpdateValue()
                end,
                width = "half",	--or "half" (optional)
                disabled = checkIfNone(currentlyEditedBuffKey),
                reference = "iconpickerBuff",
            })

		
				table.insert(optionsTable[positionCounter].controls, {
                    type = "checkbox",
                    name =  "Tracking",
                    getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].turnedOn end,
                    setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].turnedOn = value 
                    HTT_functions.reanchorBuffs()
                    end,
                    width = "full",	--or "half" (optional)
                    disabled = checkIfNone(currentlyEditedBuffKey),
                    reference = "buffTracking",
                })


                
				table.insert(optionsTable[positionCounter].controls, {
                    type = "colorpicker",
                    name = "Bar color",
                    getFunc = function() 
                        return unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].color)

                    end,	
                    setFunc = function(r,g,b,a) 
                    HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].color[1] = r 
                    HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].color[2] = g
                    HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].color[3] = b
                    HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].color[4] = a
                    local durationBar = HTTSelfBuffs:GetNamedChild("SelfBuffDurationBar"..currentlyEditedBuffKey)
                    durationBar:SetColor(r,g,b,a)
                    end,	--(alpha is optional)
                    width = "full",	--or "half" (optional)
                    disabled = checkIfNone(currentlyEditedBuffKey),
                    reference = "buffColor",
                })

                	
                    


				--if not HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable["isPreMade"][v] then
					

					

                    table.insert(optionsTable[positionCounter].controls, {
                         type = "dropdown",
                         name = "List of tracked IDs",
                         choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].IDs  or {"No IDs"},
                         getFunc = function() return holdRemoveBuffID end,
                         setFunc = function(var) holdRemoveBuffID = var end,
                         width = "half",	--or "half" (optional)
                         reference = "IDdropdownBuff",
                         disabled = checkIfNone(currentlyEditedBuffKey),
                    })

                    table.insert(optionsTable[positionCounter].controls, {
				type = "button",
				name = "Delete ID",
				func = function() 
                    if holdRemoveBuffID ~= nil then
                        table.remove(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].IDs,HTT_functions.findPositionOfElementInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].IDs,holdRemoveBuffID))
                        IDdropdownBuff.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].IDs  or {"No IDs"}
                        IDdropdownBuff:UpdateChoices()
                        EVENT_MANAGER:UnregisterForEvent("HTT"..holdRemoveBuffID,EVENT_EFFECT_CHANGED)
                    end
                end,
				width = "half",
                disabled = checkIfNone(currentlyEditedBuffKey),
                reference = "buffDeleteIDButton",
			})

				table.insert(optionsTable[positionCounter].controls, {
                type = "editbox",
                name = "Add new ID",
                getFunc = function() return addNewIDToExistingBuff end,
                setFunc = function(text) addNewIDToExistingBuff = tonumber(text) end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)
                disabled = checkIfNone(currentlyEditedBuffKey),
                default = "",	--(optional)
                reference = "buffAddNewIDEditbox",
				})

				table.insert(optionsTable[positionCounter].controls, {
				type = "button",
				name = "Add ID",
				func = function() if addNewIDToExistingBuff ~= nil then
                    HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].IDs[#HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].IDs+1] = addNewIDToExistingBuff 
                    IDdropdownBuff.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].IDs  or {"No IDs"}
                    IDdropdownBuff:UpdateChoices()
                    HTT_functions.initializeEventsBuffs(addNewIDToExistingBuff,currentlyEditedBuffKey)
                end
                end,
				width = "half",
                disabled = checkIfNone(currentlyEditedBuffKey),
                reference = "buffAddIDButton",
			})

            table.insert(optionsTable[positionCounter].controls, {
                type = "editbox",
                name = "Text displayed when effect is active",
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].text end,
                setFunc = function(text) HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].text = text 
				end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)
                disabled = checkIfNone(currentlyEditedBuffKey),
                default = "",	--(optional)
                reference = "buffTextEditbox",
            })
            table.insert(optionsTable[positionCounter].controls, {
                type = "editbox",
                name = "Text displayed when effect is missing",
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].textWhenMissing end,
                setFunc = function(text) HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].textWhenMissing = text 
				end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)
                disabled = checkIfNone(currentlyEditedBuffKey),
                default = "",	--(optional)
                reference = "buffTextWhenMissingEditbox",
            })
           

           table.insert(optionsTable[positionCounter].controls, {
                         type = "dropdown",
                         name = "List of tracked item sets",
                         choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].itemSet[1] or {"No item sets"},
                         getFunc = function() return holdRemoveBuffItemSet end,
                         setFunc = function(var) holdRemoveBuffItemSet = var end,
                         width = "half",	--or "half" (optional)
                         reference = "ItemSetBuffdropdown",
                         disabled = checkIfNone(currentlyEditedBuffKey),
                         tooltip = "If you want the tracker to automatically turn on/off based on if you have certain item set equipped, add the item set to this dropdown using the Add new item set checkbox(right click on any item from item set you want,choose Link in Chat and paste the item link here). Tracker will turn on if ANY of the added item sets is equipped",
                    })

                    table.insert(optionsTable[positionCounter].controls, {
				type = "button",
				name = "Delete Item Set",
				func = function() if holdRemoveBuffItemSet ~= nil then
                        table.remove(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].itemSet[1],HTT_functions.findPositionOfElementInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].itemSet[1],holdRemoveBuffItemSet))
                        ItemSetBuffdropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].itemSet[1] or {"No item sets"}
                        ItemSetBuffdropdown:UpdateChoices()
                    end
                end,
				width = "half",
                disabled = checkIfNone(currentlyEditedBuffKey),
                reference = "buffDeleteItemSetButton",
			})

				table.insert(optionsTable[positionCounter].controls, {
                type = "editbox",
                name = "Add new Item Set",
                getFunc = function() return addNewItemSetsToExistingItemSetsBuff end,
                setFunc = function(text) addNewItemSetsToExistingItemSetsBuff = text end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)
                disabled = checkIfNone(currentlyEditedBuffKey),
                default = "",	--(optional)
                reference = "buffAddNewItemSetEditbox",
				})

				table.insert(optionsTable[positionCounter].controls, {
				type = "button",
				name = "Add Item Set",
				func = function() 
                    if addNewItemSetsToExistingItemSetsBuff ~= nil then
                        if type(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].itemSet[1]) ~= "table" then
                            HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].itemSet[1] = {}
                        end
                        table.insert(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].itemSet[1],addNewItemSetsToExistingItemSetsBuff)
                        ItemSetBuffdropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].itemSet[1] or {"No item sets"}
                        ItemSetBuffdropdown:UpdateChoices()
                    end
                    --editbox.container:SetHidden(true)
                end,
				width = "half",
                disabled = checkIfNone(currentlyEditedBuffKey),
                reference = "buffAddItemSetButton",
                })

            table.insert(optionsTable[positionCounter].controls, {
                type = "slider",
                name = "Required item set pieces",
                tooltip = "Choose number of pieces that have to be equipped in order to turn on the tracker. The addon doesn't check your backbar so for 5-piece item sets that you have one-barred, choose 3 so the tracker gets turned on even if you start combat on the other bar",
                min = 0,
                max = 5,
                step = 1,	--(optional)
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].itemSet[2] or 0 end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].itemSet[2] = value end,
               -- end,
                width = "full",	--or "half" (optional)
                default = 5,	--(optional)
                disabled = checkIfNone(currentlyEditedBuffKey),
                reference = "buffSlider",
            })


            table.insert(optionsTable[positionCounter].controls, {
                         type = "dropdown",
                         name = "List of tracked skills",
                         choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].skill or {"No skills"},
                         getFunc = function() return holdRemoveBuffSkill end,
                         setFunc = function(var) holdRemoveBuffSkill = var end,
                         width = "half",	--or "half" (optional)
                         reference = "SkillBuffdropdown",
                         disabled = checkIfNone(currentlyEditedBuffKey),
                         tooltip = "If you want the tracker to automatically turn on/off based on if you have certain skill equipped on any bar, add the skill's slot ID (you can find Ability Viewer further down in the settings) to this dropdown using the Add new skill checkbox. Tracker will turn on if ANY of the added abilities is slotted",
                    })

                    table.insert(optionsTable[positionCounter].controls, {
				type = "button",
				name = "Delete Skill",
				func = function() if holdRemoveBuffSkill ~= nil then
                        table.remove(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].skill,HTT_functions.findPositionOfElementInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].skill,holdRemoveBuffSkill))
                        SkillBuffdropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].skill or {"No skills"}
                        SkillBuffdropdown:UpdateChoices()
                    end
                end,
				width = "half",
                disabled = checkIfNone(currentlyEditedBuffKey),
                reference = "buffDeleteSkillButton",
			})

				table.insert(optionsTable[positionCounter].controls, {
                type = "editbox",
                name = "Add new skill",
                getFunc = function() return addNewSkillToExistingSkillsBuff end,
                setFunc = function(text) addNewSkillToExistingSkillsBuff = tonumber(text) end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)
                disabled = checkIfNone(currentlyEditedBuffKey),
                default = "",	--(optional)
                reference = "buffAddNewSkillEditbox",
				})

				table.insert(optionsTable[positionCounter].controls, {
				type = "button",
				name = "Add Skill",
				func = function() 
                    if addNewSkillToExistingSkillsBuff ~= nil then
                        if type(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].skill) ~= "table" then
                            HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].skill = {}
                        end
                        table.insert(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].skill,addNewSkillToExistingSkillsBuff)
                        SkillBuffdropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].skill or {"No skills"}
                        SkillBuffdropdown:UpdateChoices()
                    end
                    --editbox.container:SetHidden(true)
                end,
				width = "half",
                disabled = checkIfNone(currentlyEditedBuffKey),
                reference = "buffAddSkillButton",
			})




				
					table.insert(optionsTable[positionCounter].controls, {
					type = "button",
					name = "Delete Tracker",
					func = function() 
                    for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable[currentlyEditedBuffKey].IDs) do
                        EVENT_MANAGER:UnregisterForEvent("HTT"..v,EVENT_EFFECT_CHANGED)
                    end
                    local textInBar = HTTSelfBuffs:GetNamedChild("SelfBuffTextInBar"..currentlyEditedBuffKey)
				    local durationTimer = HTTSelfBuffs:GetNamedChild("SelfBuffDurationTimer"..currentlyEditedBuffKey)
				    local durationBar = HTTSelfBuffs:GetNamedChild("SelfBuffDurationBar"..currentlyEditedBuffKey)
				    local icon = HTTSelfBuffs:GetNamedChild("SelfBuffIcon"..currentlyEditedBuffKey)
                    durationTimer:SetHidden(true)
					durationBar:SetHidden(true)
					icon:SetHidden(true)
					textInBar:SetHidden(true)


                    HTT_functions.removeBuff(currentlyEditedBuffKey) 
                    HTT_functions.reanchorBuffs()
                    currentlyEditedBuffKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable)
                    refreshAllBuffTrackerInfo()
					end,
					width = "half",
                    disabled = checkIfNone(currentlyEditedBuffKey),
					--warning = "Will reload the UI.",
				    reference = "buffDeleteTrackerButton",
				})
				--end
    table.insert(optionsTable[positionCounter].controls, {
        type = "submenu",
        name = "Add new buff tracker",
        controls = {
			[1] = {
                type = "editbox",
                name = "Name of the tracker",
                getFunc = function() return createNewBuffSavedVariables["name"]  end,
                setFunc = function(text) createNewBuffSavedVariables["name"] = text end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)

                default = "",	--(optional)
            },
			[2] = {
                type = "editbox",
                name = "ID of tracked buff",
                getFunc = function() return createNewBuffSavedVariables["ID"] end,
                setFunc = function(text) createNewBuffSavedVariables["ID"] = tonumber(text) end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)

                default = "",	--(optional)
            },
			[3] = {
                type = "editbox",
                name = "Text to display on the bar",
                getFunc = function() return createNewBuffSavedVariables["text"] end,
                setFunc = function(text) createNewBuffSavedVariables["text"] = text end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)

                default = "",	--(optional)
            },
			[4] = {
                type = "editbox",
                name = "Text to display when missing",
                getFunc = function() return createNewBuffSavedVariables["textWhenMissing"] end,
                setFunc = function(text) createNewBuffSavedVariables["textWhenMissing"] = text end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)

                default = "",	--(optional)
            },
			[5] = {
                type = "colorpicker",
                name = "My Color Picker",

                getFunc = function() return unpack(createNewBuffSavedVariables["color"]) end,	--(alpha is optional)
                setFunc = function(r,g,b,a) createNewBuffSavedVariables["color"][1] = r
				createNewBuffSavedVariables["color"][2] = g
				createNewBuffSavedVariables["color"][3] = b
				createNewBuffSavedVariables["color"][4] = a
				end,	--(alpha is optional)
                width = "half",	--or "half" (optional)

            },

            [6] = {
				type = "button",
				name = "Create Buff Tracker",
				func = function() if createNewBuffSavedVariables["name"] ~= nil then
                    local freeSlot = HTT_functions.findFreeSlotInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable)
                    HTT_functions.addBuff(createNewBuffSavedVariables["name"],createNewBuffSavedVariables["ID"],freeSlot,createNewBuffSavedVariables["text"],createNewBuffSavedVariables["textWhenMissing"],createNewBuffSavedVariables["color"],nil,nil,{},{},nil,nil)  
				    currentlyEditedBuffKey = freeSlot
                    refreshAllBuffTrackerInfo()
                end
				end,
				width = "half",

			},
            
        },
    })
    
   ----------- COOLDOWNS -------------

   
	table.insert(optionsTable, {
        type = "submenu",
        name = "Cooldowns",
        tooltip = "Settings of cooldown tracking",	--(optional)
        controls = {

        },
    })

    positionCounter = positionCounter +1 


         




    table.insert(optionsTable[positionCounter].controls, {

                type = "header",
                name = ZO_HIGHLIGHT_TEXT:Colorize("Order of Cooldowns"),
                width = "full",	--or "half" (optional)     
			})


       

    

        table.insert(optionsTable[positionCounter].controls, {
        type = "description",
        title = "Current order of cooldowns:",
        title = nil,	--(optional)
        text = generateCooldownOrderList(),
        width = "full",	--or "half" (optional)
        reference = "ListOfOrderCooldowns",
		disabled = checkIfNone(currentlyEditedCooldownKey),
    })

    currentlyEditedCooldownKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable)

    table.insert(optionsTable[positionCounter].controls, {
         type = "dropdown",
         name = "Cooldowns to swap",
         choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable),
         getFunc = function() return holdCooldownSwapValue1 end,
         setFunc = function(var) holdCooldownSwapValue1 = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownNameToID[var] end,
         width = "half",	--or "half" (optional)
         reference = "cooldownSwapDropdown1",
		 disabled = checkIfNone(currentlyEditedCooldownKey),
    })

    table.insert(optionsTable[positionCounter].controls, {
         type = "dropdown",
         --name = "",
         choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable),
         getFunc = function() return holdCooldownSwapValue2 end,
         setFunc = function(var) holdCooldownSwapValue2 = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownNameToID[var] end,
         width = "half",	--or "half" (optional)
         reference = "cooldownSwapDropdown2",
		 disabled = checkIfNone(currentlyEditedCooldownKey),
    })

     table.insert(optionsTable[positionCounter].controls, {
        type = "button",
        name = "Swap Cooldowns",
        func = function() 
        if holdCooldownSwapValue1~= nil and holdCooldownSwapValue2 ~= nil then
            HTT_functions.swapElementsInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns,holdCooldownSwapValue1,holdCooldownSwapValue2) 
            ListOfOrderCooldowns.data.text = generateCooldownOrderList()
            ListOfOrderCooldowns:UpdateValue()
            cooldownSwapDropdown1.data.choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable)
            cooldownSwapDropdown1:UpdateChoices()
            cooldownSwapDropdown2.data.choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable)
            cooldownSwapDropdown2:UpdateChoices()
            HTT_functions.reanchorCooldowns()
        end
        end,
        width = "half",
		disabled = checkIfNone(currentlyEditedCooldownKey),
		reference = "swapCooldownsButton",

    })



   

        

       table.insert(optionsTable[positionCounter].controls, {
                    type = "header",
                    name = ZO_HIGHLIGHT_TEXT:Colorize(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].name.." (ID:"..currentlyEditedCooldownKey..")"),
                    width = "full",	--or "half" (optional)
					reference = "headerCooldown",
					disabled = checkIfNone(currentlyEditedCooldownKey),
			    })

          table.insert(optionsTable[positionCounter].controls, {
                         type = "dropdown",
                         name = "Pick Tracker",
                         choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable)  or {"No trackers"},
                         getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].name end,
                         setFunc = function(var) currentlyEditedCooldownKey = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownNameToID[var]
						 headerCooldown.data.name = ZO_HIGHLIGHT_TEXT:Colorize(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].name.." (ID:"..currentlyEditedCooldownKey..")")
						 headerCooldown:UpdateValue()
                         IDdropdownCooldown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].IDs  or {"No IDs"}
                         IDdropdownCooldown:UpdateChoices()
                         SkillCooldowndropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].skill or {"No skills"}
                         SkillCooldowndropdown:UpdateChoices()
                         ItemSetCooldowndropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].itemSet[1] or {"No item sets"}
                         ItemSetCooldowndropdown:UpdateChoices()
                         if type(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].itemSet) ~= "table" then
                             HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].itemSet = {}
                         end
						 end,
                         width = "half",	--or "half" (optional)
                         reference = "pickDropdownCooldown",
						 disabled = checkIfNone(currentlyEditedCooldownKey),
                    })


            table.insert(optionsTable[positionCounter].controls, {
                type = "iconpicker",
                name = "Icon",
                choices = HTT_TextureList,
                iconSize = 32,
                maxColumns = 10,
                visibleRows = 9,
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].icon end,
                setFunc = function(var) HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].icon = var
                local icon = HTTCooldowns:GetNamedChild("CooldownIcon"..currentlyEditedCooldownKey)
                icon:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].icon)
                ListOfOrderCooldowns.data.text = generateCooldownOrderList()
                ListOfOrderCooldowns:UpdateValue()
                end,
                width = "half",	--or "half" (optional)
				disabled = checkIfNone(currentlyEditedCooldownKey),
				reference = "iconpickerCooldown",
            })
		
				table.insert(optionsTable[positionCounter].controls, {
                    type = "checkbox",
                    name =  "Tracking",
                    getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].turnedOn end,
                    setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].turnedOn = value 
                    HTT_functions.reanchorCooldowns()
                    end,
                    width = "full",	--or "half" (optional)
					disabled = checkIfNone(currentlyEditedCooldownKey),
					reference = "cooldownTracking",
                })


                
				table.insert(optionsTable[positionCounter].controls, {
                    type = "colorpicker",
                    name = "Bar color",
                    getFunc = function() 
                        return unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].color)

                    end,	
                    setFunc = function(r,g,b,a) 
                    HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].color[1] = r 
                    HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].color[2] = g
                    HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].color[3] = b
                    HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].color[4] = a
                    local durationBar = HTTCooldowns:GetNamedChild("CooldownsDurationBar"..currentlyEditedCooldownKey)
                    durationBar:SetColor(r,g,b,a)
                    end,	--(alpha is optional)
                    width = "full",	--or "half" (optional)
					disabled = checkIfNone(currentlyEditedCooldownKey),
					reference = "cooldownColorPicker",
                })

                	
                    


					

					

                    table.insert(optionsTable[positionCounter].controls, {
                         type = "dropdown",
                         name = "List of tracked IDs",
                         choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].IDs  or {"No IDs"},
                         getFunc = function() return holdRemoveCooldownID end,
                         setFunc = function(var) holdRemoveCooldownID = var end,
                         width = "half",	--or "half" (optional)
                         reference = "IDdropdownCooldown",
						 disabled = checkIfNone(currentlyEditedCooldownKey),
                    })

                    table.insert(optionsTable[positionCounter].controls, {
				type = "button",
				name = "Delete ID",
				func = function() 
                    if holdRemoveCooldownID ~= nil then
                        table.remove(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].IDs,HTT_functions.findPositionOfElementInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].IDs,holdRemoveCooldownID))
                        IDdropdownCooldown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].IDs  or {"No IDs"}
                        IDdropdownCooldown:UpdateChoices()
                        EVENT_MANAGER:UnregisterForEvent("HTT"..holdRemoveCooldownID,EVENT_EFFECT_CHANGED)
                    end
                end,
				width = "half",
				disabled = checkIfNone(currentlyEditedCooldownKey),
				reference = "cooldownDeleteIDButton",
			})

				table.insert(optionsTable[positionCounter].controls, {
                type = "editbox",
                name = "Add new ID",
                getFunc = function() return addNewIDToExistingCooldown end,
                setFunc = function(text) addNewIDToExistingCooldown = tonumber(text) end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)
				disabled = checkIfNone(currentlyEditedCooldownKey),
                default = "",	--(optional)
				reference = "cooldownAddNewIDEditbox",
				})

				table.insert(optionsTable[positionCounter].controls, {
				type = "button",
				name = "Add ID",
				func = function() if addNewIDToExistingCooldown ~= nil then
                    HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].IDs[#HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].IDs+1] = addNewIDToExistingCooldown 
                    IDdropdownCooldown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].IDs  or {"No IDs"}
                    IDdropdownCooldown:UpdateChoices()
                    HTT_functions.GenerateCooldownEvent(addNewIDToExistingCooldown,currentlyEditedCooldownKey)
                end
                end,
				width = "half",
				disabled = checkIfNone(currentlyEditedCooldownKey),
				reference = "cooldownAddIdButton",
			})

            table.insert(optionsTable[positionCounter].controls, {
                type = "editbox",
                name = "Text displayed when effect is active",
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].text end,
                setFunc = function(text) HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].text = text 
				end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)
				disabled = checkIfNone(currentlyEditedCooldownKey),
                default = "",	--(optional)
				reference = "cooldownText",
            })
            table.insert(optionsTable[positionCounter].controls, {
                type = "editbox",
                name = "Text displayed when effect is missing",
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].textWhenMissing end,
                setFunc = function(text) HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].textWhenMissing = text 
				end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)
				disabled = checkIfNone(currentlyEditedCooldownKey),
                default = "",	--(optional)
				reference = "cooldownTextWhenMissing",
            })
           


            

            table.insert(optionsTable[positionCounter].controls, {
                         type = "dropdown",
                         name = "List of tracked item sets",
                         choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].itemSet[1] or {"No item sets"},
                         getFunc = function() return holdRemoveCooldownItemSet end,
                         setFunc = function(var) holdRemoveCooldownItemSet = var end,
                         width = "half",	--or "half" (optional)
                         reference = "ItemSetCooldowndropdown",
						 disabled = checkIfNone(currentlyEditedCooldownKey),
                         tooltip = "If you want the tracker to automatically turn on/off based on if you have certain item set equipped, add the item set to this dropdown using the Add new item set checkbox(right click on any item from item set you want,choose Link in Chat and paste the item link here). Tracker will turn on if ANY of the added item sets is equipped",
                    })

                    table.insert(optionsTable[positionCounter].controls, {
				type = "button",
				name = "Delete Item Set",
				func = function() if holdRemoveCooldownItemSet ~= nil then
                        table.remove(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].itemSet[1],HTT_functions.findPositionOfElementInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].itemSet[1],holdRemoveCooldownItemSet))
                        ItemSetCooldowndropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].itemSet[1] or {"No item sets"}
                        ItemSetCooldowndropdown:UpdateChoices()
                    end
                end,
				width = "half",
				disabled = checkIfNone(currentlyEditedCooldownKey),
				reference = "cooldownDeleteItemSetButton",
			})

				table.insert(optionsTable[positionCounter].controls, {
                type = "editbox",
                name = "Add new Item Set",
                getFunc = function() return addNewItemSetsToExistingItemSetsCooldown end,
                setFunc = function(text) addNewItemSetsToExistingItemSetsCooldown = text end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)
				disabled = checkIfNone(currentlyEditedCooldownKey),
                default = "",	--(optional)
				reference = "cooldownAddNewItemSetEditbox",
				})

				table.insert(optionsTable[positionCounter].controls, {
				type = "button",
				name = "Add Item Set",
				func = function() 
                    if addNewItemSetsToExistingItemSetsCooldown ~= nil then
                        if type(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].itemSet[1]) ~= "table" then
                            HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].itemSet[1] = {}
                        end
                        table.insert(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].itemSet[1],addNewItemSetsToExistingItemSetsCooldown)
                        ItemSetCooldowndropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].itemSet[1] or {"No item sets"}
                        ItemSetCooldowndropdown:UpdateChoices()
                    end
                    --editbox.container:SetHidden(true)
                end,
				width = "half",
				disabled = checkIfNone(currentlyEditedCooldownKey),
				reference = "cooldownAddItemSetButton",
                })

            table.insert(optionsTable[positionCounter].controls, {
                type = "slider",
                name = "Required item set pieces",
                tooltip = "Choose number of pieces that have to be equipped in order to turn on the tracker. The addon doesn't check your backbar so for 5-piece item sets that you have one-barred, choose 3 so the tracker gets turned on even if you start combat on the other bar",
                min = 0,
                max = 5,
                step = 1,	--(optional)
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].itemSet[2] or 0 end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].itemSet[2] = value end,
               -- end,
                width = "full",	--or "half" (optional)
                default = 5,	--(optional)
				disabled = checkIfNone(currentlyEditedCooldownKey),
				reference = "cooldownSlider",
            })



            table.insert(optionsTable[positionCounter].controls, {
                         type = "dropdown",
                         name = "List of tracked skills",
                         choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].skill or {"No skills"},
                         getFunc = function() return holdRemoveCooldownSkill end,
                         setFunc = function(var) holdRemoveCooldownSkill = var end,
                         width = "half",	--or "half" (optional)
                         reference = "SkillCooldowndropdown",
						 disabled = checkIfNone(currentlyEditedCooldownKey),
                         tooltip = "If you want the tracker to automatically turn on/off based on if you have certain skill equipped on any bar, add the skill's slot ID (you can find Ability Viewer further down in the settings) to this dropdown using the Add new skill checkbox. Tracker will turn on if ANY of the added abilities is slotted",
                    })

                    table.insert(optionsTable[positionCounter].controls, {
				type = "button",
				name = "Delete Skill",
				func = function() if holdRemoveCooldownSkill ~= nil then
                        table.remove(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].skill,HTT_functions.findPositionOfElementInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].skill,holdRemoveCooldownSkill))
                        SkillCooldowndropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].skill or {"No skills"}
                        SkillCooldowndropdown:UpdateChoices()
                    end
                end,
				width = "half",
				disabled = checkIfNone(currentlyEditedCooldownKey),
				reference = "cooldownDeleteSkillButton",
			})

				table.insert(optionsTable[positionCounter].controls, {
                type = "editbox",
                name = "Add new skill",
                getFunc = function() return addNewSkillToExistingSkillsCooldown end,
                setFunc = function(text) addNewSkillToExistingSkillsCooldown = tonumber(text) end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)
				disabled = checkIfNone(currentlyEditedCooldownKey),
                default = "",	--(optional)
				reference = "cooldownAddNewSkillEditbox",
				})

				table.insert(optionsTable[positionCounter].controls, {
				type = "button",
				name = "Add Skill",
				func = function() 
                    if addNewSkillToExistingSkillsCooldown ~= nil then
                        if type(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].skill) ~= "table" then
                            HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].skill = {}
                        end
                        table.insert(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].skill,addNewSkillToExistingSkillsCooldown)
                        SkillCooldowndropdown.data.choices = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].skill or {"No skills"}
                        SkillCooldowndropdown:UpdateChoices()
                    end
                    --editbox.container:SetHidden(true)
                end,
				width = "half",
				disabled = checkIfNone(currentlyEditedCooldownKey),
				reference = "cooldownAddSkillButton",
			})




				
					table.insert(optionsTable[positionCounter].controls, {
					type = "button",
					name = "Delete Tracker",
					func = function() 
                    for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable[currentlyEditedCooldownKey].IDs) do
                        EVENT_MANAGER:UnregisterForEvent("HTT"..v,EVENT_COMBAT_EVENT)
                    end
                    local textInBar = HTTCooldowns:GetNamedChild("CooldownTextInBar"..currentlyEditedCooldownKey)
				    local durationTimer = HTTCooldowns:GetNamedChild("CooldownDurationTimer"..currentlyEditedCooldownKey)
				    local durationBar = HTTCooldowns:GetNamedChild("CooldownsDurationBar"..currentlyEditedCooldownKey)
				    local icon = HTTCooldowns:GetNamedChild("CooldownIcon"..currentlyEditedCooldownKey)
                    durationTimer:SetHidden(true)
					durationBar:SetHidden(true)
					icon:SetHidden(true)
					textInBar:SetHidden(true)


                    HTT_functions.removeCooldown(currentlyEditedCooldownKey) 
                    HTT_functions.reanchorCooldowns()
                    currentlyEditedCooldownKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable)
                    refreshAllCooldownTrackerInfo()
					end,
					width = "half",
					disabled = checkIfNone(currentlyEditedCooldownKey),
					reference = "cooldownDeleteTrackerButton",
					--warning = "Will reload the UI.",
				
				})
				--end
    table.insert(optionsTable[positionCounter].controls, {
        type = "submenu",
        name = "Add new cooldown tracker",
        controls = {
			[1] = {
                type = "editbox",
                name = "Name of the tracker",
                getFunc = function() return createNewCooldownSavedVariables["name"]  end,
                setFunc = function(text) createNewCooldownSavedVariables["name"] = text end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)

                default = "",	--(optional)
            },
			[2] = {
                type = "editbox",
                name = "ID of tracked cooldown",
                getFunc = function() return createNewCooldownSavedVariables["ID"] end,
                setFunc = function(text) createNewCooldownSavedVariables["ID"] = tonumber(text) end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)

                default = "",	--(optional)
            },
			[3] = {
                type = "editbox",
                name = "Text to display when on cooldown",
                getFunc = function() return createNewCooldownSavedVariables["text"] end,
                setFunc = function(text) createNewCooldownSavedVariables["text"] = text end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)

                default = "",	--(optional)
            },
			[4] = {
                type = "editbox",
                name = "Text to display when ready",
                getFunc = function() return createNewCooldownSavedVariables["textWhenMissing"] end,
                setFunc = function(text) createNewCooldownSavedVariables["textWhenMissing"] = text end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)

                default = "",	--(optional)
            },
            [5] = {
                type = "editbox",
                name = "Cooldown duration",
                getFunc = function() return createNewCooldownSavedVariables["duration"] end,
                setFunc = function(text) createNewCooldownSavedVariables["duration"] = tonumber(text) end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)

                default = "",	--(optional)
            },
			[6] = {
                type = "colorpicker",
                name = "My Color Picker",

                getFunc = function() return unpack(createNewCooldownSavedVariables["color"]) end,	--(alpha is optional)
                setFunc = function(r,g,b,a) createNewCooldownSavedVariables["color"][1] = r
				createNewCooldownSavedVariables["color"][2] = g
				createNewCooldownSavedVariables["color"][3] = b
				createNewCooldownSavedVariables["color"][4] = a
				end,	--(alpha is optional)
                width = "half",	--or "half" (optional)

            },

            [7] = {
				type = "button",
				name = "Create Tracker",
				func = function() if createNewCooldownSavedVariables["name"] ~= nil then
                    local freeSlot = HTT_functions.findFreeSlotInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable)
                    HTT_functions.addCooldown(createNewCooldownSavedVariables["name"],createNewCooldownSavedVariables["ID"],freeSlot,createNewCooldownSavedVariables["text"],createNewCooldownSavedVariables["textWhenMissing"],createNewCooldownSavedVariables["color"],nil,nil,createNewCooldownSavedVariables["duration"],{},{})  
				    currentlyEditedCooldownKey = freeSlot
                    refreshAllCooldownTrackerInfo()
                    
                end
				end,
				width = "half",

			},
            
        },
    })

    ----------- COOLDOWNS -------------

	------------ SYNERGY -------------

	table.insert(optionsTable, {
        type = "submenu",
        name = "Synergies",
        tooltip = "Settings of synergy tracking",	--(optional)
        controls = {

        },
    })

    positionCounter = positionCounter +1 


          




    table.insert(optionsTable[positionCounter].controls, {

                type = "header",
                name = ZO_HIGHLIGHT_TEXT:Colorize("Order of Synergies"),
                width = "full",	--or "half" (optional)     
			})


       

    

        table.insert(optionsTable[positionCounter].controls, {
        type = "description",
        title = "Current order of synergies:",
        title = nil,	--(optional)
        text = generateSynergyOrderList(),
        width = "full",	--or "half" (optional)
        reference = "ListOfOrderSynergies"
    })

    currentlyEditedSynergyKey = HTT_functions.pickAnyKey(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable)
    table.insert(optionsTable[positionCounter].controls, {
         type = "dropdown",
         name = "Synergies to swap",
         choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable),
         getFunc = function() return holdSynergySwapValue1 end,
         setFunc = function(var) holdSynergySwapValue1 = HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesNameToID[var] end,
         width = "half",	--or "half" (optional)
         reference = "synergySwapDropdown1",
         disabled = checkIfNone(currentlyEditedSynergyKey),
    })

    table.insert(optionsTable[positionCounter].controls, {
         type = "dropdown",
         --name = "",
         choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable),
         getFunc = function() return holdSynergySwapValue2 end,
         setFunc = function(var) holdSynergySwapValue2 = HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesNameToID[var] end,
         width = "half",	--or "half" (optional)
         reference = "synergySwapDropdown2",
         disabled = checkIfNone(currentlyEditedSynergyKey),
    })

     table.insert(optionsTable[positionCounter].controls, {
        type = "button",
        name = "Swap Synergies",
        func = function() 
        if holdSynergySwapValue1~= nil and holdSynergySwapValue2 ~= nil then
            HTT_functions.swapElementsInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfSynergies,holdSynergySwapValue1,holdSynergySwapValue2) 
            ListOfOrderSynergies.data.text = generateSynergyOrderList()
            ListOfOrderSynergies:UpdateValue()
            synergySwapDropdown1.data.choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable)
            synergySwapDropdown1:UpdateChoices()
            synergySwapDropdown2.data.choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable)
            synergySwapDropdown2:UpdateChoices()
            HTT_functions.reanchorSynergies()
        end
        end,
        width = "half",
        disabled = checkIfNone(currentlyEditedSynergyKey),
        reference = "swapSynergiesButton",

    })



   

        
       table.insert(optionsTable[positionCounter].controls, {
                    type = "header",
                    name = ZO_HIGHLIGHT_TEXT:Colorize(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[currentlyEditedSynergyKey].name.." (ID:"..currentlyEditedSynergyKey..")"),
                    width = "full",	--or "half" (optional)
					reference = "headerSynergy"
			    })

          table.insert(optionsTable[positionCounter].controls, {
                         type = "dropdown",
                         name = "Pick Tracker",
                         choices = createTableOfNames(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable)  or {"No trackers"},
                         getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[currentlyEditedSynergyKey].name end,
                         setFunc = function(var) currentlyEditedSynergyKey = HTTsavedVars[HTT_variables.currentlySelectedProfile].synergyNameToID[var]
						 headerSynergy.data.name = ZO_HIGHLIGHT_TEXT:Colorize(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[currentlyEditedSynergyKey].name.." (ID:"..currentlyEditedSynergyKey..")")
						 headerSynergy:UpdateValue()
						 end,
                         width = "half",	--or "half" (optional)
                         reference = "pickDropdownSynergies",
                         disabled = checkIfNone(currentlyEditedSynergyKey),
                    })

            table.insert(optionsTable[positionCounter].controls, {
                type = "iconpicker",
                name = "Icon",
                choices = HTT_TextureList,
                iconSize = 32,
                maxColumns = 10,
                visibleRows = 9,
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[currentlyEditedSynergyKey].icon end,
                setFunc = function(var) HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[currentlyEditedSynergyKey].icon = var
                local icon = HTTSynergies:GetNamedChild("SynergiesIcon"..currentlyEditedSynergyKey)
                icon:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[currentlyEditedSynergyKey].icon)
                ListOfOrderSynergies.data.text = generateSynergiesOrderList()
                ListOfOrderSynergies:UpdateValue()
                end,
                width = "half",	--or "half" (optional)
                disabled = checkIfNone(currentlyEditedSynergyKey),
                reference = "synergyIconPicker",
            })

		
				table.insert(optionsTable[positionCounter].controls, {
                    type = "checkbox",
                    name =  "Tracking",
                    getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[currentlyEditedSynergyKey].turnedOn end,
                    setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[currentlyEditedSynergyKey].turnedOn = value 
                    HTT_functions.reanchorSynergies()
                    end,
                    width = "full",	--or "half" (optional)
                    disabled = checkIfNone(currentlyEditedSynergyKey),
                    reference = "synergyTrackingCheckbox",
                })


                
				table.insert(optionsTable[positionCounter].controls, {
                    type = "colorpicker",
                    name = "Bar color",
                    getFunc = function() 
                        return unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[currentlyEditedSynergyKey].color)

                    end,	
                    setFunc = function(r,g,b,a) 
                    HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[currentlyEditedSynergyKey].color[1] = r 
                    HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[currentlyEditedSynergyKey].color[2] = g
                    HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[currentlyEditedSynergyKey].color[3] = b
                    HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[currentlyEditedSynergyKey].color[4] = a
                    local durationBar = HTTSynergies:GetNamedChild("SynergiesDurationBar"..currentlyEditedSynergyKey)
                    durationBar:SetColor(r,g,b,a)
                    end,	--(alpha is optional)
                    width = "full",	--or "half" (optional)
                    disabled = checkIfNone(currentlyEditedSynergyKey),
                    reference = "synergyColorPicker",
                })


            table.insert(optionsTable[positionCounter].controls, {
                type = "editbox",
                name = "Text displayed when effect is active",
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[currentlyEditedSynergyKey].text end,
                setFunc = function(text) HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[currentlyEditedSynergyKey].text = text 
				end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)
                disabled = checkIfNone(currentlyEditedSynergyKey),
                default = "",	--(optional)
                reference = "synergyTextEditbox",
            })
            table.insert(optionsTable[positionCounter].controls, {
                type = "editbox",
                name = "Text displayed when effect is missing",
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[currentlyEditedSynergyKey].textWhenMissing end,
                setFunc = function(text) HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable[currentlyEditedSynergyKey].textWhenMissing = text 
				end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)
                disabled = checkIfNone(currentlyEditedSynergyKey),
                default = "",	--(optional)
                reference = "synergyTextWhenMissingEditbox",
            })
        positionCounter = positionCounter+1
           



	------------ SYNERGY --------------


     table.insert(optionsTable, {
        type = "submenu",
        name = "Combat Event Viewer",
        tooltip = "In order to add your own cooldown trackers you'll need to know IDs of those events. Turn on listening to events, trigger the proc set you want to track, stop the listener and find the ID you need on the list",	--(optional)
        controls = {
            [1] = {
                type = "checkbox",
                name = "Window Visibility",
                tooltip = "While this checkbox is on, event tracking window is visible",
                getFunc = function() return HTT_variables.eventWindowVisibility end,
                setFunc = function(value) HTT_variables.eventWindowVisibility=value
                eventViewerWindow:SetHidden(not value) end,
                width = "half",	--or "half" (optional)
                --warning = "Will need to reload the UI.",	--(optional)
            },
            [2] = {
                type = "checkbox",
                name = "Listen to events",
                tooltip = "While this checkbox is on, new events will appear on window. Turn it off after you're done gathering events and want to scroll through them to find the one you need",
                getFunc = function() return HTT_variables.eventWindowListening end,
                setFunc = function(value) HTT_variables.eventWindowListening = value
                if value then
                    
                    EVENT_MANAGER:RegisterForEvent("debug", EVENT_COMBAT_EVENT, function(eventCode, result, isError,
		             abilityName,  abilityGraphic,  abilityActionSlotType,  sourceName, sourceType, 
		             targetName, targetType, hitValue,  powerType, damageType,
		             log,  sourceUnitId,  targetUnitId, abilityId, overflow)  

	            eventViewerWindow:AddText(abilityName.."   "..abilityId, 1, 1, 1)
	            end)
	            EVENT_MANAGER:AddFilterForEvent("debug", EVENT_COMBAT_EVENT, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE ,1)
                else
                    EVENT_MANAGER:UnregisterForEvent("debug",EVENT_COMBAT_EVENT)
                end
                end,
                width = "half",	--or "half" (optional)
                --warning = "Will need to reload the UI.",	--(optional)
            },
            [3] = {
				type = "button",
				name = "Clear Window",
				func = function() eventViewerWindow:ClearText()
				end,
				width = "half",
				--warning = "Will reload the UI.",	--(optional)
			},
        },
    })
    positionCounter = positionCounter+1

    table.insert(optionsTable, {
        type = "submenu",
        name = "Buff/Debuff/Ability Viewer",
        tooltip = "In order to add your own buff or debuff trackers you'll need to know their IDs. Here you can find lists of all active effects on either yourself or your current target. You can also check IDs of abilities",	--(optional)
        controls = {
            [1] = {
                type = "checkbox",
                name = "Effects on yourself",
                tooltip = "While this checkbox is on, buff tracking window is visible",
                getFunc = function() return HTT_variables.buffWindowVisibility end,
                setFunc = function(value) HTT_variables.buffWindowVisibility=value
                buffViewerWindow:SetHidden(not value) 
                if value then
                    EVENT_MANAGER:RegisterForUpdate("HTTBuffViewer", 100,BuffViewerUpdate)
                else
                    EVENT_MANAGER:UnregisterForUpdate("HTTBuffViewer", 100)
                end
                end,
                width = "half",	--or "half" (optional)
                --warning = "Will need to reload the UI.",	--(optional)
            },
            [2] = {
                type = "checkbox",
                name = "Effects on your current target",
                tooltip = "While this checkbox is on, debuff tracking window is visible",
                getFunc = function() return HTT_variables.debuffWindowVisibility end,
                setFunc = function(value) HTT_variables.debuffWindowVisibility=value
                debuffViewerWindow:SetHidden(not value) 
                if value then
                    EVENT_MANAGER:RegisterForUpdate("HTTDebuffViewer", 100,DebuffViewerUpdate)
                else
                    EVENT_MANAGER:UnregisterForUpdate("HTTDebuffViewer", 100)
                end
                end,
                width = "half",	--or "half" (optional)
                --warning = "Will need to reload the UI.",	--(optional)
            },
            [3] = {
                type = "checkbox",
                name = "Abilities on your bars",
                tooltip = "While this checkbox is on, ability slot tracking window is visible",
                getFunc = function() return HTT_variables.abilityWindowVisibility end,
                setFunc = function(value) HTT_variables.abilityWindowVisibility=value
                abilitySlotViewer:SetHidden(not value) 
                if value then
                    EVENT_MANAGER:RegisterForUpdate("HTTAbilityViewer", 100,AbilityViewerUpdate)
                else
                    EVENT_MANAGER:UnregisterForUpdate("HTTAbilityViewer", 100)
                end
                end,
                width = "half",	--or "half" (optional)
                --warning = "Will need to reload the UI.",	--(optional)
            },
        },
    })
    positionCounter = positionCounter+1

     table.insert(optionsTable, {
        type = "submenu",
        name = "Notifications",
        --tooltip = "tip",	--(optional)
        controls = {},
    })

    table.insert(optionsTable[positionCounter].controls, {
    type = "description",
    title = nil,	--(optional)
    text = "Some notifications, like for example Rive in Castle Thorn, will be listed multiple times as they have multiple IDs with different durations",
    width = "full",	--or "half" (optional)
})


    local alertCounter = 2
    for k,v in pairs(HTT_DodgeRollData) do
        table.insert(optionsTable[positionCounter].controls, {
        type = "submenu",
        name = k,
        controls = {}, 
        })
		for k1,v1 in pairs(v) do
            table.insert(optionsTable[positionCounter].controls[alertCounter].controls, {
                type = "checkbox",
                name = v1.nameOverride or GetAbilityName(k1),
                getFunc = function() return HTTsavedVars[HTT_variables.currentlySelectedProfile].alertNotifications[k1] end,
                setFunc = function(value) HTTsavedVars[HTT_variables.currentlySelectedProfile].alertNotifications[k1] = value 
                if value then
                    HTT_DodgeRoll_RegisterEvent(k1,v1.duration,v1.notOnlyPlayer,v1.sound,v1.texture,v1.dodgeDurationOverride,v1.onlyBlock,v1.preventDouble,v1.nameOverride,v1.sourceNameOverride,v1.resultOverride or 2200)
                else
                    EVENT_MANAGER:UnregisterForEvent("HTT"..k1..v1.duration, EVENT_COMBAT_EVENT)
                end
                end,

            })
		end
        alertCounter = alertCounter + 1
	end
    





	

    
    table.insert(optionsTable, {
				type = "button",
				name = "Reload UI",
				func = function() ReloadUI("ingame") end,
				width = "half",
			})
    
    
	--[[
    -- Category. --
    table.insert(optionsTable, {
        type = "header",
        name = ZO_HIGHLIGHT_TEXT:Colorize("My Header"),
        width = "full",	--or "half" (optional)
    })

    table.insert(optionsTable, {
        type = "description",
        --title = "My Title",	--(optional)
        title = nil,	--(optional)
        text = "My description text to display.",
        width = "full",	--or "half" (optional)
    })

    table.insert(optionsTable, {
        type = "dropdown",
        name = "My Dropdown",
        tooltip = "Dropdown's tooltip text.",
        choices = {"table", "of", "choices"},
        getFunc = function() return "of" end,
        setFunc = function(var) print(var) end,
        width = "half",	--or "half" (optional)
        warning = "Will need to reload the UI.",	--(optional)
    })

    table.insert(optionsTable, {
        type = "dropdown",
        name = "My Dropdown",
        tooltip = "Dropdown's tooltip text.",
        choices = {"table", "of", "choices"},
        getFunc = function() return "of" end,
        setFunc = function(var) print(var) end,
        width = "half",	--or "half" (optional)
        warning = "Will need to reload the UI.",	--(optional)
    })

    table.insert(optionsTable, {
        type = "slider",
        name = "My Slider",
        tooltip = "Slider's tooltip text.",
        min = 0,
        max = 20,
        step = 1,	--(optional)
        getFunc = function() return 3 end,
        setFunc = function(value) d(value) end,
        width = "half",	--or "half" (optional)
        default = 5,	--(optional)
    })

    table.insert(optionsTable, {
        type = "button",
        name = "My Button",
        tooltip = "Button's tooltip text.",
        func = function() d("button pressed!") end,
        width = "half",	--or "half" (optional)
        warning = "Will need to reload the UI.",	--(optional)
    })



    table.insert(optionsTable, {
        type = "submenu",
        name = "Submenu Title",
        tooltip = "My submenu tooltip",	--(optional)
        controls = {
            [1] = {
                type = "checkbox",
                name = "My Checkbox",
                tooltip = "Checkbox's tooltip text.",
                getFunc = function() return true end,
                setFunc = function(value) d(value) end,
                width = "half",	--or "half" (optional)
                warning = "Will need to reload the UI.",	--(optional)
            },
            [2] = {
                type = "colorpicker",
                name = "My Color Picker",
                tooltip = "Color Picker's tooltip text.",
                getFunc = function() return 1, 0, 0, 1 end,	--(alpha is optional)
                setFunc = function(r,g,b,a) print(r, g, b, a) end,	--(alpha is optional)
                width = "half",	--or "half" (optional)
                warning = "warning text",
            },
            [3] = {
                type = "editbox",
                name = "My Editbox",
                tooltip = "Editbox's tooltip text.",
                getFunc = function() return "this is some text" end,
                setFunc = function(text) print(text) end,
                isMultiline = false,	--boolean
                width = "half",	--or "half" (optional)
                warning = "Will need to reload the UI.",	--(optional)
                default = "",	--(optional)
            },
        },
    })

    table.insert(optionsTable, {
        type = "custom",
        reference = "MyAddonCustomControl",	--unique name for your control to use as reference
        refreshFunc = function(customControl) end,	--(optional) function to call when panel/controls refresh
        width = "half",	--or "half" (optional)
    })

    table.insert(optionsTable, {
        type = "texture",
        image = "EsoUI\\Art\\ActionBar\\abilityframe64_up.dds",
        imageWidth = 64,	--max of 250 for half width, 510 for full
        imageHeight = 64,	--max of 100
        tooltip = "Image's tooltip text.",	--(optional)
        width = "half",	--or "half" (optional)
    })]]
    
    LibAddonMenu2:RegisterOptionControls("Hyper Tanking Tools", optionsTable)
end



local function createList(table)
    if type(table) == "table" then
        local holder = ""
        for _,text in pairs(table) do
            holder = holder.."-"..text.." - "..GetAbilityName(text).."\n"
        end
        return holder
    elseif table then
        return "-"..table.." - "..GetAbilityName(table)
    end
    return "none"
end


local typeToNumber = {
    ["Debuffs"] = 1,
    ["Buffs"] = 2,
    ["Cooldowns"] = 3,
}

local function getFirstElementIfTable(variable)
    if type(variable) == "table" then
        return variable[1]
    end
    return variable
end


function HTT_LoadSettingsPremadeTrackers()
    local panelData = {
        type = "panel",
        name = "Hyper Tanking Tools - Premade Trackers",
        displayName = "Hyper Tanking Tools - Premade Trackers",
        author = "Hyperioxes",
        version = "1.18",
		website = "https://www.esoui.com/downloads/info2778-HyperTankingTools.html",
		feedback = "https://www.esoui.com/downloads/info2778-HyperTankingTools.html#comments",
		donation = "https://www.esoui.com/downloads/info2778-HyperTankingTools.html#donate",
        slashCommand = "/httpt",
        registerForRefresh = true,
        registerForDefaults = true,
    }
    LibAddonMenu2:RegisterAddonPanel("Hyper Tanking Tools - Premade Trackers", panelData)

    local optionsTable = {}
    local submenuCounter = 1
    for nameOfSubmenu,tableOfTrackers in pairs(HTTPremadeTrackersData) do
        
        table.insert(optionsTable, {
                type = "submenu",
                name = nameOfSubmenu,
                --tooltip = "My submenu tooltip",	--(optional)
                controls = {},
        })
        local trackerCounter = 1
             for trackerName,trackerVariables in pairs(tableOfTrackers) do
             
             table.insert(optionsTable[submenuCounter].controls, {
                type = "submenu",
                name = "|t32:32:"..(trackerVariables.icon or GetAbilityIcon(getFirstElementIfTable(trackerVariables.ID))).."|t   "..trackerName,
                --tooltip = "My submenu tooltip",	--(optional)
                controls = {},
            })
            table.insert(optionsTable[submenuCounter].controls[trackerCounter].controls, {
                type = "texture",
                image = (trackerVariables.icon or GetAbilityIcon(getFirstElementIfTable(trackerVariables.ID))),
                imageWidth = 100,	--max of 250 for half width, 510 for full
                imageHeight = 100,	--max of 100
                --tooltip = "Image's tooltip text.",	--(optional)
                width = "half",	--or "half" (optional)
            })
            table.insert(optionsTable[submenuCounter].controls[trackerCounter].controls, {
                type = "description",
                title = "|cffd769"..trackerName.."|r",	--(optional)
                text = trackerVariables.description,
                width = "half",	--or "half" (optional)
            })
            table.insert(optionsTable[submenuCounter].controls[trackerCounter].controls, {
                type = "description",
                title = "|cffd769Text displayed when applied:|r",	--(optional)
                text = trackerVariables.text,
                width = "half",	--or "half" (optional)
            })
            table.insert(optionsTable[submenuCounter].controls[trackerCounter].controls, {
                type = "description",
                title = "|cffd769Text displayed when missing:|r",	--(optional)
                text = trackerVariables.textWhenMissing,
                width = "half",	--or "half" (optional)
            })
            table.insert(optionsTable[submenuCounter].controls[trackerCounter].controls, {
                type = "description",
                title = "|cffd769List of effect IDs:|r",	--(optional)
                text = createList(trackerVariables.ID),
                width = "half",	--or "half" (optional)
            })
            table.insert(optionsTable[submenuCounter].controls[trackerCounter].controls, {
                type = "description",
                title = "|cffd769Tracked item set:|r",	--(optional)
                text = trackerVariables.itemSetToShow or "none",
                width = "half",	--or "half" (optional)
            })
            table.insert(optionsTable[submenuCounter].controls[trackerCounter].controls, {
                type = "description",
                title = "|cffd769List of skill IDs:|r",	--(optional)
                text = createList(trackerVariables.skills or nil),
                width = "half",	--or "half" (optional)
            })
            --[[table.insert(optionsTable[1].controls, {
                type = "colorpicker",
                name = "Color (can be changed before adding)",
                --tooltip = "Color Picker's tooltip text.",
                getFunc = function() return 1, 0, 0, 1 end,	--(alpha is optional)
                setFunc = function(r,g,b,a) print(r, g, b, a) end,	--(alpha is optional)
                width = "half",	--or "half" (optional)
            })]]
            table.insert(optionsTable[submenuCounter].controls[trackerCounter].controls, {
                type = "button",
                name = "Add to current profile",
                --tooltip = "Button's tooltip text.",
                func = function() 
                           if typeToNumber[nameOfSubmenu] == 1 then

                                local freeSlot = HTT_functions.findFreeSlotInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable)
                                HTT_functions.addTracker(typeToNumber[nameOfSubmenu],trackerName,trackerVariables.ID,freeSlot,trackerVariables.text,trackerVariables.textWhenMissing,trackerVariables.color,trackerVariables.color2,trackerVariables.color3,trackerVariables.onlyPlayer,trackerVariables.skills or {},trackerVariables.itemSet or {},trackerVariables.itemSetNumber,trackerVariables.duration,trackerVariables.icon)  
                                refreshAllDebuffTrackerInfo()
                                if HTT:GetNamedChild("DurationTimerReticle"..freeSlot) == nil then
                                    HTT_functions.createDebuffControl(freeSlot)
                                    HTT_functions.createBossDebuffControl(freeSlot)
                                end
                                if trackerName == "Weapon Skill" then
                                    for _,abilityID in pairs(trackerVariables.ID) do
                                        HTT_functions.GenerateWeaponEvent(abilityID,freeSlot)
                                    end
                                else
                                    if type(trackerVariables.ID) == "table" then
                                        for _,abilityID in pairs(trackerVariables.ID) do
                                            HTT_functions.initializeEventsDebuffs(abilityID,freeSlot)
                                        end
                                    else
                                        HTT_functions.initializeEventsDebuffs(trackerVariables.ID,freeSlot)
                                    end
                                end
                                HTT_functions.reanchorReticle()
                                HTT_functions.reanchorBoss()

                           elseif typeToNumber[nameOfSubmenu] == 2 then

                                local freeSlot = HTT_functions.findFreeSlotInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffTable)
                                HTT_functions.addTracker(typeToNumber[nameOfSubmenu],trackerName,trackerVariables.ID,freeSlot,trackerVariables.text,trackerVariables.textWhenMissing,trackerVariables.color,trackerVariables.color2,trackerVariables.color3,trackerVariables.onlyPlayer,trackerVariables.skills or {},trackerVariables.itemSet or {},trackerVariables.itemSetNumber,trackerVariables.duration,trackerVariables.icon)  
                                refreshAllBuffTrackerInfo()
                                if HTTSelfBuffs:GetNamedChild("SelfBuffDurationTimer"..freeSlot) == nil then
                                    HTT_functions.createBuffControl(freeSlot)
                                end
                                if type(trackerVariables.ID) == "table" then
                                    for _,abilityID in pairs(trackerVariables.ID) do
                                            HTT_functions.initializeEventsBuffs(abilityID,freeSlot)
                                    end
                                else
                                    if trackerName == "Dragon Blood" then
				                        HTT_functions.initializeEventsBuffsCombatEvent(trackerVariables.ID,freeSlot,23)
			                        else
                                        HTT_functions.initializeEventsBuffs(trackerVariables.ID,freeSlot)
                                    end
                                end

                                HTT_functions.reanchorBuffs()

                           elseif typeToNumber[nameOfSubmenu] == 3 then

                                local freeSlot = HTT_functions.findFreeSlotInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable)
                                HTT_functions.addTracker(typeToNumber[nameOfSubmenu],trackerName,trackerVariables.ID,freeSlot,trackerVariables.text,trackerVariables.textWhenMissing,trackerVariables.color,trackerVariables.color2,trackerVariables.color3,trackerVariables.onlyPlayer,trackerVariables.skills or {},trackerVariables.itemSet or {},trackerVariables.itemSetNumber,trackerVariables.duration,trackerVariables.icon)  
                                refreshAllCooldownTrackerInfo()
                                if HTTCooldowns:GetNamedChild("CooldownDurationTimer"..freeSlot) == nil then
                                    HTT_functions.createCooldownControl(freeSlot)
                                end
                                if type(trackerVariables.ID) == "table" then
                                    for _,abilityID in pairs(trackerVariables.ID) do
                                        HTT_functions.GenerateCooldownEvent(abilityID,freeSlot)
                                    end
                                else
                                    HTT_functions.GenerateCooldownEvent(trackerVariables.ID,freeSlot)
                                end

                                HTT_functions.reanchorCooldowns()

                           end
				        end,
                width = "half",	--or "half" (optional)
                --warning = "Will need to reload the UI.",	--(optional)
            })
            trackerCounter = trackerCounter+1
        end
        
        submenuCounter = submenuCounter+1
    end

    LibAddonMenu2:RegisterOptionControls("Hyper Tanking Tools - Premade Trackers", optionsTable)



end

local sounds = {"none",SOUNDS.DUEL_START}


function HTT_LoadSettingsRaidAlerts()
    local panelData = {
        type = "panel",
        name = "Hyper Tanking Tools - Raid Alerts",
        displayName = "Hyper Tanking Tools - Raid Alerts",
        author = "Hyperioxes",
        version = "1.18",
	    website = "https://www.esoui.com/downloads/info2778-HyperTankingTools.html",
	    feedback = "https://www.esoui.com/downloads/info2778-HyperTankingTools.html#comments",
	    donation = "https://www.esoui.com/downloads/info2778-HyperTankingTools.html#donate",
        slashCommand = "/httra",
        registerForRefresh = true,
        registerForDefaults = true,
    }
    LibAddonMenu2:RegisterAddonPanel("Hyper Tanking Tools - Raid Alerts", panelData)

    local optionsTable = {}
    


    table.insert(optionsTable, {
        type = "checkbox",
        name =  "Asylum",
        getFunc = function() return  SVAW.Asylum end,
        setFunc = function(value) SVAW.Asylum = value 
        HTT_AsylumUIUpdate()
        end,
        width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
        type = "header",
        name = ZO_HIGHLIGHT_TEXT:Colorize("Saint Olms"),
        width = "full",	--or "half" (optional)
	})
    table.insert(optionsTable, {
        type = "checkbox",
        name =  "Turn ON/OFF",
        getFunc = function() return  SVAW.Olms end,
        setFunc = function(value) SVAW.Olms = value 
        HTT_AsylumUIUpdate()
        end,
        width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
        type = "checkbox",
        name =  "Scalding Roar (breath)",
        getFunc = function() return SVAW.OlmsBreath end,
        setFunc = function(value) SVAW.OlmsBreath = value 
        HTT_AsylumUIUpdate()
        end,
        width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
        type = "checkbox",
        name =  "Storm the Heavens (kite)",
        getFunc = function() return SVAW.OlmsKite end,
        setFunc = function(value) SVAW.OlmsKite = value 
        HTT_AsylumUIUpdate()
        end,
        width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
        type = "checkbox",
        name =  "Exhaustive Charges",
        getFunc = function() return SVAW.OlmsExhaustive end,
        setFunc = function(value) SVAW.OlmsExhaustive = value 
        HTT_AsylumUIUpdate()
        end,
        width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
        type = "header",
        name = ZO_HIGHLIGHT_TEXT:Colorize("Saint Llothis"),
        width = "full",	--or "half" (optional)
	})
    table.insert(optionsTable, {
        type = "checkbox",
        name =  "Turn ON/OFF",
        getFunc = function() return SVAW.Llothis end,
        setFunc = function(value) SVAW.Llothis = value 
        HTT_AsylumUIUpdate()
        end,
        width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
        type = "checkbox",
        name =  "Oppressive Bolts (interrupt)",
        getFunc = function() return SVAW.LlothisInterrupt end,
        setFunc = function(value) SVAW.LlothisInterrupt = value 
        HTT_AsylumUIUpdate()
        end,
        width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
        type = "dropdown",
        name =  "Oppressive Bolts (interrupt) Sound Alert",
        choices = sounds,
        getFunc = function() return SVAW.LlothisInterruptSound end,
        setFunc = function(value) SVAW.LlothisInterruptSound = value 
        HTT_AsylumUIUpdate()
        end,
        width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
        type = "checkbox",
        name =  "Defiling Dye Blast (cone)",
        getFunc = function() return SVAW.LlothisCone end,
        setFunc = function(value) SVAW.LlothisCone = value 
        HTT_AsylumUIUpdate()
        end,
        width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
        type = "checkbox",
        name =  "Pernicious Transmission (jump)",
        getFunc = function() return SVAW.LlothisJump end,
        setFunc = function(value) SVAW.LlothisJump = value 
        HTT_AsylumUIUpdate()
        end,
        width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
        type = "header",
        name = ZO_HIGHLIGHT_TEXT:Colorize("Saint Felms"),
        width = "full",	--or "half" (optional)
	})
    table.insert(optionsTable, {
        type = "checkbox",
        name =  "Turn ON/OFF",
        getFunc = function() return SVAW.Felms end,
        setFunc = function(value) SVAW.Felms = value 
        HTT_AsylumUIUpdate()
        end,
        width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
        type = "checkbox",
        name =  "Manifest Wrath",
        getFunc = function() return SVAW.FelmsManifest end,
        setFunc = function(value) SVAW.FelmsManifest = value 
        HTT_AsylumUIUpdate()
        end,
        width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
        type = "checkbox",
        name =  "Teleport Strike",
        getFunc = function() return SVAW.FelmsJump end,
        setFunc = function(value) SVAW.FelmsJump = value 
        HTT_AsylumUIUpdate()
        end,
        width = "full",	--or "half" (optional)
    })




    LibAddonMenu2:RegisterOptionControls("Hyper Tanking Tools - Raid Alerts", optionsTable)
end