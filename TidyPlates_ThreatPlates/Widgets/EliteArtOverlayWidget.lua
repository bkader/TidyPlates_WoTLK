------------------------------
-- Elite Art Overlay Widget --
------------------------------
local path = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Artwork\\"

local function UpdateEliteFrameArtOverlay(frame, unit)
	local db = TidyPlatesThreat.db.profile.settings.elitehealthborder
	if unit.isElite and db.show then
		frame.Icon:SetTexture(path..db.texture)
		frame:Show()
	else
		frame:Hide()
	end
end
local function CreateEliteFrameArtOverlay(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetFrameLevel(parent.bars.healthbar:GetFrameLevel())
	frame:SetWidth(256)
	frame:SetHeight(64)
	frame.Icon = frame:CreateTexture(nil, "OVERLAY")
	frame.Icon:SetAllPoints(frame)
	frame:Hide()
	frame.Update = UpdateEliteFrameArtOverlay
	return frame
end

ThreatPlatesWidgets.CreateEliteFrameArtOverlay = CreateEliteFrameArtOverlay
