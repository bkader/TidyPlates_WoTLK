local f = CreateFrame("frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("FRIENDLIST_UPDATE")
f:RegisterEvent("GUILD_ROSTER_UPDATE")
f:RegisterEvent("BN_CONNECTED")
f:RegisterEvent("BN_FRIEND_ACCOUNT_ONLINE")
f:RegisterEvent("BN_FRIEND_ACCOUNT_OFFLINE")
f:RegisterEvent("BN_FRIEND_LIST_SIZE_CHANGED")

--local
local ListTable = {}
ListTable.g = {}
ListTable.b = {}
ListTable.f = {}
local eventsRegistered = true

local function UpdateBnetList()
	wipe(ListTable.b)
	local BnetTotal, BnetOnline = BNGetNumFriends()
	for i = 1, BnetOnline do
		local _, _, _, _, toonID, client, isOnline, _, _, _, _, _, _, _ = BNGetFriendInfo(i)
		if isOnline and toonID and client == "WoW" then
			local _, name, _, _, _, _, _, _, _, _ = BNGetToonInfo(toonID)
			tinsert(ListTable.b, name)
		end
	end
end

local function EventHandler(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		ShowFriends()
		if IsInGuild() then
			GuildRoster()
		end
		UpdateBnetList()
	elseif event == "GUILD_ROSTER_UPDATE" then
		wipe(ListTable.g)
		for i = 1, GetNumGuildMembers() do
			local name = select(1, GetGuildRosterInfo(i))
			tinsert(ListTable.g, name)
		end
	elseif event == "FRIENDLIST_UPDATE" then
		wipe(ListTable.f)
		local friendsTotal, friendsOnline = GetNumFriends()
		for i = 1, friendsOnline do
			local name = select(1, GetFriendInfo(i))
			tinsert(ListTable.f, name)
		end
	elseif event == "BN_FRIEND_LIST_SIZE_CHANGED" or event == "BN_CONNECTED" or event == "BN_FRIEND_ACCOUNT_ONLINE" or event == "BN_FRIEND_ACCOUNT_OFFLINE" then
		UpdateBnetList()
	end
end

f:SetScript("OnEvent", function(self, event, ...) EventHandler(self, event, ...) end)

local path = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\SocialWidget\\"

local function UpdateSocialWidget(frame, unit)
	local db = TidyPlatesThreat.db.profile.socialWidget
	if db.ON then
		if tContains(ListTable.f, unit.name) then
			frame.Icon:SetTexture(path .. "friendicon")
			frame:Show()
		elseif tContains(ListTable.b, unit.name) then
			frame.Icon:SetTexture("Interface\\FriendsFrame\\PlusManz-BattleNet")
			frame:Show()
		elseif tContains(ListTable.g, unit.name) then
			frame.Icon:SetTexture(path .. "guildicon")
			frame:Show()
		else
			frame:Hide()
		end
		f:SetScript("OnEvent", function(self, event, ...) EventHandler(self, event, ...) end)
	else
		frame:Hide()
		f:SetScript("OnEvent", nil)
	end
end
local function CreateSocialWidget(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetHeight(32)
	frame:SetWidth(32)
	frame.Icon = frame:CreateTexture(nil, "OVERLAY")
	frame.Icon:SetAllPoints(frame)
	frame:Hide()
	frame.Update = UpdateSocialWidget
	return frame
end

ThreatPlatesWidgets.CreateSocialWidget = CreateSocialWidget