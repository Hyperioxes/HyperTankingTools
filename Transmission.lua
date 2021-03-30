local function boolToNumber(value)
	return value and 1 or 0
end

local function numberToBool(number)
	if number == 0 then
		return false
	end
	return true
end
function convertTrackerToString(index,typeOfTracker)
	local string = ""
	--typeOfTracker
	--0 debuff
	--1 buff
	--2 cooldown
	if typeOfTracker == 0 then
		local tracker = HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable[index]
		string = string..typeOfTracker.."#"..tracker.name.."#"..","..tracker.color[1]..","..tracker.color[2]..","..tracker.color[3]..","..(tracker.color[4] or 1)..",#"
		for k,v in pairs(tracker.IDs) do
			string = string..","..v
		end
		string = string..",#"..tracker.icon.."#"
		for k,v in pairs(tracker.skill) do
			string = string..","..v
		end
		string = string..",#"
		for k,v in pairs(tracker.itemSet[1]) do
			string = string..","..v
		end
		string = string..",#"..(tracker.itemSet[2] or 0).."#"..tracker.text.."#"..tracker.textWhenMissing.."#"..boolToNumber(tracker.onlyCastByPlayer).."#"
	end
	d(string)
	return string
end

function loadTrackerFromString(string)
	local typeOfTracker = tonumber(string.sub(string, 1, 1))

	local t = {}                   
    local i = 0
    while true do
		i = string.find(string, "#", i+1)    
		if i == nil then break end
		table.insert(t, i)
    end

	if typeOfTracker == 0 then
		--name
		local name = string.sub(string, t[1]+1, t[2]-2)

		--color
		local t1 = {}                   
		local i1 = 0
		local colorString = string.sub(string, t[2]+1, t[3]-1)
		while true do
			i1 = string.find(colorString, ",", i1+1)    
			if i1 == nil then break end
			table.insert(t1, i1)
		end
		local color1 = string.sub(colorString, t1[1]+1, t1[2]-1)
		local color2 = string.sub(colorString, t1[2]+1, t1[3]-1)
		local color3 = string.sub(colorString, t1[3]+1, t1[4]-1)
		local color4 = string.sub(colorString, t1[4]+1, t1[5]-1)
		local color = {color1,color2,color3,color4}

		--IDs
		local IDs = {}
		local t2 = {}                   
		local i2 = 0
		local idString = string.sub(string, t[3]+1, t[4]-1)
		while true do
			i2 = string.find(idString, ",", i2+1)    
			if i2 == nil then break end
			table.insert(t2, i2)
		end
		for x=1, #t2-1 do
			table.insert(IDs,tonumber(string.sub(idString, t2[x]+1, t2[x+1]-1)))
		end

		--icon
		local icon = string.sub(string, t[4]+1, t[5]-1)
		
		--skills
		local skills = {}
		local t3 = {}                   
		local i3 = 0
		local skillString = string.sub(string, t[5]+1, t[6]-1)
		while true do
			i3 = string.find(skillString, ",", i3+1)    
			if i3 == nil then break end
			table.insert(t3, i3)
		end
		for x=1, #t3-1 do
			table.insert(IDs,tonumber(string.sub(idString, t3[x]+1, t3[x+1]-1)))
		end

		--itemSets
		local itemSets = {}
		local t4 = {}                   
		local i4 = 0
		local itemSetsString = string.sub(string, t[6]+1, t[7]-1)
		while true do
			i4 = string.find(itemSetsString, ",", i4+1)    
			if i4 == nil then break end
			table.insert(t4, i4)
		end
		for x=1, #t4-1 do
			table.insert(IDs,tonumber(string.sub(idString, t4[x]+1, t4[x+1]-1)))
		end

		--itemSetsNumber
		local itemSetsNumber = tonumber(string.sub(string, t[7]+1, t[8]-1))

		--text
		local text = string.sub(string, t[8]+1, t[9]-1)

		--textWhenMissing
		local textWhenMissing = string.sub(string, t[9]+1, t[10]-1)

		--onlyCastByPlayer
		local onlyCastByPlayer = numberToBool(tonumber(string.sub(string, t[10]+1, t[11]-1)))


		local tableSlot = HTT_functions.findFreeSlotInTable(HTTsavedVars[HTT_variables.currentlySelectedProfile].debuffTable)
		HTT_functions.addDebuff(name,IDs,tableSlot,text,textWhenMissing,color,nil,nil,onlyCastByPlayer,skill,itemSets,itemSetsNumber,icon)

	end
	











end
			



