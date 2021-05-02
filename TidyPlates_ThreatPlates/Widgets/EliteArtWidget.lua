----------------------
-- Elite Art Widget --
----------------------
local path = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\EliteArtWidget\\"

local function UpdateEliteFrameArt(frame, unit)
	if (unit.isElite) and TidyPlatesThreat.db.profile.eliteWidget.ON then
		frame.Icon:SetTexture(path .. TidyPlatesThreat.db.profile.eliteWidget.theme)
		frame:Show()
	else
		frame:Hide()
	end
end
local function CreateEliteFrameArt(parent)
	local db = TidyPlatesThreat.db.profile.eliteWidget
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetHeight(64)
	frame:SetWidth(64)
	frame.Icon = frame:CreateTexture(nil, "OVERLAY")
	frame.Icon:SetAllPoints(frame)
	frame:Hide()
	frame.Update = UpdateEliteFrameArt
	return frame
end

ThreatPlatesWidgets.CreateEliteFrameArt = CreateEliteFrameArt