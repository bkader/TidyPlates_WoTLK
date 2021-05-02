TidyPlatesWidgets.DebuffWidgetBuild = 2

local PlayerGUID = UnitGUID("player")
local PolledHideIn = TidyPlatesWidgets.PolledHideIn
local AuraMonitor = CreateFrame("Frame")
local WidgetList, WidgetGUID = {}, {}
local UpdateWidget
local TargetOfGroupMembers = {}
local MaximumDisplayableDebuffs = 6

local AURA_TARGET_HOSTILE = 1
local AURA_TARGET_FRIENDLY = 2

local AURA_TYPE_BUFF = 1
local AURA_TYPE_DEBUFF = 6

local AURA_TYPE = {
	["Buff"] = 1,
	["Curse"] = 2,
	["Disease"] = 3,
	["Magic"] = 4,
	["Poison"] = 5,
	["Debuff"] = 6
}

local function GetAuraWidgetByGUID(guid)
	if guid then
		return WidgetGUID[guid]
	end
end

local function IsAuraShown(widget, aura)
	if widget and widget.IsShown then
		for i = 1, 6 do
			if widget.AuraIconFrames[i] and widget.AuraIconFrames[i]:IsShown() then
				return true
			end
		end
	end
end

local RaidIconBit = {
	["STAR"] = 0x00100000,
	["CIRCLE"] = 0x00200000,
	["DIAMOND"] = 0x00400000,
	["TRIANGLE"] = 0x00800000,
	["MOON"] = 0x01000000,
	["SQUARE"] = 0x02000000,
	["CROSS"] = 0x04000000,
	["SKULL"] = 0x08000000
}

local RaidIconIndex = {
	"STAR",
	"CIRCLE",
	"DIAMOND",
	"TRIANGLE",
	"MOON",
	"SQUARE",
	"CROSS",
	"SKULL"
}

local ByRaidIcon = {}
local ByName = {}

local PlayerDispelCapabilities = {
	["Curse"] = false,
	["Disease"] = false,
	["Magic"] = false,
	["Poison"] = false
}

local function UpdatePlayerDispelTypes()
	PlayerDispelCapabilities["Curse"] = IsSpellKnown(51886) or IsSpellKnown(475) or IsSpellKnown(2782)
	PlayerDispelCapabilities["Poison"] = IsSpellKnown(2782) or IsSpellKnown(32375) or IsSpellKnown(4987) or (IsSpellKnown(527) and IsSpellKnown(33167))
	PlayerDispelCapabilities["Magic"] = (IsSpellKnown(4987) and IsSpellKnown(53551)) or (IsSpellKnown(527) and IsSpellKnown(33167)) or IsSpellKnown(32375)
	PlayerDispelCapabilities["Disease"] = IsSpellKnown(4987) or IsSpellKnown(528)
end

local function CanPlayerDispel(debuffType)
	return PlayerDispelCapabilities[debuffType or ""]
end

-----------------------------------------------------
-- Default Filter
-----------------------------------------------------
local function DefaultFilterFunction(debuff)
	return (debuff.duration < 600)
end

-----------------------------------------------------
-- Update Via Search
-----------------------------------------------------

local function FindWidgetByGUID(guid)
	return WidgetGUID[guid]
end

local function FindWidgetByName(SearchFor)
	for widget in pairs(WidgetList) do
		if widget.unit.name == SearchFor then
			return widget
		end
	end
end

local function FindWidgetByIcon(raidicon)
	for widget in pairs(WidgetList) do
		if widget.unit.isMarked and widget.unit.raidIcon == raidicon then
			return widget
		end
	end
end

local function CallForWidgetUpdate(guid, raidicon, name)
	local widget

	if guid then
		widget = FindWidgetByGUID(guid)
	end

	if not widget and name then
		widget = FindWidgetByName(name)
	end

	if not widget and raidicon then
		widget = FindWidgetByIcon(raidicon)
	end

	if widget then
		UpdateWidget(widget)
	end
end

-----------------------------------------------------
-- Aura Durations
-----------------------------------------------------
TidyPlatesData.CachedAuraDurations = {}

