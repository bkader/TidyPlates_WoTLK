-------------------------------------------------------------------------------
-- 1. alpha.lua
--

do
	local function SetAlpha(unit)
		local db = TidyPlatesThreat.db.profile
		local T = TPTP_UnitType(unit)
		local style = SetStyleThreatPlates(unit)
		local nonTargetAlpha
		if not unit.isTarget and db.blizzFade.toggle and UnitExists("target") then
			nonTargetAlpha = db.blizzFade.amount
		else
			nonTargetAlpha = 0
		end
		if style == "unique" then
			for k_c, k_v in pairs(db.uniqueSettings.list) do
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
						elseif (not unit.isElite and not unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE")) then
							return ((db.nameplate.alpha["Normal"] + nonTargetAlpha) or 1), db.blizzFade.toggle
						elseif unit.reaction == "NEUTRAL" then
							return ((db.nameplate.alpha["Neutral"] + nonTargetAlpha) or 1), db.blizzFade.toggle
						end
					end
				end
			end
		elseif style == "normal" then
			if T then
				return (db.nameplate.alpha[T] + nonTargetAlpha), db.blizzFade.toggle
			else
				return 1
			end
		elseif style == "empty" then
			return 0, db.blizzFade.toggle
		elseif ((style == "tank" or style == "dps") and db.threat.useAlpha) then
			if unit.isMarked and TidyPlatesThreat.db.profile.threat.marked.alpha then
				return (db.nameplate.alpha["Marked"] + nonTargetAlpha), db.blizzFade.toggle
			else
				return (db.threat[style].alpha[unit.threatSituation] + nonTargetAlpha), db.blizzFade.toggle
			end
		else
			if T then
				return (db.nameplate.alpha[T] + nonTargetAlpha), db.blizzFade.toggle
			else
				return 1
			end
		end
	end

	TidyPlatesThreat.SetAlpha = SetAlpha
end

-------------------------------------------------------------------------------
-- 2. scale.lua
--

do
	local function TypeScale(unit)
		local db = TidyPlatesThreat.db.profile.threat
		local T = TPTP_UnitType(unit)
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
				elseif (not unit.isElite and not unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE")) then
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
		local T = TPTP_UnitType(unit)
		local style = SetStyleThreatPlates(unit)
		if style == "unique" then
			for k_c, k_v in pairs(db.uniqueSettings.list) do
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
						elseif (not unit.isElite and not unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE")) then
							return ((db.nameplate.scale["Normal"]) or 1)
						elseif unit.reaction == "NEUTRAL" then
							return ((db.nameplate.scale["Neutral"]) or 1)
						end
					end
				end
			end
		elseif style == "normal" then
			return db.nameplate.scale[(unit.isTarget and "Target" or T)] or 1
		elseif (style == "tank" or style == "dps") and db.threat.useScale then
			local targetscale = unit.isTarget and db.nameplate.scale.Target or 0

			if unit.isMarked and db.threat.marked.scale then
				return (db.nameplate.scale.Marked > targetscale) and db.nameplate.scale.Marked or targetscale
			else
				local scale = db.threat[style].scale[unit.threatSituation]
				return (((scale > targetscale) and scale or targetscale) + TypeScale(unit))
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
end

-------------------------------------------------------------------------------
-- 3. healthtext.lua
--

do
	local Truncate = function(value)
		if TidyPlatesThreat.db.profile.text.truncate then
			if value >= 1e6 then
				return format("%.1fm", value / 1e6)
			elseif value >= 1e4 then
				return format("%.1fk", value / 1e3)
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
						HpPct = floor(100 * (unit.health / unit.healthmax)) .. "%"
					else
						HpPct = " - " .. floor(100 * (unit.health / unit.healthmax)) .. "%"
					end
				else
					HpPct = floor(100 * (unit.health / unit.healthmax)) .. "%"
				end
			else
				HpPct = ""
			end
			if TidyPlatesThreat.db.profile.text.amount then
				if TidyPlatesThreat.db.profile.text.deficit then
					if (unit.health == unit.healthmax) then
						HpAmt = ""
					else
						HpAmt = "-" .. Truncate(unit.healthmax - unit.health)
					end
				else
					HpAmt = Truncate(unit.health)
				end
			else
				HpAmt = ""
			end
			if TidyPlatesThreat.db.profile.text.max then
				if TidyPlatesThreat.db.profile.text.amount then
					if TidyPlatesThreat.db.profile.text.deficit and unit.health == unit.healthmax then
						HpMax = Truncate(unit.healthmax)
					else
						HpMax = " / " .. Truncate(unit.healthmax)
					end
				else
					HpMax = Truncate(unit.healthmax)
				end
			else
				HpMax = ""
			end
			if TidyPlatesThreat.db.profile.settings.customtext.show then
				if (unit.health / unit.healthmax) < 1 then
					return HpAmt .. HpMax .. HpPct
				else
					if TidyPlatesThreat.db.profile.text.full then
						return HpAmt .. HpMax .. HpPct
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
end

-------------------------------------------------------------------------------
-- 4. healthbarcolor.lua
--

do
	TidyPlatesUtility:EnableGroupWatcher()
	TidyPlatesWidgets:EnableAuraWatcher()
	TidyPlatesWidgets:EnableTankWatch()

	local isTanked = TidyPlatesWidgets.IsTankedByAnotherTank

	local TotemNameFallback = TidyPlatesUtility.TotemNameFallback

	local function SetHealthbarColor(unit)
		local db = TidyPlatesThreat.db.profile
		local style = SetStyleThreatPlates(unit)
		if style == "totem" or style == "etotem" then
			if db.settings.raidicon.hpColor and unit.isMarked then
				local R = db.settings.raidicon.hpMarked[unit.raidIcon]
				return R.r, R.g, R.b
			else
				local tS = db.totemSettings[TPtotemList[unit.name] or TPtotemList[TotemNameFallback(unit.name)]]
				if tS[2] then
					c = tS.color
					return c.r, c.g, c.b
				else
					return unit.red, unit.green, unit.blue
				end
			end
		elseif style == "unique" then
			for k_c, k_v in pairs(db.uniqueSettings.list) do
				if k_v == unit.name then
					local u = db.uniqueSettings[k_c]
					if u.useColor then
						if u.allowMarked and unit.isMarked and db.settings.raidicon.hpColor then
							local R = db.settings.raidicon.hpMarked[unit.raidIcon]
							return R.r, R.g, R.b
						else
							local c = u.color
							return c.r, c.g, c.b
						end
					elseif not u.useColor then
						if u.allowMarked and unit.isMarked and db.settings.raidicon.hpColor then
							local R = db.settings.raidicon.hpMarked[unit.raidIcon]
							return R.r, R.g, R.b
						elseif not unit.isMarked and db.threat.useHPColor and InCombatLockdown() and db.threat.ON then
							if TidyPlatesThreat.db.char.threat.tanking then
								if unit.threatValue < 2 then
									if isTanked(unit) then
										local S = db.tHPbarColor
										return S.r, S.b, S.b
									else
										local T = db.settings["tank"].threatcolor[unit.threatSituation]
										return T.r, T.g, T.b
									end
								else
									local T = db.settings["tank"].threatcolor[unit.threatSituation]
									return T.r, T.g, T.b
								end
							else
								local T = db.settings["dps"].threatcolor[unit.threatSituation]
								return T.r, T.g, T.b
							end
						else
							return unit.red, unit.green, unit.blue
						end
					end
				end
			end
		elseif (((style == "tank") or (style == "dps")) and db.threat.useHPColor and InCombatLockdown()) then
			if db.settings.raidicon.hpColor and unit.isMarked then
				local R = db.settings.raidicon.hpMarked[unit.raidIcon]
				return R.r, R.g, R.b
			else
				local T = db.settings[style].threatcolor[unit.threatSituation]
				return T.r, T.g, T.b
			end
		else
			if db.settings.raidicon.hpColor and unit.isMarked then
				local R = db.settings.raidicon.hpMarked[unit.raidIcon]
				return R.r, R.g, R.b
			else
				if db.healthColorChange then
					local pct = unit.health / unit.healthmax
					return (1 - pct), (0 + pct), 0
				elseif db.customColor then
					if unit.reaction == "FRIENDLY" then
						if db.friendlyClass then
							if TidyPlatesThreat.db.profile.cache[unit.name] then
								local class = TidyPlatesThreat.db.profile.cache[unit.name]
								local c = RAID_CLASS_COLORS[class]
								return c.r, c.g, c.b
							elseif unit.guid and GetPlayerInfoByGUID(unit.guid) and not TidyPlatesThreat.db.profile.cache[unit.name] then
								local _, class = GetPlayerInfoByGUID(unit.guid)
								local c = RAID_CLASS_COLORS[class]
								if db.cacheClass then
									TidyPlatesThreat.db.profile.cache[unit.name] = class
								end
								return c.r, c.g, c.b
							else
								local d = db.fHPbarColor
								return d.r, d.g, d.b
							end
						else
							local d = db.fHPbarColor
							return d.r, d.g, d.b
						end
					elseif unit.reaction == "NEUTRAL" then
						local n = db.nHPbarColor
						return n.r, n.g, n.b
					else
						local c = db.HPbarColor
						if unit.class and (unit.class == "UNKNOWN") then
							if not db.allowClass then
								return c.r, c.g, c.b
							else
								return unit.red, unit.green, unit.blue
							end
						else
							return unit.red, unit.green, unit.blue
						end
					end
				elseif unit.class and (unit.class ~= "UNKNOWN") then
					local c = RAID_CLASS_COLORS[unit.class]
					if not db.allowClass then
						return 1, 0, 0
					else
						return unit.red, unit.green, unit.blue
					end
				elseif TidyPlatesThreat.db.profile.cache[unit.name] and db.friendlyClass then
					local class = TidyPlatesThreat.db.profile.cache[unit.name]
					local c = RAID_CLASS_COLORS[class]
					return c.r, c.g, c.b
				elseif
					unit.guid and GetPlayerInfoByGUID(unit.guid) and not TidyPlatesThreat.db.profile.cache[unit.name] and
						db.friendlyClass
				 then
					local _, class = GetPlayerInfoByGUID(unit.guid)
					local c = RAID_CLASS_COLORS[class]
					if db.cacheClass then
						TidyPlatesThreat.db.profile.cache[unit.name] = class
					end
					return c.r, c.g, c.b
				else
					return unit.red, unit.green, unit.blue
				end
			end
		end
	end

	TidyPlatesThreat.SetHealthbarColor = SetHealthbarColor
end

-------------------------------------------------------------------------------
-- 5. castbarcolor.lua
--

do
	local function SetCastbarColor(unit)
		local db = TidyPlatesThreat.db.profile
		local c = {r = 1, g = 1, b = 0, a = 1}
		if db.castbarColor.toggle and not unit.spellIsShielded then
			c = db.castbarColor
		elseif db.castbarColorShield.toggle and db.castbarColor.toggle and unit.spellIsShielded then
			c = db.castbarColorShield
		end
		return c.r, c.g, c.b, c.a
	end

	TidyPlatesThreat.SetCastbarColor = SetCastbarColor
end

-------------------------------------------------------------------------------
-- 6. nametextcolor.lua
--

do
	local IsInGroup = TidyPlatesUtility.IsInGroup
	local GetGroupTypeAndCount = TidyPlatesUtility.GetGroupTypeAndCount

	local function SetNameColor(unit)
		local db = TidyPlatesThreat.db.profile
		local color = db.settings.name.color
		local r, g, b = color.r, color.g, color.b

		if unit and unit.reaction == "FRIENDLY" and db.friendlyNameOnly then
			if unit.type == "PLAYER" then
				if db.cache[unit.name] then
					local class = db.cache[unit.name]
					local c = RAID_CLASS_COLORS[class]
					r, g, b = c.r, c.g, c.b
				elseif unit.guid and GetPlayerInfoByGUID(unit.guid) and not db.cache[unit.name] then
					local _, class = GetPlayerInfoByGUID(unit.guid)
					local c = RAID_CLASS_COLORS[class]
					if db.cacheClass then
						db.cache[unit.name] = class
					end
					r, g, b = c.r, c.g, c.b
				elseif IsInGroup() then
					local prefix, min_member, max_member = GetGroupTypeAndCount()
					for i = min_member, max_member do
						if UnitExists(prefix .. i) and UnitName(prefix .. i) == unit.name then
							local class = select(2, UnitClass(prefix .. i))
							local c = RAID_CLASS_COLORS[class]
							if db.cacheClass then
								db.cache[unit.name] = class
							end
							r, g, b = c.r, c.g, c.b
							break
						end
					end
				end
			elseif unit.type == "NPC" then
				r, g, b = 0.2, 0.6, 0.1
			else
				r, g, b = db.fHPbarColor.r, db.fHPbarColor.g, db.fHPbarColor.b
			end
		end
		return r, g, b
	end

	TidyPlatesThreat.SetNameColor = SetNameColor
end

-------------------------------------------------------------------------------
-- 7. threatcolor.lua
--

do
	local function SetThreatColor(unit)
		local style = SetStyleThreatPlates(unit)
		local color = {r = "0", g = "0", b = "0", a = "0"}
		if style == "dps" or style == "tank" or style == "normal" and InCombatLockdown() then
			color = TidyPlatesThreat.db.profile.settings[style]["threatcolor"][unit.threatSituation]
		end
		return color.r, color.g, color.b, color.a
	end

	TidyPlatesThreat.SetThreatColor = SetThreatColor
end

-------------------------------------------------------------------------------
-- 8. shapeshifts.lua
--

do
	local _, class = UnitClass("player")
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
end