local function SetCastbarColor(unit)
	local db = TidyPlatesThreat.db.profile
	local c = {r = 1,g = 1,b = 0,a = 1}
	if db.castbarColor.toggle and not unit.spellIsShielded then
		c = db.castbarColor
	elseif db.castbarColorShield.toggle and db.castbarColor.toggle and unit.spellIsShielded then
		c = db.castbarColorShield
	end
	return c.r, c.g, c.b, c.a
end

TidyPlatesThreat.SetCastbarColor = SetCastbarColor