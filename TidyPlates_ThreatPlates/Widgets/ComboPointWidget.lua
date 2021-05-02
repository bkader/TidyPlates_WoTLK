------------------------
-- Combo Point Widget --
------------------------
local path = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\ComboPointWidget\\"
local COMBO_ART = {"1", "2", "3", "4", "5"}

local WidgetList = {}

local function UpdateWidgetFrame(frame)
	local points
	if UnitExists("target") then
		points = GetComboPoints("player", "target")
	end
	if points and points > 0 and TidyPlatesThreat.db.profile.comboWidget.ON then
		frame.Icon:SetTexture(path .. COMBO_ART[points])
		frame:Show()
	else
		frame:_Hide()
	end
end

local function UpdateWidgetContext(frame, unit)
	local guid = unit.guid
	frame.guid = guid

	if guid then
		WidgetList[guid] = frame
	end

	if UnitGUID("target") == guid then
		UpdateWidgetFrame(frame)
	else
		frame:_Hide()
	end
end

local function ClearWidgetContext(frame)
	local guid = frame.guid
	if guid then
		WidgetList[guid] = nil
		frame.guid = nil
	end
end

local WatcherFrame = CreateFrame("Frame", nil, WorldFrame)
local isEnabled = false
WatcherFrame:RegisterEvent("UNIT_COMBO_POINTS")

local function WatcherFrameHandler(frame, event, unitid)
	local guid = UnitGUID("target")
	if guid then
		local widget = WidgetList[guid]
		if widget then
			UpdateWidgetFrame(widget)
		end
	end
end

local function EnableWatcherFrame(arg)
	if arg then
		WatcherFrame:SetScript("OnEvent", WatcherFrameHandler)
		isEnabled = true
	else
		WatcherFrame:SetScript("OnEvent", nil)
		isEnabled = false
	end
end

-- Widget Creation
local function CreateWidgetFrame(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:Hide()

	frame:SetHeight(64)
	frame:SetWidth(64)
	frame.Icon = frame:CreateTexture(nil, "OVERLAY")
	frame.Icon:SetAllPoints(frame)

	frame.UpdateContext = UpdateWidgetContext
	frame.Update = UpdateWidgetContext
	frame._Hide = frame.Hide
	frame.Hide = function()
		ClearWidgetContext(frame)
		frame:_Hide()
	end
	if not isEnabled then
		EnableWatcherFrame(true)
	end
	return frame
end

ThreatPlatesWidgets.CreateComboPointWidget = CreateWidgetFrame