---------------
-- Target Widget
---------------

local function UpdateSelectionWidget(self, unit)
	if unit.isTarget then
		self:Show()
	else
		self:Hide()
	end
end

local function SetSelectionWidgetTexture(self, texture)
	if texture then
		self.Texture:SetTexture(texture)
	end
end

local function CreateSelectionWidget(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetFrameLevel(parent.bars.healthbar:GetFrameLevel())
	frame:SetWidth(128)
	frame:SetHeight(32)
	frame.Texture = frame:CreateTexture(nil, "BACKGROUND")
	frame.Texture:SetAllPoints(frame)
	frame.Update = UpdateSelectionWidget
	frame.SetWidgetTexture = SetSelectionWidgetTexture
	return frame
end

TidyPlatesWidgets.CreateSelectionWidget = CreateSelectionWidget