local function GetSpellDuration(spellid)
	if spellid then
		return TidyPlatesData.CachedAuraDurations[spellid]
	end
end

local function SetSpellDuration(spellid, duration)
	if spellid then
		TidyPlatesData.CachedAuraDurations[spellid] = duration
	end
end

-----------------------------------------------------
-- Aura Instances
-----------------------------------------------------

-- New Style
local AuraInstances = {}

local Aura_List = {} -- Two Dimensional
local Aura_Spellid = {}
local Aura_Expiration = {}
local Aura_Stacks = {}
local Aura_Caster = {}
local Aura_Duration = {}
local Aura_Texture = {}
local Aura_Type = {}
local Aura_Target = {}

local function SetAuraInstance(guid, spellid, expiration, stacks, caster, duration, texture, auratype, auratarget)
	if guid and spellid and caster and texture then
		local aura_id = spellid .. (tostring(caster or "UNKNOWN_CASTER"))
		local aura_instance_id = guid .. aura_id
		Aura_List[guid] = Aura_List[guid] or {}
		Aura_List[guid][aura_id] = aura_instance_id
		Aura_Spellid[aura_instance_id] = spellid
		Aura_Expiration[aura_instance_id] = expiration
		Aura_Stacks[aura_instance_id] = stacks
		Aura_Caster[aura_instance_id] = caster
		Aura_Duration[aura_instance_id] = duration
		Aura_Texture[aura_instance_id] = texture
		Aura_Type[aura_instance_id] = auratype
		Aura_Target[aura_instance_id] = auratarget
	end
end

local function GetAuraInstance(guid, aura_id)
	if guid and aura_id then
		local aura_instance_id = guid .. aura_id
		local spellid, expiration, stacks, caster, duration, texture, auratype
		spellid = Aura_Spellid[aura_instance_id]
		expiration = Aura_Expiration[aura_instance_id]
		stacks = Aura_Stacks[aura_instance_id]
		caster = Aura_Caster[aura_instance_id]
		duration = Aura_Duration[aura_instance_id]
		texture = Aura_Texture[aura_instance_id]
		auratype = Aura_Type[aura_instance_id]
		auratarget = Aura_Target[aura_instance_id]
		return spellid, expiration, stacks, caster, duration, texture, auratype, auratarget
	end
end

local function WipeAuraList(guid)
	if guid and Aura_List[guid] then
		local unit_aura_list = Aura_List[guid]
		for aura_id, aura_instance_id in pairs(unit_aura_list) do
			Aura_Spellid[aura_instance_id] = nil
			Aura_Expiration[aura_instance_id] = nil
			Aura_Stacks[aura_instance_id] = nil
			Aura_Caster[aura_instance_id] = nil
			Aura_Duration[aura_instance_id] = nil
			Aura_Texture[aura_instance_id] = nil
			Aura_Type[aura_instance_id] = nil
			Aura_Target[aura_instance_id] = nil
			unit_aura_list[aura_id] = nil
		end
	end
end

local function GetAuraList(guid)
	if guid and Aura_List[guid] then
		return Aura_List[guid]
	end
end

local function RemoveAuraInstance(guid, spellid, caster)
	if guid and spellid and Aura_List[guid] then
		local aura_instance_id = tostring(guid) .. tostring(spellid) .. (tostring(caster or "UNKNOWN_CASTER"))
		local aura_id = spellid .. (tostring(caster or "UNKNOWN_CASTER"))
		if Aura_List[guid][aura_id] then
			Aura_Spellid[aura_instance_id] = nil
			Aura_Expiration[aura_instance_id] = nil
			Aura_Stacks[aura_instance_id] = nil
			Aura_Caster[aura_instance_id] = nil
			Aura_Duration[aura_instance_id] = nil
			Aura_Texture[aura_instance_id] = nil
			Aura_Type[aura_instance_id] = nil
			Aura_Target[aura_instance_id] = nil
			Aura_List[guid][aura_id] = nil
		end
	end
end

