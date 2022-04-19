TidyPlatesUtility = {}

local _

-------------------------------------------------------------------------------------
--  General Helpers
-------------------------------------------------------------------------------------
local copytable
copytable = function(original)
	local duplicate = {}
	for key, value in pairs(original) do
		if type(value) == "table" then
			duplicate[key] = copytable(value)
		else
			duplicate[key] = value
		end
	end
	return duplicate
end

local function mergetable(master, mate)
	local merged = {}
	local matedata
	for key, value in pairs(master) do
		if type(value) == "table" then
			matedata = mate[key]
			if type(matedata) == "table" then
				merged[key] = mergetable(value, matedata)
			else
				merged[key] = copytable(value)
			end
		else
			matedata = mate[key]
			if matedata == nil then
				merged[key] = master[key]
			else
				merged[key] = matedata
			end
		end
	end
	return merged
end

local function updatetable(original, added)
	-- Check for exist
	if not (original or added) then
		return original
	end
	if not (type(original) == "table" and type(added) == "table") then
		return original
	end
	local originalval

	for index, var in pairs(original) do
		if type(var) == "table" then
			original[index] = updatetable(var, added[index]) or var
		else
			if added[index] ~= nil then
				original[index] = added[index]
			else
				original[index] = original[index]
			end
		end
	end
	return original
end

local function valueToString(value)
	if value ~= nil then
		if value >= 1000000 then
			return format("%.1fm", value / 1000000)
		elseif value >= 1000 then
			return format("%.1fk", value / 1000)
		else
			return value
		end
	end
end

TidyPlatesUtility.abbrevNumber = valueToString
TidyPlatesUtility.copyTable = copytable
TidyPlatesUtility.mergeTable = mergetable
TidyPlatesUtility.updateTable = updatetable

------------------------
-- Threat Function
------------------------
do
	local function GetRelativeThreat(unit)
		if not UnitExists(unit) then
			return
		end
		local group, size

		local playerthreat, leaderThreat, tempthreat, petthreat, leaderUnitID = 0, 0, 0, 0, nil
		local playerThreatVal, leaderThreatVal = 0, 0

		local leader = nil

		-- Request Player Threat
		_, _, playerthreat, _, playerThreatVal = UnitDetailedThreatSituation("player", unit)
		-- Request Pet Threat
		if HasPetUI() then
			_, _, petthreat = UnitDetailedThreatSituation("pet", unit)
			leaderThreat = petthreat or 0
			leaderUnitID = "pet"
		end
		-- Get Group Type
		if UnitInRaid("player") then
			group = "raid"
			size = GetNumRaidMembers() - 1
		elseif UnitInParty("player") then
			group = "party"
			size = GetNumPartyMembers()
		else
			group = nil
		end
		-- Cycle through Group, picking highest threat holder
		if group then
			for index = 1, size do
				local unitid = group .. index
				_, _, tempthreat = UnitDetailedThreatSituation(unitid, unit)
				if tempthreat and tempthreat > leaderThreat then
					leaderThreat = tempthreat
					leaderUnitID = unitid
				end
			end
		end

		if playerthreat and leaderThreat and leaderUnitID then
			_, _, leaderThreatVal = UnitDetailedThreatSituation(leaderUnitID, unit)
			leaderThreatVal = leaderThreatVal or 0

			if playerthreat == 100 then
				return playerthreat + (100 - leaderThreat), nil, playerThreatVal - leaderThreatVal
			else
				return playerthreat, leaderUnitID, -(leaderThreatVal - playerThreatVal)
			end
		else
			return
		end
	end

	TidyPlatesUtility.GetRelativeThreat = GetRelativeThreat
end

