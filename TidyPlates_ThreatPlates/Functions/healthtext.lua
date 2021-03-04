local Truncate = function(value)
	if TidyPlatesThreat.db.profile.text.truncate then
		if value >= 1e6 then
			return format('%.1fm', value / 1e6)
		elseif value >= 1e4 then
			return format('%.1fk', value / 1e3)
		else
			return value
		end
	else 
		return value
	end
end

local function SetCustomText(unit)
	local HpPct = ""
	local HpAmt = ""
	local HpMax = ""
	if unit.health then
		if TidyPlatesThreat.db.profile.text.percent then
			if (TidyPlatesThreat.db.profile.text.amount or TidyPlatesThreat.db.profile.text.max) then
				if TidyPlatesThreat.db.profile.text.deficit and not TidyPlatesThreat.db.profile.text.max and unit.health == unit.healthmax then
					HpPct = floor(100*(unit.health / unit.healthmax)).."%"
				else
					HpPct = " - "..floor(100*(unit.health / unit.healthmax)).."%"
				end
			else
				HpPct = floor(100*(unit.health / unit.healthmax)).."%"
			end
		else
			HpPct = ""
		end
		if TidyPlatesThreat.db.profile.text.amount then
			if TidyPlatesThreat.db.profile.text.deficit then
				if (unit.health == unit.healthmax) then
					HpAmt = ""
				else
					HpAmt = "-"..Truncate(unit.healthmax - unit.health)
				end
			else
				HpAmt = Truncate(unit.health)
			end
		else HpAmt = ""
		end
		if TidyPlatesThreat.db.profile.text.max then
			if TidyPlatesThreat.db.profile.text.amount then
				if TidyPlatesThreat.db.profile.text.deficit and unit.health == unit.healthmax then
					HpMax = Truncate (unit.healthmax)
				else
					HpMax = " / "..Truncate(unit.healthmax)
				end
			else 
				HpMax = Truncate(unit.healthmax)
			end
		else 
			HpMax = ""
		end
		if TidyPlatesThreat.db.profile.settings.name.show then
			if (unit.health / unit.healthmax) < 1 then
				return HpAmt..HpMax..HpPct
			else
				if TidyPlatesThreat.db.profile.text.full then
					return HpAmt..HpMax..HpPct
				else 
					return ""
				end
			end
		else 
			return ""
		end
	else
		return ""
	end
end

TidyPlatesThreat.SetCustomText = SetCustomText