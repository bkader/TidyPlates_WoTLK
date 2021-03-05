local EncounterWatcherFrame = CreateFrame("Frame")
local UnitEventHandlers = {}
local UnitLookupTable = {}
local TrackedAuras = {}

-- Widget Event Handler
local function EventHandler(frame, unit)
	UnitLookupTable[UnitName(unit)] = unit
	local debuffIndex, debuffName, debuffType
	
	-- Only send update if the aura is something you're looking for
	for debuffIndex = 1, 40 do
		debuffName, _, _, _, debuffType = UnitDebuff(unitid,auraindex)
		if debuffName and (TrackedAuras[debuffName] or TrackedAuras[debuffType]) then
			TidyPlates:Update()
			return
		end			
	end
end

EncounterWatcherFrame:SetScript("OnEvent", EventHandler)
EncounterWatcherFrame:RegisterEvent("UNIT_AURA")

-- In-Theme
local function GetIndicatorColor(name)
	local unitid = UnitLookupTable[name]
	local debuffName, debuffType, debuffColor, debuffReference, debuffIndex
	local debuffPriority = 0
	if unitid then
		for debuffIndex = 1, 40 do
			debuffName, _, _, _, debuffType = UnitDebuff(unitid,auraindex)
			if debuffName then
				debuffReference = TrackedAuras[debuffName] or TrackedAuras[debuffType]
				if debuffReference and debuffReference.priority > debuffPriority then
					debuffColor = debuffReference.color
					debuffPriority = debuffReference.priority
				end
				
			end			
		end
	end
	return debuffColor
end

--[[

------------------------------
-- Auras to Track (experimental)
------------------------------
local TrackedAuras = {}
TrackedAuras["Necrotic Plague"] = {color = {r = .1,g = 1, b = 0, a = 1},}

local function CheckGroupMemberDebuffs(name)
	local unitid = UnitNameCache[name]
	local debuffName, debuffType, debuffColor, debuffReference, debuffIndex, _
	local debuffPriority = 0
	
	if unitid then
		for debuffIndex = 1, 40 do
			debuffName, _, _, _, debuffType = UnitDebuff(unitid,debuffIndex)					-- Operational
			--debuffName, debuffType, _, _, _, _, _, _ = UnitBuff(unitid,debuffIndex)		-- For testing 

			if debuffName then
				debuffReference = TrackedAuras[debuffName] or TrackedAuras[debuffType]
				if debuffReference then
					debuffColor = debuffReference.color
					return debuffColor
				end
				
			end			
		end
	end
	return nil
end
--]]
