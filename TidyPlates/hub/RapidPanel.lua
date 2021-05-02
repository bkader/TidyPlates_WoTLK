local font = "Interface\\Addons\\TidyPlates\\Media\\DefaultFont.ttf"
local PanelHelpers = TidyPlatesUtility.PanelHelpers

local function QuickSetPoints(frame, columnFrame, neighborFrame, xOffset, yOffset)
	local TopOffset = frame.Margins.Top + (yOffset or 0)
	local LeftOffset = frame.Margins.Left + (xOffset or 0)
	frame:ClearAllPoints()
	if neighborFrame then
		if neighborFrame.Margins then
			TopOffset = neighborFrame.Margins.Bottom + TopOffset + (yOffset or 0)
		end
		frame:SetPoint("TOP", neighborFrame, "BOTTOM", -(neighborFrame:GetWidth() / 2), -TopOffset)
	else
		frame:SetPoint("TOP", columnFrame, "TOP", 0, -TopOffset)
	end
	frame:SetPoint("LEFT", columnFrame, "LEFT", LeftOffset, 0)
end

local function CreateQuickSlider(name, label, ...) --, neighborFrame, xOffset, yOffset)
	local columnFrame = ...
	local frame = PanelHelpers:CreateSliderFrame(name, columnFrame, label, .5, 0, 1, .1)
	frame:SetWidth(170)
	-- Margins	-- Bottom/Left are negative
	frame.Margins = {Left = 12, Right = 8, Top = 20, Bottom = 13}
	QuickSetPoints(frame, ...)
	-- Set Feedback Function
	frame:SetScript("OnMouseUp", function() columnFrame.Callback() end)
	return frame
end

local function CreateQuickCheckbutton(name, label, ...)
	local columnFrame = ...
	local frame = PanelHelpers:CreateCheckButton(name, columnFrame, label)
	-- Margins	-- Bottom/Left are supposed to be negative
	frame.Margins = {Left = 2, Right = 100, Top = 0, Bottom = 0}
	QuickSetPoints(frame, ...)
	-- Set Feedback Function
	frame:SetScript("OnClick", function() columnFrame.Callback() end)
	return frame
end

local function SetSliderMechanics(slider, value, minimum, maximum, increment)
	slider:SetMinMaxValues(minimum, maximum)
	slider:SetValueStep(increment)
	slider:SetValue(value)
end

local function CreateQuickEditbox(name, ...)
	local columnFrame = ...
	local frame = CreateFrame("ScrollFrame", name, columnFrame, "UIPanelScrollFrameTemplate")
	frame.BorderFrame = CreateFrame("Frame", nil, frame)
	local EditBox = CreateFrame("EditBox", nil, frame)
	-- Margins	-- Bottom/Left are supposed to be negative
	frame.Margins = {Left = 4, Right = 24, Top = 8, Bottom = 8}

	-- Frame Size
	frame:SetWidth(150)
	frame:SetHeight(100)
	-- Border
	frame.BorderFrame:SetPoint("TOPLEFT", 0, 5)
	frame.BorderFrame:SetPoint("BOTTOMRIGHT", 3, -5)
	frame.BorderFrame:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4}
	})
	frame.BorderFrame:SetBackdropColor(0.05, 0.05, 0.05, 0)
	frame.BorderFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)

	-- Text
	EditBox:SetPoint("TOPLEFT")
	EditBox:SetPoint("BOTTOMLEFT")
	EditBox:SetHeight(100)
	EditBox:SetWidth(150)
	EditBox:SetMultiLine(true)

	EditBox:SetFrameLevel(frame:GetFrameLevel() - 1)
	EditBox:SetFont("Fonts\\FRIZQT__.TTF", 11, "NONE")
	EditBox:SetText("Empty")
	EditBox:SetAutoFocus(false)
	EditBox:SetTextInsets(9, 6, 2, 2)
	frame:SetScrollChild(EditBox)
	frame.EditBox = EditBox

	function frame:GetValue()
		return EditBox:GetText()
	end
	function frame:SetValue(value)
		EditBox:SetText(value)
	end
	frame._SetWidth = frame.SetWidth
	function frame:SetWidth(value)
		frame:_SetWidth(value)
		EditBox:SetWidth(value)
	end
	-- Set Positions
	QuickSetPoints(frame, ...)
	-- Set Feedback Function
	return frame
