------------------------------
-- Debuff and Roster Handler
------------------------------
local UnitIds = TidyPlatesUtility.GroupMembers.UnitId
local DangerWatcher

-- Event Handler
local function AggroEvents(frame, event, unit)
	local isUnitInParty = UnitPlayerOrPetInParty(unit)
	local isUnitInRaid = UnitInRaid(unit)
	local isUnitPet = (unit == "pet")

	if isUnitInParty or isUnitInRaid or isUnitPet then
		TidyPlates:Update()
	end
end

local function GetThreatCondition(name)
	local unitid = UnitIds[name]

	if unitid then
		local unitaggro = UnitThreatSituation(unitid)
		if unitaggro and unitaggro > 1 then
			return true
		end
	end
end

local function Enable()
	if not DangerWatcher then
		DangerWatcher = CreateFrame("Frame")
	end
	DangerWatcher:SetScript("OnEvent", AggroEvents)
	DangerWatcher:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE")
	TidyPlatesUtility.EnableGroupWatcher()
end

local function Disable()
	DangerWatcher:SetScript("OnEvent", nil)
	DangerWatcher:UnregisterAllEvents()
	DangerWatcher = nil
end

TidyPlatesWidgets.EnableAggroWatch = Enable
TidyPlatesWidgets.DisableAggroWatch = Disable
TidyPlatesWidgets.GetThreatCondition = GetThreatCondition