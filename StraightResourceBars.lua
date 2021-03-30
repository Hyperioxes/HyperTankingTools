
local StartingHealth,StartingMaxHealth = GetUnitPower("player",POWERTYPE_HEALTH)
local StartingMagicka,StartingMaxMagicka = GetUnitPower("player",POWERTYPE_MAGICKA)
local StartingStamina,StartingMaxStamina = GetUnitPower("player",POWERTYPE_STAMINA)
local MkReadyAt = 0

local damageShield = 0


local function UpdateEvery100()
	local MKLine = HTTStaminaStraight:GetNamedChild("staminaMartialLine")
	local staminaMartialCooldown = MKLine:GetNamedChild("staminaMartialCooldown")
	if GetGameTimeSeconds() > MkReadyAt then
		staminaMartialCooldown:SetHidden(true)
	else
		staminaMartialCooldown:SetHidden(false)
	end
	staminaMartialCooldown:SetText(HTT_functions.HTT_processTimer((math.floor((MkReadyAt-GetGameTimeSeconds())*10)/10)))
	local health,maxHealth = GetUnitPower("player",POWERTYPE_HEALTH)
	local shield = GetUnitAttributeVisualizerEffectInfo("player",ATTRIBUTE_VISUAL_POWER_SHIELDING,STAT_MITIGATION,ATTRIBUTE_HEALTH,POWERTYPE_HEALTH) or 0
	damageShield = shield
	local straightHP = HTTHealthStraight:GetNamedChild("healthBar")
	local straightShield = HTTHealthStraight:GetNamedChild("shieldBar")
	local straightHPText = HTTHealthStraight:GetNamedChild("healthText")
	if shield>maxHealth then
		shield = maxHealth
	end
	straightHP:SetDimensions(300*(health/maxHealth),35)
	straightShield:SetDimensions(300*(shield/maxHealth),35)
	if shield > 0 then
		straightHPText:SetText(health.."/"..maxHealth.."["..shield.."] ("..math.floor((health/maxHealth)*100).."%)")
	else
		straightHPText:SetText(health.."/"..maxHealth.." ("..math.floor((health/maxHealth)*100).."%)")
	end

	-- DODGE ROLL ---

	local dodgeRollBar = HTTStaminaStraight:GetNamedChild("dodgeRollBarFill")
	local dodgeRollStackCounter = HTTStaminaStraight:GetNamedChild("dodgeRollBarCounter")
	local dodgeRollRemainingDuration,dodgeRollStacks = HTT_functions.GetUnitInfo({69143},"player")
	dodgeRollRemainingDuration = dodgeRollRemainingDuration/4
	dodgeRollBar:SetDimensions(120*dodgeRollRemainingDuration,15)
	if dodgeRollStacks > 0 then
		dodgeRollStackCounter:SetHidden(false)
		dodgeRollStackCounter:SetText(dodgeRollStacks)
	else
		dodgeRollStackCounter:SetHidden(true)
	end
	-- DODGE ROLL ---

	-- MOUNT STAMINA ---

	local mountStaminaIconFrame = HTTStaminaStraight:GetNamedChild("mountStaminaBarIconFrame")
	local mountStaminaBar = mountStaminaIconFrame:GetNamedChild("mountStaminaBarFill")
	local horseStamina,horseMaxStamina = GetUnitPower("player",POWERTYPE_MOUNT_STAMINA)
	if IsMounted() then
		mountStaminaBar:SetDimensions(120*(horseStamina/horseMaxStamina),15)
		mountStaminaIconFrame:SetHidden(false)
	else
		mountStaminaIconFrame:SetHidden(true)
	end

	-- MOUNT STAMINA ---



end

local function UpdateEvery1000()
	local stam,maxStam = GetUnitPower("player",POWERTYPE_STAMINA)
	local mag,maxMag = GetUnitPower("player",POWERTYPE_MAGICKA)
	local MagPoELine = HTTMagickaStraight:GetNamedChild("magickaPearlLine")
	local StamPoELine = HTTStaminaStraight:GetNamedChild("staminaPearlLine")
	local MKLine = HTTStaminaStraight:GetNamedChild("staminaMartialLine")
	if HTT_functions.CheckIfNumberOfPiecesIsWorn(1,"|H0:item:171437:364:50:0:0:0:0:0:0:0:0:0:0:0:2048:0:0:0:0:0:0|h|h") then
		if maxMag>maxStam then
			MagPoELine:SetHidden(false)
			StamPoELine:SetHidden(true)
		else
			MagPoELine:SetHidden(true)
			StamPoELine:SetHidden(false)
		end
	else
		MagPoELine:SetHidden(true)
		StamPoELine:SetHidden(true)
	end
	if HTT_functions.CheckIfNumberOfPiecesIsWorn(3,"|H1:item:95463:364:50:26845:370:50:4:0:0:0:0:0:0:0:2049:35:0:1:0:109:0|h|h") then
		MKLine:SetHidden(false)
	else
		MKLine:SetHidden(true)
	end
end



