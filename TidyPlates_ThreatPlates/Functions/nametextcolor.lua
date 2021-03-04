local function SetNameColor(unit)
	local db = TidyPlatesThreat.db.profile.settings.name.color
	return db.r, db.g, db.b
end

TidyPlatesThreat.SetNameColor = SetNameColor