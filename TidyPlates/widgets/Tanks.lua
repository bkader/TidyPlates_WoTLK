------------------------------
-- Target Tracker
------------------------------

local TrackedUnits = {}
local TrackedUnitTargets = {}
local TrackedUnitTargetHistory = {}
local TargetWatcher

local function TargetWatcherEvents()
	local widget, plate
	local target, guid
	local changes = false
	TrackedUnits = wipe(TrackedUnits)

	-- Store target history
	for gid, tar in pairs(TrackedUnitTargets) do
		TrackedUnitTargetHistory[gid] = tar
		TrackedUnitTargets[gid] = nil
	end

	-- Reset the Tracking List
	for gid in pairs(TrackedUnits) do
		TrackedUnits[gid] = nil
	end

	-- Build a list of Trackable targets (via target, focus, and raid members)
	guid = UnitGUID("target")
	if guid then
		TrackedUnits[guid] = "target"
	end

	guid = UnitGUID("focus")
	if guid then
		TrackedUnits[guid] = "focus"
	end

	local raidsize = GetNumRaidMembers() - 1
	for index = 1, raidsize do
		local unitid = "raid" .. index .. "target"
		guid = UnitGUID(unitid)
		if guid then
			TrackedUnits[guid] = unitid
		end
	end

	-- Build a list of the target's targets and check for changes
	for gid, unitid in pairs(TrackedUnits) do
		if unitid then
			TrackedUnitTargets[gid] = UnitName(unitid .. "target")
			if TrackedUnitTargets[gid] ~= TrackedUnitTargetHistory[gid] then
				changes = true
			end
		end
	end

	-- Call for indicator Update, if needed
	if changes then
		TidyPlates:Update()
	end
end

---------------
-- Tank Monitor
---------------
local TankNames = {}
local TankWatcher

local function IsTankedByAnotherTank(unit)
	local targetOf
	if unit.guid then
		if unit.isTarget then
			targetOf = UnitName("targettarget") -- Nameplate is a target
		elseif unit.isMouseover then
			targetOf = UnitName("mouseovertarget") -- Nameplate is a mouseover
		else
			targetOf = TrackedUnitTargets[unit.guid]
		end

		if targetOf and TankNames[targetOf] then
			return true
		end
	end
	return false
end

local function TankWatcherEvents()
	if UnitInRaid("player") then
		local size = GetNumRaidMembers() - 1
		for index = 1, size do
			local raidid = "raid" .. tostring(index)

			local isAssigned = GetPartyAssignment("MAINTANK", raidid) or GetPartyAssignment("MAINASSIST", raidid) or ("TANK" == UnitGroupRolesAssigned(raidid))

			if isAssigned then
				TankNames[UnitName(raidid)] = true
			else
				TankNames[UnitName(raidid)] = nil
			end
		end
	else
		TankNames = wipe(TankNames)
		if HasPetUI("player") and UnitName("pet") then
			TankNames[UnitName("pet")] = true
		end
	end
end

local function EnableTankWatch()
	if not TargetWatcher then
		TargetWatcher = CreateFrame("Frame")
	end
	TargetWatcher:RegisterEvent("PLAYER_REGEN_ENABLED")
	TargetWatcher:RegisterEvent("PLAYER_REGEN_DISABLED")
	TargetWatcher:RegisterEvent("PLAYER_TARGET_CHANGED")
	TargetWatcher:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE")
	TargetWatcher:RegisterEvent("UNIT_TARGET")
	TargetWatcher:SetScript("OnEvent", TargetWatcherEvents)
	TargetWatcherEvents()

	if not TankWatcher then
		TankWatcher = CreateFrame("Frame")
	end
	TankWatcher:RegisterEvent("RAID_ROSTER_UPDATE")
	TankWatcher:RegisterEvent("PARTY_MEMBERS_CHANGED")
	TankWatcher:RegisterEvent("PARTY_CONVERTED_TO_RAID")
	TankWatcher:SetScript("OnEvent", TankWatcherEvents)
	TankWatcherEvents()
end

local function DisableTankWatch()
	if TargetWatcher then
		TargetWatcher:SetScript("OnEvent", nil)
		TargetWatcher:UnregisterAllEvents()
		TargetWatcher = nil
	end

	if TankWatcher then
		TankWatcher:SetScript("OnEvent", nil)
		TankWatcher:UnregisterAllEvents()
		TankWatcher = nil
	end
end

TidyPlatesWidgets.EnableTankWatch = EnableTankWatch
TidyPlatesWidgets.DisableTankWatch = DisableTankWatch
TidyPlatesWidgets.IsTankedByAnotherTank = IsTankedByAnotherTank