local function CleanAuraLists()
	local currentTime = GetTime()
	for guid, instance_list in pairs(Aura_List) do
		local auracount = 0
		for aura_id, aura_instance_id in pairs(instance_list) do
			local expiration = Aura_Expiration[aura_instance_id]
			if expiration and expiration < currentTime then
				Aura_List[guid][aura_id] = nil
				Aura_Spellid[aura_instance_id] = nil
				Aura_Expiration[aura_instance_id] = nil
				Aura_Stacks[aura_instance_id] = nil
				Aura_Caster[aura_instance_id] = nil
				Aura_Duration[aura_instance_id] = nil
				Aura_Texture[aura_instance_id] = nil
				Aura_Type[aura_instance_id] = nil
				Aura_Target[aura_instance_id] = nil
				auracount = auracount + 1
			end
		end
		if auracount == 0 then
			Aura_List[guid] = nil
		end
	end
end

-----------------------------------------------------
-- Aura Updating Via UnitID (Via UnitDebuff API function and UNIT_AURA events)
-----------------------------------------------------

local function UpdateAurasByUnitID(unitid)
	-- Limit to enemies, for now
	local unitType
	if UnitIsFriend("player", unitid) then
		unitType = AURA_TARGET_FRIENDLY
	else
		unitType = AURA_TARGET_HOSTILE
	end
	if unitType == AURA_TARGET_FRIENDLY then
		return
	end -- Filter

	-- Check the UnitIDs Debuffs
	local guid = UnitGUID(unitid)
	-- Reset Auras for a guid
	WipeAuraList(guid)
	-- Debuffs
	for index = 1, 32 do
		local name, _, texture, count, dispelType, duration, expirationTime, unitCaster, _, _, spellid =
			UnitDebuff(unitid, index)
		if not name then
			break
		end
		SetSpellDuration(spellid, duration)
		SetAuraInstance(guid, spellid, expirationTime, count, UnitGUID(unitCaster or ""), duration, texture, AURA_TYPE[dispelType or "Debuff"], unitType)
	end

	-- Buffs (Only for friendly units)
	if unitType == AURA_TARGET_FRIENDLY then
		for index = 1, 32 do
			local name, _, texture, count, dispelType, duration, expirationTime, unitCaster, _, _, spellid =
				UnitBuff(unitid, index)
			if not name then
				break
			end
			SetSpellDuration(spellid, duration)
			SetAuraInstance(guid, spellid, expirationTime, count, UnitGUID(unitCaster or ""), duration, texture, AURA_TYPE_BUFF, AURA_TARGET_FRIENDLY)
		end
	end

	local raidicon, name
	if UnitPlayerControlled(unitid) then
		name = UnitName(unitid)
	end
	raidicon = RaidIconIndex[GetRaidTargetIndex(unitid) or ""]
	if raidicon then
		ByRaidIcon[raidicon] = guid
	end

	CallForWidgetUpdate(guid, raidicon, name)
end

local function UpdateAuraByLookup(guid)
	if guid == UnitGUID("target") then
		UpdateAurasByUnitID("target")
	elseif guid == UnitGUID("mouseover") then
		UpdateAurasByUnitID("mouseover")
	elseif TargetOfGroupMembers[guid] then
		local unit = TargetOfGroupMembers[guid]
		if unit then
			local unittarget = UnitGUID(unit .. "target")
			if guid == unittarget then
				UpdateAurasByUnitID(unittarget)
			end
		end
	end
	return false
end

-----------------------------------------------------
-- Aura Updating Via Combat Log
-----------------------------------------------------

local function CombatLog_ApplyAura(...)
	local timestamp, sourceGUID, destGUID, destName, spellid = ...
	local duration = GetSpellDuration(spellid)
	local texture = select(3, GetSpellInfo(spellid))
	SetAuraInstance(destGUID, spellid, GetTime() + (duration or 0), 1, sourceGUID, duration, texture, AURA_TYPE_DEBUFF, AURA_TARGET_HOSTILE)
end