------------------------
-- Group Functions
------------------------
do
	local GetNumRaidMembers, GetNumPartyMembers = GetNumRaidMembers, GetNumPartyMembers

	local function IsInRaid()
		return (GetNumRaidMembers() > 0)
	end

	local function IsInGroup()
		return (GetNumRaidMembers() > 0 or GetNumPartyMembers() > 0)
	end

	local function UnitInGroup(unit)
		return IsInRaid() and (UnitInRaid(unit) ~= nil) or (UnitInParty(unit) == 1)
	end

	local UnitIterator
	do
		local rmem, pmem, step, count

		local function SelfIterator(excPets)
			while step do
				local unit, owner
				if step == 1 then
					unit, owner, step = "player", nil, 2
				elseif step == 2 then
					if not excPets then
						unit, owner = "playerpet", "player"
					end
					step = nil
				end
				if unit and UnitExists(unit) then
					return unit, owner
				end
			end
		end

		local function PartyIterator(excPets)
			while step do
				local unit, owner
				if step <= 2 then
					unit, owner = SelfIterator(excPets)
					step = step or 3
				elseif step == 3 then
					unit, owner, step = format("party%d", count), nil, 4
				elseif step == 4 then
					if not excPets then
						unit, owner = format("partypet%d", count), format("party%d", count)
					end
					count = count + 1
					step = count <= pmem and 3 or nil
				end
				if unit and UnitExists(unit) then
					return unit, owner
				end
			end
		end

		local function RaidIterator(excPets)
			while step do
				local unit, owner
				if step == 1 then
					unit, owner, step = format("raid%d", count), nil, 2
				elseif step == 2 then
					if not excPets then
						unit, owner = format("raidpet%d", count), format("raid%d", count)
					end
					count = count + 1
					step = count <= rmem and 1 or nil
				end
				if unit and UnitExists(unit) then
					return unit, owner
				end
			end
		end

		function UnitIterator(excPets)
			rmem, step = GetNumRaidMembers(), 1
			if rmem == 0 then
				pmem = GetNumPartyMembers()
				if pmem == 0 then
					return SelfIterator, excPets
				end
				count = 1
				return PartyIterator, excPets
			end
			count = 1
			return RaidIterator, excPets
		end
	end

	TidyPlatesUtility.IsInRaid = IsInRaid
	TidyPlatesUtility.IsInGroup = IsInGroup
	TidyPlatesUtility.UnitInGroup = UnitInGroup
	TidyPlatesUtility.UnitIterator = UnitIterator
end

------------------------------------------------------------------
-- Panel Helpers (Used to create interface panels)
------------------------------------------------------------------

local function CreatePanelFrame(self, reference, listname, title)
	local panelframe = CreateFrame("Frame", reference, UIParent)
	panelframe.name = listname
	panelframe.Label = panelframe:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	panelframe.Label:SetPoint("TOPLEFT", panelframe, "TOPLEFT", 16, -16)
	panelframe.Label:SetHeight(15)
	panelframe.Label:SetWidth(350)
	panelframe.Label:SetJustifyH("LEFT")
	panelframe.Label:SetJustifyV("TOP")
	panelframe.Label:SetText(title or listname)
	return panelframe
end

local function CreateDescriptionFrame(self, reference, parent, title, text)
	local descframe = CreateFrame("Frame", reference, parent)
	descframe:SetHeight(15)
	descframe:SetWidth(200)

	descframe.Label = descframe:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	descframe.Label:SetAllPoints()
	descframe.Label:SetJustifyH("LEFT")
	descframe.Label:SetText(title)

	descframe.Description = descframe:CreateFontString(nil, "ARTWORK", "GameFontWhiteSmall")
	descframe.Description:SetPoint("TOPLEFT")
	descframe.Description:SetPoint("BOTTOMRIGHT")
	descframe.Description:SetJustifyH("LEFT")
	descframe.Description:SetJustifyV("TOP")
	descframe.Description:SetText(text)
	--
	return descframe
end

local function CreateCheckButton(self, reference, parent, label)
	local checkbutton = CreateFrame("CheckButton", reference, parent, "InterfaceOptionsCheckButtonTemplate")
	_G[reference .. "Text"]:SetText(label)
	checkbutton.GetValue = function()
		return (checkbutton:GetChecked() == 1)
	end
	checkbutton.SetValue = checkbutton.SetChecked

	return checkbutton
