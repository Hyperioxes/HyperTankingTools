HTT_initializeUI = {}





function HTT_initializeUI.generateUI()

	local WM = GetWindowManager()
	local HTT = WM:CreateTopLevelWindow("HTT")
	local HTTOwnStacks = WM:CreateTopLevelWindow("HTTOwnStacks")
	local HTTBlock = WM:CreateTopLevelWindow("HTTBlock")
	local HTTSelfBuffs = WM:CreateTopLevelWindow("HTTSelfBuffs")
	for i=1,MAX_BOSSES do
		_G["HTTBoss"..i] = WM:CreateTopLevelWindow("HTTBoss"..i)
	end
	local HTTCooldowns = WM:CreateTopLevelWindow("HTTCooldowns")
	local HTTAlert = WM:CreateTopLevelWindow("HTTAlert")
	local HTTHealth = WM:CreateTopLevelWindow("HTTHealth")
	local HTTStamina = WM:CreateTopLevelWindow("HTTStamina")
	local HTTMagicka = WM:CreateTopLevelWindow("HTTMagicka")
	local HTTSynergies = WM:CreateTopLevelWindow("HTTSynergies")
	local HTTReflect = WM:CreateTopLevelWindow("HTTReflect")

	
	

	

    HTT:SetResizeToFitDescendents(true)
    HTT:SetMovable(true)
    HTT:SetMouseEnabled(true)
	HTT:SetHidden(true)
	HTT:SetScale(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIScale)


	HTTOwnStacks:SetResizeToFitDescendents(true)
    HTTOwnStacks:SetMovable(true)
    HTTOwnStacks:SetMouseEnabled(true)
	HTTOwnStacks:SetHidden(true)
	HTTOwnStacks:SetScale(HTTsavedVars[HTT_variables.currentlySelectedProfile].specialUIScale)

	HTTBlock:SetResizeToFitDescendents(true)
    HTTBlock:SetMovable(true)
    HTTBlock:SetMouseEnabled(true)
	HTTBlock:SetHidden(true)

	HTTSelfBuffs:SetResizeToFitDescendents(true)
    HTTSelfBuffs:SetMovable(true)
    HTTSelfBuffs:SetMouseEnabled(true)
	HTTSelfBuffs:SetHidden(true)
	HTTSelfBuffs:SetScale(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffUIScale)

	for i=1,MAX_BOSSES do
		_G["HTTBoss"..i]:SetResizeToFitDescendents(true)
		_G["HTTBoss"..i]:SetMovable(true)
		_G["HTTBoss"..i]:SetMouseEnabled(true)
		_G["HTTBoss"..i]:SetHidden(true)
		_G["HTTBoss"..i]:SetScale(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffBossUIScale)
	end
	

	HTTCooldowns:SetResizeToFitDescendents(true)
    HTTCooldowns:SetMovable(true)
    HTTCooldowns:SetMouseEnabled(true)
	HTTCooldowns:SetHidden(true)
	HTTCooldowns:SetScale(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownUIScale)

	HTTAlert:SetResizeToFitDescendents(true)
    HTTAlert:SetMovable(true)
    HTTAlert:SetMouseEnabled(true)
	HTTAlert:SetHidden(true)
	HTTAlert:SetScale(HTTsavedVars[HTT_variables.currentlySelectedProfile].alertUIScale)

	HTTHealth:SetResizeToFitDescendents(true)
    HTTHealth:SetMovable(false)
    HTTHealth:SetMouseEnabled(true)
	HTTHealth:SetHidden(false)

	HTTStamina:SetResizeToFitDescendents(true)
    HTTStamina:SetMovable(false)
    HTTStamina:SetMouseEnabled(true)
	HTTStamina:SetHidden(false)

	HTTMagicka:SetResizeToFitDescendents(true)
    HTTMagicka:SetMovable(false)
    HTTMagicka:SetMouseEnabled(true)
	HTTMagicka:SetHidden(false)

	HTTSynergies:SetResizeToFitDescendents(true)
    HTTSynergies:SetMovable(true)
    HTTSynergies:SetMouseEnabled(true)
	HTTSynergies:SetHidden(true)
	HTTSynergies:SetScale(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesUIScale)

	HTTReflect:SetResizeToFitDescendents(true)
    HTTReflect:SetMovable(true)
    HTTReflect:SetMouseEnabled(true)
	HTTReflect:SetHidden(false)



    HTT:SetHandler("OnMoveStop", function(control)
        HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffset = HTT:GetLeft()
	    HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffset  = HTT:GetTop()
    end)

	HTTOwnStacks:SetHandler("OnMoveStop", function(control)
        HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetOwnStacks = HTTOwnStacks:GetLeft()
	    HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetOwnStacks  = HTTOwnStacks:GetTop()
    end)

	HTTBlock:SetHandler("OnMoveStop", function(control)
        HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetBlock = HTTBlock:GetLeft()
	    HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetBlock  = HTTBlock:GetTop()
    end)

	HTTSelfBuffs:SetHandler("OnMoveStop", function(control)
        HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetSelfBuffs = HTTSelfBuffs:GetLeft()
	    HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetSelfBuffs  = HTTSelfBuffs:GetTop()
    end)

	HTTBoss1:SetHandler("OnMoveStop", function(control)
        HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetBoss1 = HTTBoss1:GetLeft()
	    HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetBoss1  = HTTBoss1:GetTop()
    end)

	HTTBoss2:SetHandler("OnMoveStop", function(control)
        HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetBoss2 = HTTBoss2:GetLeft()
	    HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetBoss2  = HTTBoss2:GetTop()
    end)

	HTTBoss3:SetHandler("OnMoveStop", function(control)
        HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetBoss3 = HTTBoss3:GetLeft()
	    HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetBoss3  = HTTBoss3:GetTop()
    end)

	HTTBoss4:SetHandler("OnMoveStop", function(control)
        HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetBoss4 = HTTBoss4:GetLeft()
	    HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetBoss4  = HTTBoss4:GetTop()
    end)

	HTTBoss5:SetHandler("OnMoveStop", function(control)
        HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetBoss5 = HTTBoss5:GetLeft()
	    HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetBoss5  = HTTBoss5:GetTop()
    end)

	HTTBoss6:SetHandler("OnMoveStop", function(control)
        HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetBoss6 = HTTBoss6:GetLeft()
	    HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetBoss6  = HTTBoss6:GetTop()
    end)

	HTTCooldowns:SetHandler("OnMoveStop", function(control)
        HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetCooldowns = HTTCooldowns:GetLeft()
	    HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetCooldowns  = HTTCooldowns:GetTop()
    end)

	HTTAlert:SetHandler("OnMoveStop", function(control)
        HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetAlert = HTTAlert:GetLeft()
	    HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetAlert  = HTTAlert:GetTop()
    end)

	HTTHealth:SetHandler("OnMoveStop", function(control)
        HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetHealth = HTTHealth:GetLeft()
	    HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetHealth  = HTTHealth:GetTop()
    end)

	HTTStamina:SetHandler("OnMoveStop", function(control)
        HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetStamina = HTTStamina:GetLeft()
	    HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetStamina  = HTTStamina:GetTop()
    end)

	HTTMagicka:SetHandler("OnMoveStop", function(control)
        HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetMagicka = HTTMagicka:GetLeft()
	    HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetMagicka  = HTTMagicka:GetTop()
    end)

	HTTSynergies:SetHandler("OnMoveStop", function(control)
        HTTsavedVars[HTT_variables.currentlySelectedProfile].xOffsetSynergies = HTTSynergies:GetLeft()
	    HTTsavedVars[HTT_variables.currentlySelectedProfile].yOffsetSynergies  = HTTSynergies:GetTop()
    end)



	LibMsgWin:CreateMsgWindow("eventViewerWindow", "Combat Events", 0, 0)
	eventViewerWindow:SetHidden(true)

	LibMsgWin:CreateMsgWindow("buffViewerWindow", "Effects on yourself", 0, 0)
	buffViewerWindow:SetHidden(true)

	LibMsgWin:CreateMsgWindow("debuffViewerWindow", "Effects on current target", 0, 0)
	debuffViewerWindow:SetHidden(true)

	LibMsgWin:CreateMsgWindow("abilitySlotViewer", "IDs of abilities", 0, 0)
	abilitySlotViewer:SetHidden(true)

	-------- REFLECT ---------------

	local Rwidth, Rheight = GuiRoot:GetDimensions()
	local reflect = WM:CreateControl("$(parent)reflect",HTTReflect,  CT_TEXTURE, 4)
	reflect:SetDimensions(128,64)
	reflect:SetAnchor(BOTTOMLEFT,HTTReflect,BOTTOMLEFT,(Rwidth/2)-64,Rheight/2.24)
	reflect:SetTexture("HyperTankingTools/icons/reflectOutline.dds")
	reflect:SetHidden(true)
	reflect:SetDrawLayer(1)

	local reflectFill = WM:CreateControl("$(parent)reflectFill",HTTReflect,  CT_TEXTURE, 4)
	reflectFill:SetDimensions(128,64)
	reflectFill:SetAnchor(CENTER,reflect,CENTER,0,0)
	reflectFill:SetTexture("HyperTankingTools/icons/reflectFill.dds")
	reflectFill:SetHidden(true)
	reflectFill:SetDrawLayer(0)
	reflectFill:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].reflectIndicatorColor))

	-------- REFLECT ---------------



	local healtBarOutline = WM:CreateControl("$(parent)healtBarOutline",HTTHealth,  CT_TEXTURE, 4)
	healtBarOutline:SetDimensions(64,512)
	healtBarOutline:SetAnchor(TOPLEFT,HTTHealth,TOPLEFT,32,0)
	healtBarOutline:SetTexture("HyperTankingTools/icons/outlineBar.dds")
	healtBarOutline:SetColor(0.1,0.1,0.1)
	healtBarOutline:SetHidden(false)
	healtBarOutline:SetDrawLayer(2)

	local healtBarOutlineOpaque = WM:CreateControl("$(parent)healtBarOutlineOpaque",HTTHealth,  CT_TEXTURE, 4)
	healtBarOutlineOpaque:SetDimensions(64,512)
	healtBarOutlineOpaque:SetAnchor(TOPLEFT,healtBarOutline,TOPLEFT,0,0)
	healtBarOutlineOpaque:SetTexture("HyperTankingTools/icons/fillBar.dds")

	healtBarOutlineOpaque:SetColor(0.1,0.1,0.1,0.6)
	healtBarOutlineOpaque:SetHidden(false)
	healtBarOutlineOpaque:SetDrawLayer(0)

	local healthBar = WM:CreateControl("$(parent)healthBar",HTTHealth,  CT_TEXTURE, 4)
	healthBar:SetDimensions(64,512)
	healthBar:SetAnchor(BOTTOMLEFT,healtBarOutline,BOTTOMLEFT,0,0)
	healthBar:SetTexture("HyperTankingTools/icons/fillBar.dds")
	healthBar:SetColor(214/255,0,0)
	healthBar:SetHidden(false)
	healthBar:SetDrawLayer(1)

	local horseStaminaOutline = WM:CreateControl("$(parent)horseStaminaOutline",HTTHealth,  CT_TEXTURE, 4)
	horseStaminaOutline:SetDimensions(32,128)
	horseStaminaOutline:SetAnchor(TOPRIGHT,healtBarOutline,TOPLEFT,16,0)
	horseStaminaOutline:SetTexture("HyperTankingTools/icons/outlineBarBottom.dds")
	horseStaminaOutline:SetTextureRotation(math.pi)
	horseStaminaOutline:SetColor(0.1,0.1,0.1)
	horseStaminaOutline:SetHidden(false)
	horseStaminaOutline:SetDrawLayer(0)
	
	local horseStaminaOutlineOpaque = WM:CreateControl("$(parent)horseStaminaOutlineOpaque",HTTHealth,  CT_TEXTURE, 4)
	horseStaminaOutlineOpaque:SetDimensions(32,128)
	horseStaminaOutlineOpaque:SetAnchor(BOTTOMLEFT,horseStaminaOutline,BOTTOMLEFT,0,0)
	horseStaminaOutlineOpaque:SetTexture("HyperTankingTools/icons/fillBarBottom.dds")
	horseStaminaOutlineOpaque:SetTextureRotation(math.pi)
	horseStaminaOutlineOpaque:SetColor(0.1,0.1,0.1,0.6)
	horseStaminaOutlineOpaque:SetHidden(false)
	horseStaminaOutlineOpaque:SetDrawLayer(0)

	local horseStamina = WM:CreateControl("$(parent)horseStamina",HTTHealth,  CT_TEXTURE, 4)
	horseStamina:SetDimensions(32,128)
	horseStamina:SetAnchor(BOTTOMLEFT,horseStaminaOutline,BOTTOMLEFT,0,0)
	horseStamina:SetTexture("HyperTankingTools/icons/fillBarBottom.dds")
	horseStamina:SetTextureRotation(math.pi)
	horseStamina:SetColor(0, 212/255, 0)
	horseStamina:SetHidden(false)
	horseStamina:SetDrawLayer(1)
	
	local horseStaminaIconFrame = WM:CreateControl("$(parent)horseStaminaIconFrame",HTTHealth,  CT_TEXTURE, 4)
	horseStaminaIconFrame:SetDimensions(32,32)
	horseStaminaIconFrame:SetAnchor(TOP,horseStaminaOutline,BOTTOM,-8,-3)
	horseStaminaIconFrame:SetColor(0.1,0.1,0.1)
	horseStaminaIconFrame:SetTexture("HyperTankingTools/icons/frameFilled.dds")
	horseStaminaIconFrame:SetHidden(false)
	horseStaminaIconFrame:SetDrawLayer(1)
	
	local horseStaminaIcon = WM:CreateControl("$(parent)horseStaminaIcon",HTTHealth,  CT_TEXTURE, 4)
	horseStaminaIcon:SetDimensions(23,23)
	horseStaminaIcon:SetAnchor(CENTER,horseStaminaIconFrame,CENTER,0,0)
	horseStaminaIcon:SetTexture("/esoui/art/mountportraits/mountportait_horse_e.dds")
	horseStaminaIcon:SetHidden(false)
	horseStaminaIcon:SetDrawLayer(2)
	
	

	local balanceBarOutline = WM:CreateControl("$(parent)balanceBarOutline",HTTHealth,  CT_TEXTURE, 4)
	balanceBarOutline:SetDimensions(32,128)
	balanceBarOutline:SetAnchor(BOTTOMRIGHT,healtBarOutline,BOTTOMLEFT,16,0)
	balanceBarOutline:SetTexture("HyperTankingTools/icons/outlineBarTop.dds")
	balanceBarOutline:SetTextureRotation(math.pi)
	balanceBarOutline:SetColor(0.1,0.1,0.1)
	balanceBarOutline:SetHidden(false)
	balanceBarOutline:SetDrawLayer(0)

	local balanceBarOutlineOpaque = WM:CreateControl("$(parent)balanceBarOutlineOpaque",HTTHealth,  CT_TEXTURE, 4)
	balanceBarOutlineOpaque:SetDimensions(32,128)
	balanceBarOutlineOpaque:SetAnchor(BOTTOMLEFT,balanceBarOutline,BOTTOMLEFT,0,0)
	balanceBarOutlineOpaque:SetTexture("HyperTankingTools/icons/fillBarTop.dds")
	balanceBarOutlineOpaque:SetTextureRotation(math.pi)
	balanceBarOutlineOpaque:SetColor(0.1,0.1,0.1,0.6)
	balanceBarOutlineOpaque:SetHidden(false)
	balanceBarOutlineOpaque:SetDrawLayer(0)

	local balanceBar = WM:CreateControl("$(parent)balanceBar",HTTHealth,  CT_TEXTURE, 4)
	balanceBar:SetDimensions(32,128)
	balanceBar:SetAnchor(TOPLEFT,balanceBarOutline,TOPLEFT,0,0)
	balanceBar:SetTexture("HyperTankingTools/icons/fillBarTop.dds")
	balanceBar:SetTextureRotation(math.pi)
	balanceBar:SetColor(23/255, 224/255, 1)
	balanceBar:SetHidden(false)
	balanceBar:SetDrawLayer(1)

	local balanceBarIconFrame = WM:CreateControl("$(parent)balanceBarIconFrame",HTTHealth,  CT_TEXTURE, 4)
	balanceBarIconFrame:SetDimensions(32,32)
	balanceBarIconFrame:SetAnchor(BOTTOM,balanceBarOutline,TOP,-8,3)
	balanceBarIconFrame:SetColor(0.1,0.1,0.1)
	balanceBarIconFrame:SetTexture("HyperTankingTools/icons/frame.dds")
	balanceBarIconFrame:SetHidden(false)
	balanceBarIconFrame:SetDrawLayer(2)
	
	local balanceBarIcon = WM:CreateControl("$(parent)balanceBarIcon",HTTHealth,  CT_TEXTURE, 4)
	balanceBarIcon:SetDimensions(23,23)
	balanceBarIcon:SetAnchor(CENTER,balanceBarIconFrame,CENTER,0,0)
	balanceBarIcon:SetTexture("/esoui/art/icons/ability_mageguild_003_b.dds")
	balanceBarIcon:SetHidden(false)
	balanceBarIcon:SetDrawLayer(1)

	


	local majorMendingOutline = WM:CreateControl("$(parent)majorMendingOutline",HTTHealth,  CT_TEXTURE, 4)
	majorMendingOutline:SetDimensions(32,128)
	majorMendingOutline:SetAnchor(BOTTOMLEFT,healtBarOutline,BOTTOMRIGHT,-8,0)
	majorMendingOutline:SetTexture("HyperTankingTools/icons/outlineBarTop.dds")
	majorMendingOutline:SetTextureRotation(math.pi)
	majorMendingOutline:SetColor(0.1,0.1,0.1)
	majorMendingOutline:SetHidden(false)
	majorMendingOutline:SetDrawLayer(0)

	local majorMendingOutlineOpaque = WM:CreateControl("$(parent)majorMendingOutlineOpaque",HTTHealth,  CT_TEXTURE, 4)
	majorMendingOutlineOpaque:SetDimensions(32,128)
	majorMendingOutlineOpaque:SetAnchor(BOTTOMLEFT,majorMendingOutline,BOTTOMLEFT,0,0)
	majorMendingOutlineOpaque:SetTexture("HyperTankingTools/icons/fillBarTop.dds")
	majorMendingOutlineOpaque:SetTextureRotation(math.pi)
	majorMendingOutlineOpaque:SetColor(0.1,0.1,0.1,0.6)
	majorMendingOutlineOpaque:SetHidden(false)
	majorMendingOutlineOpaque:SetDrawLayer(0)

	local majorMending = WM:CreateControl("$(parent)majorMending",HTTHealth,  CT_TEXTURE, 4)
	majorMending:SetDimensions(32,128)
	majorMending:SetAnchor(TOPLEFT,majorMendingOutline,TOPLEFT,0,0)
	majorMending:SetTexture("HyperTankingTools/icons/fillBarTop.dds")
	majorMending:SetTextureRotation(math.pi)
	majorMending:SetColor(68/255, 1, 0)
	majorMending:SetHidden(false)
	majorMending:SetDrawLayer(1)

	local majorMendingIconFrame = WM:CreateControl("$(parent)majorMendingIconFrame",HTTHealth,  CT_TEXTURE, 4)
	majorMendingIconFrame:SetDimensions(32,32)
	majorMendingIconFrame:SetAnchor(BOTTOM,majorMendingOutline,TOP,-8,3)
	majorMendingIconFrame:SetColor(0.1,0.1,0.1)
	majorMendingIconFrame:SetTexture("HyperTankingTools/icons/frame.dds")
	majorMendingIconFrame:SetHidden(false)
	majorMendingIconFrame:SetDrawLayer(2)
	
	local majorMendingIcon = WM:CreateControl("$(parent)majorMendingIcon",HTTHealth,  CT_TEXTURE, 4)
	majorMendingIcon:SetDimensions(23,23)
	majorMendingIcon:SetAnchor(CENTER,majorMendingIconFrame,CENTER,0,0)
	majorMendingIcon:SetTexture("/esoui/art/icons/ability_buff_major_mending.dds")
	majorMendingIcon:SetHidden(false)
	majorMendingIcon:SetDrawLayer(1)
	
	local shieldBar = WM:CreateControl("$(parent)shieldBar",HTTHealth,  CT_TEXTURE, 4)
	shieldBar:SetDimensions(64,512)
	shieldBar:SetAnchor(BOTTOMLEFT,healthBar,BOTTOMLEFT,0,0)
	shieldBar:SetTexture("HyperTankingTools/icons/fillBar.dds")
	shieldBar:SetColor(224/255, 123/255, 123/255,0.7)
	shieldBar:SetHidden(false)
	shieldBar:SetDrawLayer(2)

	local healthText = WM:CreateControl("$(parent)healthText",HTTHealth,CT_LABEL)
	healthText:SetFont("ZoFontGameSmall")
	healthText:SetScale(1.0)
	healthText:SetDrawLayer(1)
	healthText:SetColor(255, 255, 255, 1)
	healthText:SetText("currentHealth")				
	healthText:SetAnchor(LEFT, healtBarOutline, RIGHT,-20,-20)
	healthText:SetDimensions(100, 1)
	--healthText:SetHorizontalAlignment(CENTER)
	healthText:SetHidden(false)

	local healthTextPercentage = WM:CreateControl("$(parent)healthTextPercentage",HTTHealth,CT_LABEL)
	healthTextPercentage:SetFont("ZoFontGameSmall")
	healthTextPercentage:SetScale(1.0)
	healthTextPercentage:SetDrawLayer(1)
	healthTextPercentage:SetColor(255, 255, 255, 1)
	healthTextPercentage:SetText("percentageHealth")				
	healthTextPercentage:SetAnchor(LEFT, healtBarOutline, RIGHT,-20,0)
	healthTextPercentage:SetDimensions(100, 1)
	--healthTextPercentage:SetHorizontalAlignment(CENTER)
	healthTextPercentage:SetHidden(false)
	


	local staminaBarOutline = WM:CreateControl("$(parent)staminaBarOutline",HTTStamina,  CT_TEXTURE, 4)
	staminaBarOutline:SetDimensions(64,256)
	staminaBarOutline:SetAnchor(BOTTOMLEFT,HTTStamina,BOTTOMLEFT,0,0)
	staminaBarOutline:SetTexture("HyperTankingTools/icons/outlineBarTop.dds")
	staminaBarOutline:SetColor(0.1,0.1,0.1)
	staminaBarOutline:SetHidden(false)
	staminaBarOutline:SetDrawLayer(2)

	local staminaBarOutlineOpaque = WM:CreateControl("$(parent)staminaBarOutlineOpaque",HTTStamina,  CT_TEXTURE, 4)
	staminaBarOutlineOpaque:SetDimensions(64,256)
	staminaBarOutlineOpaque:SetAnchor(BOTTOMLEFT,staminaBarOutline,BOTTOMLEFT,0,0)
	staminaBarOutlineOpaque:SetTexture("HyperTankingTools/icons/fillBarTop.dds")
	staminaBarOutlineOpaque:SetColor(0.1,0.1,0.1,0.6)
	staminaBarOutlineOpaque:SetHidden(false)
	staminaBarOutlineOpaque:SetDrawLayer(0)

	local staminaBarFill = WM:CreateControl("$(parent)staminaBarFill",HTTStamina,  CT_TEXTURE, 4)
	staminaBarFill:SetDimensions(64,256)
	staminaBarFill:SetAnchor(BOTTOMLEFT,staminaBarOutline,BOTTOMLEFT,0,0)
	staminaBarFill:SetTexture("HyperTankingTools/icons/fillBarTop.dds")
	staminaBarFill:SetColor(19/255,189/255,0)
	staminaBarFill:SetHidden(false)
	staminaBarFill:SetDrawLayer(0)

	local staminaBarLine = WM:CreateControl("$(parent)staminaBarLine",HTTStamina,  CT_TEXTURE, 4)
	staminaBarLine:SetDimensions(24,4)
	staminaBarLine:SetAnchor(BOTTOMLEFT,staminaBarOutline,BOTTOMLEFT,33,0)
	staminaBarLine:SetColor(0,0,0,1)
	staminaBarLine:SetHidden(false)
	staminaBarLine:SetDrawLayer(1)

	local dodgeRollBarOutline = WM:CreateControl("$(parent)dodgeRollBarOutline",HTTStamina,  CT_TEXTURE, 4)
	dodgeRollBarOutline:SetDimensions(32,128)
	dodgeRollBarOutline:SetAnchor(TOPLEFT,staminaBarOutline,TOPRIGHT,-16,0)
	dodgeRollBarOutline:SetTexture("HyperTankingTools/icons/outlineBarTop.dds")
	dodgeRollBarOutline:SetColor(0.1,0.1,0.1)
	dodgeRollBarOutline:SetHidden(false)
	dodgeRollBarOutline:SetDrawLayer(0)

	local dodgeRollBarOutlineOpaque = WM:CreateControl("$(parent)dodgeRollBarOutlineOpaque",HTTStamina,  CT_TEXTURE, 4)
	dodgeRollBarOutlineOpaque:SetDimensions(32,128)
	dodgeRollBarOutlineOpaque:SetAnchor(BOTTOMLEFT,dodgeRollBarOutline,BOTTOMLEFT,0,0)
	dodgeRollBarOutlineOpaque:SetTexture("HyperTankingTools/icons/fillBarTop.dds")
	dodgeRollBarOutlineOpaque:SetColor(0.1,0.1,0.1,0.6)
	dodgeRollBarOutlineOpaque:SetHidden(false)
	dodgeRollBarOutlineOpaque:SetDrawLayer(0)

	local dodgeRollBarFill = WM:CreateControl("$(parent)dodgeRollBarFill",HTTStamina,  CT_TEXTURE, 4)
	dodgeRollBarFill:SetDimensions(32,128)
	dodgeRollBarFill:SetAnchor(BOTTOMLEFT,dodgeRollBarOutline,BOTTOMLEFT,0,0)
	dodgeRollBarFill:SetTexture("HyperTankingTools/icons/fillBarTop.dds")
	dodgeRollBarFill:SetColor(0,0.4,0)
	dodgeRollBarFill:SetHidden(false)
	dodgeRollBarFill:SetDrawLayer(1)

	local dodgeRollBarIconFrame = WM:CreateControl("$(parent)dodgeRollBarIconFrame",HTTStamina,  CT_TEXTURE, 4)
	dodgeRollBarIconFrame:SetDimensions(32,32)
	dodgeRollBarIconFrame:SetAnchor(TOP,dodgeRollBarOutline,BOTTOM,8,-3)
	dodgeRollBarIconFrame:SetColor(0.1,0.1,0.1)
	dodgeRollBarIconFrame:SetTexture("HyperTankingTools/icons/frame.dds")
	dodgeRollBarIconFrame:SetHidden(false)
	dodgeRollBarIconFrame:SetDrawLayer(2)
	
	local dodgeRollBarIcon = WM:CreateControl("$(parent)dodgeRollBarIcon",HTTStamina,  CT_TEXTURE, 4)
	dodgeRollBarIcon:SetDimensions(23,23)
	dodgeRollBarIcon:SetAnchor(CENTER,dodgeRollBarIconFrame,CENTER,0,0)
	dodgeRollBarIcon:SetTexture("esoui/art/icons/ability_rogue_037.dds")
	dodgeRollBarIcon:SetHidden(false)
	dodgeRollBarIcon:SetDrawLayer(1)

	local dodgeRollStackCounter = WM:CreateControl("$(parent)dodgeRollStackCounter",HTTStamina,CT_LABEL)
	dodgeRollStackCounter:SetFont("ZoFontWindowTitle")
	dodgeRollStackCounter:SetScale(0.8)
	dodgeRollStackCounter:SetDrawLayer(2)
	dodgeRollStackCounter:SetColor(255, 255, 255, 1)
	dodgeRollStackCounter:SetText("4")				
	dodgeRollStackCounter:SetAnchor(BOTTOMLEFT, dodgeRollBarIcon, BOTTOMLEFT,6, -16)
	dodgeRollStackCounter:SetDimensions(15,15)
	dodgeRollStackCounter:SetHorizontalAlignment(CENTER)
	dodgeRollStackCounter:SetHidden(false)

	local staminaText = WM:CreateControl("$(parent)staminaText",HTTStamina,CT_LABEL)
	staminaText:SetFont("ZoFontGameSmall")
	staminaText:SetScale(1.0)
	staminaText:SetDrawLayer(1)
	staminaText:SetColor(255, 255, 255, 1)
	staminaText:SetText("currentStamina")				
	staminaText:SetAnchor(BOTTOMLEFT, staminaBarOutline, BOTTOMLEFT,0, -22)
	staminaText:SetDimensions(HTTsavedVars[HTT_variables.currentlySelectedProfile].width, 20)
	staminaText:SetHorizontalAlignment(CENTER)
	staminaText:SetHidden(false)

	local staminaTextPercentage = WM:CreateControl("$(parent)staminaTextPercentage",HTTStamina,CT_LABEL)
	staminaTextPercentage:SetFont("ZoFontGameSmall")
	staminaTextPercentage:SetScale(1.0)
	staminaTextPercentage:SetDrawLayer(1)
	staminaTextPercentage:SetColor(255, 255, 255, 1)
	staminaTextPercentage:SetText("percentageStamina")				
	staminaTextPercentage:SetAnchor(BOTTOMLEFT, staminaBarOutline, BOTTOMLEFT,0,0)
	staminaTextPercentage:SetDimensions(HTTsavedVars[HTT_variables.currentlySelectedProfile].width, 20)
	staminaTextPercentage:SetHorizontalAlignment(CENTER)
	staminaTextPercentage:SetHidden(false)

	local magickaBarOutline = WM:CreateControl("$(parent)magickaBarOutline",HTTMagicka,  CT_TEXTURE, 4)
	magickaBarOutline:SetDimensions(64,256)
	magickaBarOutline:SetAnchor(TOPLEFT,HTTMagicka,TOPLEFT,0,0)
	magickaBarOutline:SetColor(0.1,0.1,0.1)
	magickaBarOutline:SetTexture("HyperTankingTools/icons/outlineBarBottom.dds")
	magickaBarOutline:SetHidden(false)
	magickaBarOutline:SetDrawLayer(0)

	local magickaBarOutlineOpaque = WM:CreateControl("$(parent)magickaBarOutlineOpaque",HTTMagicka,  CT_TEXTURE, 4)
	magickaBarOutlineOpaque:SetDimensions(64,256)
	magickaBarOutlineOpaque:SetAnchor(TOPLEFT,magickaBarOutline,TOPLEFT,0,0)
	magickaBarOutlineOpaque:SetTexture("HyperTankingTools/icons/fillBarBottom.dds")
	magickaBarOutlineOpaque:SetColor(0.1,0.1,0.1,0.6)
	magickaBarOutlineOpaque:SetHidden(false)
	magickaBarOutlineOpaque:SetDrawLayer(0)

	local magickaBarFill = WM:CreateControl("$(parent)magickaBarFill",HTTMagicka,  CT_TEXTURE, 4)
	magickaBarFill:SetDimensions(64,256)
	magickaBarFill:SetAnchor(TOPLEFT,magickaBarOutline,TOPLEFT,0,0)
	magickaBarFill:SetTexture("HyperTankingTools/icons/fillBarBottom.dds")
	magickaBarFill:SetColor(0,0,222/255)
	magickaBarFill:SetHidden(false)
	magickaBarFill:SetDrawLayer(1)

	local magickaText = WM:CreateControl("$(parent)magickaText",HTTMagicka,CT_LABEL)
	magickaText:SetFont("ZoFontGameSmall")
	magickaText:SetScale(1.0)
	magickaText:SetDrawLayer(1)
	magickaText:SetColor(255, 255, 255, 1)
	magickaText:SetText("currentMagicka")				
	magickaText:SetAnchor(TOPLEFT, magickaBarOutline, TOPLEFT,0, 22)
	magickaText:SetDimensions(HTTsavedVars[HTT_variables.currentlySelectedProfile].width, 20)
	magickaText:SetHorizontalAlignment(CENTER)
	magickaText:SetHidden(false)

	local magickaTextPercentage = WM:CreateControl("$(parent)magickaTextPercentage",HTTMagicka,CT_LABEL)
	magickaTextPercentage:SetFont("ZoFontGameSmall")
	magickaTextPercentage:SetScale(1.0)
	magickaTextPercentage:SetDrawLayer(1)
	magickaTextPercentage:SetColor(255, 255, 255, 1)
	magickaTextPercentage:SetText("percentageMagicka")				
	magickaTextPercentage:SetAnchor(TOPLEFT, magickaBarOutline, TOPLEFT,0,0)
	magickaTextPercentage:SetDimensions(HTTsavedVars[HTT_variables.currentlySelectedProfile].width, 20)
	magickaTextPercentage:SetHorizontalAlignment(CENTER)
	magickaTextPercentage:SetHidden(false)

	


