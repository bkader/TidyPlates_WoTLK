local GetRelativeThreat = TidyPlatesUtility.GetRelativeThreat

----------------------
-- FadeLater() - Registers a callback, which hides the specified frame in X seconds
----------------------
local FadeLater
do
	-- table constructions cause heap allocation; reuse tables
	local Framelist = {} -- Key = Frame, Value = Expiration Time
	local Watcherframe = CreateFrame("Frame")
	local WatcherframeActive = false
	local select = select
	local nextScheduledUpdate = 0
	local updateInterval = .07

	local function CheckFramelist(self)
		local curTime = GetTime()
		if curTime < nextScheduledUpdate then
			return
		end

		local framecount, alpha, timeRemains = 0, 0, 0
		nextScheduledUpdate = curTime + updateInterval
		-- Cycle through the watchlist, hiding frames which are timed-out
		for frame, expiration in pairs(Framelist) do
			timeRemains = expiration - curTime
			if frame:IsShown() then
				if timeRemains > 0 then
					framecount = framecount + 1
					if timeRemains < .5 then
						frame:SetAlpha(timeRemains * 2)
					end
				else
					frame:SetAlpha(0)
					Framelist[frame] = nil
				end
			else
				Framelist[frame] = nil
			end
		end
		-- If no more frames to watch, unregister the OnUpdate script
		if framecount == 0 then
			Watcherframe:SetScript("OnUpdate", nil)
			WatcherframeActive = false
		end
	end

	function FadeLater(frame, expiration)
		frame:SetAlpha(1)
		-- Register Frame
		Framelist[frame] = expiration
		-- Init Watchframe
		if WatcherframeActive then
			return
		else
			Watcherframe:SetScript("OnUpdate", CheckFramelist)
			WatcherframeActive = true
		end
	end
end

---------------------------------------------------------------------
local font = "FONTS\\ARIALN.ttf"
local art = "Interface\\Addons\\TidyPlates\\widgets\\ThreatLine\\ThreatLineUnified"
local artCoordinates = {
	Line = {0, .2, 0, 1},
	Right = {.5, .75, 0, 1},
	Left = {.25, .5, 0, 1}
}
local threatcolor

---------------------------------------------------------------------

local WidgetList = {}

local testMode = false

-- Graphics Update
local function UpdateThreatLine(frame, unitid)
	local maxwitdth = frame:GetWidth() / 2
	local leaderThreat, leaderThreatDelta, leaderThreatPct
	local leaderThreatMax, leaderThreatMin = frame.ThreatMax, frame.ThreatMin
	if testMode then
		leaderThreatPct, leaderUnitId = 180, "player"
	else
		leaderThreatPct, leaderUnitId, leaderThreatDelta = GetRelativeThreat(unitid)
	end

	if not leaderThreatPct then
		frame:_Hide()
		return
	end
	if leaderThreatPct and leaderThreatPct > 0 then
		if frame.UseRawValues then
			if leaderThreatDelta > 0 then
				leaderThreat = min(leaderThreatDelta, leaderThreatMax) / leaderThreatMax
			else
				leaderThreat = (-(max(leaderThreatDelta, leaderThreatMin))) / leaderThreatMin
			end
		else
			leaderThreat = leaderThreatPct
		end

		frame.Line:ClearAllPoints()
		-- Get Positions and Size
		if leaderThreat > 100 then
			-- While tanking
			frame.Line:SetWidth(maxwitdth * ((leaderThreat - 100) / 100))
			threatcolor = frame._HighColor
			frame.Line:SetPoint("LEFT", frame, "CENTER")
		else
			-- While NOT tanking
			frame.Line:SetWidth(maxwitdth * ((100 - leaderThreat) / 100))
			threatcolor = frame._LowColor
			frame.Line:SetPoint("RIGHT", frame, "CENTER")
		end

		if leaderUnitId and leaderUnitId ~= "player" then
			if UnitIsUnit(leaderUnitId, "pet") or GetPartyAssignment("MAINTANK", leaderUnitId) or GetPartyAssignment("MAINASSIST", leaderUnitId) or ("TANK" == UnitGroupRolesAssigned(leaderUnitId)) then
				threatcolor = frame._TankedColor
			end

			--if frame.ShowText then
			frame.TargetText:SetText(UnitName(leaderUnitId)) -- TP 6.1
			frame.TargetText:SetTextColor(threatcolor.r, threatcolor.g, threatcolor.b) -- TP 6.1
		else
			frame.TargetText:SetText("")
		end
		-- Set Colors
		frame.Left:SetVertexColor(threatcolor.r, threatcolor.g, threatcolor.b)
		frame.Line:SetVertexColor(threatcolor.r, threatcolor.g, threatcolor.b)
		frame.Right:SetVertexColor(threatcolor.r, threatcolor.g, threatcolor.b)
		-- Set Fading
		frame:Show()
		frame.FadeTime = GetTime() + 2
		frame:FadeLater(frame.FadeTime)
	else
		frame:_Hide()
	end
end

local function UpdateWidgetTarget(frame)
	if UnitExists("target") then
		UpdateThreatLine(frame, "target")
	else
		frame:Hide()
	end
end

