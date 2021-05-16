-- Group Roster Monitor
local Group = {}
Group.Names = {}
Group.Tanks = {}
Group.Class = {}
Group.Role = {}
Group.UnitId = {}
Group.GUID = {}
Group.Type = "solo"
Group.Size = 1

local function IsUnitTank(unitId)
	if GetPartyAssignment("MAINTANK", unitId) or GetPartyAssignment("MAINASSIST", unitId) or ("TANK" == UnitGroupRolesAssigned(unitId)) then
		return true
	end
end

local function UpdateRoster(frame, event, ...)
	-- Check Group Type
	local groupType, groupSize
	if UnitInRaid("player") then
		groupType = "raid"
		groupSize = GetNumRaidMembers() - 1
	elseif UnitInParty("player") then
		groupType = "party"
		groupSize = GetNumPartyMembers()
	else
		groupType = "solo"
		groupSize = 1
	end

	wipe(Group.Names)
	wipe(Group.Tanks)
	wipe(Group.Class)
	wipe(Group.Role)
	wipe(Group.UnitId)
	wipe(Group.GUID)

	Group.Type = groupType
	Group.Size = groupSize

	-- Cycle through Group
	if groupType then
		for index = 1, groupSize do
			local unitId = groupType .. index
			local unitName = UnitName(unitId)
			if unitName then
				Group.Names[unitId] = unitName
				Group.Class[unitName] = select(2, UnitClass(unitId))
				Group.Tanks[unitName] = IsUnitTank(unitId)
				Group.Role[unitName] = UnitGroupRolesAssigned(unitId)
				Group.UnitId[unitName] = unitId
				Group.GUID[UnitGUID(unitId)] = unitId
			end
		end
	end

	TidyPlates:Update()
end

local function Enable()
	if not RosterMonitor then
		RosterMonitor = CreateFrame("Frame")
	end
	RosterMonitor:RegisterEvent("RAID_ROSTER_UPDATE")
	RosterMonitor:RegisterEvent("PARTY_MEMBERS_CHANGED")
	RosterMonitor:RegisterEvent("PARTY_CONVERTED_TO_RAID")
	RosterMonitor:RegisterEvent("PLAYER_ENTERING_WORLD")
	RosterMonitor:SetScript("OnEvent", UpdateRoster)

	UpdateRoster()
end

local function Disable()
	if RosterMonitor then
		RosterMonitor:SetScript("OnEvent", nil)
		RosterMonitor:UnregisterAllEvents()
		RosterMonitor = nil

		wipe(Group.Names)
		wipe(Group.Tanks)
		wipe(Group.Class)
		wipe(Group.Role)
		wipe(Group.UnitId)

		Group.Type = nil
		Group.Size = nil
	end
end

TidyPlatesUtility.GroupMembers = Group
TidyPlatesUtility.EnableGroupWatcher = Enable
TidyPlatesUtility.DisableGroupWatcher = Disable