local TidyPlates = _G.TidyPlates
local TidyPlatesUtility = _G.TidyPlatesUtility
local TidyPlatesWidgets = _G.TidyPlatesWidgets
local TidyPlatesWidgetData = _G.TidyPlatesWidgetData

TidyPlatesWidgets.DebuffWidgetBuild = 2

local PlayerGUID = UnitGUID("player")
local PolledHideIn = TidyPlatesWidgets.PolledHideIn
local AuraMonitor = CreateFrame("Frame")
local WidgetList, WidgetGUID = {}, {}
local UpdateWidget
local TargetOfGroupMembers = {}
local DebuffColumns = 3
local inArena = false

local function DefaultDebuffPreFilter()
    return true
end
local DebuffPrefilter = DefaultDebuffPreFilter

local AURA_TARGET_HOSTILE = 1
local AURA_TARGET_FRIENDLY = 2

local AURA_TYPE_BUFF = 1
local AURA_TYPE_DEBUFF = 6

local _

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
    ["STAR"] = 0x00000001,
    ["CIRCLE"] = 0x00000002,
    ["DIAMOND"] = 0x00000004,
    ["TRIANGLE"] = 0x00000008,
    ["MOON"] = 0x00000010,
    ["SQUARE"] = 0x00000020,
    ["CROSS"] = 0x00000040,
    ["SKULL"] = 0x00000080
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

local ByRaidIcon = {} -- Raid Icon to GUID
local ByName = {} -- Name to GUID (PVP)

local PlayerDispelCapabilities = {
    ["Curse"] = false,
    ["Disease"] = false,
    ["Magic"] = false,
    ["Poison"] = false
}

local function UpdatePlayerDispelTypes()
    PlayerDispelCapabilities["Curse"] = IsSpellKnown(51886) or IsSpellKnown(475) or IsSpellKnown(2782)
    PlayerDispelCapabilities["Poison"] =
        IsSpellKnown(2782) or IsSpellKnown(32375) or IsSpellKnown(4987) or (IsSpellKnown(527) and IsSpellKnown(33167))
    PlayerDispelCapabilities["Magic"] =
        (IsSpellKnown(4987) and IsSpellKnown(53551)) or (IsSpellKnown(2782) and IsSpellKnown(88423)) or
        (IsSpellKnown(527) and IsSpellKnown(33167)) or
        (IsSpellKnown(51886) and IsSpellKnown(77130)) or
        IsSpellKnown(32375)
    PlayerDispelCapabilities["Disease"] = IsSpellKnown(4987) or IsSpellKnown(528)
end

local function CanPlayerDispel(debuffType)
    return PlayerDispelCapabilities[debuffType or ""]
end

-----------------------------------------------------
-- Default Filter
-----------------------------------------------------
local function DefaultFilterFunction(debuff)
    if (debuff.duration < 600) then
        return true
    end
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
    if (not widget) and name then
        widget = FindWidgetByName(name)
    end
    if (not widget) and raidicon then
        widget = FindWidgetByIcon(raidicon)
    end

    if widget then
        UpdateWidget(widget)
    end
end

-----------------------------------------------------
-- Aura Durations
-----------------------------------------------------
TidyPlatesWidgetData.CachedAuraDurations = {}

local function GetSpellDuration(spellid)
    if spellid then
        return TidyPlatesWidgetData.CachedAuraDurations[spellid]
    end
end

local function SetSpellDuration(spellid, duration)
    if spellid then
        TidyPlatesWidgetData.CachedAuraDurations[spellid] = duration
    end
end

-----------------------------------------------------
-- Aura Instances
-----------------------------------------------------

-- New Style
local Aura_List = {} -- Two Dimensional
local Aura_Spellid = {}
local Aura_Spellname = {}
local Aura_Expiration = {}
local Aura_Stacks = {}
local Aura_Caster = {}
local Aura_Duration = {}
local Aura_Texture = {}
local Aura_Type = {}
local Aura_Target = {}

