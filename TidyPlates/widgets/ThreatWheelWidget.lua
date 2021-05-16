local threatfont = "FONTS\\ARIALN.ttf"
---------------
-- General Functions
---------------
local function SetFade(frame)
	if GetTime() > frame.FadeTime then
		frame:Hide()
		frame:SetScript("OnUpdate", nil)
	end
end

local RaidTankList = {}
local function IsRaidTank(unitid)
	if UnitIsUnit("pet", unitid) then
		return true
	end

	return RaidTankList[UnitName(unitid)]
end

---------------
-- Threat Functions
---------------
local function GetThreatSegment(threat)
	if not threat then
		return nil
	end
	if threat > 133 then
		return "HIGHTANK"
	elseif threat > 116 then
		return "MEDIUMTANK"
	elseif threat > 100 then
		return "LOWTANK"
	elseif threat > 83 then
		return "HIGHDPS"
	elseif threat > 66 then
		return "MEDIUMDPS"
	else
		return "LOWDPS"
	end
end

local GetRelativeThreat = TidyPlatesUtility.GetRelativeThreat

---------------
-- Roster Monitor
---------------
do
	local function UpdateRoster()
		if UnitInRaid("player") then
			local size = GetNumRaidMembers() - 1
			for index = 1, size do
				local raidid = "raid" .. tostring(index)
				local isAssigned = GetPartyAssignment("MAINTANK", raidid) or GetPartyAssignment("MAINASSIST", raidid)
				if isAssigned then
					RaidTankList[UnitName(raidid)] = true
				else
					RaidTankList[UnitName(raidid)] = nil
				end
			end
		else
			wipe(RaidTankList)
		end
	end

	local RosterMonitor = CreateFrame("Frame")
	RosterMonitor:RegisterEvent("RAID_ROSTER_UPDATE")
	RosterMonitor:RegisterEvent("PARTY_MEMBERS_CHANGED")
	RosterMonitor:RegisterEvent("PARTY_CONVERTED_TO_RAID")
	RosterMonitor:RegisterEvent("PLAYER_ENTERING_WORLD")

	RosterMonitor:SetScript("OnEvent", UpdateRoster)
end

---------------
-- Threat Circle Widget
---------------
do
	local threatSpinnerWidgetArt = "Interface\\Addons\\TidyPlates\\widgets\\ThreatSpinner\\SpinnerArt"

	local THREATWIDGET_SEGMENT_COORD = {
		HIGHTANK = {.75, 1, .5, 1},
		MEDIUMTANK = {.5, .75, .5, 1},
		LOWTANK = {.25, .5, .5, 1},
		HIGHDPS = {0, .25, .5, 1},
		MEDIUMDPS = {.75, 1, 0, .5},
		LOWDPS = {.5, .75, 0, .5},
		UNKNOWN = {.25, .5, 0, .5}
	}

	local function UpdateThreatWheelWidget(frame, unit)
		local unitid
		if unit.reaction == "FRIENDLY" or (not InCombatLockdown()) then
			frame:Hide()
			return
		end
		if unit.isTarget and UnitExists("target") then
			unitid = "target"
		elseif unit.isMouseover then
			unitid = "mouseover"
		end

		if unitid and unit.guid then
			local threat, topholder = GetRelativeThreat(unitid)
			local threatsegment = GetThreatSegment(threat)
			if threatsegment then
				-- Set Indicator
				frame:Show()
				frame.ThreatIcon:SetTexCoord(unpack(THREATWIDGET_SEGMENT_COORD[threatsegment]))
				frame.ThreatText:SetText(floor(threat))
				if topholder then
					frame.TargetText:SetText(UnitName(topholder))
				else
					frame.TargetText:SetText("")
				end
				-- Set Fading
				frame:Show()
				frame.FadeTime = GetTime() + 3
				frame:HideIn(frame.FadeTime)
			else
				frame:Hide()
			end
		elseif (GetTime() > frame.FadeTime) then
			frame:Hide()
		end
	end

	local function CreateThreatWheelWidget(parent)
		local frame = CreateFrame("Frame", nil, parent)
		frame:SetWidth(64)
		frame:SetHeight(64)
		-- Icon
		frame.ThreatIcon = frame:CreateTexture(nil, "OVERLAY")
		frame.ThreatIcon:SetAllPoints(frame)
		frame.ThreatIcon:SetTexture(threatSpinnerWidgetArt)
		-- Threat Text
		frame.ThreatText = frame:CreateFontString(nil, "OVERLAY")
		frame.ThreatText:SetFont(threatfont, 8, "NONE")
		frame.ThreatText:SetPoint("CENTER", frame.ThreatIcon, "CENTER", -1, 0)
		frame.ThreatText:SetWidth(20)
		frame.ThreatText:SetHeight(20)
		-- Target Text
		frame.TargetText = frame:CreateFontString(nil, "OVERLAY")
		frame.TargetText:SetFont(threatfont, 8, "NONE")
		frame.TargetText:SetShadowOffset(1, -1)
		frame.TargetText:SetShadowColor(0, 0, 0, 1)
		frame.TargetText:SetPoint("BOTTOM", frame, "TOP", 1, -25)
		frame.TargetText:SetWidth(50)
		frame.TargetText:SetHeight(20)
		-- Setup
		frame.HideIn = TidyPlatesWidgets.HideIn
		frame.FadeTime = 0
		frame:Hide()
		frame.Update = UpdateThreatWheelWidget
		return frame
	end

	TidyPlatesWidgets.CreateThreatWheelWidget = CreateThreatWheelWidget
end