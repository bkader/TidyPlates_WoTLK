-----------------------
-- Target Art Widget --
-----------------------
local path = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\TargetArtWidget\\"
local db

-- Target Art
local function UpdateTargetFrameArt(frame, unit)
	db = TidyPlatesThreat.db.profile

	local t = db.targetWidget
	if t.ON and UnitExists("target") and unit.isTarget and SetStyleThreatPlates(unit) ~= "etotem" then
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

			frame:Show()
		end
	else
		frame:Hide()
	end
end

local function CreateTargetFrameArt(parent)
	local frame = CreateFrame("Frame", nil, parent)

	frame.IconLeft = parent:CreateTexture(nil, "OVERLAY")
	frame.IconLeft:SetPoint("RIGHT", parent.bars.healthbar, "LEFT")

	frame.IconRight = parent:CreateTexture(nil, "OVERLAY")
	frame.IconRight:SetPoint("LEFT", parent.bars.healthbar, "RIGHT")

	db = TidyPlatesThreat.db.profile

	if db.targetWidget.inverted then
		frame.IconLeft:SetRotation(1.57)
		frame.IconRight:SetRotation(-1.57)
	else
		frame.IconLeft:SetRotation(-1.57)
		frame.IconRight:SetRotation(1.57)
	end

	if db.targetWidget.width ~= nil then
		frame.IconLeft:SetWidth(db.targetWidget.width)
		frame.IconRight:SetWidth(db.targetWidget.width)
	end

	if db.targetWidget.height ~= nil then
		frame.IconLeft:SetHeight(db.targetWidget.height)
		frame.IconRight:SetHeight(db.targetWidget.height)
	end

	frame:SetScript("OnShow", function(self)
		self.IconLeft:Show()
		self.IconRight:Show()
	end)

	frame:SetScript("OnHide", function(self)
		self.IconLeft:Hide()
		self.IconRight:Hide()
	end)

	frame.Update = UpdateTargetFrameArt
	return frame
end

ThreatPlatesWidgets.CreateTargetFrameArt = CreateTargetFrameArt