end

local function CreateQuickColorbox(name, label, ...)
	local columnFrame = ...
	local frame = PanelHelpers:CreateColorBox(name, columnFrame, label, 0, .5, 1, 1)
	-- Margins	-- Bottom/Left are supposed to be negative
	frame.Margins = {Left = 5, Right = 100, Top = 3, Bottom = 2}
	-- Set Positions
	QuickSetPoints(frame, ...)
	-- Set Feedback Function
	frame.OnValueChanged = function()
		columnFrame.Callback()
	end
	return frame
end

local function CreateQuickDropdown(name, label, dropdownTable, initialValue, ...)
	local columnFrame = ...
	local frame = PanelHelpers:CreateDropdownFrame(name, columnFrame, dropdownTable, initialValue, label)
	-- Margins	-- Bottom/Left are supposed to be negative
	frame.Margins = {Left = -12, Right = 2, Top = 22, Bottom = 0}
	-- Set Positions
	QuickSetPoints(frame, ...)
	-- Set Feedback Function
	frame.OnValueChanged = function()
		columnFrame.Callback()
	end
	return frame
end

local function CreateQuickHeadingLabel(name, label, ...)
	local columnFrame = ...
	local frame = CreateFrame("Frame", name, columnFrame)
	frame:SetHeight(20)
	frame:SetWidth(500)
	frame.Text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	frame.Text:SetFont(font, 22)
	frame.Text:SetTextColor(255 / 255, 105 / 255, 6 / 255)
	frame.Text:SetAllPoints()
	frame.Text:SetText(label)
	frame.Text:SetJustifyH("LEFT")
	frame.Text:SetJustifyV("BOTTOM")
	-- Margins	-- Bottom/Left are supposed to be negative
	frame.Margins = {Left = 6, Right = 2, Top = 2, Bottom = 2}
	-- Set Positions
	QuickSetPoints(frame, ...)
	return frame
end

local function CreateQuickItemLabel(name, label, ...)
	local columnFrame = ...
	local frame = CreateFrame("Frame", name, columnFrame)
	frame:SetHeight(15)
	frame:SetWidth(500)
	frame.Text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	frame.Text:SetAllPoints()
	frame.Text:SetText(label)
	frame.Text:SetJustifyH("LEFT")
	frame.Text:SetJustifyV("BOTTOM")
	-- Margins	-- Bottom/Left are supposed to be negative
	frame.Margins = {Left = 6, Right = 2, Top = 2, Bottom = 2}
	-- Set Positions
	QuickSetPoints(frame, ...)
	return frame
end

local function OnMouseWheelScrollFrame(frame, value, name)
	local scrollbar = _G[frame:GetName() .. "ScrollBar"]
	local currentPosition = scrollbar:GetValue()
	local increment = 50

	-- Spin Up
	if (value > 0) then
		-- Spin Down
		scrollbar:SetValue(currentPosition - increment)
	else
		scrollbar:SetValue(currentPosition + increment)
	end
end

TidyPlatesHubRapidPanel = {}
TidyPlatesHubRapidPanel.CreateQuickSlider = CreateQuickSlider
TidyPlatesHubRapidPanel.CreateQuickCheckbutton = CreateQuickCheckbutton
TidyPlatesHubRapidPanel.SetSliderMechanics = SetSliderMechanics
TidyPlatesHubRapidPanel.CreateQuickEditbox = CreateQuickEditbox
TidyPlatesHubRapidPanel.CreateQuickColorbox = CreateQuickColorbox
TidyPlatesHubRapidPanel.CreateQuickDropdown = CreateQuickDropdown
TidyPlatesHubRapidPanel.CreateQuickHeadingLabel = CreateQuickHeadingLabel
TidyPlatesHubRapidPanel.CreateQuickItemLabel = CreateQuickItemLabel
TidyPlatesHubRapidPanel.OnMouseWheelScrollFrame = OnMouseWheelScrollFrame