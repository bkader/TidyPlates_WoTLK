local function TypeScale(unit)
	local db = TidyPlatesThreat.db.profile.threat
	local T =  TPTP_UnitType(unit)
	if db.useType then
		if T == "Neutral" then
			return db.scaleType["Normal"]
		elseif T == "Normal" or T == "Elite" or T == "Boss" then
			return db.scaleType[T]
		elseif T == "Unique" then
			if (unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE")) then
				return db.scaleType["Boss"]
			elseif (unit.isElite and not unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE")) then
				return db.scaleType["Elite"]
			elseif (not unit.isElite and not unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE"))then
				return db.scaleType["Normal"]
			elseif unit.reaction == "NEUTRAL" then
				return db.scaleType["Normal"]
			end
		end
	else		
		return 0
	end
end

local function SetScale(unit)
	local db = TidyPlatesThreat.db.profile
	local T =  TPTP_UnitType(unit)
	local style = SetStyleThreatPlates(unit)
	if style == "unique" then
		for k_c,k_v in pairs(db.uniqueSettings.list) do
			if k_v == unit.name then
				local u = db.uniqueSettings[k_c]
				if not u.overrideScale then
					return u.scale
				elseif db.threat.ON and InCombatLockdown and db.threat.useScale and u.overrideScale then
					if unit.isMarked and db.threat.marked.scale then
						return (db.nameplate.scale["Marked"])
					else
						if TidyPlatesThreat.db.char.threat.tanking then
							return (db.threat["tank"].scale[unit.threatSituation] + (TypeScale(unit)))
						else
							return (db.threat["dps"].scale[unit.threatSituation] + (TypeScale(unit)))
						end
					end
				elseif not InCombatLockdown() and u.overrideScale then
					if (unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE")) then
						return ((db.nameplate.scale["Boss"]) or 1)
					elseif (unit.isElite and not unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE")) then
						return ((db.nameplate.scale["Elite"]) or 1)
					elseif (not unit.isElite and not unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE"))then
						return ((db.nameplate.scale["Normal"]) or 1)
					elseif unit.reaction == "NEUTRAL" then
						return ((db.nameplate.scale["Neutral"]) or 1)
					end
				end
			end
		end
	elseif style == "normal" then
		return db.nameplate.scale[T]
	elseif (style == "tank" or style == "dps") and db.threat.useScale then
		if unit.isMarked and db.threat.marked.scale then
			return db.nameplate.scale["Marked"]
		else
			return ( db.threat[style].scale[unit.threatSituation] + (TypeScale(unit)))
		end
	else 
		if db.nameplate.scale then
			return (db.nameplate.scale[T] or 1)
		else
			return 1
		end
	end
end

TidyPlatesThreat.SetScale = SetScale