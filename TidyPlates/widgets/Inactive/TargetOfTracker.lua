	-- Events
	
	--[[
	PLAYER_ENTERING_WORLD
	PLAYER_REGEN_ENABLED
	PLAYER_REGEN_DISABLED
	PLAYER_TARGET_CHANGED
	UNIT_THREAT_SITUATION_UPDATE
	
	UNIT_TARGET
	
numPartyMembers = GetNumPartyMembers()
Returns: numPartyMembers - Number of additional members in the player's party (between 1 and MAX_PARTY_MEMBERS, or 0 if the player is not in a party) (number)

numRaidMembers = GetNumRaidMembers()
Returns: numRaidMembers - Number of members in the raid (including the player) (number)


UNIT_TARGET - arg1, unit affected

Interesting Events
UNIT_TARGETABLE_CHANGED


	--]]

	
	local TrackedUnits = {}
	local TrackedUnitTargets = {}
	local TrackedUnitTargetHistory = {}
	
	local function UpdateTracker()
		local widget, plate
		local target, unitid, guid
		local changes = false
		wipe(TrackedUnits)
		
		-- Store target history
		for guid, target in pairs(TrackedUnitTargets) do
			TrackedUnitTargetHistory[guid] = target
			TrackedUnitTargets[guid] = nil
		end
		
		-- Reset the Tracking List
		for guid in pairs(TrackedUnits) do TrackedUnits[guid] = nil end
		
		-- Build a list of Trackable targets (via target, focus, and raid members)
		guid = UnitGUID("target")
		if guid then TrackedUnits[guid] = "target" end

		guid = UnitGUID("focus")
		if guid then TrackedUnits[guid] = "focus" end
		
		local raidsize = GetNumRaidMembers() - 1
		for index = 1, raidsize do
			unitid = "raid"..index.."target"
			guid = UnitGUID(unitid)
			if guid then TrackedUnits[guid] = unitid end
		end
		
		-- Build a list of the target's targets and check for changes
		for guid, unitid in pairs(TrackedUnits) do
			if unitid then 
				TrackedUnitTargets[guid] = UnitName(unitid.."target")
				if TrackedUnitTargets[guid] ~= TrackedUnitTargetHistory[guid] then changes = true end
			end
		end
		
		-- Call for indicator Update, if needed
		if changes then 
			TidyPlates:Update()	
		end
	end
	
	local EventWatcher = CreateFrame("Frame")
	EventWatcher:SetScript("OnEvent", UpdateTracker)
	EventWatcher:RegisterEvent("PLAYER_ENTERING_WORLD")
	EventWatcher:RegisterEvent("PLAYER_REGEN_ENABLED")
	--EventWatcher:RegisterEvent("PLAYER_REGEN_DISABLED")
	EventWatcher:RegisterEvent("PLAYER_TARGET_CHANGED")
	EventWatcher:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE")
	EventWatcher:RegisterEvent("UNIT_TARGET")
	