local function SetAuraInstance(guid, spellid, spellname, expiration, stacks, caster, duration, texture, auratype, auratarget)
    if guid and spellid and caster and texture then
        if DebuffPrefilter(spellid, spellname, auratype) ~= true then
            return
        end

        local aura_id = spellid .. (tostring(caster or "UNKNOWN_CASTER"))
        local aura_instance_id = guid .. aura_id
        Aura_List[guid] = Aura_List[guid] or {}
        Aura_List[guid][aura_id] = aura_instance_id
        Aura_Spellid[aura_instance_id] = spellid
        Aura_Spellname[aura_instance_id] = spellname
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
        spellname = Aura_Spellname[aura_instance_id]
        expiration = Aura_Expiration[aura_instance_id]
        stacks = Aura_Stacks[aura_instance_id]
        caster = Aura_Caster[aura_instance_id]
        duration = Aura_Duration[aura_instance_id]
        texture = Aura_Texture[aura_instance_id]
        auratype = Aura_Type[aura_instance_id]
        auratarget = Aura_Target[aura_instance_id]
        return spellid, spellname, expiration, stacks, caster, duration, texture, auratype, auratarget
    end
end

local function WipeUnitAuraList(guid)
    if guid and Aura_List[guid] then
        local unit_aura_list = Aura_List[guid]
        for aura_id, aura_instance_id in pairs(unit_aura_list) do
            Aura_Spellid[aura_instance_id] = nil
            Aura_Spellname[aura_instance_id] = nil
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
            Aura_Spellname[aura_instance_id] = nil
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

local function CleanAuraLists() -- Removes expired auras from the lists
    local currentTime = GetTime()
    for guid, instance_list in pairs(Aura_List) do
        local auracount = 0
        for aura_id, aura_instance_id in pairs(instance_list) do
            local expiration = Aura_Expiration[aura_instance_id]
            if expiration and expiration < currentTime then
                Aura_List[guid][aura_id] = nil
                Aura_Spellid[aura_instance_id] = nil
                Aura_Spellname[aura_instance_id] = nil
                Aura_Expiration[aura_instance_id] = nil
                Aura_Stacks[aura_instance_id] = nil
                Aura_Caster[aura_instance_id] = nil
                Aura_Duration[aura_instance_id] = nil
                Aura_Texture[aura_instance_id] = nil
                Aura_Type[aura_instance_id] = nil
                Aura_Target[aura_instance_id] = nil
            else
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
    local unitType
    if UnitIsFriend("player", unitid) then
        unitType = AURA_TARGET_FRIENDLY
    else
        unitType = AURA_TARGET_HOSTILE
    end

    -- Check the UnitIDs Debuffs
    local guid = UnitGUID(unitid)
    -- Reset Auras for a guid
    WipeUnitAuraList(guid)
    -- Debuffs
    for index = 1, 32 do
        local spellname, _, texture, count, dispelType, duration, expirationTime, unitCaster, _, _, spellid = UnitDebuff(unitid, index)
        if not spellname then break end
        SetSpellDuration(spellid, duration) -- Caches the aura data for times when the duration cannot be determined (ie. via combat log)
        SetAuraInstance(guid, spellid, spellname, expirationTime, count, UnitGUID(unitCaster or ""), duration, texture, AURA_TYPE[dispelType or "Debuff"], unitType)
    end

    -- Buffs (Only for friendly units)
    if unitType == AURA_TARGET_FRIENDLY then
        for index = 1, 32 do
            local spellname, _, texture, count, dispelType, duration, expirationTime, unitCaster, _, _, spellid = UnitBuff(unitid, index)
            if not spellname then break end
            SetSpellDuration(spellid, duration) -- Caches the aura data for times when the duration cannot be determined (ie. via combat log)
            SetAuraInstance(guid, spellid, spellname, expirationTime, count, UnitGUID(unitCaster or ""), duration, texture, AURA_TYPE_BUFF, AURA_TARGET_FRIENDLY)
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

-----------------------------------------------------
-- Aura Updating Via Combat Log
-- local sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellid, spellName, spellSchool, auraType, stackCount = ...
-----------------------------------------------------

local function CombatLog_ApplyAura(...)
    local timestamp, sourceGUID, destGUID, destName, spellid, spellname, stackCount = ...
    local duration = GetSpellDuration(spellid)
    local texture = select(3, GetSpellInfo(spellid))
    SetAuraInstance(destGUID, spellid, spellname, GetTime() + (duration or 0), 1, sourceGUID, duration, texture, AURA_TYPE_DEBUFF, AURA_TARGET_HOSTILE)
end

local function CombatLog_RemoveAura(...)
    local timestamp, sourceGUID, destGUID, destName, spellid = ...
    RemoveAuraInstance(destGUID, spellid, sourceGUID)
end