--[[	local ultimateBarOutline = WM:CreateControl("$(parent)ultimateBarOutline",HTTMagicka,  CT_TEXTURE, 4)
	ultimateBarOutline:SetDimensions(32,128)
	ultimateBarOutline:SetAnchor(BOTTOMLEFT,magickaBarFill,BOTTOMLEFT,50,0)
	ultimateBarOutline:SetTexture("HyperTankingTools/icons/outlineBarBottom.dds")
	ultimateBarOutline:SetColor(0.1,0.1,0.1)
	ultimateBarOutline:SetHidden(false)
	ultimateBarOutline:SetDrawLayer(0)

	local ultimateBarOutlineOpaque = WM:CreateControl("$(parent)ultimateBarOutlineOpaque",HTTMagicka,  CT_TEXTURE, 4)
	ultimateBarOutlineOpaque:SetDimensions(32,128)
	ultimateBarOutlineOpaque:SetAnchor(BOTTOMLEFT,magickaBarFill,BOTTOMLEFT,50,0)
	ultimateBarOutlineOpaque:SetTexture("HyperTankingTools/icons/fillBarBottom.dds")
	ultimateBarOutlineOpaque:SetColor(0.1,0.1,0.1,0.6)
	ultimateBarOutlineOpaque:SetHidden(false)
	ultimateBarOutlineOpaque:SetDrawLayer(0)

	local ultimateBar = WM:CreateControl("$(parent)ultimateBar",HTTMagicka,  CT_TEXTURE, 4)
	ultimateBar:SetDimensions(32,128)
	ultimateBar:SetAnchor(BOTTOMLEFT,magickaBarFill,BOTTOMLEFT,50,0)
	ultimateBar:SetTexture("HyperTankingTools/icons/fillBarBottom.dds")
	ultimateBar:SetColor(1, 225/255, 0)
	ultimateBar:SetHidden(false)
	ultimateBar:SetDrawLayer(1)

	local ultimateBarIconFrame = WM:CreateControl("$(parent)ultimateBarIconFrame",HTTMagicka,  CT_TEXTURE, 4)
	ultimateBarIconFrame:SetDimensions(32,32)
	ultimateBarIconFrame:SetAnchor(BOTTOMLEFT,magickaBarFill,BOTTOMLEFT,57,-124)
	ultimateBarIconFrame:SetColor(0.1,0.1,0.1)
	ultimateBarIconFrame:SetTexture("HyperTankingTools/icons/frame.dds")
	ultimateBarIconFrame:SetHidden(false)
	ultimateBarIconFrame:SetDrawLayer(2)
	
	local ultimateBarIcon = WM:CreateControl("$(parent)ultimateBarIcon",HTTMagicka,  CT_TEXTURE, 4)
	ultimateBarIcon:SetDimensions(23,23)
	ultimateBarIcon:SetAnchor(BOTTOMLEFT,ultimateBarIconFrame,BOTTOMLEFT,5,-4)
	ultimateBarIcon:SetTexture("/esoui/art/icons/ability_ava_003_a.dds")
	ultimateBarIcon:SetHidden(false)
	ultimateBarIcon:SetDrawLayer(1)]]






	------------- Alerts ------------------

	local AlertsBackground = WM:CreateControl("$(parent)AlertsBackground", HTTAlert, CT_BACKDROP)
	AlertsBackground:SetEdgeColor(0,0,0)
	AlertsBackground:SetCenterColor(0,0,0)
	AlertsBackground:SetAnchor(TOPLEFT, HTTAlert, TOPLEFT, 0, 0)
	AlertsBackground:SetAlpha(1)
	AlertsBackground:SetScale(1.0)
	AlertsBackground:SetDrawLayer(0)
	AlertsBackground:SetDimensions(HTTsavedVars[HTT_variables.currentlySelectedProfile].width + 10, 110)
	AlertsBackground:SetHidden(false)


	local AlertsText = WM:CreateControl("$(parent)AlertsText",HTTAlert,CT_LABEL)
	AlertsText:SetFont("ZoFontGameSmall")
	AlertsText:SetScale(1)
	AlertsText:SetDrawLayer(1)
	AlertsText:SetColor(255, 255, 255, 1)
	AlertsText:SetText("Attack Pattern")				
	AlertsText:SetAnchor(TOPCENTER, AlertsBackground, TOPCENTER,5, 0)
	AlertsText:SetDimensions(HTTsavedVars[HTT_variables.currentlySelectedProfile].width, 20)
	AlertsText:SetHorizontalAlignment(CENTER)
	AlertsText:SetHidden(false)


	local gapBetweenElements = 20
	local additionalGap = 2
	for k=1, 4 do
		


		timer = WM:CreateControl("$(parent)AlertsDurationTimer"..k, HTTAlert, CT_LABEL)			
		timer:SetFont("ZoFontGameSmall")
		timer:SetScale(1.0)
		timer:SetWrapMode(TEX_MODE_CLAMP)
		timer:SetDrawLayer(2)
		timer:SetColor(255,255,255, 1)
		timer:SetText("0.0s")				
		timer:SetAnchor(TOPLEFT, AlertsBackground, TOPLEFT, 5, gapBetweenElements+additionalGap)
		timer:SetDimensions(HTTsavedVars[HTT_variables.currentlySelectedProfile].width, HTTsavedVars[HTT_variables.currentlySelectedProfile].height/2)
		timer:SetHorizontalAlignment(LEFT)
		timer:SetHidden(false)
			
			

		bar = WM:CreateControl("$(parent)AlertsDurationBar"..k, HTTAlert, CT_STATUSBAR)	
		bar:SetScale(1.0)
		bar:SetAnchor(TOPLEFT, AlertsBackground, TOPLEFT, 5+HTTsavedVars[HTT_variables.currentlySelectedProfile].height/2, gapBetweenElements-2+additionalGap)
		bar:SetDimensions(math.floor(HTTsavedVars[HTT_variables.currentlySelectedProfile].width *0.8), HTTsavedVars[HTT_variables.currentlySelectedProfile].height/2)
		bar:SetColor(0.2,0.6,0.9,1)
		bar:SetHidden(false)		
		bar:SetDrawLayer(1)
		bar:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].currentlySelectedBarTexture)

		textInBar = WM:CreateControl("$(parent)AlertsTextInBar"..k, HTTAlert, CT_LABEL)
		textInBar:SetFont("ZoFontGameSmall")
		textInBar:SetScale(1.0)
		textInBar:SetWrapMode(TEX_MODE_CLAMP)
		textInBar:SetDrawLayer(2)
		textInBar:SetColor(1,1,1,1)
		textInBar:SetText("attack "..k)				
		textInBar:SetAnchor(TOPLEFT, AlertsBackground, TOPLEFT, 30,gapBetweenElements+additionalGap)
		textInBar:SetDimensions(HTTsavedVars[HTT_variables.currentlySelectedProfile].width, HTTsavedVars[HTT_variables.currentlySelectedProfile].height/2)
		textInBar:SetHidden(false)

		icon = WM:CreateControl("$(parent)AlertsIcon"..k, HTTAlert, CT_TEXTURE,4)
		icon:SetDimensions(math.floor( HTTsavedVars[HTT_variables.currentlySelectedProfile].height/2), HTTsavedVars[HTT_variables.currentlySelectedProfile].height/2)
		icon:SetAnchor(TOPLEFT,AlertsBackground,TOPLEFT,5,gapBetweenElements-2+additionalGap)
		icon:SetTexture("")
		icon:SetHidden(false)
		icon:SetDrawLayer(2)




		additionalGap = additionalGap + 2
		gapBetweenElements = gapBetweenElements + HTTsavedVars[HTT_variables.currentlySelectedProfile].height/2

	end
	

	------------- Alerts ------------------



	------------------ Block ------------------------



	local block = WM:CreateControl("$(parent)Block",HTTBlock,  CT_TEXTURE, 4)
	block:SetDimensions(HTTsavedVars[HTT_variables.currentlySelectedProfile].shieldTextureWidth,HTTsavedVars[HTT_variables.currentlySelectedProfile].shieldTextureHeight)
	block:SetAnchor(BOTTOMLEFT,HTTBlock,BOTTOMLEFT,0,0)
	block:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].customShield)
	block:SetHidden(false)
	block:SetDrawLayer(2)

	local blockCost = WM:CreateControl("$(parent)blockCost",HTTBlock,CT_LABEL)
	blockCost:SetFont("ZoFontWindowTitle")
	blockCost:SetScale(1.0)
	blockCost:SetDrawLayer(1)
	blockCost:SetColor(52/255, 235/255, 70/255, 1)
	blockCost:SetText("Block Cost")				
	blockCost:SetAnchor(BOTTOMLEFT, block, BOTTOMLEFT,HTTsavedVars[HTT_variables.currentlySelectedProfile].shieldTextureWidth,-20)
	blockCost:SetDimensions(150,100)
	blockCost:SetHorizontalAlignment(CENTER)
	blockCost:SetHidden(false)

	local blockCost = WM:CreateControl("$(parent)blockMitigation",HTTBlock,CT_LABEL)
	blockCost:SetFont("ZoFontWindowTitle")
	blockCost:SetScale(1.0)
	blockCost:SetDrawLayer(1)
	blockCost:SetColor(52/255, 235/255, 70/255, 1)
	blockCost:SetText("Block Mitigation %")				
	blockCost:SetAnchor(BOTTOMLEFT, block, BOTTOMLEFT,HTTsavedVars[HTT_variables.currentlySelectedProfile].shieldTextureWidth,15)
	blockCost:SetDimensions(150,100)
	blockCost:SetHorizontalAlignment(CENTER)
	blockCost:SetHidden(false)


	------------------ Block ------------------------

	----------------- Self buffs -----------------------

	local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffUIWidth
	local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffUIHeight
	local scale = HTTsavedVars[HTT_variables.currentlySelectedProfile].buffUIScale
	local SelfBuffsBackground = WM:CreateControl("$(parent)SelfBuffsBackground", HTTSelfBuffs, CT_TEXTURE)
	SelfBuffsBackground:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffBackgroundColor))
	SelfBuffsBackground:SetAnchor(TOPLEFT, HTTSelfBuffs, TOPLEFT, 0, 0)
	SelfBuffsBackground:SetDimensions(width, (height*HTT_functions.GetNumberOfBuffs())+20)
	SelfBuffsBackground:SetHidden(false)

	local SelfBuffsText = WM:CreateControl("$(parent)SelfBuffsText",HTTSelfBuffs,CT_LABEL)
	SelfBuffsText:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].buffFont)
	SelfBuffsText:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].buffFont][1])
	SelfBuffsText:SetDrawLayer(1)
	SelfBuffsText:SetColor(255, 255, 255, 1)
	SelfBuffsText:SetText("Buffs")				
	SelfBuffsText:SetAnchor(TOPLEFT, SelfBuffsBackground, TOPLEFT,(width*(3/100))*scale, 0)
	SelfBuffsText:SetDimensions(width*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].buffFont][1]/20), 1)
	SelfBuffsText:SetHidden(false)

	for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfBuffs) do
		HTT_functions.createBuffControl(v)
	end

	

	----------------- Self buffs -----------------------

	--------------- Stonefist stacks on yourself  // Shimmering Shield // Empower ---------------------

	local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].specialUIWidth
	local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].specialUIHeight
	local scale = HTTsavedVars[HTT_variables.currentlySelectedProfile].specialUIScale
	
	if GetUnitClassId("player") == 1 or GetUnitClassId("player") == 4 then

		local StackCountBG = WM:CreateControl("$(parent)StackCountBG", HTTOwnStacks, CT_TEXTURE)
		StackCountBG:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].specialBackgroundColor))
		StackCountBG:SetAnchor(TOPLEFT, HTTOwnStacks, TOPLEFT, 0, 0)
		StackCountBG:SetDrawLayer(0)
		StackCountBG:SetDimensions(width, height)
		StackCountBG:SetHidden(false)
	

	
		local ballSize = HTT_functions.GetLesserValue(height,width/3)/2

		for i=-1, 1 do
			local circleOutline = WM:CreateControl("$(parent)CircleOutline"..i,HTTOwnStacks,  CT_TEXTURE, 4)
			circleOutline:SetDimensions(ballSize, ballSize)
			circleOutline:SetAnchor(HTT_variables.anchorsByNumber[i],StackCountBG,HTT_variables.anchorsByNumber[i],(width/(-10))*i,height/(-10))
			circleOutline:SetTexture([[/esoui/art/skillsadvisor/circle_passiveabilityframe_doubleframe.dds]])
			circleOutline:SetHidden(false)
			circleOutline:SetDrawLayer(3)
			local circle = WM:CreateControl("$(parent)CircleInner"..i,HTTOwnStacks,  CT_TEXTURE, 4)
			circle:SetDimensions(ballSize*0.85, ballSize*0.85)
			circle:SetAnchor(CENTER,circleOutline,CENTER,0,0)
			circle:SetTexture(HTT_variables.specialTextures[GetUnitClassId("player")])
			circle:SetHidden(false)
			circle:SetDrawLayer(2)

		end

		stackTimerBarOutline = WM:CreateControl("$(parent)StackTimerBarTexture", HTTOwnStacks, CT_TEXTURE)
		stackTimerBarOutline:SetDimensions(width*0.8,height/5)
		stackTimerBarOutline:SetAnchor(TOPLEFT,StackCountBG,TOPLEFT,width/100,height/20)
		stackTimerBarOutline:SetTexture("/esoui/art/ava/ava_resourcestatus_progbar_achieved_overlay.dds")
		stackTimerBarOutline:SetHidden(false)
		stackTimerBarOutline:SetDrawLayer(2)

		stackTimerBar = WM:CreateControl("$(parent)StackTimerBar", HTTOwnStacks, CT_STATUSBAR)	
		stackTimerBar:SetAnchor(LEFT, stackTimerBarOutline, LEFT, width*0.025, 0)
		stackTimerBar:SetDimensions(width*0.75,height/6)
		stackTimerBar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].classSpecialColor))
		stackTimerBar:SetHidden(false)		
		stackTimerBar:SetDrawLayer(2)
		stackTimerBar:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].currentlySelectedBarTexture)



		stackTimerText = WM:CreateControl("$(parent)StackTimerText", HTTOwnStacks, CT_LABEL)			
		stackTimerText:SetFont("ZoFontCallout3")
		stackTimerText:SetScale(height/250)
		stackTimerText:SetDrawLayer(3)
		stackTimerText:SetColor(255,255,255, 1)
		stackTimerText:SetText("0.0s")				
		stackTimerText:SetAnchor(TOPRIGHT, StackCountBG, TOPRIGHT,((2/15)*height)-(width/15),height/60)
		stackTimerText:SetDimensions(120,1)
		stackTimerText:SetHidden(false)
	elseif GetUnitClassId("player") == 5 then
		local EmpowerBackground = WM:CreateControl("$(parent)EmpowerBackground", HTTOwnStacks, CT_BACKDROP)
		EmpowerBackground:SetEdgeColor(0,0,0)
		EmpowerBackground:SetCenterColor(0,0,0)
		EmpowerBackground:SetAnchor(TOPLEFT, HTTOwnStacks, TOPLEFT, 0, 0)
		EmpowerBackground:SetAlpha(1)
		EmpowerBackground:SetScale(1.0)
		EmpowerBackground:SetDrawLayer(0)
		EmpowerBackground:SetHidden(false)
		EmpowerBackground:SetDimensions(width,height*5) -- default 210,60

		local EmpowerIcon = WM:CreateControl("$(parent)EmpowerIcon", HTTOwnStacks, CT_TEXTURE,4)
		EmpowerIcon:SetDimensions(width/10, height/2.8)
		EmpowerIcon:SetAnchor(TOPLEFT,EmpowerBackground,TOPLEFT,width/40,height/12)
		EmpowerIcon:SetTexture("esoui/art/icons/ability_buff_major_empower.dds")
		EmpowerIcon:SetHidden(false)
		EmpowerIcon:SetDrawLayer(2)

		local EmpowerText = WM:CreateControl("$(parent)EmpowerText",HTTOwnStacks,CT_LABEL)
		EmpowerText:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont)
		EmpowerText:SetScale((height/3)/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont][1])
		EmpowerText:SetDrawLayer(1)
		EmpowerText:SetColor(255, 255, 255, 1)
		EmpowerText:SetText("Empower")				
		EmpowerText:SetAnchor(LEFT, EmpowerIcon, RIGHT,width/40, 0)
		EmpowerText:SetDimensions(width*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont][1]/20), (height/3)*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont][1]/20))
		EmpowerText:SetHorizontalAlignment(0)
		EmpowerText:SetVerticalAlignment(1)
		EmpowerText:SetHidden(false)

		for n=1, 12 do

				local EmpowerRoleIcon = WM:CreateControl("$(parent)EmpowerRoleIcon"..n, HTTOwnStacks, CT_TEXTURE,4)
				EmpowerRoleIcon:SetDimensions(height/2.8, height/2.8)
				EmpowerRoleIcon:SetAnchor(TOPLEFT,EmpowerBackground,TOPLEFT,scale*width/40,((height/2.75*n)+height/6)*scale)
				EmpowerRoleIcon:SetTexture(HTT_variables.roleIcons[1])
				EmpowerRoleIcon:SetHidden(false)
				EmpowerRoleIcon:SetDrawLayer(2)

				local EmpowerBar = WM:CreateControl("$(parent)EmpowerBar"..n, HTTOwnStacks, CT_STATUSBAR)	
				EmpowerBar:SetScale(1.0)
				EmpowerBar:SetAnchor(LEFT, EmpowerRoleIcon, RIGHT, scale*width/200, 0)
				EmpowerBar:SetDimensions(width*(0.75), height/3)
				EmpowerBar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].classSpecialColor))
				EmpowerBar:SetHidden(false)		
				EmpowerBar:SetDrawLayer(2)
				EmpowerBar:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].currentlySelectedBarTexture)


				local EmpowerTimer = WM:CreateControl("$(parent)EmpowerTimer"..n, HTTOwnStacks, CT_LABEL)			
				EmpowerTimer:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont)
				EmpowerTimer:SetScale((height/3)/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont][1])
				EmpowerTimer:SetWrapMode(TEX_MODE_CLAMP)
				EmpowerTimer:SetDrawLayer(2)
				EmpowerTimer:SetColor(255,255,255, 1)
				EmpowerTimer:SetText("0.0s")				
				EmpowerTimer:SetAnchor(LEFT, EmpowerRoleIcon, RIGHT, scale*width*(0.75),0)
				EmpowerTimer:SetDimensions((width/8)*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont][1]/20),(height/2.8)*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont][1]/20))
				EmpowerTimer:SetHorizontalAlignment(1)
				EmpowerTimer:SetVerticalAlignment(1)
				EmpowerTimer:SetHidden(false)
			

				

				local EmpowerTextInBar = WM:CreateControl("$(parent)EmpowerTextInBar"..n, HTTOwnStacks, CT_LABEL)
				EmpowerTextInBar:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont)
				EmpowerTextInBar:SetScale((height/3)/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont][1])
				EmpowerTextInBar:SetWrapMode(TEX_MODE_CLAMP)
				EmpowerTextInBar:SetDrawLayer(3)
				EmpowerTextInBar:SetColor(255,255,255, 1)
				EmpowerTextInBar:SetText("Group Member "..n)				
				EmpowerTextInBar:SetAnchor(LEFT, EmpowerBar, LEFT, scale*width/36,0)
				EmpowerTextInBar:SetDimensions(width*0.7*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont][1]/20),(height/3)*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].specialFont][1]/20))
				EmpowerTextInBar:SetHidden(false)
				EmpowerTextInBar:SetVerticalAlignment(1)

				

		end
	end

	

	--------------- Stonefist stacks on yourself ---------------------


	--------------- Reticle Debuffs ----------------------------
    

	local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIWidth
	local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIHeight
	local scale = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffUIScale
	HTTBackground = WM:CreateControl("$(parent)BackgroundReticle", HTT, CT_TEXTURE)
	HTTBackground:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].reticleBackgroundColor))
	HTTBackground:SetAnchor(TOPLEFT, HTT, TOPLEFT, 0, 0)
	HTTBackground:SetScale(1.0)
	HTTBackground:SetDrawLayer(0)
	HTTBackground:SetDimensions(width, (height*HTT_functions.GetNumberOfDebuffs())+20)
	HTTBackground:SetHidden(false)


	HTTText = WM:CreateControl("$(parent)TextReticle",HTT,CT_LABEL)
	HTTText:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffFont)
	HTTText:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffFont][1])
	--HTTText:SetWrapMode(TEX_MODE_CLAMP)
	HTTText:SetDrawLayer(1)
	HTTText:SetColor(255, 255, 255, 1)
	HTTText:SetText("Boss name")				
	HTTText:SetAnchor(TOPLEFT, HTTBackground, TOPLEFT,(width*(3/100))*scale, 0)
	HTTText:SetDimensions(width*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffFont][1]/20), 1)
	HTTText:SetHorizontalAlignment(CENTER)
	HTTText:SetHidden(false)



	for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs) do

			

		HTT_functions.createDebuffControl(v)






	end



	------------------------ RETICLE DEBUFFS ----------------------------------

	------------------------ BOSS DEBUFFS -----------------------------------

	local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffBossUIWidth
	local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffBossUIHeight
	local scale = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffBossUIScale
	for i=1, MAX_BOSSES do

		HTTBackground = WM:CreateControl("$(parent)BackgroundBoss"..i, _G["HTTBoss"..i], CT_TEXTURE)
		HTTBackground:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].bossBackgroundColor))
		HTTBackground:SetAnchor(TOPLEFT, _G["HTTBoss"..i], TOPLEFT, 0, 0)
		HTTBackground:SetScale(1.0)
		HTTBackground:SetDrawLayer(0)
		HTTBackground:SetDimensions(width, (height*HTT_functions.GetNumberOfDebuffs())+20)
		HTTBackground:SetHidden(false)


		HTTText = WM:CreateControl("$(parent)TextBoss"..i,_G["HTTBoss"..i],CT_LABEL)
		HTTText:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].bossFont)
		HTTText:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].bossFont][1])
		--HTTText:SetWrapMode(TEX_MODE_CLAMP)
		HTTText:SetDrawLayer(1)
		HTTText:SetColor(255, 255, 255, 1)
		HTTText:SetText("Boss name"..i)				
		HTTText:SetAnchor(TOPLEFT, HTTBackground, TOPLEFT,(width*(3/100))*scale, 0)
		HTTText:SetDimensions(width*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].bossFont][1]/20), 1)
		HTTText:SetHorizontalAlignment(CENTER)
		HTTText:SetHidden(false)


	end

	for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfDebuffs) do
		HTT_functions.createBossDebuffControl(v)
	end


	------------------------ BOSS DEBUFFS -----------------------------------

	------------------------- COOLDOWNS -----------------------------------

	local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownUIWidth
	local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownUIHeight
	local scale = HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownUIScale
	local CooldownsBackground = WM:CreateControl("$(parent)CooldownsBackground", HTTCooldowns, CT_TEXTURE)
	CooldownsBackground:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownBackgroundColor))
	CooldownsBackground:SetAnchor(TOPLEFT, HTTCooldowns, TOPLEFT, 0, 0)
	CooldownsBackground:SetScale(1.0)
	CooldownsBackground:SetDrawLayer(0)
	CooldownsBackground:SetDimensions(width, (height*HTT_functions.CountTurnedOn(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownTable["isTurnedOn"]))+20)
	CooldownsBackground:SetHidden(false)


	local CooldownsText = WM:CreateControl("$(parent)CooldownsText",HTTCooldowns,CT_LABEL)
	CooldownsText:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownFont)
	CooldownsText:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownFont][1])
	CooldownsText:SetDrawLayer(1)
	CooldownsText:SetColor(255, 255, 255, 1)
	CooldownsText:SetText("Cooldowns")				
	CooldownsText:SetAnchor(TOPLEFT, CooldownsBackground, TOPLEFT,(width*(3/100))*scale, 0)
	CooldownsText:SetDimensions(width*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].cooldownFont][1]/20), 1)
	CooldownsText:SetHorizontalAlignment(CENTER)
	CooldownsText:SetHidden(false)



	for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfCooldowns) do
		HTT_functions.createCooldownControl(v)

	end

	------------------------- COOLDOWNS -----------------------------------
	
	-------------------------- SYNERGIES --------------------------------


	local width = HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesUIWidth
	local height = HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesUIHeight
	local scale = HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesUIScale


	local SynergiesBackground = WM:CreateControl("$(parent)SynergiesBackground", HTTSynergies, CT_TEXTURE)
	SynergiesBackground:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesBackgroundColor))
	SynergiesBackground:SetAnchor(TOPLEFT, HTTSynergies, TOPLEFT, 0, 0)
	SynergiesBackground:SetScale(1.0)
	SynergiesBackground:SetDrawLayer(0)
	SynergiesBackground:SetDimensions(width, (height*HTT_functions.CountTurnedOn(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable["isTurnedOn"]))+20)
	SynergiesBackground:SetHidden(false)


	local SynergiesText = WM:CreateControl("$(parent)SynergiesText",HTTSynergies,CT_LABEL)
	SynergiesText:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont)
	SynergiesText:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont][1])
	SynergiesText:SetDrawLayer(1)
	SynergiesText:SetColor(255, 255, 255, 1)
	SynergiesText:SetText("Synergies")				
	SynergiesText:SetAnchor(TOPLEFT, SynergiesBackground, TOPLEFT,(width*(3/100))*scale, 0)
	SynergiesText:SetDimensions(width*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont][1]/20), 1)
	SynergiesText:SetHorizontalAlignment(CENTER)
	SynergiesText:SetHidden(false)


	for _,v in pairs(HTTsavedVars[HTT_variables.currentlySelectedProfile].orderOfSynergies) do
		


		timer = WM:CreateControl("$(parent)SynergiesDurationTimer"..v, HTTSynergies, CT_LABEL)			
		timer:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont)
		timer:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont][1])
		timer:SetWrapMode(TEX_MODE_CLAMP)
		timer:SetDrawLayer(2)
		timer:SetColor(255,255,255, 1)
		timer:SetText("0.0s")				
		timer:SetAnchor(TOPLEFT, SynergiesBackground, TOPLEFT, 5,0)
		timer:SetDimensions((HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont][1]/20)*width/4, 1)
		--timer:SetHorizontalAlignment(LEFT)
		timer:SetHidden(false)
			
			

		bar = WM:CreateControl("$(parent)SynergiesDurationBar"..v, HTTSynergies, CT_STATUSBAR)	
		bar:SetScale(1.0)
		bar:SetAnchor(TOPLEFT, SynergiesBackground, TOPLEFT,0, 0)
		bar:SetDimensions(width*0.75,height)
		bar:SetColor(unpack(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable["colors"][v]))
		bar:SetHidden(false)		
		bar:SetDrawLayer(1)
		bar:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].currentlySelectedBarTexture)

		textInBar = WM:CreateControl("$(parent)SynergiesTextInBar"..v, HTTSynergies, CT_LABEL)
		textInBar:SetFont(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont)
		textInBar:SetScale(height/HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont][1])
		textInBar:SetWrapMode(TEX_MODE_CLAMP)
		textInBar:SetDrawLayer(2)
		textInBar:SetColor(1,1,1,1)
		textInBar:SetText(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable["names"][v])				
		textInBar:SetAnchor(TOPLEFT, SynergiesBackground, TOPLEFT, 30,0)
		textInBar:SetDimensions(width*(HTT_variables.fontMultipliers[HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesFont][1]/20), 1)
		textInBar:SetHidden(false)

		icon = WM:CreateControl("$(parent)SynergiesIcon"..v, HTTSynergies, CT_TEXTURE,4)
		icon:SetDimensions(height,height)
		icon:SetAnchor(TOPLEFT,SynergiesBackground,TOPLEFT,5,0)
		icon:SetTexture(HTTsavedVars[HTT_variables.currentlySelectedProfile].synergiesTable["icons"][v])
		icon:SetHidden(false)
		icon:SetDrawLayer(2)



	end



	-------------------------- SYNERGIES --------------------------------



















    HTT_functions.ProcessAnchors()
end