local function generateEvents()
	--999 HEALTH
	--1 MAGICKA
	--3 STAMINA

	--------- UPDATE EVENTS ------------
	EVENT_MANAGER:RegisterForUpdate("HTT_StraightResource_UpdateEvery100", 100,UpdateEvery100)
	EVENT_MANAGER:RegisterForUpdate("HTT_StraightResource_UpdateEvery1000", 1000,UpdateEvery1000)
	--------- UPDATE EVENTS ------------




	--------- MARTIAL KNOWLEDGE COOLDOWN EVENT ---------------

	EVENT_MANAGER:RegisterForEvent("HTTStraight_MartialKnowledgeCooldown", EVENT_COMBAT_EVENT, function()   
	MkReadyAt = GetGameTimeSeconds() + 8
	zo_callLater(function () 
	local current,max = GetUnitPower("player",POWERTYPE_STAMINA)
	local MKLine = HTTStaminaStraight:GetNamedChild("staminaMartialLine")
	local MKBackground = MKLine:GetNamedChild("staminaMartialLineIconOutline")
	local MKPercentage = MKLine:GetNamedChild("staminaMartialLinePercentage")
	MKPercentage:SetText(math.floor((current/max)*100).."%")
	local percentageColorToApply = {0.1,1,0.1} --green
	local colorToApply = {1,0.1,0.1} --red
	if current > max*0.5 then
		percentageColorToApply = {1,0.1,0.1} -- red
	end
	MKPercentage:SetColor(unpack(percentageColorToApply))
	if MkReadyAt > GetGameTimeSeconds() then
		colorToApply = {0.1,1,0.1} -- green
	end
	MKLine:SetColor(unpack(colorToApply))
	MKBackground:SetColor(unpack(colorToApply))
	end, 8000)
	----------MARTIAL KNOWLEDGE ---------------
	local current,max = GetUnitPower("player",POWERTYPE_STAMINA)
	local MKLine = HTTStaminaStraight:GetNamedChild("staminaMartialLine")
	local MKBackground = MKLine:GetNamedChild("staminaMartialLineIconOutline")
	local MKPercentage = MKLine:GetNamedChild("staminaMartialLinePercentage")
	MKPercentage:SetText(math.floor((current/max)*100).."%")
	local percentageColorToApply = {0.1,1,0.1} --green
	local colorToApply = {1,0.1,0.1} --red
	if current > max*0.5 then
		percentageColorToApply = {1,0.1,0.1} -- red
	end
	MKPercentage:SetColor(unpack(percentageColorToApply))
	if MkReadyAt > GetGameTimeSeconds() then
		colorToApply = {0.1,1,0.1} -- green
	end
	MKLine:SetColor(unpack(colorToApply))
	MKBackground:SetColor(unpack(colorToApply))
	---------- MARTIAL KNOWLEDGE ---------------
	end)
	EVENT_MANAGER:AddFilterForEvent("HTTStraight_MartialKnowledgeCooldown", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID,127070)
	EVENT_MANAGER:AddFilterForEvent("HTTStraight_MartialKnowledgeCooldown", EVENT_COMBAT_EVENT, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE ,1)

	--------- MARTIAL KNOWLEDGE COOLDOWN EVENT ---------------








	-------- HEALTH ----------
	EVENT_MANAGER:RegisterForEvent("HTTStraight_HealthUpdate", EVENT_POWER_UPDATE, function(_,player,type,_,current,max,idk)
	------- STRAIGHT ----------
	local straightHP = HTTHealthStraight:GetNamedChild("healthBar")
	local straightShield = HTTHealthStraight:GetNamedChild("shieldBar")
	local straightHPText = HTTHealthStraight:GetNamedChild("healthText")
	local shield = damageShield
	if shield>max then
		shield = max
	end
	straightHP:SetDimensions(300*(current/max),35)
	straightShield:SetDimensions(300*(shield/max),35)
	if shield > 0 then
		straightHPText:SetText(current.."/"..max.."["..shield.."] ("..math.floor((current/max)*100).."%)")
	else
		straightHPText:SetText(current.."/"..max.." ("..math.floor((current/max)*100).."%)")
	end
	end)
	------- STRAIGHT ----------

	------- CURVED ----------



	------- CURVED ----------
	EVENT_MANAGER:AddFilterForEvent("HTTStraight_HealthUpdate", EVENT_POWER_UPDATE, REGISTER_FILTER_UNIT_TAG ,"player")
	EVENT_MANAGER:AddFilterForEvent("HTTStraight_HealthUpdate", EVENT_POWER_UPDATE, REGISTER_FILTER_POWER_TYPE,-2)
	-------- HEALTH ----------



	-------- MAGICKA --------------------------------------------------------------------------------
	EVENT_MANAGER:RegisterForEvent("HTTStraight_MagickaUpdate", EVENT_POWER_UPDATE, function(_,player,type,_,current,max,idk)

	---------- BASE ----------------------------
	local straightMag = HTTMagickaStraight:GetNamedChild("magickaBarFill")
	local straightMagText = HTTMagickaStraight:GetNamedChild("magickaText")
	straightMag:SetDimensions(300*(current/max),35)
	straightMagText:SetText(current.."/"..max.." ("..math.floor((current/max)*100).."%)")
	---------- BASE ----------------------------

	---------- PEARLS OF EHLNOFEY ---------------
	local PoELine = HTTMagickaStraight:GetNamedChild("magickaPearlLine")
	local PoEBackground = PoELine:GetNamedChild("magickaPearlLineIconOutline")
	local PoEPercentage = PoELine:GetNamedChild("magickaPearlLinePercentage")
	PoEPercentage:SetText(math.floor((current/max)*100).."%")
	local colorToApply = {0.1,1,0.1}
	if current > max*0.3 then
		colorToApply = {1,0.1,0.1}
	end
	PoELine:SetColor(unpack(colorToApply))
	PoEBackground:SetColor(unpack(colorToApply))
	PoEPercentage:SetColor(unpack(colorToApply))
	---------- PEARLS OF EHLNOFEY ---------------

	end)
	EVENT_MANAGER:AddFilterForEvent("HTTStraight_MagickaUpdate", EVENT_POWER_UPDATE, REGISTER_FILTER_UNIT_TAG ,"player")
	EVENT_MANAGER:AddFilterForEvent("HTTStraight_MagickaUpdate", EVENT_POWER_UPDATE, REGISTER_FILTER_POWER_TYPE,0)
	-------- MAGICKA --------------------------------------------------------------------------------
	







	-------- STAMINA ----------
	EVENT_MANAGER:RegisterForEvent("HTTStraight_StaminaUpdate", EVENT_POWER_UPDATE, function(_,player,type,_,current,max,idk)
	---------- BASE ----------------------------
	local straightStam = HTTStaminaStraight:GetNamedChild("staminaBarFill")
	local straightStamText = HTTStaminaStraight:GetNamedChild("staminaText")
	straightStam:SetDimensions(300*(current/max),35)
	straightStamText:SetText(current.."/"..max.." ("..math.floor((current/max)*100).."%)")
	---------- BASE ----------------------------


	---------- PEARLS OF EHLNOFEY ---------------
	local PoELine = HTTStaminaStraight:GetNamedChild("staminaPearlLine")
	local PoEBackground = PoELine:GetNamedChild("staminaPearlLineIconOutline")
	local PoEPercentage = PoELine:GetNamedChild("staminaPearlLinePercentage")
	PoEPercentage:SetText(math.floor((current/max)*100).."%")
	local colorToApply = {0.1,1,0.1}
	if current > max*0.3 then
		colorToApply = {1,0.1,0.1}
	end
	PoELine:SetColor(unpack(colorToApply))
	PoEBackground:SetColor(unpack(colorToApply))
	PoEPercentage:SetColor(unpack(colorToApply))
	---------- PEARLS OF EHLNOFEY ---------------

	----------MARTIAL KNOWLEDGE ---------------
	local MKLine = HTTStaminaStraight:GetNamedChild("staminaMartialLine")
	local MKBackground = MKLine:GetNamedChild("staminaMartialLineIconOutline")
	local MKPercentage = MKLine:GetNamedChild("staminaMartialLinePercentage")
	MKPercentage:SetText(math.floor((current/max)*100).."%")
	local percentageColorToApply = {0.1,1,0.1} --green
	local colorToApply = {1,0.1,0.1} --red
	if current > max*0.5 then
		percentageColorToApply = {1,0.1,0.1} -- red
	end
	MKPercentage:SetColor(unpack(percentageColorToApply))
	if MkReadyAt > GetGameTimeSeconds() then
		colorToApply = {0.1,1,0.1} -- green
	end
	MKLine:SetColor(unpack(colorToApply))
	MKBackground:SetColor(unpack(colorToApply))
	---------- MARTIAL KNOWLEDGE ---------------

	end)
	EVENT_MANAGER:AddFilterForEvent("HTTStraight_StaminaUpdate", EVENT_POWER_UPDATE, REGISTER_FILTER_UNIT_TAG ,"player")
	EVENT_MANAGER:AddFilterForEvent("HTTStraight_StaminaUpdate", EVENT_POWER_UPDATE, REGISTER_FILTER_POWER_TYPE,6)
	-------- STAMINA ----------
