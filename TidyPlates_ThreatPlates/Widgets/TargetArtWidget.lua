-----------------------
-- Target Art Widget --
-----------------------
local path = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\TargetArtWidget\\"
local db

-- Target Art
local function UpdateTargetFrameArt(frame, unit)
	db = db or TidyPlatesThreat.db.profile

	local t = db.targetWidget
	if UnitExists("target") and unit.isTarget and t["ON"] and SetStyleThreatPlates(unit) ~= "etotem" then
		if db.friendlyNameOnly and unit.reaction == "FRIENDLY" then
			frame.IconLeft:Hide()
			frame.IconRight:Hide()
		else
			frame.IconLeft:SetTexture(path .. t.theme)
			frame.IconLeft:SetVertexColor(t.r, t.g, t.b, t.a)
			frame.IconRight:SetVertexColor(t.r, t.g, t.b, t.a)
			frame.IconRight:SetTexture(path .. t.theme)

			if t.size then
				frame.IconLeft:SetSize(t.size, t.size)
				frame.IconRight:SetSize(t.size, t.size)
			end

			if t.inverted then
				frame.IconLeft:SetRotation(1.57)
				frame.IconRight:SetRotation(-1.57)
			else
				frame.IconLeft:SetRotation(-1.57)
				frame.IconRight:SetRotation(1.57)
			end

			if t.width ~= nil then
				frame.IconLeft:SetWidth(t.width)
				frame.IconRight:SetWidth(t.width)
			end

			if t.height ~= nil then
				frame.IconLeft:SetHeight(t.height)
				frame.IconRight:SetHeight(t.height)
			end

			frame.IconLeft:Show()
			frame.IconRight:Show()
		end
	else
		frame.IconLeft:Hide()
		frame.IconRight:Hide()
	end
end

local function CreateTargetFrameArt(parent)
	local frame = CreateFrame("Frame", nil, parent)

	local IconLeft = parent:CreateTexture(nil, "OVERLAY")
	IconLeft:SetPoint("RIGHT", parent.bars.healthbar, "LEFT")

	local IconRight = parent:CreateTexture(nil, "OVERLAY")
	IconRight:SetPoint("LEFT", parent.bars.healthbar, "RIGHT")

	db = db or TidyPlatesThreat.db.profile

	if db.targetWidget.inverted then
		IconLeft:SetRotation(1.57)
		IconRight:SetRotation(-1.57)
	else
		IconLeft:SetRotation(-1.57)
		IconRight:SetRotation(1.57)
	end

	if db.targetWidget.width ~= nil then
		IconLeft:SetWidth(db.targetWidget.width)
		IconRight:SetWidth(db.targetWidget.width)
	end

	if db.targetWidget.height ~= nil then
		IconLeft:SetHeight(db.targetWidget.height)
		IconRight:SetHeight(db.targetWidget.height)
	end

	IconLeft:Hide()
	IconRight:Hide()

	frame.IconLeft, frame.IconRight = IconLeft, IconRight
	frame.Update = UpdateTargetFrameArt
	return frame
end

ThreatPlatesWidgets.CreateTargetFrameArt = CreateTargetFrameArt