local function CombatLog_RemoveAura(...)
	local timestamp, sourceGUID, destGUID, destName, spellid = ...
	RemoveAuraInstance(destGUID, spellid, sourceGUID)
end

local function CombatLog_UpdateAuraStacks(...)
	local timestamp, sourceGUID, destGUID, destName, spellid, stackCount = ...
	local duration = GetSpellDuration(spellid)
	local texture = select(3, GetSpellInfo(spellid))
	SetAuraInstance(destGUID, spellid, GetTime() + (duration or 0), stackCount, sourceGUID, duration, texture, AURA_TYPE_DEBUFF, AURA_TARGET_HOSTILE)
end

-----------------------------------------------------
-- General Events
-----------------------------------------------------

local function EventUnitTarget()
	TargetOfGroupMembers = wipe(TargetOfGroupMembers)

	for name, unitid in pairs(TidyPlatesUtility.GroupMembers.UnitId) do
		local targetOf = unitid .. ("target" or "")
		if UnitExists(targetOf) then
			TargetOfGroupMembers[UnitGUID(targetOf)] = targetOf
		end
	end
end

local function EventPlayerTarget()
	if UnitExists("target") then
		UpdateAurasByUnitID("target")
	end
end

local function EventUnitAura(unitid)
	if unitid == "target" then
		UpdateAurasByUnitID("target")
	elseif unitid == "focus" then
		UpdateAurasByUnitID("focus")
	end
end

-----------------------------------------------------
-- Function Reference Lists
-----------------------------------------------------
local CombatLogEvents = {
	-- Refresh Expire Time
	["SPELL_AURA_APPLIED"] = CombatLog_ApplyAura,
	["SPELL_AURA_REFRESH"] = CombatLog_ApplyAura,
	-- Add a stack
	["SPELL_AURA_APPLIED_DOSE"] = CombatLog_UpdateAuraStacks,
	-- Remove a stack
	["SPELL_AURA_REMOVED_DOSE"] = CombatLog_UpdateAuraStacks,
	-- Expires Aura
	["SPELL_AURA_BROKEN"] = CombatLog_RemoveAura,
	["SPELL_AURA_BROKEN_SPELL"] = CombatLog_RemoveAura,
	["SPELL_AURA_REMOVED"] = CombatLog_RemoveAura
}

local GeneralEvents = {
	["UNIT_TARGET"] = EventUnitTarget,
	["UNIT_AURA"] = EventUnitAura,
	["PLAYER_ENTERING_WORLD"] = CleanAuraLists,
	["PLAYER_REGEN_ENABLED"] = CleanAuraLists,
	["PLAYER_TALENT_UPDATE"] = UpdatePlayerDispelTypes,
	["ACTIVE_TALENT_GROUP_CHANGED"] = UpdatePlayerDispelTypes
}

local function GetCombatEventResults(...)
	local timestamp, combatevent, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellid, spellName, spellSchool, auraType, stackCount = ...
	return timestamp, combatevent, sourceGUID, destGUID, destName, destFlags, destFlags, auraType, spellid, stackCount
end

