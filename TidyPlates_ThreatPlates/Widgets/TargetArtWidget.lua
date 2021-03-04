-----------------------
-- Target Art Widget --
-----------------------
local path = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\TargetArtWidget\\"
-- Target Art
local function UpdateTargetFrameArt(frame, unit)
	local t = TidyPlatesThreat.db.profile.targetWidget
	if UnitExists("target") and unit.isTarget and t["ON"] and SetStyleThreatPlates(unit) ~= "etotem" then
		frame.Icon:SetTexture(path..t.theme)
		frame.Icon:SetVertexColor(t.r,t.g,t.b,t.a)
		frame:Show()
	else
		frame:Hide()
	end
end
local function CreateTargetFrameArt(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetFrameLevel(parent.bars.healthbar:GetFrameLevel())
	frame:SetWidth(256)
	frame:SetHeight(64)	
	frame.Icon = frame:CreateTexture(nil, "OVERLAY")
	frame.Icon:SetAllPoints(frame)
	frame:Hide()
	frame.Update = UpdateTargetFrameArt
	return frame
end

ThreatPlatesWidgets.CreateTargetFrameArt = CreateTargetFrameArt