end

local function CreateRadioButtons(self, reference, parent, numberOfButtons, defaultButton, spacing, list, label)
	local radioButtonSet = {}

	for index = 1, numberOfButtons do
		radioButtonSet[index] = CreateFrame("CheckButton", reference .. index, parent, "UIRadioButtonTemplate")
		radioButtonSet[index].Label = _G[reference .. index .. "Text"]
		radioButtonSet[index].Label:SetText(list[index] or " ")
		radioButtonSet[index].Label:SetWidth(250)
		radioButtonSet[index].Label:SetJustifyH("LEFT")

		if index > 1 then
			radioButtonSet[index]:SetPoint("TOP", radioButtonSet[index - 1], "BOTTOM", 0, -(spacing or 10))
		end

		radioButtonSet[index]:SetScript("OnClick", function(self)
			for button = 1, numberOfButtons do
				radioButtonSet[button]:SetChecked(false)
			end
			self:SetChecked(true)
		end)
	end

	radioButtonSet.GetChecked = function()
		for index = 1, numberOfButtons do
			if radioButtonSet[index]:GetChecked() then
				return index
			end
		end
	end

	radioButtonSet.SetChecked = function(self, number)
		for index = 1, numberOfButtons do
			radioButtonSet[index]:SetChecked(false)
		end
		radioButtonSet[number]:SetChecked(true)
	end

	radioButtonSet[defaultButton]:SetChecked(true)
	radioButtonSet.GetValue = radioButtonSet.GetChecked
	radioButtonSet.SetValue = radioButtonSet.SetChecked

	return radioButtonSet
end

local function CreateSliderFrame(self, reference, parent, label, val, minval, maxval, step, mode)
	local slider = CreateFrame("Slider", reference, parent, "OptionsSliderTemplate")
	slider:SetWidth(100)
	slider:SetHeight(15)
	slider:SetMinMaxValues(minval or 0, maxval or 1)
	slider:SetValueStep(step or .1)
	slider:SetValue(val or .5)
	slider:SetOrientation("HORIZONTAL")
	slider:Enable()
	-- Labels
	slider.Label = slider:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	slider.Label:SetPoint("TOPLEFT", -5, 18)
	slider.Low = _G[reference .. "Low"]
	slider.High = _G[reference .. "High"]
	slider.Label:SetText(label or "")
	-- Value
	slider.Value = slider:CreateFontString(nil, "ARTWORK", "GameFontWhite")
	slider.Value:SetPoint("BOTTOM", 0, -10)
	slider.Value:SetWidth(50)
	--slider.Value
	if mode and mode == "ACTUAL" then
		slider.Value:SetText(tostring(ceil(val)))
		slider:SetScript("OnValueChanged", function()
			local v = tostring(ceil(slider:GetValue()))
			slider.Value:SetText(v)
		end)
		slider.Low:SetText(ceil(minval or 0))
		slider.High:SetText(ceil(maxval or 1))
	else
		slider.Value:SetText(tostring(ceil(100 * (val or .5))))
		slider:SetScript("OnValueChanged", function()
			slider.Value:SetText(tostring(ceil(100 * slider:GetValue())) .. "%")
		end)
		slider.Low:SetText(ceil((minval or 0) * 100) .. "%")
		slider.High:SetText(ceil((maxval or 1) * 100) .. "%")
	end

	return slider
end

