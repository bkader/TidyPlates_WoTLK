local TidyPlates = _G.TidyPlates
local TidyPlatesUtility = _G.TidyPlatesUtility
local TidyPlatesWidgetData = _G.TidyPlatesWidgetData

TidyPlatesWidgetData.UnitDescriptions = TidyPlatesWidgetData.UnitDescriptions or {}
TidyPlatesWidgetData.UnitGuild = TidyPlatesWidgetData.UnitGuild or {}
TidyPlatesWidgetData.UnitClass = TidyPlatesWidgetData.UnitClass or {}

local Friends = {}
local Guild = {}

local ReputationStringList = {
    [FACTION_STANDING_LABEL1] = true, -- "Hated";
    [FACTION_STANDING_LABEL2] = true, -- "Hostile";
    [FACTION_STANDING_LABEL3] = true, -- "Unfriendly";
    [FACTION_STANDING_LABEL4] = true, -- "Neutral";
    [FACTION_STANDING_LABEL5] = true, -- "Friendly";
    [FACTION_STANDING_LABEL6] = true, -- "Honored";
    [FACTION_STANDING_LABEL7] = true, -- "Revered";
    [FACTION_STANDING_LABEL8] = true -- "Exalted";
}

local UnitCacheMonitor
local UnitCacheMonitorEvents = {}
local _
local myRealm = GetRealmName("player")
local inInstance

local function UpdateGuildCache()
	Guild = wipe(Guild)
    local guildname = GetGuildInfo("player")
    if not guildname then return end
    local numGuildMembers, numOnline = GetNumGuildMembers()
    for index = 1, numGuildMembers do
        local name, rank, rankIndex, level, class, _, _, _, online = GetGuildRosterInfo(index)
        if online then
            Guild[name] = class
        end
    end
end

local function UpdateFriendCache()
	Friends = wipe(Friends)
    local numFriends = GetNumFriends()
    for index = 1, numFriends do
        local name, level, class, _, connected = GetFriendInfo(index)
        if connected and name then
            Friends[name] = true
        end
    end
end

local InstanceTypes = {
    ["none"] = 1,
    ["party"] = 2,
    ["raid"] = 2,
    ["arena"] = 3,
    ["pvp"] = 3
}

function UnitCacheMonitorEvents.WHO_LIST_UPDATE()
	local unitadded = false
    for i = 1, GetNumWhoResults() do
        local name, guild, level, race, localClass, zone, class = GetWhoInfo(i)
        -- Check for alterations
        if name and (TidyPlatesWidgetData.UnitGuild[name] ~= guild or TidyPlatesWidgetData.UnitClass[name] ~= class) then
            unitadded = true
            TidyPlatesWidgetData.UnitClass[name] = class
            TidyPlatesWidgetData.UnitGuild[name] = guild
        end
    end

    if unitadded then
        TidyPlates:RequestDelegateUpdate()
    end
end

function UnitCacheMonitorEvents.PLAYER_ENTERING_WORLD()
    local _, itype = GetInstanceInfo()
    if itype and itype ~= "none" then
        inInstance = true
    else
        inInstance = false
    end
end

function UnitCacheMonitorEvents.UPDATE_MOUSEOVER_UNIT(self, ...)
    -- Bypass caching while in an instance
    if inInstance then return end

    -- Vars
    local name, class, level, realm, description, _, unitadded

    -- Player
    ------------------------------------

    if UnitIsPlayer("mouseover") then
        realm = GetRealmName("mouseover")
        if myRealm ~= realm then
            return
        end -- Don't cache folks from other servers

        name = UnitName("mouseover")
        description = GetGuildInfo("mouseover")
        _, class = UnitClass("mouseover")

        -- Check for alterations
        if TidyPlatesWidgetData.UnitGuild[name] ~= description or TidyPlatesWidgetData.UnitClass[name] ~= class then
            unitadded = true
            TidyPlatesWidgetData.UnitClass[name] = class
            TidyPlatesWidgetData.UnitGuild[name] = description
        end
	-- NPC
	------------------------------------
    else
        name = GameTooltipTextLeft1:GetText()

        if name then
            name = gsub(gsub((name), "|c........", ""), "|r", "")
        else
            return
        end
        if name ~= UnitName("mouseover") then
            return
        end
        if UnitPlayerControlled("mouseover") then
            return
        end -- Avoid caching pet names

        description, descriptionAlt = GameTooltipTextLeft2:GetText(), GameTooltipTextLeft3:GetText()

        if ReputationStringList[description] then
            description = descriptionAlt
        end

        if description then
            _, level = strsplit(" ", description)
            if tonumber(level) or level == "??" then
                description = nil
            end
        end

        if TidyPlatesWidgetData.UnitDescriptions[name] ~= description then
            unitadded = true
            TidyPlatesWidgetData.UnitDescriptions[name] = description
        end
    end

    if unitadded then
        TidyPlates:RequestDelegateUpdate()
    end
end

function UnitCacheMonitorEvents.GUILD_ROSTER_UPDATE(self, ...)
    UpdateGuildCache()
    TidyPlates:RequestDelegateUpdate()
end

function UnitCacheMonitorEvents.FRIENDLIST_UPDATE(self, ...)
    UpdateFriendCache()
    TidyPlates:RequestDelegateUpdate()
end

local function OnEvent(frame, event, ...)
    UnitCacheMonitorEvents[event](...)
end

local function Enable()
    if not UnitCacheMonitor then
        UnitCacheMonitor = CreateFrame("Frame")
    end
    for event in pairs(UnitCacheMonitorEvents) do
        UnitCacheMonitor:RegisterEvent(event)
    end
    UnitCacheMonitor:SetScript("OnEvent", OnEvent)

    if not TidyPlatesWidgetData.UnitDescriptions then
        TidyPlatesWidgetData.UnitDescriptions = {}
    end
    if not TidyPlatesWidgetData.UnitClass then
        TidyPlatesWidgetData.UnitClass = {}
    end
    if not TidyPlatesWidgetData.UnitGuild then
        TidyPlatesWidgetData.UnitGuild = {}
    end
    Guild = Guild or {}
    Friends = Friends or {}

    GuildRoster()
    UpdateFriendCache()
end

local function Disable()
    if UnitCacheMonitor then
        UnitCacheMonitor:SetScript("OnEvent", nil)
        UnitCacheMonitor:UnregisterAllEvents()
    end
end

local function InstanceStatus()
    return inInstance
end
local function CachedUnitDescription(name)
    if inInstance then
        return nil
    else
        return TidyPlatesWidgetData.UnitDescriptions[name]
    end
end

local function CachedUnitGuild(name)
    if inInstance then
        return nil
    else
        return TidyPlatesWidgetData.UnitGuild[name]
    end
end

local function CachedUnitClass(name)
    if inInstance then
        return nil
    else
        return TidyPlatesWidgetData.UnitClass[name]
    end
end

local function IsFriend(name)
    return Friends[name]
end

local function IsGuildmate(name)
    return Guild[name]
end

TidyPlatesUtility.CachedUnitDescription = CachedUnitDescription
TidyPlatesUtility.CachedUnitGuild = CachedUnitGuild
TidyPlatesUtility.CachedUnitClass = CachedUnitClass
TidyPlatesUtility.IsFriend = IsFriend
TidyPlatesUtility.IsGuildmate = IsGuildmate

TidyPlatesUtility.InstanceStatus = InstanceStatus
TidyPlatesUtility.EnableUnitCache = Enable
TidyPlatesUtility.DisableUnitCache = Disable