local function CombatLog_UpdateAuraStacks(...)
    local timestamp, sourceGUID, destGUID, destName, spellid, spellname, stackCount = ...
    local duration = GetSpellDuration(spellid)
    local texture = select(3, GetSpellInfo(spellid))
    SetAuraInstance(destGUID, spellid, spellname, GetTime() + (duration or 0), stackCount, sourceGUID, duration, texture, AURA_TYPE_DEBUFF, AURA_TARGET_HOSTILE)
end

-----------------------------------------------------
-- General Events
-----------------------------------------------------

local function EventUnitAura(unitid)
    if inArena or unitid == "target" or unitid == "target" or unitid == "focus" then
        UpdateAurasByUnitID(unitid)
    end
end

local function EventPlayerEnterWorld()
    CleanAuraLists()
    local isInstance, instanceType = IsInInstance()
    if instanceType and instanceType == "arena" then
        inArena = true
    else
        inArena = false
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
    ["UNIT_AURA"] = EventUnitAura,
    ["PLAYER_ENTERING_WORLD"] = EventPlayerEnterWorld,
    ["PLAYER_REGEN_ENABLED"] = CleanAuraLists
}

local function TargetOnlyEventHandler(frame, event, unitid)
    if unitid == "target" then
        UpdateAurasByUnitID("target")
    end
end

local function GuidIsLocalUnitId(guid)
    if guid == UnitGUID("target") or guid == UnitGUID("mouseover") or guid == UnitGUID("focus") then
        return true
    else
        return false
    end
end

local GetCombatEventResults

function GetCombatEventResults(...)
    local timestamp, combatevent, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellid, spellname, _, auraType, stackCount = ...
    return timestamp, combatevent, sourceGUID, destGUID, destName, destFlags, auraType, spellid, spellname, stackCount
end

local function CombatEventHandler(frame, event, ...)
    -- General Events, Passthrough
    if event ~= "COMBAT_LOG_EVENT_UNFILTERED" then
        if GeneralEvents[event] then
            GeneralEvents[event](...)
        end
        return
    elseif inArena then
        return
    end

    -- Combat Log Unfiltered
    local timestamp, combatevent, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellid, spellname, spellSchool, auraType, stackCount = ...

    -- Evaluate only for enemy units, for now
    if (bit.band(destFlags, COMBATLOG_OBJECT_REACTION_FRIENDLY) == 0) then -- FILTER: ENEMY UNIT
        local CombatLogUpdateFunction = CombatLogEvents[combatevent]
        -- Evaluate only for certain combat log events
        if CombatLogUpdateFunction then
            -- Evaluate only for debuffs
            if auraType == "DEBUFF" then -- FILTER: DEBUFF
                -- Update Auras via API/UnitID Search
                if not GuidIsLocalUnitId(destGUID) then --- REMOVE this function, and replace with a function that checks to see if the detected unit is a unitid match
                    -- Update Auras via Combat Log
                    CombatLogUpdateFunction(timestamp, sourceGUID, destGUID, destName, spellid, spellname, stackCount)
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
                    if bit.band(destFlags, bitmask) > 0 then
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
    local timeleft = expiration - GetTime()
    if timeleft > 60 then
        frame.TimeLeft:SetText(floor(timeleft / 60) .. "m")
    else
        --frame.TimeLeft:SetText(floor(timeleft*10)/10)
        frame.TimeLeft:SetText(floor(timeleft))
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
    elseif frame then
        PolledHideIn(frame, 0)
    end
end

local AuraSlotspellid = {} -- auraSlot[slot] = spellid
local AuraSlotPriority = {} -- auraSlot[slot] = priority

local function debuffSort(a, b)
    return a.priority < b.priority
end

local DebuffCache = {}
local CurrentAura = {}

