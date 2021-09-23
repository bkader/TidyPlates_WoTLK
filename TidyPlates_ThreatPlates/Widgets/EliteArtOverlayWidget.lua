------------------------------
-- Elite Art Overlay Widget --
------------------------------
local path = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Media\\Artwork\\"
local DB

local function UpdateEliteFrameArtOverlay(frame, unit)
	DB = TidyPlatesThreat.db.profile
	local db = DB.settings.elitehealthborder
	if unit.isElite and db.show and not (unit.reaction == "FRIENDLY" and DB.friendlyNameOnly) then
		frame.Icon:SetTexture(path .. db.texture)
		frame:Show()
	else
		frame:Hide()
	end
end
local function CreateEliteFrameArtOverlay(parent)
	DB = TidyPlatesThreat.db.profile

	local frame = CreateFrame("Frame", nil, parent)
	frame:SetFrameLevel(parent.bars.healthbar:GetFrameLevel())
	frame:SetWidth((DB.settings.healthbar.width or 120) * 2.1333)
	frame:SetHeight((DB.settings.healthbar.height or 10) * 6.4)
	frame.Icon = frame:CreateTexture(nil, "OVERLAY")
	frame.Icon:SetAllPoints(frame)
	frame:Hide()
	frame.Update = UpdateEliteFrameArtOverlay
	return frame
end

ThreatPlatesWidgets.CreateEliteFrameArtOverlay = CreateEliteFrameArtOverlay