end

local function removeEvents()
	EVENT_MANAGER:UnregisterForEvent("HTTStraight_MartialKnowledgeCooldown", EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent("HTTStraight_HealthUpdate", EVENT_POWER_UPDATE)
	EVENT_MANAGER:UnregisterForEvent("HTTStraight_StaminaUpdate", EVENT_POWER_UPDATE)
	EVENT_MANAGER:UnregisterForEvent("HTTStraight_MagickaUpdate", EVENT_POWER_UPDATE)
	EVENT_MANAGER:UnregisterForUpdate("HTT_StraightResource_UpdateEvery100", 100)
	EVENT_MANAGER:UnregisterForUpdate("HTT_StraightResource_UpdateEvery1000", 1000)
end






function HTT_InitializeStraightUI()
	local WM = GetWindowManager()
	local HTTHealthStraight = WM:CreateTopLevelWindow("HTTHealthStraight")
	local HTTStaminaStraight = WM:CreateTopLevelWindow("HTTStaminaStraight")
	local HTTMagickaStraight = WM:CreateTopLevelWindow("HTTMagickaStraight")


	HTTHealthStraight:SetResizeToFitDescendents(true)
    HTTHealthStraight:SetMovable(false)
    HTTHealthStraight:SetMouseEnabled(true)
	HTTHealthStraight:SetHidden(false)

	HTTStaminaStraight:SetResizeToFitDescendents(true)
    HTTStaminaStraight:SetMovable(false)
    HTTStaminaStraight:SetMouseEnabled(true)
	HTTStaminaStraight:SetHidden(false)

	HTTMagickaStraight:SetResizeToFitDescendents(true)
    HTTMagickaStraight:SetMovable(false)
    HTTMagickaStraight:SetMouseEnabled(true)
	HTTMagickaStraight:SetHidden(false)

	local Rwidth, Rheight = GuiRoot:GetDimensions()
	HTTHealthStraight:SetHandler("OnMoveStop", function(control)
        HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetHealthStraight = HTTHealthStraight:GetLeft() - (Rwidth*0.421875)
	    HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetHealthStraight  = HTTHealthStraight:GetTop() - (Rheight/1.1125)
    end)

	HTTStaminaStraight:SetHandler("OnMoveStop", function(control)
        HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetStaminaStraight = HTTStaminaStraight:GetLeft() - (Rwidth*0.63)
	    HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetStaminaStraight  = HTTStaminaStraight:GetTop() - (Rheight/1.1125)
    end)

	HTTMagickaStraight:SetHandler("OnMoveStop", function(control)
        HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetMagickaStraight = HTTMagickaStraight:GetLeft() - (Rwidth*0.213541)
	    HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetMagickaStraight  = HTTMagickaStraight:GetTop() - (Rheight/1.1125)
    end)

	------------------ HEALTH -----------------------------

	local healtBarOutline = WM:CreateControl("$(parent)healtBarOutline",HTTHealthStraight,  CT_TEXTURE, 4)
	healtBarOutline:SetDimensions(300,35)
	healtBarOutline:SetAnchor(TOPLEFT,HTTHealthStraight,TOPLEFT,0,0)
	healtBarOutline:SetTexture("HyperTankingTools/icons/straightOutlineBar.dds")
	healtBarOutline:SetColor(0.1,0.1,0.1)
	healtBarOutline:SetHidden(false)
	healtBarOutline:SetDrawLayer(3)

	local healtBarOutlineOpaque = WM:CreateControl("$(parent)healtBarOutlineOpaque",HTTHealthStraight,  CT_TEXTURE, 4)
	healtBarOutlineOpaque:SetDimensions(300,35)
	healtBarOutlineOpaque:SetAnchor(CENTER,healtBarOutline,CENTER,0,0)
	healtBarOutlineOpaque:SetTexture("HyperTankingTools/icons/straightFillBar.dds")
	healtBarOutlineOpaque:SetColor(0.1,0.1,0.1,0.6)
	healtBarOutlineOpaque:SetHidden(false)
	healtBarOutlineOpaque:SetDrawLayer(0)

	local healthBar = WM:CreateControl("$(parent)healthBar",HTTHealthStraight,  CT_TEXTURE, 4)
	healthBar:SetDimensions(300,35)
	healthBar:SetAnchor(CENTER,healtBarOutline,CENTER,0,0)
	healthBar:SetTexture("HyperTankingTools/icons/straightFillBar.dds")
	healthBar:SetColor(214/255,0,0)
	healthBar:SetHidden(false)
	healthBar:SetDrawLayer(1)

	local shieldBar = WM:CreateControl("$(parent)shieldBar",HTTHealthStraight,  CT_TEXTURE, 4)
	shieldBar:SetDimensions(300,35)
	shieldBar:SetAnchor(CENTER,healtBarOutline,CENTER,0,0)
	--shieldBar:SetTexture("HyperTankingTools/icons/straightFillBar.dds")
	shieldBar:SetColor(1,0.7,0.7,0.5)
	shieldBar:SetHidden(false)
	shieldBar:SetDrawLayer(2)

	local healthText = WM:CreateControl("$(parent)healthText",HTTHealthStraight,CT_LABEL)
	healthText:SetFont("ZoFontGameSmall")
	healthText:SetScale(1.0)
	healthText:SetDrawLayer(3)
	healthText:SetColor(255, 255, 255, 1)
	healthText:SetText(StartingHealth.."/"..StartingMaxHealth.." ("..math.floor((StartingHealth/StartingMaxHealth)*100).."%)")			
	healthText:SetAnchor(CENTER, healtBarOutlineOpaque, CENTER,0,0)
	healthText:SetDimensions(300, 35)
	healthText:SetHidden(false)
	healthText:SetHorizontalAlignment(1)
	healthText:SetVerticalAlignment(1)


	------------------ HEALTH -----------------------------

	------------------ MAGICKA -----------------------------


	local magickaBarOutline = WM:CreateControl("$(parent)magickaBarOutline",HTTMagickaStraight,  CT_TEXTURE, 4)
	magickaBarOutline:SetDimensions(300,35)
	magickaBarOutline:SetAnchor(TOPLEFT,HTTMagickaStraight,TOPLEFT,0,0)
	magickaBarOutline:SetColor(0.1,0.1,0.1)
	magickaBarOutline:SetTexture("HyperTankingTools/icons/straightOutlineBar.dds")
	magickaBarOutline:SetHidden(false)
	magickaBarOutline:SetDrawLayer(2)

	local magickaBarOutlineOpaque = WM:CreateControl("$(parent)magickaBarOutlineOpaque",HTTMagickaStraight,  CT_TEXTURE, 4)
	magickaBarOutlineOpaque:SetDimensions(300,35)
	magickaBarOutlineOpaque:SetAnchor(CENTER,magickaBarOutline,CENTER,0,0)
	magickaBarOutlineOpaque:SetTexture("HyperTankingTools/icons/straightFillBar.dds")
	magickaBarOutlineOpaque:SetColor(0.1,0.1,0.1,0.6)
	magickaBarOutlineOpaque:SetHidden(false)
	magickaBarOutlineOpaque:SetDrawLayer(0)

	local magickaPearlLine = WM:CreateControl("$(parent)magickaPearlLine",HTTMagickaStraight,  CT_TEXTURE, 4)
	magickaPearlLine:SetDimensions(4,75)
	magickaPearlLine:SetAnchor(CENTER,magickaBarOutlineOpaque,CENTER,60,0)
	magickaPearlLine:SetColor(1,0.1,0.1,1)
	magickaPearlLine:SetHidden(true)
	magickaPearlLine:SetDrawLayer(3)

	local magickaPearlLineIconOutline = WM:CreateControl("$(parent)magickaPearlLineIconOutline",magickaPearlLine,  CT_TEXTURE, 4)
	magickaPearlLineIconOutline:SetDimensions(64,64)
	magickaPearlLineIconOutline:SetAnchor(BOTTOM,magickaPearlLine,TOP,0,15)
	magickaPearlLineIconOutline:SetColor(1,0.1,0.1)
	magickaPearlLineIconOutline:SetTexture("HyperTankingTools/icons/frame.dds")
	magickaPearlLineIconOutline:SetHidden(false)
	magickaPearlLineIconOutline:SetDrawLayer(4)

	local magickaPearlLinePercentage = WM:CreateControl("$(parent)magickaPearlLinePercentage",magickaPearlLine,CT_LABEL)
	magickaPearlLinePercentage:SetFont("ZoFontWindowTitle")
	magickaPearlLinePercentage:SetScale(1.0)
	magickaPearlLinePercentage:SetDrawLayer(1)
	magickaPearlLinePercentage:SetText("100%")				
	magickaPearlLinePercentage:SetAnchor(BOTTOM, magickaPearlLineIconOutline, TOP,0,-4)
	magickaPearlLinePercentage:SetDimensions(64,26)
	magickaPearlLinePercentage:SetHidden(false)
	magickaPearlLinePercentage:SetHorizontalAlignment(1)
	magickaPearlLinePercentage:SetVerticalAlignment(1)
	magickaPearlLinePercentage:SetColor(1,0.1,0.1)

	local magickaPearlLineIconBackground = WM:CreateControl("$(parent)magickaPearlLineIconBackground",magickaPearlLine,  CT_TEXTURE, 4)
	magickaPearlLineIconBackground:SetDimensions(60,60)
	magickaPearlLineIconBackground:SetAnchor(CENTER,magickaPearlLineIconOutline,CENTER,0,0)
	magickaPearlLineIconBackground:SetColor(0.1,0.1,0.1)
	magickaPearlLineIconBackground:SetTexture("HyperTankingTools/icons/frameFilled.dds")
	magickaPearlLineIconBackground:SetHidden(false)
	magickaPearlLineIconBackground:SetDrawLayer(3)

	local magickaPearlLineIcon = WM:CreateControl("$(parent)magickaPearlLineIcon",magickaPearlLine,  CT_TEXTURE, 4)
	magickaPearlLineIcon:SetDimensions(56,56)
	magickaPearlLineIcon:SetAnchor(CENTER,magickaPearlLineIconBackground,CENTER,0,0)
	magickaPearlLineIcon:SetTexture("/esoui/art/icons/antiquities_ornate_necklace_3.dds")
	magickaPearlLineIcon:SetHidden(false)
	magickaPearlLineIcon:SetDrawLayer(4)

	local magickaBarFill = WM:CreateControl("$(parent)magickaBarFill",HTTMagickaStraight,  CT_TEXTURE, 4)
	magickaBarFill:SetDimensions(300,35)
	magickaBarFill:SetAnchor(TOPRIGHT,magickaBarOutline,TOPRIGHT,0,0)
	magickaBarFill:SetTexture("HyperTankingTools/icons/straightFillBar.dds")
	magickaBarFill:SetColor(0,0,222/255)
	magickaBarFill:SetHidden(false)
	magickaBarFill:SetDrawLayer(1)

	local magickaText = WM:CreateControl("$(parent)magickaText",HTTMagickaStraight,CT_LABEL)
	magickaText:SetFont("ZoFontGameSmall")
	magickaText:SetScale(1.0)
	magickaText:SetDrawLayer(4)
	magickaText:SetColor(255, 255, 255, 1)
	magickaText:SetText(StartingMagicka.."/"..StartingMaxMagicka.." ("..math.floor((StartingMagicka/StartingMaxMagicka)*100).."%)")				
	magickaText:SetAnchor(CENTER, magickaBarOutlineOpaque, CENTER,0, 0)
	magickaText:SetDimensions(300, 35)
	magickaText:SetHidden(false)
	magickaText:SetHorizontalAlignment(1)
	magickaText:SetVerticalAlignment(1)

	local newControl = ZO_Object.New(self)


	------------------ MAGICKA -----------------------------

	------------------ STAMINA -----------------------------

	local staminaBarOutline = WM:CreateControl("$(parent)staminaBarOutline",HTTStaminaStraight,  CT_TEXTURE, 4)
	staminaBarOutline:SetDimensions(300,35)
	staminaBarOutline:SetAnchor(TOPLEFT,HTTStaminaStraight,TOPLEFT,0,0)
	staminaBarOutline:SetTexture("HyperTankingTools/icons/straightOutlineBar.dds")
	staminaBarOutline:SetColor(0.1,0.1,0.1)
	staminaBarOutline:SetHidden(false)
	staminaBarOutline:SetDrawLayer(2)

	local staminaBarOutlineOpaque = WM:CreateControl("$(parent)staminaBarOutlineOpaque",HTTStaminaStraight,  CT_TEXTURE, 4)
	staminaBarOutlineOpaque:SetDimensions(300,35)
	staminaBarOutlineOpaque:SetAnchor(CENTER,staminaBarOutline,CENTER,0,0)
	staminaBarOutlineOpaque:SetTexture("HyperTankingTools/icons/straightFillBar.dds")
	staminaBarOutlineOpaque:SetColor(0.1,0.1,0.1,0.6)
	staminaBarOutlineOpaque:SetHidden(false)
	staminaBarOutlineOpaque:SetDrawLayer(0)

	local dodgeRollBarIconFrame = WM:CreateControl("$(parent)dodgeRollBarIconFrame",HTTStaminaStraight,  CT_TEXTURE, 4)
	dodgeRollBarIconFrame:SetDimensions(32,32)
	dodgeRollBarIconFrame:SetAnchor(BOTTOMRIGHT,staminaBarOutline,TOPRIGHT,40,-5)
	dodgeRollBarIconFrame:SetTexture("HyperTankingTools/icons/frame.dds")
	dodgeRollBarIconFrame:SetColor(0.1,0.1,0.1,1)
	dodgeRollBarIconFrame:SetHidden(false)
	dodgeRollBarIconFrame:SetDrawLayer(1)

	local dodgeRollBarCounter = WM:CreateControl("$(parent)dodgeRollBarCounter",HTTStaminaStraight,CT_LABEL)
	dodgeRollBarCounter:SetFont("ZoFontWindowTitle")
	dodgeRollBarCounter:SetScale(0.8)
	dodgeRollBarCounter:SetDrawLayer(2)
	dodgeRollBarCounter:SetText("0")				
	dodgeRollBarCounter:SetAnchor(CENTER, dodgeRollBarIconFrame, CENTER,0,-4)
	dodgeRollBarCounter:SetDimensions(32,32)
	dodgeRollBarCounter:SetHidden(false)
	dodgeRollBarCounter:SetHorizontalAlignment(1)
	dodgeRollBarCounter:SetVerticalAlignment(1)
	dodgeRollBarCounter:SetColor(1,1,1,1)

	local dodgeRollBarIcon = WM:CreateControl("$(parent)dodgeRollBarIcon",HTTStaminaStraight,  CT_TEXTURE, 4)
	dodgeRollBarIcon:SetDimensions(23,23)
	dodgeRollBarIcon:SetAnchor(CENTER,dodgeRollBarIconFrame,CENTER,0,0)
	dodgeRollBarIcon:SetTexture("esoui/art/icons/ability_rogue_037.dds")
	dodgeRollBarIcon:SetColor(1,1,1,1)
	dodgeRollBarIcon:SetHidden(false)
	dodgeRollBarIcon:SetDrawLayer(0)

	local dodgeRollBarOutline = WM:CreateControl("$(parent)dodgeRollBarOutline",HTTStaminaStraight,  CT_TEXTURE, 4)
	dodgeRollBarOutline:SetDimensions(120,15)
	dodgeRollBarOutline:SetAnchor(RIGHT,dodgeRollBarIconFrame,LEFT,4,0)
	dodgeRollBarOutline:SetTexture("HyperTankingTools/icons/straightOutlineBar.dds")
	dodgeRollBarOutline:SetColor(0.1,0.1,0.1,1)
	dodgeRollBarOutline:SetHidden(false)
	dodgeRollBarOutline:SetDrawLayer(0)

	local dodgeRollBarOutlineOpaque = WM:CreateControl("$(parent)dodgeRollBarOutlineOpaque",HTTStaminaStraight,  CT_TEXTURE, 4)
	dodgeRollBarOutlineOpaque:SetDimensions(120,15)
	dodgeRollBarOutlineOpaque:SetAnchor(CENTER,dodgeRollBarOutline,CENTER,0,0)
	dodgeRollBarOutlineOpaque:SetTexture("HyperTankingTools/icons/straightFillBar.dds")
	dodgeRollBarOutlineOpaque:SetColor(0.1,0.1,0.1,0.6)
	dodgeRollBarOutlineOpaque:SetHidden(false)
	dodgeRollBarOutlineOpaque:SetDrawLayer(0)

	local dodgeRollBarFill = WM:CreateControl("$(parent)dodgeRollBarFill",HTTStaminaStraight,  CT_TEXTURE, 4)
	dodgeRollBarFill:SetDimensions(120,15)
	dodgeRollBarFill:SetAnchor(RIGHT,dodgeRollBarOutlineOpaque,RIGHT,0,0)
	dodgeRollBarFill:SetTexture("HyperTankingTools/icons/straightFillBar.dds")
	dodgeRollBarFill:SetColor(0,0.4,0)
	dodgeRollBarFill:SetHidden(false)
	dodgeRollBarFill:SetDrawLayer(0)

	local mountStaminaBarIconFrame = WM:CreateControl("$(parent)mountStaminaBarIconFrame",HTTStaminaStraight,  CT_TEXTURE, 4)
	mountStaminaBarIconFrame:SetDimensions(32,32)
	mountStaminaBarIconFrame:SetAnchor(TOPRIGHT,staminaBarOutline,BOTTOMRIGHT,40,5)
	mountStaminaBarIconFrame:SetTexture("HyperTankingTools/icons/frameFilled.dds")
	mountStaminaBarIconFrame:SetColor(0.1,0.1,0.1,1)
	mountStaminaBarIconFrame:SetHidden(false)
	mountStaminaBarIconFrame:SetDrawLayer(0)

	local mountStaminaBarIcon = WM:CreateControl("$(parent)mountStaminaBarIcon",mountStaminaBarIconFrame,  CT_TEXTURE, 4)
	mountStaminaBarIcon:SetDimensions(23,23)
	mountStaminaBarIcon:SetAnchor(CENTER,mountStaminaBarIconFrame,CENTER,0,0)
	mountStaminaBarIcon:SetTexture("/esoui/art/mountportraits/mountportait_horse_e.dds")
	mountStaminaBarIcon:SetColor(1,1,1,1)
	mountStaminaBarIcon:SetHidden(false)
	mountStaminaBarIcon:SetDrawLayer(0)

	local mountStaminaBarOutline = WM:CreateControl("$(parent)mountStaminaBarOutline",mountStaminaBarIconFrame,  CT_TEXTURE, 4)
	mountStaminaBarOutline:SetDimensions(120,15)
	mountStaminaBarOutline:SetAnchor(RIGHT,mountStaminaBarIconFrame,LEFT,4,0)
	mountStaminaBarOutline:SetTexture("HyperTankingTools/icons/straightOutlineBar.dds")
	mountStaminaBarOutline:SetColor(0.1,0.1,0.1,1)
	mountStaminaBarOutline:SetHidden(false)
	mountStaminaBarOutline:SetDrawLayer(0)

	local mountStaminaBarOutlineOpaque = WM:CreateControl("$(parent)mountStaminaBarOutlineOpaque",mountStaminaBarIconFrame,  CT_TEXTURE, 4)
	mountStaminaBarOutlineOpaque:SetDimensions(120,15)
	mountStaminaBarOutlineOpaque:SetAnchor(CENTER,mountStaminaBarOutline,CENTER,0,0)
	mountStaminaBarOutlineOpaque:SetTexture("HyperTankingTools/icons/straightFillBar.dds")
	mountStaminaBarOutlineOpaque:SetColor(0.1,0.1,0.1,0.6)
	mountStaminaBarOutlineOpaque:SetHidden(false)
	mountStaminaBarOutlineOpaque:SetDrawLayer(0)

	local mountStaminaBarFill = WM:CreateControl("$(parent)mountStaminaBarFill",mountStaminaBarIconFrame,  CT_TEXTURE, 4)
	mountStaminaBarFill:SetDimensions(120,15)
	mountStaminaBarFill:SetAnchor(RIGHT,mountStaminaBarOutlineOpaque,RIGHT,0,0)
	mountStaminaBarFill:SetTexture("HyperTankingTools/icons/straightFillBar.dds")
	mountStaminaBarFill:SetColor(0, 212/255, 0)
	mountStaminaBarFill:SetHidden(false)
	mountStaminaBarFill:SetDrawLayer(0)

	local staminaMartialLine = WM:CreateControl("$(parent)staminaMartialLine",HTTStaminaStraight,  CT_TEXTURE, 4)
	staminaMartialLine:SetDimensions(4,75)
	staminaMartialLine:SetAnchor(CENTER,staminaBarOutlineOpaque,CENTER,0,0)
	staminaMartialLine:SetColor(1,0.1,0.1,1)
	staminaMartialLine:SetHidden(true)
	staminaMartialLine:SetDrawLayer(3)

	local staminaMartialLineIconOutline = WM:CreateControl("$(parent)staminaMartialLineIconOutline",staminaMartialLine,  CT_TEXTURE, 4)
	staminaMartialLineIconOutline:SetDimensions(64,64)
	staminaMartialLineIconOutline:SetAnchor(BOTTOM,staminaMartialLine,TOP,0,15)
	staminaMartialLineIconOutline:SetColor(1,0.1,0.1)
	staminaMartialLineIconOutline:SetTexture("HyperTankingTools/icons/frame.dds")
	staminaMartialLineIconOutline:SetHidden(false)
	staminaMartialLineIconOutline:SetDrawLayer(4)

	local staminaMartialCooldown = WM:CreateControl("$(parent)staminaMartialCooldown",staminaMartialLine,CT_LABEL)
	staminaMartialCooldown:SetFont("ZoFontWindowTitle")
	staminaMartialCooldown:SetScale(1.0)
	staminaMartialCooldown:SetDrawLayer(4)
	staminaMartialCooldown:SetText("8.0")				
	staminaMartialCooldown:SetAnchor(CENTER, staminaMartialLineIconOutline, CENTER,0,0)
	staminaMartialCooldown:SetDimensions(64,64)
	staminaMartialCooldown:SetHidden(false)
	staminaMartialCooldown:SetHorizontalAlignment(1)
	staminaMartialCooldown:SetVerticalAlignment(1)
	staminaMartialCooldown:SetColor(0.1,1,0.1,1)

	local staminaMartialLinePercentage = WM:CreateControl("$(parent)staminaMartialLinePercentage",staminaMartialLine,CT_LABEL)
	staminaMartialLinePercentage:SetFont("ZoFontWindowTitle")
	staminaMartialLinePercentage:SetScale(1.0)
	staminaMartialLinePercentage:SetDrawLayer(1)
	staminaMartialLinePercentage:SetText("100%")				
	staminaMartialLinePercentage:SetAnchor(BOTTOM, staminaMartialLineIconOutline, TOP,0,-4)
	staminaMartialLinePercentage:SetDimensions(64,26)
	staminaMartialLinePercentage:SetHidden(false)
	staminaMartialLinePercentage:SetHorizontalAlignment(1)
	staminaMartialLinePercentage:SetVerticalAlignment(1)
	staminaMartialLinePercentage:SetColor(1,0.1,0.1)


	local staminaMartialLineIcon = WM:CreateControl("$(parent)staminaMartialLineIcon",staminaMartialLine,  CT_TEXTURE, 4)
	staminaMartialLineIcon:SetDimensions(46,46)
	staminaMartialLineIcon:SetAnchor(CENTER,staminaMartialLineIconOutline,CENTER,0,0)
	staminaMartialLineIcon:SetTexture("/esoui/art/icons/ability_mage_044.dds")
	staminaMartialLineIcon:SetHidden(false)
	staminaMartialLineIcon:SetDrawLayer(3)

	local staminaPearlLine = WM:CreateControl("$(parent)staminaPearlLine",HTTStaminaStraight,  CT_TEXTURE, 4)
	staminaPearlLine:SetDimensions(4,75)
	staminaPearlLine:SetAnchor(CENTER,staminaBarOutlineOpaque,CENTER,-60,0)
	staminaPearlLine:SetColor(1,0.1,0.1,1)
	staminaPearlLine:SetHidden(true)
	staminaPearlLine:SetDrawLayer(3)

	local staminaPearlLineIconOutline = WM:CreateControl("$(parent)staminaPearlLineIconOutline",staminaPearlLine,  CT_TEXTURE, 4)
	staminaPearlLineIconOutline:SetDimensions(64,64)
	staminaPearlLineIconOutline:SetAnchor(BOTTOM,staminaPearlLine,TOP,0,15)
	staminaPearlLineIconOutline:SetColor(1,0.1,0.1)
	staminaPearlLineIconOutline:SetTexture("HyperTankingTools/icons/frame.dds")
	staminaPearlLineIconOutline:SetHidden(false)
	staminaPearlLineIconOutline:SetDrawLayer(4)

	local staminaPearlLinePercentage = WM:CreateControl("$(parent)staminaPearlLinePercentage",staminaPearlLine,CT_LABEL)
	staminaPearlLinePercentage:SetFont("ZoFontWindowTitle")
	staminaPearlLinePercentage:SetScale(1.0)
	staminaPearlLinePercentage:SetDrawLayer(1)
	staminaPearlLinePercentage:SetText("100%")				
	staminaPearlLinePercentage:SetAnchor(BOTTOM, staminaPearlLineIconOutline, TOP,0,-4)
	staminaPearlLinePercentage:SetDimensions(64,26)
	staminaPearlLinePercentage:SetHidden(false)
	staminaPearlLinePercentage:SetHorizontalAlignment(1)
	staminaPearlLinePercentage:SetVerticalAlignment(1)
	staminaPearlLinePercentage:SetColor(1,0.1,0.1)

	local staminaPearlLineIconBackground = WM:CreateControl("$(parent)staminaPearlLineIconBackground",staminaPearlLine,  CT_TEXTURE, 4)
	staminaPearlLineIconBackground:SetDimensions(60,60)
	staminaPearlLineIconBackground:SetAnchor(CENTER,staminaPearlLineIconOutline,CENTER,0,0)
	staminaPearlLineIconBackground:SetColor(0.1,0.1,0.1)
	staminaPearlLineIconBackground:SetTexture("HyperTankingTools/icons/frameFilled.dds")
	staminaPearlLineIconBackground:SetHidden(false)
	staminaPearlLineIconBackground:SetDrawLayer(3)

	local staminaPearlLineIcon = WM:CreateControl("$(parent)staminaPearlLineIcon",staminaPearlLine,  CT_TEXTURE, 4)
	staminaPearlLineIcon:SetDimensions(56,56)
	staminaPearlLineIcon:SetAnchor(CENTER,staminaPearlLineIconBackground,CENTER,0,0)
	staminaPearlLineIcon:SetTexture("/esoui/art/icons/antiquities_ornate_necklace_3.dds")
	staminaPearlLineIcon:SetHidden(false)
	staminaPearlLineIcon:SetDrawLayer(4)

	local staminaBarFill = WM:CreateControl("$(parent)staminaBarFill",HTTStaminaStraight,  CT_TEXTURE, 4)
	staminaBarFill:SetDimensions(300,35)
	staminaBarFill:SetAnchor(TOPLEFT,staminaBarOutline,TOPLEFT,0,0)
	staminaBarFill:SetTexture("HyperTankingTools/icons/straightFillBar.dds")
	staminaBarFill:SetColor(19/255,189/255,0)
	staminaBarFill:SetHidden(false)
	staminaBarFill:SetDrawLayer(1)

	local staminaText = WM:CreateControl("$(parent)staminaText",HTTStaminaStraight,CT_LABEL)
	staminaText:SetFont("ZoFontGameSmall")
	staminaText:SetScale(1.0)
	staminaText:SetDrawLayer(4)
	staminaText:SetColor(255, 255, 255, 1)
	staminaText:SetText(StartingStamina.."/"..StartingMaxStamina.." ("..math.floor((StartingStamina/StartingMaxStamina)*100).."%)")				
	staminaText:SetAnchor(CENTER, staminaBarOutline, CENTER,0, 0)
	staminaText:SetDimensions(300, 35)
	staminaText:SetHidden(false)
	staminaText:SetHorizontalAlignment(1)
	staminaText:SetVerticalAlignment(1)

	------------------ STAMINA -----------------------------





	HTTHealthStraight:ClearAnchors()
	HTTHealthStraight:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,(Rwidth*0.421875)+HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetHealthStraight,(Rheight/1.1125)+HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetHealthStraight)
	HTTStaminaStraight:ClearAnchors()
	HTTStaminaStraight:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,(Rwidth*0.63)+HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetStaminaStraight,(Rheight/1.1125)+HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetStaminaStraight)
	HTTMagickaStraight:ClearAnchors()
	HTTMagickaStraight:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,(Rwidth*0.213541)+HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetMagickaStraight,(Rheight/1.1125)+HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetMagickaStraight)

	HTT_switchStraightUI(HTTsavedVars[HTT_variables.currentlySelectedProfile].isStraightResourceOn)