local function CombatEventHandler(frame, event, ...)
	-- General Events, Passthrough
	if event ~= "COMBAT_LOG_EVENT_UNFILTERED" then
		if GeneralEvents[event] then
			GeneralEvents[event](...)
		end
		return
	end

	-- Combat Log Unfiltered
	local timestamp, combatevent, sourceGUID, destGUID, destName, destFlags, destRaidFlag, auraType, spellid, stackCount =
		GetCombatEventResults(...)

	-- Evaluate only for enemy units, for now
	if (bit.band(destFlags, COMBATLOG_OBJECT_REACTION_FRIENDLY) == 0) then -- FILTER: ENEMY UNIT
		local CombatLogUpdateFunction = CombatLogEvents[combatevent]
		-- Evaluate only for certain combat log events
		if CombatLogUpdateFunction then
			-- Evaluate only for debuffs
			if auraType == "DEBUFF" then -- FILTER: DEBUFF
				-- Update Auras via API/UnitID Search
				if not UpdateAuraByLookup(destGUID) then
					-- Update Auras via Combat Log
					CombatLogUpdateFunction(timestamp, sourceGUID, destGUID, destName, spellid, stackCount)
				end
				-- To Do: Need to write something to detect when a change was made to the destID
				-- Return values on functions?

				local name, raidicon
				-- Cache Unit Name for alternative lookup strategy
				if bit.band(destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0 then
					local rawName = strsplit("-", destName) -- Strip server name from players
					ByName[rawName] = destGUID
					name = rawName
				end
				-- Cache Raid Icon Data for alternative lookup strategy
				for iconname, bitmask in pairs(RaidIconBit) do
					if bit.band(destRaidFlag, bitmask) > 0 then
						ByRaidIcon[iconname] = destGUID
						raidicon = iconname
						break
					end
				end

				CallForWidgetUpdate(destGUID, raidicon, name)
			end
		end
	end
end

-------------------------------------------------------------
-- Widget Object Functions
-------------------------------------------------------------
local function UpdateWidgetTime(frame, expiration)
	local timeleft = ceil(expiration - GetTime())
	if timeleft > 60 then
		frame.TimeLeft:SetText(ceil(timeleft / 60) .. "m")
	else
		frame.TimeLeft:SetText(ceil(timeleft))
	end
end

local function UpdateIcon(frame, texture, expiration, stacks)
	if frame and texture and expiration then
		-- Icon
		frame.Icon:SetTexture(texture)

		-- Stacks
		if stacks > 1 then
			frame.Stacks:SetText(stacks)
		else
			frame.Stacks:SetText("")
		end

		-- Expiration
		UpdateWidgetTime(frame, expiration)
		frame:Show()
		PolledHideIn(frame, expiration)
	else
		PolledHideIn(frame, 0)
	end
end

local AuraSlotspellid = {}
local AuraSlotPriority = {}

local function debuffSort(a, b)
	return a.priority < b.priority
end

local DebuffCache = {}
--local CurrentAura = {}

local function UpdateIconGrid(frame, guid)
	local AuraIconFrames = frame.AuraIconFrames
	local AurasOnUnit = GetAuraList(guid)
	local AuraSlotIndex = 1

	DebuffCache = wipe(DebuffCache)
	local debuffCount = 0

	-- Cache displayable debuffs
	if AurasOnUnit then
		frame:Show()
		for instanceid in pairs(AurasOnUnit) do
			local aura = {}
			aura.spellid, aura.expiration, aura.stacks, aura.caster, aura.duration, aura.texture, aura.type, aura.target =
				GetAuraInstance(guid, instanceid)

			if tonumber(aura.spellid) then
				aura.name = GetSpellInfo(tonumber(aura.spellid))
				aura.unit = frame.unit

				-- Call Filter Function
				local show, priority = frame.Filter(aura)
				aura.priority = priority or 10

				-- Get Order/Priority
				if show and aura.expiration > GetTime() then
					debuffCount = debuffCount + 1
					DebuffCache[debuffCount] = aura
				end
			end
		end
	end

	-- Display Auras
	if debuffCount > 0 then
		sort(DebuffCache, debuffSort)
		for index = 1, #DebuffCache do
			local cachedaura = DebuffCache[index]
			if cachedaura.spellid and cachedaura.expiration then
				UpdateIcon(AuraIconFrames[AuraSlotIndex], cachedaura.texture, cachedaura.expiration, cachedaura.stacks)
				AuraSlotIndex = AuraSlotIndex + 1
			end
			if AuraSlotIndex > MaximumDisplayableDebuffs then
				break
			end
		end
	end

	-- Clear Extra Slots
	for index = AuraSlotIndex, MaximumDisplayableDebuffs do
		UpdateIcon(AuraIconFrames[index])
	end

	DebuffCache = wipe(DebuffCache)
end

function UpdateWidget(frame)
	-- Check for ID
	local unit = frame.unit
	local guid = unit.guid

	if not guid then
		-- Attempt to ID widget via Name or Raid Icon
		if unit.type == "PLAYER" then
			guid = ByName[unit.name]
		elseif unit.isMarked then
			guid = ByRaidIcon[unit.raidIcon]
		end

		if guid then
			unit.guid = guid -- Feed data back into unit table		-- Testing
		else
			frame:Hide()
			return
		end
	end

	UpdateIconGrid(frame, guid)
	TidyPlates:RequestDelegateUpdate() -- Delegate Update, For Debuff Widget-Controlled Scale and Opacity Functions
end

local function UpdateWidgetTarget(frame)
	UpdateIconGrid(frame, UnitGUID("target"))
end

-- Context Update (mouseover, target change)
local function UpdateWidgetContext(frame, unit)
	local guid = unit.guid
	frame.unit = unit
	frame.guidcache = guid

	WidgetList[frame] = true
	if guid then
		WidgetGUID[guid] = frame
	end

	if unit.isTarget then
		UpdateAurasByUnitID("target")
	elseif unit.isMouseover then
		UpdateAurasByUnitID("mouseover")
	end

	local raidicon, name
	if unit.isMarked then
		raidicon = unit.raidIcon
		if guid and raidicon then
			ByRaidIcon[raidicon] = guid
		end
	end
	if unit.type == "PLAYER" and unit.reaction == "HOSTILE" then
		name = unit.name
	end

	CallForWidgetUpdate(guid, raidicon, name)
end

local function ClearWidgetContext(frame)
	if frame.guidcache then
		WidgetGUID[frame.guidcache] = nil
		frame.unit = nil
	end
	WidgetList[frame] = nil
end

-------------------------------------------------------------
-- Widget Frames
-------------------------------------------------------------
local AuraBorderArt = "Interface\\AddOns\\TidyPlatesWidgets\\Aura\\AuraFrame" -- FINISH ART
local AuraGlowArt = "Interface\\AddOns\\TidyPlatesWidgets\\Aura\\AuraGlow"
local AuraHighlightArt = "Interface\\AddOns\\TidyPlatesWidgets\\Aura\\CCBorder" -- AuraBorderArt, AuraHighlightArt
local AuraTestArt = ""
local AuraFont = "Interface\\Addons\\TidyPlates\\Media\\DefaultFont.ttf"

local function Enable()
	AuraMonitor:SetScript("OnEvent", CombatEventHandler)
	AuraMonitor:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	for event in pairs(GeneralEvents) do
		AuraMonitor:RegisterEvent(event)
	end

	TidyPlatesUtility:EnableGroupWatcher()

	if not TidyPlatesData.CachedAuraDurations then
		TidyPlatesData.CachedAuraDurations = {}
	end
end

local function Disable()
	AuraMonitor:SetScript("OnEvent", nil)
	AuraMonitor:UnregisterAllEvents()
	--TidyPlatesUtility:DisableGroupWatcher()
end

-- Create an Aura Icon
local function CreateAuraIconFrame(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(26)
	frame:SetHeight(14)
	-- Icon
	frame.Icon = frame:CreateTexture(nil, "BACKGROUND")
	frame.Icon:SetAllPoints(frame)
	frame.Icon:SetTexCoord(.07, 1 - .07, .23, 1 - .23) -- obj:SetTexCoord(left,right,top,bottom)
	-- Border
	frame.Border = frame:CreateTexture(nil, "ARTWORK")
	frame.Border:SetWidth(32)
	frame.Border:SetHeight(32)
	frame.Border:SetPoint("CENTER", 1, -2)
	frame.Border:SetTexture(AuraBorderArt)
	-- Glow
	frame.Glow = frame:CreateTexture(nil, "ARTWORK")
	frame.Glow:SetAllPoints(frame.Border)
	frame.Glow:SetTexture(AuraGlowArt)
	--  Time Text
	frame.TimeLeft = frame:CreateFontString(nil, "OVERLAY")
	frame.TimeLeft:SetFont(AuraFont, 9, "OUTLINE")
	frame.TimeLeft:SetShadowOffset(1, -1)
	frame.TimeLeft:SetShadowColor(0, 0, 0, 1)
	frame.TimeLeft:SetPoint("RIGHT", 0, 8)
	frame.TimeLeft:SetWidth(26)
	frame.TimeLeft:SetHeight(16)
	frame.TimeLeft:SetJustifyH("RIGHT")
	--  Stacks
	frame.Stacks = frame:CreateFontString(nil, "OVERLAY")
	frame.Stacks:SetFont(AuraFont, 10, "OUTLINE")
	frame.Stacks:SetShadowOffset(1, -1)
	frame.Stacks:SetShadowColor(0, 0, 0, 1)
	frame.Stacks:SetPoint("RIGHT", 0, -6)
	frame.Stacks:SetWidth(26)
	frame.Stacks:SetHeight(16)
	frame.Stacks:SetJustifyH("RIGHT")
	-- Information about the currently displayed aura
	frame.AuraInfo = {Name = "", Icon = "", Stacks = 0, Expiration = 0, Type = ""}
	--frame.Poll = UpdateWidgetTime
	frame.Poll = parent.PollFunction
	frame:Hide()
	return frame
end

-- Create the Main Widget Body and Icon Array
local function CreateAuraWidget(parent)
	-- Create Base frame
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(128)
	frame:SetHeight(32)
	frame:Show()
	-- Create Icon Array
	frame.PollFunction = UpdateWidgetTime
	frame.AuraIconFrames = {}
	local AuraIconFrames = frame.AuraIconFrames

	for index = 1, MaximumDisplayableDebuffs do
		AuraIconFrames[index] = CreateAuraIconFrame(frame)
	end
	local FirstRowCount = min(MaximumDisplayableDebuffs / 2)
	-- Set Anchors
	AuraIconFrames[1]:SetPoint("LEFT", frame)
	for index = 2, FirstRowCount do
		AuraIconFrames[index]:SetPoint("LEFT", AuraIconFrames[index - 1], "RIGHT", 5, 0)
	end
	AuraIconFrames[FirstRowCount + 1]:SetPoint("BOTTOMLEFT", AuraIconFrames[1], "TOPLEFT", 0, 8)
	for index = (FirstRowCount + 2), MaximumDisplayableDebuffs do
		AuraIconFrames[index]:SetPoint("LEFT", AuraIconFrames[index - 1], "RIGHT", 5, 0)
	end
	-- Functions
	frame._Hide = frame.Hide
	frame.Hide = function()
		ClearWidgetContext(frame)
		frame:_Hide()
	end
	frame:SetScript("OnHide", function()
		for index = 1, 4 do
			PolledHideIn(AuraIconFrames[index], 0)
		end
	end)
	frame.Filter = DefaultFilterFunction
	frame.UpdateContext = UpdateWidgetContext
	frame.Update = UpdateWidgetContext
	frame.UpdateTarget = UpdateWidgetTarget
	return frame
end

-----------------------------------------------------
-- External
-----------------------------------------------------
TidyPlatesWidgets.GetAuraWidgetByGUID = GetAuraWidgetByGUID
TidyPlatesWidgets.IsAuraShown = IsAuraShown
TidyPlatesWidgets.CanPlayerDispel = CanPlayerDispel

TidyPlatesWidgets.CreateAuraWidget = CreateAuraWidget
TidyPlatesWidgets.EnableAuraWatcher = Enable
TidyPlatesWidgets.DisableAuraWatcher = Disable

-----------------------------------------------------
-- Debuff Library
-----------------------------------------------------

function DynamicHashTableSize(entries)
	if (entries == 0) then
		return 36
	else
		return math.pow(2, math.ceil(math.log(entries) / math.log(2))) * 40 + 36
	end
end

local TableMemory

TableMemory = function(pTable, level)
	level = level or 1
	local sum = 0
	local entries = 0
	local indent = " "
	for s = 1, level do
		indent = indent .. " "
	end

	for i, v in pairs(pTable) do
		if type(v) == "table" then
			local mem = TableMemory(v, level + 1)
			sum = sum + mem
			entries = entries + 1
		else
			entries = entries + 1
		end
	end
	return DynamicHashTableSize(entries) + sum, entries
end