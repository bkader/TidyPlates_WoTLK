local L = TidyPlates.L

local Panel
local font = "Fonts\\FRIZQT__.TTF"
local CopyTable = TidyPlatesUtility.copyTable
local PanelHelpers = TidyPlatesUtility.PanelHelpers

---------------------------------------------
-- Variables Definition
---------------------------------------------
TidyPlatesHubTankCache = {}
TidyPlatesHubTankSavedVariables = {}
TidyPlatesHubTankVariables = {
	-- Style
	---------------------------------------
	StyleEnemyMode = 1,
	StyleFriendlyMode = 1,
	-- Opacity
	---------------------------------------
	OpacityTarget = 1,
	OpacityNonTarget = .5,
	OpacitySpotlightMode = 1,
	OpacitySpotlight = .5,
	OpacityFullSpell = false, -- Bring Casting units to Full Opacity
	OpacityFullNoTarget = true, -- Use full opacity when No Target
	OpacityFiltered = 0,
	OpacityFilterNeutralUnits = false, -- OpacityHideNeutral = false,
	OpacityFilterNonElite = false, -- OpacityHideNonElites = false,
	OpacityFilterInactive = false,
	OpacityFilterList = "Fanged Pit Viper",
	OpacityFilterLookup = {},
	-- Scale
	---------------------------------------
	ScaleStandard = 1,
	ScaleSpotlightMode = 4,
	ScaleSpotlight = 1.2,
	ScaleIgnoreNeutralUnits = false,
	ScaleIgnoreNonEliteUnits = false,
	ScaleIgnoreInactive = false,
	-- Text
	---------------------------------------
	TextHealthTextMode = 1,
	TextShowLevel = false,
	TextUseBlizzardFont = false,
	-- Color
	---------------------------------------
	ColorHealthBarMode = 3,
	ColorDangerGlowMode = 2,
	TextNameColorMode = 1,
	ColorAttackingMe = {r = 15 / 255, g = 133 / 255, b = 255 / 255}, -- Bright Blue
	ColorAggroTransition = {r = 255 / 255, g = 216 / 255, b = 0 / 255}, -- Yellow
	ColorAttackingOthers = {r = 255 / 255, g = 128 / 255, b = 0}, -- Orange
	ColorAttackingOtherTank = {r = 15 / 255, g = 133 / 255, b = 255 / 255}, -- Bright Blue
	ColorDangerGlowOnParty = false,
	ClassColorPartyMembers = false,
	-- Widgets
	---------------------------------------
	WidgetTargetHighlight = true,
	WidgetEliteIndicator = true,
	ClassEnemyIcon = false,
	ClassPartyIcon = false,
	WidgetsTotemIcon = false,
	WidgetsComboPoints = true,
	WidgetsThreatIndicator = true,
	WidgetsThreatIndicatorMode = 1,
	WidgetsRangeIndicator = false,
	WidgetsRangeMode = 1,
	WidgetsDebuff = true,
	WidgetsDebuffMode = 3,
	WidgetsDebuffList = {["Obsolete"] = true},
	--WidgetsDebuffTrackList = "Moonfire",
	WidgetsDebuffTrackList = "My Rake\nMy Rip\nMy Moonfire\nAll 339",
	WidgetsDebuffLookup = {},
	WidgetsDebuffPriority = {},
	-- Frame
	---------------------------------------
	FrameVerticalPosition = .5
}

TidyPlatesHubTankCache = CopyTable(TidyPlatesHubTankVariables)
local TidyPlatesHubTankDefaults = CopyTable(TidyPlatesHubTankVariables)
---------------
-- Helpers
---------------

local function CallForStyleUpdate()
	for name, theme in pairs(TidyPlatesThemeList) do
		if theme.OnApplyThemeCustomization then
			theme.OnApplyThemeCustomization()
		end
	end
end

local function GetPanelValues(panel, targetTable, cloneTable)
	for index in pairs(targetTable) do
		if panel[index] then
			targetTable[index] = panel[index]:GetValue()
			cloneTable[index] = targetTable[index]
		end
	end
