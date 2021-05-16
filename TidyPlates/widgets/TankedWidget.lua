do
	local artpath = "Interface\\Addons\\TidyPlates\\widgets\\MainTanked\\"
	local shieldArt = artpath .. "Shield"
	local knifeArt = artpath .. "Knife"
	local artname

	local function UpdateTankedWidget(frame, unit)
		local unitid
		if unit.reaction == "FRIENDLY" or (not InCombatLockdown()) then
			frame:Hide()
			return
		end

		if unit.isTarget then
			unitid = "target"
		elseif unit.isMouseover then
			unitid = "mouseover"
		else
			return
		end

		if unitid and unit.guid then
			local targetID = unitid .. "target"
			if UnitExists(targetID) then
				if UnitInRaid(targetID) and (GetPartyAssignment("MAINTANK", targetID) or GetPartyAssignment("MAINASSIST", targetID)) or ("TANK" == UnitGroupRolesAssigned(targetID)) then
					artname = shieldArt
				else
					artname = knifeArt
				end

				frame.icon:SetTexture(artpath .. "Shield")
				frame.FadeTime = GetTime() + 2
				frame:HideIn(frame.FadeTime)
				frame:Show()
			else
				frame:Hide()
			end
		elseif (GetTime() > frame.FadeTime) then
			frame:Hide()
		end
	end

	local function CreateTankedWidget(parent)
		-- Init Widget
		local frame = CreateFrame("Frame", nil, parent)
		frame.FadeTime = 0
		frame:SetWidth(26)
		frame:SetHeight(26)
		-- Tank Icon
		frame.icon = frame:CreateTexture(nil, "OVERLAY")
		frame.icon:SetTexture(artname)
		frame.icon:SetAllPoints(frame)
		frame.icon:Hide()
		-- Update
		frame.HideIn = TidyPlatesWidgets.HideIn
		frame.Update = UpdateTankedWidget
		frame:Hide()
		return frame
	end

	TidyPlatesWidgets.CreateTankedWidget = CreateTankedWidget
end