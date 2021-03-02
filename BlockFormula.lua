HTT_blockFormula = {}
function HTT_blockFormula.GetSturdyBonus()
	local sturdyBonus = 0
	local equipment = {EQUIP_SLOT_CHEST,EQUIP_SLOT_FEET,EQUIP_SLOT_OFF_HAND,EQUIP_SLOT_HAND,EQUIP_SLOT_HEAD,EQUIP_SLOT_LEGS,EQUIP_SLOT_SHOULDERS,EQUIP_SLOT_WAIST}
	for _,v in pairs(equipment) do
		local trait,text = GetItemLinkTraitInfo(GetItemLink(BAG_WORN,v))
		if trait == ITEM_TRAIT_TYPE_ARMOR_STURDY then
			local value = string.gsub(text,"%D","")
			value = tonumber(value)
			if value >10 then
				value = value/10
			end
			sturdyBonus = sturdyBonus + value
		end
	end
	return 1-sturdyBonus/100
end

function HTT_blockFormula.GetJeweleryBonus()
	local jeweleryBonus = 0
	local equipment = {EQUIP_SLOT_NECK,EQUIP_SLOT_RING1,EQUIP_SLOT_RING2}
	for _,v in pairs(equipment) do
		local name,text = select(2,GetItemLinkEnchantInfo(GetItemLink(BAG_WORN,v)))
		if name == "Bracing Enchantment" then
			b,e = string.find(text,"[0-9]+")
			jeweleryBonus = jeweleryBonus + tonumber(b and string.sub(text,b,e))
		end
	end
	return jeweleryBonus
end

function HTT_blockFormula.GetSkillMitigations()
	local skillMitigations = 0
	local class = GetUnitClassId("player")
	
	if class == 1 then
		skillMitigations = skillMitigations + (5*GetSkillAbilityUpgradeInfo(1,2,7)) --DK Iron Skin
	end
	if (GetItemWeaponType(BAG_WORN,EQUIP_SLOT_MAIN_HAND) == WEAPONTYPE_FROST_STAFF and GetActiveWeaponPairInfo() == ACTIVE_WEAPON_PAIR_MAIN) or (GetItemWeaponType(BAG_WORN,EQUIP_SLOT_BACKUP_MAIN) == WEAPONTYPE_FROST_STAFF and GetActiveWeaponPairInfo() == ACTIVE_WEAPON_PAIR_BACKUP) then --Frost Staff Ancient Knowledge
		skillMitigations = skillMitigations + (10*GetSkillAbilityUpgradeInfo(2,5,10))
	end
	if (GetItemWeaponType(BAG_WORN,EQUIP_SLOT_OFF_HAND) == WEAPONTYPE_SHIELD and GetActiveWeaponPairInfo() == ACTIVE_WEAPON_PAIR_MAIN) or (GetItemWeaponType(BAG_WORN,EQUIP_SLOT_BACKUP_OFF) == WEAPONTYPE_SHIELD and GetActiveWeaponPairInfo() ==ACTIVE_WEAPON_PAIR_BACKUP) then --SnB Sword and Board
		skillMitigations = skillMitigations + (10*GetSkillAbilityUpgradeInfo(2,2,8))
	end
	return skillMitigations
end

function HTT_blockFormula.GetSkillBlockCostReduction()
	local skillCostReduction = 0
	if  (GetItemWeaponType(BAG_WORN,EQUIP_SLOT_MAIN_HAND) == WEAPONTYPE_FROST_STAFF and GetActiveWeaponPairInfo() == ACTIVE_WEAPON_PAIR_MAIN) or (GetItemWeaponType(BAG_WORN,EQUIP_SLOT_BACKUP_MAIN) == WEAPONTYPE_FROST_STAFF and GetActiveWeaponPairInfo() == ACTIVE_WEAPON_PAIR_BACKUP) then --SnB Fortress
		skillCostReduction = skillCostReduction + (18*GetSkillAbilityUpgradeInfo(2,2,7))
	end
	if (GetItemWeaponType(BAG_WORN,EQUIP_SLOT_OFF_HAND) == WEAPONTYPE_SHIELD and GetActiveWeaponPairInfo() == ACTIVE_WEAPON_PAIR_MAIN) or (GetItemWeaponType(BAG_WORN,EQUIP_SLOT_BACKUP_OFF) == WEAPONTYPE_SHIELD and GetActiveWeaponPairInfo() ==ACTIVE_WEAPON_PAIR_BACKUP) then --Frost Staff Ancient Knowledge
		skillCostReduction = skillCostReduction + (18*GetSkillAbilityUpgradeInfo(2,5,10))
	end
	return 1-skillCostReduction/100
end

function HTT_blockFormula.isDefensiveStanceSlotted()
	local mitigationAndCost = 0
	local defensiveStanceID = GetSkillAbilityId(2,2,4)
	for i=3, 7 do
		if defensiveStanceID==GetSlotBoundId(i) then
			mitigationAndCost = mitigationAndCost + 10
		end
	end
	return mitigationAndCost
end

function HTT_blockFormula.GetCPBlockCostReduction()
	pointsInShadowWard = GetNumPointsSpentOnChampionSkill(8, 3)
	return 1-math.floor(0.0025*pointsInShadowWard*(2-pointsInShadowWard*0.01)*100)/100
end

function HTT_blockFormula.GetImmovableMitigation()
	heavyCount = 0
	if HTT_variables.immovableOn then
		local equipment = {EQUIP_SLOT_CHEST,EQUIP_SLOT_FEET,EQUIP_SLOT_HAND,EQUIP_SLOT_HEAD,EQUIP_SLOT_LEGS,EQUIP_SLOT_SHOULDERS,EQUIP_SLOT_WAIST}
		for _,v in pairs(equipment) do
			if GetItemArmorType(BAG_WORN,v) == ARMORTYPE_HEAVY then
				heavyCount = heavyCount + 1
			end
		end
	end
	return heavyCount*5
end

function HTT_blockFormula.GetBoundAegisMitigation()
	if HTT_variables.isBoundAegisOn then
		return 40
	end
	return 0
end

function HTT_blockFormula.GetSacredGroundMitigation()
	if HTT_variables.isSacredGroundOn then
		return 10
	end
	return 0
end


function HTT_blockFormula.GetBlockCost()
	return math.floor((1730*HTT_blockFormula.GetCPBlockCostReduction()-HTT_blockFormula.GetJeweleryBonus())*HTT_blockFormula.GetSturdyBonus()*(1-HTT_blockFormula.isDefensiveStanceSlotted()/100)*HTT_blockFormula.GetSkillBlockCostReduction())
end

function HTT_blockFormula.GetBlockMitigation()
	d()GetActiveWeaponPairInfo()
	blockMitigation = ((HTT_blockFormula.isDefensiveStanceSlotted()+HTT_blockFormula.GetSkillMitigations()+HTT_blockFormula.GetImmovableMitigation()+HTT_blockFormula.GetBoundAegisMitigation()+HTT_blockFormula.GetSacredGroundMitigation())/2)+50
	if blockMitigation > 90 then
		blockMitigation = 90
	end
	return blockMitigation
end