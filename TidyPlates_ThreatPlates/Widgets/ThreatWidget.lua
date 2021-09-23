-------==------------
-- Threat Widget --
-------------------
local path = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\ThreatWidget\\"
local db

-- Threat Widget
local function UpdateThreatWidget(frame, unit)
	db = db or TidyPlatesThreat.db.profile
	local threatLevel
	local style = SetStyleThreatPlates(unit)
	if TidyPlatesThreat.db.char.threat.tanking then
		threatLevel = unit.threatSituation
	else
		if unit.threatSituation == "HIGH" then
			threatLevel = "LOW"
		elseif unit.threatSituation == "LOW" then
			threatLevel = "HIGH"
		elseif unit.threatSituation == "MEDIUM" then
			threatLevel = "MEDIUM"
		end
	end
	if ((style == "dps") or (style == "tank") or (style == "unique")) and InCombatLockdown() and unit.class == "UNKNOWN" and db.threat.art.ON then
		if unit.isMarked and db.threat.marked.art then
			frame:Hide()
		else
			frame.Texture:SetTexture(path .. db.threat.art.theme .. "\\" .. threatLevel)
			frame:Show()
		end
	else
		frame:Hide()
	end
end
local function CreateThreatArtWidget(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetFrameLevel(parent.bars.healthbar:GetFrameLevel() + 2)

	db = db or TidyPlatesThreat.db.profile

	local width = db.settings.healthbar.width
	local height = db.settings.healthbar.height
	frame:SetWidth(width * 2.1333)
	frame:SetHeight(height * 6.4)

	frame.Texture = frame:CreateTexture(nil, "OVERLAY")
	frame.Texture:SetAllPoints(frame)
	frame:Hide()
	frame.Update = UpdateThreatWidget
	return frame
end

ThreatPlatesWidgets.CreateThreatArtWidget = CreateThreatArtWidget