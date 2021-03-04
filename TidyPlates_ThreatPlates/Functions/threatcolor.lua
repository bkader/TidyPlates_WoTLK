local function SetThreatColor(unit)
	local style = SetStyleThreatPlates(unit)
	local color = {r = "0", g = "0", b = "0", a = "0"}
	if style == "dps" or style == "tank" or style == "normal" and InCombatLockdown() then
		color = TidyPlatesThreat.db.profile.settings[style]["threatcolor"][unit.threatSituation]
	end
	return color.r, color.g, color.b, color.a	
end

TidyPlatesThreat.SetThreatColor = SetThreatColor