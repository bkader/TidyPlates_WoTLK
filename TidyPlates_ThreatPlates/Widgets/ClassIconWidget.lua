-----------------------
-- Class Icon Widget --
-----------------------
local path = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\ClassIconWidget\\"

local function UpdateClassIconWidget(frame, unit)
	local db = TidyPlatesThreat.db.profile
	if db.classWidget.ON then
		if unit.class and (unit.class ~= "UNKNOWN") then
			frame.Icon:SetTexture(path..db.classWidget.theme.."\\"..unit.class) 
			frame:Show()
		elseif db.cache[unit.name] and db.friendlyClassIcon then
			local class = db.cache[unit.name]
			frame.Icon:SetTexture(path..db.classWidget.theme.."\\"..class)
			frame:Show()
		elseif unit.guid and not db.cache[unit.name] and db.friendlyClassIcon then
			_, engClass = GetPlayerInfoByGUID(unit.guid)
			if engClass then
				frame.Icon:SetTexture(path..db.classWidget.theme.."\\"..engClass)
				frame:Show()
			end
		else 
			frame:Hide() 		
		end
	else 
		frame:Hide() 
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