local function UpdateIconGrid(frame, guid)
    local AuraIconFrames = frame.AuraIconFrames
    local AurasOnUnit = GetAuraList(guid)
    local AuraSlotIndex = 1
    local DebuffLimit = DebuffColumns * 2

    DebuffCache = wipe(DebuffCache)
    local debuffCount = 0
    local currentAuraIndex = 0
    local aura

    -- Cache displayable debuffs
    if AurasOnUnit then
        frame:Show()
        for instanceid in pairs(AurasOnUnit) do
            currentAuraIndex = debuffCount + 1

            --local aura = {}
            CurrentAura[currentAuraIndex] = wipe(CurrentAura[currentAuraIndex] or {})
            aura = CurrentAura[currentAuraIndex]

            aura.spellid, aura.name, aura.expiration, aura.stacks, aura.caster, aura.duration, aura.texture, aura.type, aura.reaction = GetAuraInstance(guid, instanceid)

            if tonumber(aura.spellid) then
                aura.unit = frame.unit

                -- Call Filter Function
                local show, priority = frame.Filter(aura)
                --local show, priority = true, 10		-- Testing
                aura.priority = priority or 10

                -- Get Order/Priority
                if show and aura.expiration > GetTime() then
                    debuffCount = debuffCount + 1
                    DebuffCache[debuffCount] = aura
                --DebuffCache[debuffCount] = instanceid
                end

            --print("UpdateIconGrid", aura.spellid, aura.name, aura.expiration, aura.stacks, aura.caster, aura.duration, aura.texture, aura.type, aura.reaction, show, aura.priority)
            end
        end
    end

    -- Display Auras
    if debuffCount > 0 then
        sort(DebuffCache, debuffSort)
        for index = 1, #DebuffCache do
            local cachedaura = DebuffCache[index]
            if cachedaura.spellid and cachedaura.expiration then
                --print("UpdateIcon", AuraIconFrames[AuraSlotIndex], cachedaura.texture, cachedaura.expiration, cachedaura.stacks)
                UpdateIcon(AuraIconFrames[AuraSlotIndex], cachedaura.texture, cachedaura.expiration, cachedaura.stacks)
                AuraSlotIndex = AuraSlotIndex + 1
            end
            if AuraSlotIndex > DebuffLimit then
                break
            end
        end
    end

    -- Clear Extra Slots
    for index = AuraSlotIndex, DebuffLimit do
        UpdateIcon(AuraIconFrames[index])
    end

    DebuffCache = wipe(DebuffCache)
end

function UpdateWidget(frame)
    -- Check for ID
    local unit = frame.unit
    if not unit then
        return
    end

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
local function UpdateWidgetContextFull(frame, unit)
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

local function UpdateWidgetContextTargetOnly(frame, unit)
    if unit.isTarget then
    -- UpdateAurasByUnitID("target")
    end
end

local UpdateWidgetContext = UpdateWidgetContextFull

local function ClearWidgetContext(frame)
    if frame.guidcache then
        WidgetGUID[frame.guidcache] = nil
        frame.unit = nil
    end
    WidgetList[frame] = nil
end

local function ExpireFunction(icon)
    UpdateWidget(icon.Parent)
end

-------------------------------------------------------------
-- Widget Frames
-------------------------------------------------------------
local WideArt = "Interface\\AddOns\\TidyPlates\\widgets\\Aura\\AuraFrameWide" -- FINISH ART
local SquareArt = "Interface\\AddOns\\TidyPlates\\widgets\\Aura\\AuraFrameSquare" -- FINISH ART
local AuraGlowArt = "Interface\\AddOns\\TidyPlates\\widgets\\Aura\\AuraGlow"
local AuraHighlightArt = "Interface\\AddOns\\TidyPlates\\widgets\\Aura\\CCBorder" -- AuraBorderArt, AuraHighlightArt
local AuraTestArt = ""
--local AuraFont = "Interface\\Addons\\TidyPlates\\Media\\DefaultFont.ttf"
local AuraFont = "FONTS\\ARIALN.TTF"

local function Enable()
    AuraMonitor:SetScript("OnEvent", CombatEventHandler)
    AuraMonitor:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    for event in pairs(GeneralEvents) do
        AuraMonitor:RegisterEvent(event)
    end

    TidyPlatesUtility:EnableGroupWatcher()

    if not TidyPlatesWidgetData.CachedAuraDurations then
        TidyPlatesWidgetData.CachedAuraDurations = {}
    end
end

local function EnableForTargetOnly()
    AuraMonitor:UnregisterAllEvents()
    -- AuraMonitor:SetScript("OnEvent", TargetEventHandler)
    AuraMonitor:RegisterEvent("UNIT_AURA")

    TidyPlatesUtility:EnableGroupWatcher()
end

local function Disable()
    AuraMonitor:SetScript("OnEvent", nil)
    AuraMonitor:UnregisterAllEvents()
end