end

local function SetPanelValues(panel, sourceTable)
	for index, value in pairs(sourceTable) do
		if panel[index] then
			panel[index]:SetValue(value)
		end
	end
end

local function GetSavedVariables(targetTable, cloneTable)
	for i, v in pairs(targetTable) do
		if cloneTable[i] ~= nil then
			targetTable[i] = cloneTable[i]
		end
	end
end

local function ListToTable(...)
	local t = {}
	for index = 1, select("#", ...) do
		local line = select(index, ...)
		if line ~= "" then
			t[index] = line
		end
	end
	return t
end

local function ConvertStringToTable(source, target)
	local temp = ListToTable(strsplit("\n", source))
	target = wipe(target)

	for index = 1, #source do
		local str = temp[index]
		if str then
			target[str] = true
		end
	end
end

local PrefixList = {
	["ALL"] = 1,
	["All"] = 1,
	["all"] = 1,
	["MY"] = 2,
	["My"] = 2,
	["my"] = 2,
	["NO"] = 3,
	["CC"] = 4,
	["OTHER"] = 5
}

local function ConvertDebuffListTable(source, target, order)
	local temp = ListToTable(strsplit("\n", source))
	target = wipe(target)
	if order then
		order = wipe(order)
	end

	for index = 1, #temp do
		local str = temp[index]
		local item
		local _, _, prefix, suffix = string.find(str, "(%w+)[%s%p]*(.*)")
		if prefix then
			if PrefixList[prefix] then
				item = suffix
				target[item] = PrefixList[prefix]
			else -- If no prefix is listed, assume 1
				if suffix and suffix ~= "" then
					item = prefix .. " " .. suffix
				else
					item = prefix
				end
				target[item] = 1
			end
			if order then
				order[item] = index
			end
		end
	end
end
------------------------------------------------
-- Rapid Panel Functions
------------------------------------------------
local function OnPanelItemChange()
	GetPanelValues(Panel, TidyPlatesHubTankVariables, TidyPlatesHubTankSavedVariables)
	CallForStyleUpdate()
	ConvertDebuffListTable(
		TidyPlatesHubTankVariables.WidgetsDebuffTrackList,
		TidyPlatesHubTankVariables.WidgetsDebuffLookup,
		TidyPlatesHubTankVariables.WidgetsDebuffPriority
	)
	ConvertStringToTable(TidyPlatesHubTankVariables.OpacityFilterList, TidyPlatesHubTankVariables.OpacityFilterLookup)
end

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

local function CreateQuickSlider(name, label, ...)
	local columnFrame = ...
	local frame = PanelHelpers:CreateSliderFrame(name, columnFrame, label, .5, 0, 1, .1)
	frame:SetWidth(170)
	-- Margins	-- Bottom/Left are negative
	frame.Margins = {Left = 12, Right = 8, Top = 20, Bottom = 13}
	QuickSetPoints(frame, ...)
	-- Set Feedback Function
	frame:SetScript("OnMouseUp", function() OnPanelItemChange() end)
	return frame
end

local function CreateQuickCheckbutton(name, label, ...)
	local columnFrame = ...
	local frame = PanelHelpers:CreateCheckButton(name, columnFrame, label)
	-- Margins	-- Bottom/Left are supposed to be negative
	frame.Margins = {Left = 2, Right = 100, Top = 0, Bottom = 0}
	QuickSetPoints(frame, ...)
	-- Set Feedback Function
	frame:SetScript("OnClick", function() OnPanelItemChange() end)
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
	-- Functions
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
	frame.OnValueChanged = OnPanelItemChange
	--frame.OnValueChanged = columnFrame.OnFeedback
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
	frame.OnValueChanged = OnPanelItemChange
	--frame.OnValueChanged = columnFrame.OnFeedback
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