-- http://www.wowwiki.com/UI_Object_UIDropDownMenu
-- item.fontObject
local function CreateDropdownFrame(helpertable, reference, parent, menu, default, label, byName)
	local dropdown = CreateFrame("Frame", reference, parent, "UIDropDownMenuTemplate")
	local index, item
	dropdown.Text = _G[reference .. "Text"]
	if byName then
		dropdown.Text:SetText(default)
	else
		dropdown.Text:SetText(menu[default].text)
	end
	dropdown.Text:SetWidth(100)
	dropdown:SetWidth(120)

	if label then
		dropdown.Label = dropdown:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		dropdown.Label:SetPoint("TOPLEFT", 18, 18)
		dropdown.Label:SetText(label)
	end

	dropdown.Value = default

	-- Injects the init function into the template
	dropdown.initialize = function(self, level)
		for index, item in pairs(menu) do
			item.func = function(self)
				dropdown.Text:SetText(item.text)
				dropdown.Value = index
				if dropdown.OnValueChanged then
					dropdown.OnValueChanged()
				end
			end
			UIDropDownMenu_AddButton(item, level)
		end
	end

	dropdown.SetValue = function(self, value)
		if byName then
			dropdown.Text:SetText(value)
		else
			dropdown.Text:SetText(menu[value].text)
			dropdown.Value = value
		end
	end

	dropdown.GetValue = function()
		if byName then
			return dropdown.Text:GetText()
		else
			return dropdown.Value
		end
	end

	return dropdown
end

local CreateColorBox
do
	local workingFrame
	local function ChangeColor(cancel)
		local a, r, g, b
		if cancel then
			workingFrame:SetBackdropColor(unpack(ColorPickerFrame.startingval))
		else
			a, r, g, b = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB()
			workingFrame:SetBackdropColor(r, g, b, 1 - a)
			if workingFrame.OnValueChanged then
				workingFrame:OnValueChanged()
			end
		end
	end

	local function ShowColorPicker(frame)
		local r, g, b, a = frame:GetBackdropColor()
		workingFrame = frame
		ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = ChangeColor, ChangeColor, ChangeColor
		ColorPickerFrame.startingval = {r, g, b, a}
		ColorPickerFrame:SetColorRGB(r, g, b)
		ColorPickerFrame.hasOpacity = true
		ColorPickerFrame.opacity = 1 - a
		ColorPickerFrame:SetFrameStrata(frame:GetFrameStrata())
		ColorPickerFrame:SetFrameLevel(frame:GetFrameLevel() + 1)
		ColorPickerFrame:Hide()
		ColorPickerFrame:Show() -- Need to activate the OnShow handler.
	end

	function CreateColorBox(self, reference, parent, label, r, g, b, a)
		local colorbox = CreateFrame("Button", reference, parent)
		colorbox:SetWidth(24)
		colorbox:SetHeight(24)
		colorbox:SetBackdrop({
			bgFile = "Interface\\ChatFrame\\ChatFrameColorSwatch",
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
			tile = false,
			tileSize = 16,
			edgeSize = 8,
			insets = {left = 1, right = 1, top = 1, bottom = 1}
		})
		colorbox:SetBackdropColor(r, g, b, a)
		colorbox:SetScript("OnClick", function() ShowColorPicker(colorbox) end)
		-- Label
		colorbox.Label = colorbox:CreateFontString(nil, "ARTWORK", "GameFontWhiteSmall")
		colorbox.Label:SetPoint("TOPLEFT", colorbox, "TOPRIGHT", 4, -7)
		colorbox.Label:SetText(label)

		colorbox.GetValue = function()
			local color = {}
			color.r, color.g, color.b, color.a = colorbox:GetBackdropColor()
			return color
		end
		colorbox.SetValue = function(self, color)
			colorbox:SetBackdropColor(color.r, color.g, color.b, color.a)
		end

		return colorbox
	end
end

PanelHelpers = {}

PanelHelpers.CreatePanelFrame = CreatePanelFrame
PanelHelpers.CreateDescriptionFrame = CreateDescriptionFrame
PanelHelpers.CreateCheckButton = CreateCheckButton
PanelHelpers.CreateRadioButtons = CreateRadioButtons
PanelHelpers.CreateSliderFrame = CreateSliderFrame
PanelHelpers.CreateDropdownFrame = CreateDropdownFrame
PanelHelpers.CreateColorBox = CreateColorBox

TidyPlatesUtility.PanelHelpers = PanelHelpers

