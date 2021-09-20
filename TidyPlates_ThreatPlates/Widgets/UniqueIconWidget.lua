---------------
-- Unique Icon Widget
---------------
local db
local function UpdateUniqueIconWidget(self, unit)
	db = TidyPlatesThreat.db.profile
	if db.uniqueWidget.ON then
		if tContains(db.uniqueSettings.list, unit.name) then
			for k_c, k_v in pairs(db.uniqueSettings.list) do
				if k_v == unit.name then
					if db.uniqueSettings[k_c].icon and db.uniqueSettings[k_c].showIcon then
						if tonumber(db.uniqueSettings[k_c].icon) == nil then
							self.Icon:SetTexture(db.uniqueSettings[k_c].icon)
						else
							local icon = select(3, GetSpellInfo(tonumber(db.uniqueSettings[k_c].icon)))
							self.Icon:SetTexture(icon or "Interface\\Icons\\Temp")
						end
						self:Show()
					else
						self:Hide()
					end
				end
			end
		else
			self:Hide()
		end
	else
		self:Hide()
	end
end

local function CreateUniqueIconWidget(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(64)
	frame:SetHeight(64)
	frame.Icon = frame:CreateTexture(nil, "OVERLAY")
	frame.Icon:SetPoint("CENTER", frame)
	frame.Icon:SetAllPoints(frame)
	frame:Hide()
	frame.Update = UpdateUniqueIconWidget
	return frame
end

ThreatPlatesWidgets.CreateUniqueIconWidget = CreateUniqueIconWidget