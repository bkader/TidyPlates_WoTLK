TidyPlatesData.UnitDescriptions = {}
TidyPlatesData.UnitClass = {}
TidyPlatesData.Friends = {}
TidyPlatesData.Guild = {}

local UnitCacheMonitor
local UnitCacheMonitorEvents = {}

local function UpdateGuildCache()
	if not TidyPlatesData.Guild then
		TidyPlatesData.Guild = {}
	end
	local guildname = GetGuildInfo("player")
	if not guildname then
		return
	end
	local numGuildMembers, numOnline = GetNumGuildMembers()
	for index = 1, numGuildMembers do
		local name, rank, rankIndex, level, class = GetGuildRosterInfo(index)
		TidyPlatesData.Guild[name] = true
		TidyPlatesData.UnitClass[name] = class
		TidyPlatesData.UnitDescriptions[name] = guildname
	end
end

local function UpdateFriendCache()
	if not TidyPlatesData.Friends then
		TidyPlatesData.Friends = {}
	end

	local numFriends = GetNumFriends()
	for index = 1, numFriends do
		local name, level, class = GetFriendInfo(index)
		if name then
			TidyPlatesData.Friends[name] = true
		end
	end
end

function UnitCacheMonitorEvents.UPDATE_MOUSEOVER_UNIT(self, ...)
	local name, class, level, description, _, unitadded

	-- If a unit is a player...
	if UnitIsPlayer("mouseover") then
		-- If a unit is an NPC...
		name = UnitName("mouseover")
		description = GetGuildInfo("mouseover")
		class = select(2, UnitClass("mouseover"))

		if TidyPlatesData.UnitClass[name] ~= class then
			unitadded = true
			TidyPlatesData.UnitClass[name] = class
		end
	elseif GameTooltipTextLeft1:GetText() == UnitName("mouseover") then
		name = GameTooltipTextLeft1:GetText()
		description = GameTooltipTextLeft2:GetText()
		if description then
			level = select(2, strsplit(" ", description))
			if tonumber(level) or level == "??" then
				description = nil
			end
		end
	end

	if TidyPlatesData.UnitDescriptions[name] ~= description then
		unitadded = true
		TidyPlatesData.UnitDescriptions[name] = description
	end

	if unitadded then
		TidyPlates:RequestDelegateUpdate()
	end
end

function UnitCacheMonitorEvents.GUILD_ROSTER_UPDATE(self, ...)
	UpdateGuildCache()
end

function UnitCacheMonitorEvents.FRIENDLIST_UPDATE(self, ...)
	UpdateFriendCache()
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

	if not TidyPlatesData.UnitDescriptions then
		TidyPlatesData.UnitDescriptions = {}
	end
	if not TidyPlatesData.UnitClass then
		TidyPlatesData.UnitClass = {}
	end
	if not TidyPlatesData.Guild then
		TidyPlatesData.Guild = {}
	end
	if not TidyPlatesData.Friends then
		TidyPlatesData.Friends = {}
	end

	if IsInGuild() then
		GuildRoster()
	end
	UpdateFriendCache()
end

local function Disable()
	if UnitCacheMonitor then
		UnitCacheMonitor:SetScript("OnEvent", nil)
		UnitCacheMonitor:UnregisterAllEvents()
		UnitCacheMonitor = nil
	end
end

TidyPlatesUtility.EnableUnitCache = Enable
TidyPlatesUtility.DisableUnitCache = Disable