end

local function onSceneChange(_,scene)
	if scene == SCENE_SHOWN then
		HTTHealthStraight:SetHidden(false)
		HTTStaminaStraight:SetHidden(false)
		HTTMagickaStraight:SetHidden(false)
	else
		HTTHealthStraight:SetHidden(true)
		HTTStaminaStraight:SetHidden(true)
		HTTMagickaStraight:SetHidden(true)
	end
end

function HTT_switchStraightUI(turnedOn)
	if turnedOn then
		HTTHealthStraight:SetHidden(false)
		HTTStaminaStraight:SetHidden(false)
		HTTMagickaStraight:SetHidden(false)
		SCENE_MANAGER:GetScene("hud"):RegisterCallback("StateChange", onSceneChange)
		SCENE_MANAGER:GetScene("hudui"):RegisterCallback("StateChange", onSceneChange)
		generateEvents()
	else
		HTTHealthStraight:SetHidden(true)
		HTTStaminaStraight:SetHidden(true)
		HTTMagickaStraight:SetHidden(true)
		SCENE_MANAGER:GetScene("hud"):UnregisterCallback("StateChange", onSceneChange)
		SCENE_MANAGER:GetScene("hudui"):UnregisterCallback("StateChange", onSceneChange)
		removeEvents()
	end
end