-- Create an Aura Icon
local function CreateWideAuraIconFrame(parent)
    local frame = CreateFrame("Frame", nil, parent)
    frame.unit = nil
    frame.Parent = parent
    frame:SetWidth(26.5)
    frame:SetHeight(14.5)
    -- Icon
    frame.Icon = frame:CreateTexture(nil, "BACKGROUND")
    frame.Icon:SetAllPoints(frame)
    frame.Icon:SetTexCoord(.07, 1 - .07, .23, 1 - .23) -- obj:SetTexCoord(left,right,top,bottom)
    -- Border
    frame.Border = frame:CreateTexture(nil, "ARTWORK")
    frame.Border:SetWidth(32)
    frame.Border:SetHeight(32)
    frame.Border:SetPoint("CENTER", 1, -2)
    frame.Border:SetTexture(WideArt)
    -- Glow
    --frame.Glow = frame:CreateTexture(nil, "ARTWORK")
    --frame.Glow:SetAllPoints(frame.Border)
    --frame.Glow:SetTexture(AuraGlowArt)
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
    frame.AuraInfo = {
        Name = "",
        Icon = "",
        Stacks = 0,
        Expiration = 0,
        Type = ""
    }
    --frame.Poll = UpdateWidgetTime
    frame.Expire = ExpireFunction
    -- UpdateWidget(frame)
    frame.Poll = parent.PollFunction
    frame:Hide()
    return frame
end

-- Create an Aura Icon
local function CreateSquareAuraIconFrame(parent)
    local frame = CreateFrame("Frame", nil, parent)
    frame.Parent = parent
    frame:SetWidth(16.5)
    frame:SetHeight(14.5)

    -- Icon
    frame.Icon = frame:CreateTexture(nil, "BACKGROUND")
    frame.Icon:SetAllPoints(frame)
    frame.Icon:SetTexCoord(.10, 1 - .07, .12, 1 - .12) -- obj:SetTexCoord(left,right,top,bottom)

    -- Border
    frame.Border = frame:CreateTexture(nil, "ARTWORK")
    frame.Border:SetWidth(32)
    frame.Border:SetHeight(32)
    frame.Border:SetPoint("CENTER", 0, -2)
    frame.Border:SetTexture(SquareArt)

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
    frame.Poll = parent.PollFunction
    frame:Hide()
    return frame
end

local CreateIconFrame = CreateWideAuraIconFrame

-- Create the Main Widget Body and Icon Array
local function CreateAuraWidget(parent, style)
    -- Create Base frame
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetWidth(128)
    frame:SetHeight(32)
    frame:Show()
    -- Create Icon Array
    frame.PollFunction = UpdateWidgetTime
    frame.AuraIconFrames = {}
    local AuraIconFrames = frame.AuraIconFrames

    local DebuffLimit = DebuffColumns * 2

    for index = 1, DebuffLimit do
        AuraIconFrames[index] = CreateIconFrame(frame)
    end
    -- Set Anchors
    AuraIconFrames[1]:SetPoint("LEFT", frame)
    for index = 2, DebuffColumns do
        AuraIconFrames[index]:SetPoint("LEFT", AuraIconFrames[index - 1], "RIGHT", 5, 0)
    end
    AuraIconFrames[DebuffColumns + 1]:SetPoint("BOTTOMLEFT", AuraIconFrames[1], "TOPLEFT", 0, 8)
    for index = (DebuffColumns + 2), DebuffLimit do
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

local function UseSquareDebuffIcon()
    CreateIconFrame = CreateSquareAuraIconFrame
    DebuffColumns = 5
    TidyPlates:ForceUpdate()
end

local function UseWideDebuffIcon()
    CreateIconFrame = CreateWideAuraIconFrame
    DebuffColumns = 3
    TidyPlates:ForceUpdate()
end

local function SetPrefilter(func)
    DebuffPrefilter = func or DefaultDebuffPreFilter
end

-----------------------------------------------------
-- External
-----------------------------------------------------
TidyPlatesWidgets.GetAuraWidgetByGUID = GetAuraWidgetByGUID
TidyPlatesWidgets.IsAuraShown = IsAuraShown
TidyPlatesWidgets.CanPlayerDispel = CanPlayerDispel

TidyPlatesWidgets.UseSquareDebuffIcon = UseSquareDebuffIcon
TidyPlatesWidgets.UseWideDebuffIcon = UseWideDebuffIcon
TidyPlatesWidgets.SetDebuffPrefilter = SetPrefilter

TidyPlatesWidgets.CreateAuraWidget = CreateAuraWidget

TidyPlatesWidgets.EnableAuraWatcher = Enable
TidyPlatesWidgets.EnableAuraWatcherTargetOnly = EnableForTargetOnly
TidyPlatesWidgets.DisableAuraWatcher = Disable