------------------------------------------------------------------
-- Interface Options Panel
------------------------------------------------------------------
local function CreateInterfacePanel(panelName, panelTitle, heading, parentTitle)
	local StyleModes = {
		-- Nameplate Style
		{text = L["Default"], notCheckable = 1},
		{text = L["Text Only"], notCheckable = 1},
		{text = L["Bars during Combat"], notCheckable = 1},
		{text = L["Bars on Active/Damaged Units"], notCheckable = 1},
		{text = L["Bars on Elite Units"], notCheckable = 1},
		{text = L["Bars on Marked Units"], notCheckable = 1},
		{text = L["Bars on Players"], notCheckable = 1}
	}

	local TextModes = {
		{text = L["None"], notCheckable = 1},
		{text = L["Percent Health"], notCheckable = 1},
		{text = L["Exact health"], notCheckable = 1},
		{text = L["Health Deficit"], notCheckable = 1},
		{text = L["Health Total & Percent"], notCheckable = 1},
		{text = L["Target Of"], notCheckable = 1},
		{text = L["Approximate Health"], notCheckable = 1}
	}

	local RangeModes = {
		{text = L["9 yards"]},
		{text = L["15 yards"]},
		{text = L["28 yards"]},
		{text = L["40 yards"]}
	}

	local DebuffModes = {
		{text = L["Show All"], notCheckable = 1},
		{text = L["Show These... "], notCheckable = 1},
		{text = L["Show All Mine "], notCheckable = 1},
		{text = L["Show My... "], notCheckable = 1},
		{text = L["By Prefix..."], notCheckable = 1}
	}

	local OpacityModes = {
		{text = L["None"], notCheckable = 1},
		{text = L["By Low Threat"], notCheckable = 1},
		{text = L["By Mouseover"], notCheckable = 1},
		{text = L["By Debuff Widget"], notCheckable = 1},
		{text = L["By Enemy"], notCheckable = 1},
		{text = L["By NPC"], notCheckable = 1},
		{text = L["By Raid Icon"], notCheckable = 1},
		{text = L["By Active/Damaged"], notCheckable = 1}
	}
	local ScaleModes = {
		{text = L["None"], notCheckable = 1},
		{text = L["By Elite"], notCheckable = 1},
		{text = L["By Target"], notCheckable = 1},
		{text = L["By Low Threat"], notCheckable = 1},
		{text = L["By Debuff Widget"], notCheckable = 1},
		{text = L["By Enemy"], notCheckable = 1},
		{text = L["By NPC"], notCheckable = 1},
		{text = L["By Raid Icon"], notCheckable = 1}
	}
	local HealthColorModes = {
		{text = L["None"], notCheckable = 1},
		{text = L["By Class"], notCheckable = 1},
		{text = L["By Threat"], notCheckable = 1},
		{text = L["By Reaction"], notCheckable = 1}
	}

	local WarningGlowModes = {
		{text = L["None"], notCheckable = 1},
		{text = L["By Low Threat"], notCheckable = 1}
	}

	local ThreatModes = {
		{text = L["Tug-o-Threat"], notCheckable = 1},
		{text = L["Threat Wheel"], notCheckable = 1}
	}

	local NameColorModes = {
		{text = L["Default"], notCheckable = 1},
		{text = L["By Class"], notCheckable = 1},
		{text = L["By Threat"], notCheckable = 1},
		{text = L["By Reaction"], notCheckable = 1}
	}

	local panel = CreateFrame("Frame", panelName .. "_InterfaceOptionsPanel", UIParent)
	panel.name = panelTitle
	if parentTitle then
		panel.parent = parentTitle
	end
	panel:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		insets = {left = 2, right = 2, top = 2, bottom = 2}
	})
	panel:SetBackdropColor(0.06, 0.06, 0.06, 1)

	-- Main Scrolled Frame
	panel.MainFrame = CreateFrame("Frame")
	panel.MainFrame:SetWidth(412)
	panel.MainFrame:SetHeight(1850) -- This can be set VERY long since we've got it in a scrollable window.

	-- Scrollable Panel Window
	------------------------------
	panel.ScrollFrame = CreateFrame("ScrollFrame", panelName .. "_Scrollframe", panel, "UIPanelScrollFrameTemplate")
	panel.ScrollFrame:SetPoint("TOPLEFT", 16, -48)
	panel.ScrollFrame:SetPoint("BOTTOMRIGHT", -32, 16)
	panel.ScrollFrame:SetScrollChild(panel.MainFrame)
	panel.ScrollFrame:SetScript("OnMouseWheel", OnMouseWheelScrollFrame)

	-- Graphic Border on Scroll Frame
	panel.ScrollFrameBorder = CreateFrame("Frame", panelName .. "ScrollFrameBorder", panel.ScrollFrame)
	panel.ScrollFrameBorder:SetPoint("TOPLEFT", -4, 5)
	panel.ScrollFrameBorder:SetPoint("BOTTOMRIGHT", 3, -5)
	panel.ScrollFrameBorder:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4}
	})
	panel.ScrollFrameBorder:SetBackdropColor(0.05, 0.05, 0.05, 0)
	panel.ScrollFrameBorder:SetBackdropBorderColor(0.2, 0.2, 0.2, 1)

	-- Alignment Colum
	------------------------------
	panel.AlignmentColumn = CreateFrame("Frame", panelName .. "_AlignmentColumn", panel.MainFrame)
	local AlignmentColumn = panel.AlignmentColumn
	AlignmentColumn:SetPoint("TOPLEFT", 12, 0)
	AlignmentColumn:SetPoint("BOTTOMRIGHT", panel.MainFrame, "BOTTOM")

	-- Heading
	------------------------------
	panel.MainLabel = CreateQuickHeadingLabel(nil, heading, panel, nil, 16, 16)

	-- Style
	------------------------------
	panel.StyleLabel = CreateQuickHeadingLabel(nil, L["Style"], AlignmentColumn, nil, 0, 4)
	panel.StyleEnemyMode = CreateQuickDropdown(panelName .. "StyleEnemyMode", L["Enemy Nameplates:"], StyleModes, 1, AlignmentColumn, panel.StyleLabel)
	panel.StyleFriendlyMode = CreateQuickDropdown(panelName .. "StyleFriendlyMode", L["Friendly Nameplates:"], StyleModes, 1, AlignmentColumn, panel.StyleEnemyMode)

	--Opacity
	------------------------------
	panel.OpacityLabel = CreateQuickHeadingLabel(nil, L["Opacity"], AlignmentColumn, panel.StyleFriendlyMode, 0, 4)
	panel.OpacityTarget = CreateQuickSlider(panelName .. "OpacityTarget", L["Current Target Opacity:"], AlignmentColumn, panel.OpacityLabel, 0, 2)
	panel.OpacityNonTarget = CreateQuickSlider(panelName .. "OpacityNonTarget", L["Non-Target Opacity:"], AlignmentColumn, panel.OpacityTarget, 0, 2)
	panel.OpacitySpotlightMode = CreateQuickDropdown(panelName .. "OpacitySpotlightMode", L["Opacity Spotlight Mode:"], OpacityModes, 1, AlignmentColumn, panel.OpacityNonTarget)
	panel.OpacitySpotlight = CreateQuickSlider(panelName .. "OpacitySpotlight", L["Spotlight Opacity:"], AlignmentColumn, panel.OpacitySpotlightMode, 0, 2)
	panel.OpacityFullSpell = CreateQuickCheckbutton(panelName .. "OpacityFullSpell", L["Bring Casting Units to Target Opacity"], AlignmentColumn, panel.OpacitySpotlight, 16)
	panel.OpacityFullNoTarget = CreateQuickCheckbutton(panelName .. "OpacityFullNoTarget", L["Use Target Opacity When No Target Exists"], AlignmentColumn, panel.OpacityFullSpell, 16)
	panel.OpacityFiltered = CreateQuickSlider(panelName .. "OpacityFiltered", L["Filtered Unit Opacity:"], AlignmentColumn, panel.OpacityFullNoTarget, 0, 2)
	panel.OpacityFilterNeutralUnits = CreateQuickCheckbutton(panelName .. "OpacityFilterNeutralUnits", L["Filter Neutral Units"], AlignmentColumn, panel.OpacityFiltered, 16)
	panel.OpacityFilterNonElite = CreateQuickCheckbutton(panelName .. "OpacityFilterNonElite", L["Filter Non-Elite"], AlignmentColumn, panel.OpacityFilterNeutralUnits, 16)
	panel.OpacityFilterInactive = CreateQuickCheckbutton(panelName .. "OpacityFilterInactive", L["Filter Inactive"], AlignmentColumn, panel.OpacityFilterNonElite, 16)
	panel.OpacityCustomFilterLabel = CreateQuickItemLabel(nil, L["Filter By Unit Name:"], AlignmentColumn, panel.OpacityFilterInactive, 16)
	panel.OpacityFilterList = CreateQuickEditbox(panelName .. "OpacityFilterList", AlignmentColumn, panel.OpacityCustomFilterLabel, 16)

	--Scale
	------------------------------
	panel.ScaleLabel = CreateQuickHeadingLabel(nil, L["Scale"], AlignmentColumn, panel.OpacityFilterList, 0, 4)
	panel.ScaleStandard = CreateQuickSlider(panelName .. "ScaleStandard", L["Normal Scale:"], AlignmentColumn, panel.ScaleLabel, 0, 2)panel.ScaleSpotlightMode = CreateQuickDropdown( panelName .. "ScaleSpotlightMode", L["Scale Spotlight Mode:"], ScaleModes, 1, AlignmentColumn, panel.ScaleStandard)
	panel.ScaleSpotlight = CreateQuickSlider(panelName .. "ScaleSpotlight", L["Spotlight Scale:"], AlignmentColumn, panel.ScaleSpotlightMode, 0, 2)
	panel.ScaleIgnoreNeutralUnits = CreateQuickCheckbutton(panelName .. "ScaleIgnoreNeutralUnits", L["Ignore Neutral Units"], AlignmentColumn, panel.ScaleSpotlight, 16)
	panel.ScaleIgnoreNonEliteUnits = CreateQuickCheckbutton(panelName .. "ScaleIgnoreNonEliteUnits", L["Ignore Non-Elite Units"], AlignmentColumn, panel.ScaleIgnoreNeutralUnits, 16)
	panel.ScaleIgnoreInactive = CreateQuickCheckbutton(panelName .. "ScaleIgnoreInactive", L["Ignore Inactive Units"], AlignmentColumn, panel.ScaleIgnoreNonEliteUnits, 16)

	--Text
	------------------------------
	panel.TextLabel = CreateQuickHeadingLabel(nil, L["Text"], AlignmentColumn, panel.ScaleIgnoreInactive, 0, 4)
	panel.TextNameColorMode = CreateQuickDropdown(panelName .. "TextNameColorMode", L["Name Text Color Mode:"], NameColorModes, 1, AlignmentColumn, panel.TextLabel)
	panel.TextHealthTextMode = CreateQuickDropdown(panelName .. "TextHealthTextMode", L["Health Text:"], TextModes, 1, AlignmentColumn, panel.TextNameColorMode)
	panel.TextShowLevel = CreateQuickCheckbutton(panelName .. "TextShowLevel", L["Show Level Text"], AlignmentColumn, panel.TextHealthTextMode)
	panel.TextUseBlizzardFont = CreateQuickCheckbutton(panelName .. "TextUseBlizzardFont", L["Use Default Blizzard Font"], AlignmentColumn, panel.TextShowLevel)

	--Color
	------------------------------
	panel.ColorLabel = CreateQuickHeadingLabel(nil, L["Color"], AlignmentColumn, panel.TextUseBlizzardFont, 0, 4)
	panel.ColorHealthBarMode = CreateQuickDropdown(panelName .. "ColorHealthBarMode", L["Health Bar Color Mode:"], HealthColorModes, 1, AlignmentColumn, panel.ColorLabel)
	panel.ColorDangerGlowMode = CreateQuickDropdown(panelName .. "ColorDangerGlowMode", L["Warning Glow/Border Mode:"], WarningGlowModes, 1, AlignmentColumn, panel.ColorHealthBarMode)
	panel.ColorThreatColorLabels = CreateQuickItemLabel(nil, L["Threat Colors:"], AlignmentColumn, panel.ColorDangerGlowMode, 0)
	panel.ColorAttackingMe = CreateQuickColorbox(panelName .. "ColorAttackingMe", L["Attacking Me"], AlignmentColumn, panel.ColorThreatColorLabels, 16)
	panel.ColorAggroTransition = CreateQuickColorbox(panelName .. "ColorAggroTransition", L["Losing Aggro"], AlignmentColumn, panel.ColorAttackingMe, 16)
	panel.ColorAttackingOthers = CreateQuickColorbox(panelName .. "ColorAttackingOthers", L["Attacking Others"], AlignmentColumn, panel.ColorAggroTransition, 16)
	panel.ColorAttackingOtherTank = CreateQuickColorbox(panelName .. "ColorAttackingOtherTank", L["Attacking Another Tank"], AlignmentColumn, panel.ColorAttackingOthers, 16)
	panel.ColorDangerGlowOnParty = CreateQuickCheckbutton(panelName .. "ColorDangerGlowOnParty", L["Show Warning around Group Members with Aggro"], AlignmentColumn, panel.ColorAttackingOtherTank)
	panel.ClassColorPartyMembers = CreateQuickCheckbutton(panelName .. "ClassColorPartyMembers", L["Show Class Color for Party and Raid Members"], AlignmentColumn, panel.ColorDangerGlowOnParty)

	--Widgets
	------------------------------
	panel.WidgetsLabel = CreateQuickHeadingLabel(nil, L["Widgets"], AlignmentColumn, panel.ClassColorPartyMembers, 0, 4)
	panel.WidgetTargetHighlight = CreateQuickCheckbutton(panelName .. "WidgetTargetHighlight", L["Show Highlight on Current Target"], AlignmentColumn, panel.WidgetsLabel)
	panel.WidgetEliteIndicator = CreateQuickCheckbutton(panelName .. "WidgetEliteIndicator", L["Show Elite Indicator"], AlignmentColumn, panel.WidgetTargetHighlight)
	panel.ClassEnemyIcon = CreateQuickCheckbutton(panelName .. "ClassEnemyIcon", L["Show Enemy Class Icons"], AlignmentColumn, panel.WidgetEliteIndicator)
	panel.ClassPartyIcon = CreateQuickCheckbutton(panelName .. "ClassPartyIcon", L["Show Party Member Class Icons"], AlignmentColumn, panel.ClassEnemyIcon)
	panel.WidgetsTotemIcon = CreateQuickCheckbutton(panelName .. "WidgetsTotemIcon", L["Show Totem Icons"], AlignmentColumn, panel.ClassPartyIcon)
	panel.WidgetsComboPoints = CreateQuickCheckbutton(panelName .. "WidgetsComboPoints", L["Show Combo Points"], AlignmentColumn, panel.WidgetsTotemIcon)
	panel.WidgetsThreatIndicator = CreateQuickCheckbutton(panelName .. "WidgetsThreatIndicator", L["Show Threat Indicator"], AlignmentColumn, panel.WidgetsComboPoints)
	panel.WidgetsThreatIndicatorMode = CreateQuickDropdown(panelName .. "WidgetsThreatIndicatorMode", L["Threat Indicator:"], ThreatModes, 1, AlignmentColumn, panel.WidgetsThreatIndicator, 16)
	panel.WidgetsRangeIndicator = CreateQuickCheckbutton(panelName .. "WidgetsRangeIndicator", L["Show Party Range Warning"], AlignmentColumn, panel.WidgetsThreatIndicatorMode)
	panel.WidgetsRangeMode = CreateQuickDropdown(panelName .. "WidgetsRangeMode", L["Range:"], RangeModes, 1, AlignmentColumn, panel.WidgetsRangeIndicator, 16)
	panel.WidgetsDebuff = CreateQuickCheckbutton(panelName .. "WidgetsDebuff", L["Show My Debuff Timers"], AlignmentColumn, panel.WidgetsRangeMode)
	panel.WidgetsDebuffMode = CreateQuickDropdown(panelName .. "WidgetsDebuffMode", L["Debuff Filter:"], DebuffModes, 1, AlignmentColumn, panel.WidgetsDebuff, 16)
	panel.WidgetsDebuffListLabel = CreateQuickItemLabel(nil, L["Debuff Names:"], AlignmentColumn, panel.WidgetsDebuffMode, 16)
	panel.WidgetsDebuffTrackList = CreateQuickEditbox(panelName .. "WidgetsDebuffTrackList", AlignmentColumn, panel.WidgetsDebuffListLabel, 16)
	-- TIP
	panel.WidgetsDebuffTrackListDescription = CreateQuickItemLabel(nil, L["WidgetsDebuffTrackList_Description"], AlignmentColumn, panel.WidgetsDebuffListLabel, 210)
	panel.WidgetsDebuffTrackListDescription:SetHeight(128)
	panel.WidgetsDebuffTrackListDescription:SetWidth(200)
	panel.WidgetsDebuffTrackListDescription.Text:SetJustifyV("TOP")

	--Frame
	------------------------------
	panel.FrameLabel = CreateQuickHeadingLabel(nil, L["Frame"], AlignmentColumn, panel.WidgetsDebuffTrackList, 0, 4)
	panel.FrameVerticalPosition = CreateQuickSlider(panelName .. "FrameVerticalPosition", L["Vertical Position of Artwork:"], AlignmentColumn, panel.FrameLabel, 0, 2)

	-- Slider Ranges
	SetSliderMechanics(panel.OpacityTarget, 1, 0, 1, .01)
	SetSliderMechanics(panel.OpacityNonTarget, 1, 0, 1, .01)
	SetSliderMechanics(panel.OpacitySpotlight, 1, 0, 1, .01)
	SetSliderMechanics(panel.OpacityFiltered, 1, 0, 1, .01)
	SetSliderMechanics(panel.ScaleStandard, 1, .1, 3, .01)
	SetSliderMechanics(panel.ScaleSpotlight, 1, .1, 3, .01)
	SetSliderMechanics(panel.FrameVerticalPosition, .5, 0, 1, .02)

	-- [[
	PasteThemeDataButton = CreateFrame("Button", panelName .. "PasteThemeDataButton", panel, "UIPanelButtonTemplate2")
	PasteThemeDataButton:SetPoint("TOPRIGHT", -6, -20)
	PasteThemeDataButton:SetWidth(60)
	PasteThemeDataButton:SetScale(.85)
	PasteThemeDataButton:SetText(L["Paste"])

	CopyThemeDataButton = CreateFrame("Button", panelName .. "CopyThemeDataButton", panel, "UIPanelButtonTemplate2")
	CopyThemeDataButton:SetPoint("TOPRIGHT", PasteThemeDataButton, "TOPLEFT", -4, 0)
	CopyThemeDataButton:SetWidth(60)
	CopyThemeDataButton:SetScale(.85)
	CopyThemeDataButton:SetText(L["Copy"])

	ReloadThemeDataButton = CreateFrame("Button", panelName .. "ReloadThemeDataButton", panel, "UIPanelButtonTemplate2")
	ReloadThemeDataButton:SetPoint("TOPRIGHT", CopyThemeDataButton, "TOPLEFT", -4, 0)
	ReloadThemeDataButton:SetWidth(60)
	ReloadThemeDataButton:SetScale(.85)
	ReloadThemeDataButton:SetText(L["Reset"])

	local yellow, blue, red, orange = "|cffffff00", "|cFF3782D1", "|cFFFF1100", "|cFFFF6906"
	ReloadThemeDataButton:SetScript("OnClick", function()
		if IsShiftKeyDown() then
			wipe(TidyPlatesHubTankSavedVariables)
			ReloadUI()
		else
			SetPanelValues(panel, TidyPlatesHubTankDefaults)
			OnPanelItemChange()
			print(L:F("commonResetPanel", yellow, orange, blue, L.Tank, yellow))
			print(L:F("resetTidyPlanelShift", yellow, blue, yellow, red, yellow))
		end
	end)

	PasteThemeDataButton:SetScript("OnClick", function()
		print(L:F("commonPastePanel", yellow, orange, blue, L.Damage, yellow))
		SetPanelValues(panel, TidyPlatesHubTankCache)
		OnPanelItemChange()
	end)

	CopyThemeDataButton:SetScript("OnClick", function()
		print(L:F("commonCopyPanel", yellow, orange, blue, L.Damage, yellow))
		GetPanelValues(panel, TidyPlatesHubTankCache, TidyPlatesHubTankSavedVariables)
	end)

	-----------------
	-- Button Handlers
	-----------------
	panel.okay = OnPanelItemChange
	panel.refresh = function()
		SetPanelValues(panel, TidyPlatesHubTankVariables)
	end

	-----------------
	-- Panel Event Handler
	-----------------
	panel:SetScript("OnEvent", function(self, event, ...)
		if event == "PLAYER_LOGIN" then
		elseif event == "PLAYER_ENTERING_WORLD" then
			GetSavedVariables(TidyPlatesHubTankVariables, TidyPlatesHubTankSavedVariables)
			CallForStyleUpdate()

			-- Convert old list values for Opacity Filter
			if
				TidyPlatesHubTankVariables.OpacityFilterCustom and
					type(TidyPlatesHubTankVariables.OpacityFilterCustom) == "table"
			 then
				local convertedValues = ""
				for i, v in pairs(TidyPlatesHubTankVariables.OpacityFilterCustom) do
					convertedValues = convertedValues .. tostring(i) .. "\n"
					TidyPlatesHubTankVariables.OpacityFilterCustom[i] = nil
				end
				TidyPlatesHubTankVariables.OpacityFilterCustom = nil
				TidyPlatesHubTankVariables.OpacityFilterList = convertedValues
			end

			-- Convert old list values for Debuff List
			if
				TidyPlatesHubTankVariables.WidgetsDebuffList and
					type(TidyPlatesHubTankVariables.WidgetsDebuffList) == "table"
			 then
				local convertedValues = ""
				for i, v in pairs(TidyPlatesHubTankVariables.WidgetsDebuffList) do
					convertedValues = convertedValues .. "\n" .. tostring(i)
					TidyPlatesHubTankVariables.WidgetsDebuffList[i] = nil
				end
				TidyPlatesHubTankVariables.WidgetsDebuffList = convertedValues
			end

			ConvertDebuffListTable(
				TidyPlatesHubTankVariables.WidgetsDebuffTrackList,
				TidyPlatesHubTankVariables.WidgetsDebuffLookup,
				TidyPlatesHubTankVariables.WidgetsDebuffPriority
			)
			ConvertStringToTable(
				TidyPlatesHubTankVariables.OpacityFilterList,
				TidyPlatesHubTankVariables.OpacityFilterLookup
			)
		end
	end)
	panel:RegisterEvent("PLAYER_LOGIN")
	panel:RegisterEvent("PLAYER_ENTERING_WORLD")
	panel:RegisterEvent("VARIABLES_LOADED")

	----------------
	-- Return a pointer to the whole thingy
	----------------
	InterfaceOptions_AddCategory(panel)
	return panel
end

-- Variable Loading
local function GetUpdatedVariablePointers()
	return TidyPlatesHubTankVariables, TidyPlatesHubTankSavedVariables
end

-- Create Instance of Panel
Panel = CreateInterfacePanel(
	"TidyPlatesHubTank",
	"Tidy Plates Hub: |cFF3782D1Tank",
	"Tidy Plates Hub: |cFF3782D1Tank",
	nil,
	GetUpdatedVariablePointers
)
function ShowTidyPlatesHubTankPanel()
	InterfaceOptionsFrame_OpenToCategory(Panel)
end
SLASH_HUBTANK1 = "/hubtank"
SlashCmdList["HUBTANK"] = ShowTidyPlatesHubTankPanel