-- Context Update (mouseover, target change)
local function UpdateWidgetContext(frame, unit)
	-- Filter
	if testMode then
		UpdateThreatLine(frame)
		return
	end
	if unit.reaction == "FRIENDLY" or (not InCombatLockdown()) or (not (UnitInParty("player") or HasPetUI())) then
		frame:_Hide()
		return
	end

	-- Context Update
	local guid = unit.guid
	if guid then
		WidgetList[guid] = frame
	end
	frame.guid = guid
	frame.unit = unit

	-- Update threat *now*, depending on context
	if unit.isTarget then
		UpdateThreatLine(frame, "target")
	elseif unit.isMouseover then
		UpdateThreatLine(frame, "mouseover")
	end
end

local function ClearWidgetContext(frame)
	frame.unit = nil
	local guid = frame.guid
	if guid then
		WidgetList[guid] = nil
		frame.guid = nil
	end
end

-- Watcher Frame
local WatcherFrame = CreateFrame("Frame", nil, WorldFrame)
local isEnabled = false
WatcherFrame:RegisterEvent("UNIT_THREAT_LIST_UPDATE")
WatcherFrame:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE")

-- GUID/UnitID Lookup List
local TargetList = {}
local updateCap = 1
local lastUpdate = 0

local function WatcherFrameHandler(frame, event)
	if event == "UNIT_THREAT_LIST_UPDATE" and (lastUpdate + updateCap) > GetTime() then
		return
	end

	local widget
	-- Reset the GUID/UnitID Lookup List
	for guid in pairs(TargetList) do
		TargetList[guid] = nil
	end

	-- Build a list of links to Target GUIDs
	guid = UnitGUID("target")
	if guid then
		TargetList[guid] = "target"
	end

	guid = UnitGUID("focus")
	if guid then
		TargetList[guid] = "focus"
	end

	-- This code enables full raid target watching
	local raidsize = GetNumRaidMembers() - 1
	for index = 1, raidsize do
		local unitid = "raid" .. index .. "target"
		guid = UnitGUID(unitid)
		if guid then
			TargetList[guid] = unitid
		end
	end

	-- Reference the list of GUIDs to active widgets (with GUIDs and Hostile)
	for guid, unitid in pairs(TargetList) do
		widget = WidgetList[guid]
		if widget then
			UpdateThreatLine(widget, unitid)
		end
	end

	lastUpdate = GetTime()
end

local function EnableWatcherFrame(arg)
	if arg then
		WatcherFrame:SetScript("OnEvent", WatcherFrameHandler)
		isEnabled = true
	else
		WatcherFrame:SetScript("OnEvent", nil)
		isEnabled = false
	end
end

-- Widget Creation
local function CreateWidgetFrame(parent)
	-- Required Widget Code
	local frame = CreateFrame("Frame", nil, parent)
	frame:Hide()

	-- Custom Code
	frame:SetWidth(100)
	frame:SetHeight(24)
	-- Threat Line
	frame.Line = frame:CreateTexture(nil, "OVERLAY")
	frame.Line:SetTexture(art)
	frame.Line:SetTexCoord(unpack(artCoordinates["Line"]))
	frame.Line:SetHeight(32)
	-- Left
	frame.Left = frame:CreateTexture(nil, "OVERLAY")
	frame.Left:SetTexture(art)
	frame.Left:SetTexCoord(unpack(artCoordinates["Left"]))
	frame.Left:SetPoint("RIGHT", frame.Line, "LEFT")
	frame.Left:SetWidth(32)
	frame.Left:SetHeight(32)
	-- Right
	frame.Right = frame:CreateTexture(nil, "OVERLAY")
	frame.Right:SetTexture(art)
	frame.Right:SetTexCoord(unpack(artCoordinates["Right"]))
	frame.Right:SetPoint("LEFT", frame.Line, "RIGHT")
	frame.Right:SetWidth(32)
	frame.Right:SetHeight(32)

	-- Target-Of Text
	frame.TargetText = frame:CreateFontString(nil, "OVERLAY")
	frame.TargetText:SetFont(font, 8, "OUTLINE")
	--frame.TargetText:SetShadowOffset(1, -1)
	--frame.TargetText:SetShadowColor(0,0,0,1)
	frame.TargetText:SetWidth(50)
	frame.TargetText:SetHeight(20)
	frame.TargetText:SetJustifyH("RIGHT")
	frame.TargetText:SetPoint("RIGHT", frame.Line, "LEFT", -5, 2)
	-- Mechanics/Setup
	frame.FadeLater = FadeLater
	frame.FadeTime = 0
	frame:Hide()
	frame.ThreatMax, frame.ThreatMin, frame.UseRawValues = 1, 0, false

	-- Customization
	frame._LowColor = {r = .14, g = .75, b = 1}
	frame._TankedColor = {r = 0, g = .9, b = .1}
	frame._HighColor = {r = 1, g = .67, b = .14}
	frame._ShowTargetOf = true
	-- End Custom Code

	-- Required Widget Code
	frame.UpdateContext = UpdateWidgetContext
	frame.Update = UpdateWidgetTarget
	frame._Hide = frame.Hide
	frame.Hide = function()
		ClearWidgetContext(frame)
		frame:_Hide()
	end
	if not isEnabled then
		EnableWatcherFrame(true)
	end
	return frame
end

TidyPlatesWidgets.CreateThreatLineWidget = CreateWidgetFrame