local function StartMovement(frame)
	-- Store Original Point to frame.OriginalAnchor
	frame:StartMoving()
	local OriginalAnchor = frame.OriginalAnchor

	if not OriginalAnchor.point then
		OriginalAnchor.point,
			OriginalAnchor.relativeTo,
			OriginalAnchor.relativePoint,
			OriginalAnchor.xOfs,
			OriginalAnchor.yOfs = frame:GetPoint(1)
	end
end

local function FinishMovement(frame)
	-- Store New Screen-RelativePosition to frame.NewAnchor
	local NewAnchor = frame.NewAnchor
	local OriginalAnchor = frame.OriginalAnchor
	NewAnchor.point, NewAnchor.relativeTo, NewAnchor.relativePoint, NewAnchor.xOfs, NewAnchor.yOfs = frame:GetPoint(1)
	frame:StopMovingOrSizing()
end

local function EnableFreePositioning(frame)
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetScript("OnMouseDown", StartMovement)
	frame:SetScript("OnMouseUp", FinishMovement)
	frame.OriginalAnchor = {}
	frame.NewAnchor = {}
end

PanelHelpers.EnableFreePositioning = EnableFreePositioning

----------------------
-- Call In() - Registers a callback, which hides the specified frame in X seconds
----------------------
do
	local CallList = {} -- Key = Frame, Value = Expiration Time
	setmetatable(CallList, {__mode = "kv"}) -- TODO: keep an eye on weak tables.

	local Watcherframe = CreateFrame("Frame")
	local WatcherframeActive = false
	local select = select
	local timeToUpdate = 0

	local function CheckWatchList(self)
		local curTime = GetTime()
		if curTime < timeToUpdate then
			return
		end
		local count = 0
		timeToUpdate = curTime + 1
		-- Cycle through the watchlist
		for func, expiration in pairs(CallList) do
			if expiration < curTime then
				CallList[func] = nil
				func()
			else
				count = count + 1
			end
		end
		-- If no more frames to watch, unregister the OnUpdate script
		if count == 0 then
			Watcherframe:SetScript("OnUpdate", nil)
		end
	end

	local function CallIn(func, expiration)
		-- Register Frame
		CallList[func] = expiration + GetTime()
		-- Init Watchframe
		if not WatcherframeActive then
			Watcherframe:SetScript("OnUpdate", CheckWatchList)
			WatcherframeActive = true
		end
	end

	TidyPlatesUtility.CallIn = CallIn
end

-------------------------------------------------------------------------------------
--  ShareMedia
-------------------------------------------------------------------------------------
do
	local LSM = LibStub("LibSharedMedia-3.0")

	local function MediaFetch(mediatype, key, default)
		return (key and LSM:Fetch(mediatype, key)) or (default and LSM:Fetch(mediatype, default)) or default
	end

	local function MediaList(mediatype)
		return LSM:HashTable(mediatype)
	end

	local function MediaRegister(mediatype, key, path)
		return LSM:Register(mediatype, key, path)
	end

	TidyPlatesUtility.MediaFetch = MediaFetch
	TidyPlatesUtility.MediaList = MediaList
	TidyPlatesUtility.MediaRegister = MediaRegister
end

-------------------------------------------------------------------------------------
--  Weak Tables
-------------------------------------------------------------------------------------
do
	local tablePool = {}
	setmetatable(tablePool, {__mode = "k"})

	local function new()
		local t = next(tablePool) or {}
		tablePool[t] = nil
		return t
	end

	local function del(t, deep)
		if type(t) == "table" then
			for k, v in pairs(t) do
				if deep and type(v) == "table" then
					del(v)
				end
				t[k] = nil
			end
			t[""] = true
			t[""] = nil
			tablePool[t] = true
		end
		return nil
	end

	TidyPlatesUtility.weaktable = {__mode = "v"}
	TidyPlatesUtility.NewTable = new
	TidyPlatesUtility.DelTable = del
end