local _,class = UnitClass("player")
local AuraType = {
	DEATHKNIGHT = "presences",
	DRUID = "shapeshifts",
	PALADIN = "auras",
	WARRIOR = "stances"
}
local function ShapeshiftUpdate()
	local _db = TidyPlatesThreat.db.char[AuraType[class]]	
	if _db.ON then
		TidyPlatesThreat.db.char.threat.tanking = _db[GetShapeshiftForm()]
		TidyPlates:ReloadTheme()
		TidyPlates:ForceUpdate()
	end
end

TidyPlatesThreat.ShapeshiftUpdate = ShapeshiftUpdate