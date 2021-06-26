-----------------------
-- Class Icon Widget --
-----------------------
local path = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\ClassIconWidget\\"

local function noop()
	return
end

local function UpdateClassIconWidget(frame, unit)
	local db = TidyPlatesThreat.db.profile
	if db.classWidget.ON then
		if unit.class and (unit.class ~= "UNKNOWN") then
			frame.Icon:SetTexture(path .. db.classWidget.theme .. "\\" .. unit.class)
			frame:Show()
		elseif db.cache[unit.name] and db.friendlyClassIcon then
			local class = db.cache[unit.name]
			frame.Icon:SetTexture(path .. db.classWidget.theme .. "\\" .. class)
			frame:Show()
		elseif unit.guid and not db.cache[unit.name] and db.friendlyClassIcon then
			local engClass = select(2, GetPlayerInfoByGUID(unit.guid))
			if engClass then
				frame.Icon:SetTexture(path .. db.classWidget.theme .. "\\" .. engClass)
				frame:Show()
			end
		else
			frame:Hide()
		end
	else
		frame:Hide()
	end

	-- hack to move friendly class icons above names.
	if frame:IsShown() and unit.reaction == "FRIENDLY" and unit.type == "PLAYER" then
		if db.friendlyNameOnly then
			if not frame.moved then
				frame:ClearAllPoints()
				frame:SetPoint("BOTTOM", frame:GetParent(), "BOTTOM", 0, 20)
				frame.moved = true
				frame._SetPoint = frame.SetPoint
				frame.SetPoint = noop
				frame._SetAllPoints = frame.SetAllPoints
				frame.SetAllPoints = noop
			end
		elseif frame._SetPoint and frame.moved then
			frame.SetPoint = frame._SetPoint
			frame.SetAllPoints = frame._SetAllPoints
			frame:ClearAllPoints()
			frame:SetPoint("CENTER", frame:GetParent(), "CENTER", -74, 7)
			frame.moved = nil
		end
	end
end

local function CreateClassIconWidget(parent)
	local db = TidyPlatesThreat.db.profile.classWidget
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetHeight(64)
	frame:SetWidth(64)
	frame.Icon = frame:CreateTexture(nil, "OVERLAY")
	frame.Icon:SetAllPoints(frame)
	frame:Hide()
	frame.Update = UpdateClassIconWidget
	return frame
end

ThreatPlatesWidgets.CreateClassIconWidget = CreateClassIconWidget