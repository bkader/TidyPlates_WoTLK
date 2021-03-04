local function SetAlpha(unit)
	local db = TidyPlatesThreat.db.profile
	local T =  TPTP_UnitType(unit)
	local style = SetStyleThreatPlates(unit)
	local nonTargetAlpha
	if not unit.isTarget and db.blizzFade.toggle and UnitExists("target") then
		nonTargetAlpha = db.blizzFade.amount
	else
		nonTargetAlpha = 0
	end
	if style == "unique" then
		for k_c,k_v in pairs(db.uniqueSettings.list) do
			if k_v == unit.name then
				u = db.uniqueSettings[k_c]
				if not u.overrideAlpha then
					return (u.alpha + nonTargetAlpha), db.blizzFade.toggle
				elseif db.threat.ON and InCombatLockdown() and db.threat.useAlpha and u.overrideAlpha then
					if unit.isMarked and TidyPlatesThreat.db.profile.threat.marked.alpha then
						return (db.nameplate.alpha["Marked"] + nonTargetAlpha), db.blizzFade.toggle
					else
						if TidyPlatesThreat.db.char.threat.tanking then
							return (db.threat["tank"].alpha[unit.threatSituation] + nonTargetAlpha), db.blizzFade.toggle
						else
							return (db.threat["dps"].alpha[unit.threatSituation] + nonTargetAlpha), db.blizzFade.toggle
						end
					end
				elseif not InCombatLockdown() and u.overrideAlpha then
					if (unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE")) then
						return ((db.nameplate.alpha["Boss"] + nonTargetAlpha) or 1), db.blizzFade.toggle
					elseif (unit.isElite and not unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE")) then
						return ((db.nameplate.alpha["Elite"] + nonTargetAlpha) or 1), db.blizzFade.toggle
					elseif (not unit.isElite and not unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE"))then
						return ((db.nameplate.alpha["Normal"] + nonTargetAlpha) or 1), db.blizzFade.toggle
					elseif unit.reaction == "NEUTRAL" then
						return ((db.nameplate.alpha["Neutral"] + nonTargetAlpha) or 1), db.blizzFade.toggle
					end
				end
			end
		end
	elseif style == "normal" then
		if T then return (db.nameplate.alpha[T] + nonTargetAlpha), db.blizzFade.toggle else return 1 end
	elseif style == "empty" then
		return 0, db.blizzFade.toggle
	elseif ((style == "tank" or style == "dps") and db.threat.useAlpha) then
		if unit.isMarked and TidyPlatesThreat.db.profile.threat.marked.alpha then
			return (db.nameplate.alpha["Marked"] + nonTargetAlpha), db.blizzFade.toggle
		else
			return (db.threat[style].alpha[unit.threatSituation] + nonTargetAlpha), db.blizzFade.toggle
		end
	else 
		if T then return (db.nameplate.alpha[T] + nonTargetAlpha), db.blizzFade.toggle else return 1 end
	end
end

TidyPlatesThreat.SetAlpha = SetAlpha