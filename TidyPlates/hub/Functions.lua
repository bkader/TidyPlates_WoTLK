------------------------------------------------------
-- Tidy Plates Hub
------------------------------------------------------

TidyPlatesHubFunctions = {}
local LocalVars = TidyPlatesHubDamageVariables
local LocalRole = 1

local WidgetLib = TidyPlatesWidgets
local valueToString = TidyPlatesUtility.abbrevNumber
local EnableTankWatch = TidyPlatesWidgets.EnableTankWatch
local DisableTankWatch = TidyPlatesWidgets.DisableTankWatch
local IsTankedByAnotherTank = TidyPlatesWidgets.IsTankedByAnotherTank
local GetThreatCondition = TidyPlatesWidgets.GetThreatCondition
local IsTotem = TidyPlatesUtility.IsTotem
local IsAuraShown = TidyPlatesWidgets.IsAuraShown

local CreateThreatLineWidget = WidgetLib.CreateThreatLineWidget
local CreateAuraWidget = WidgetLib.CreateAuraWidget
local CreateClassWidget = WidgetLib.CreateClassWidget
local CreateRangeWidget = WidgetLib.CreateRangeWidget
local CreateComboPointWidget = WidgetLib.CreateComboPointWidget
local CreateTotemIconWidget = WidgetLib.CreateTotemIconWidget

local BlueColor = {r = 60 / 255, g = 168 / 255, b = 255 / 255}
local GreenColor = {r = 96 / 255, g = 224 / 255, b = 37 / 255}
local RedColor = {r = 255 / 255, g = 51 / 255, b = 32 / 255}
local YellowColor = {r = 252 / 255, g = 220 / 255, b = 27 / 255}
local GoldColor = {r = 252 / 255, g = 140 / 255, b = 0}
local OrangeColor = {r = 255 / 255, g = 64 / 255, b = 0}
local WhiteColor = {r = 250 / 255, g = 250 / 255, b = 250 / 255}

local function DummyFunction()
end

local White = {r = 1, g = 1, b = 1}
local Black = {r = 0, g = 0, b = 0}

---------------------------------------
-- Text
---------------------------------------
local function ShortenNumber(number)
	if number > 1000000 then
		return (ceil((number / 10000)) / 100) .. " M"
	elseif number > 1000 then
		return (ceil((number / 10)) / 100) .. " k"
	else
		return number
	end
end

local function SepThousands(n)
	local left, num, right = string.match(n, "^([^%d]*%d)(%d*)(.-)")
	return left .. (num:reverse():gsub("(%d%d%d)", "%1,"):reverse()) .. right
end

-- None
local function HealthFunctionNone()
	return ""
end
-- Percent
local function HealthFunctionPercent(unit)
	if unit.health < unit.healthmax then
		return ceil(100 * (unit.health / unit.healthmax)) .. "%"
	else
		return ""
	end
end
-- Actual
local function HealthFunctionExact(unit)
	return SepThousands(unit.health)
end
-- Approximate
local function HealthFunctionApprox(unit)
	return ShortenNumber(unit.health)
end
--Deficit
local function HealthFunctionDeficit(unit)
	local health, healthmax = unit.health, unit.healthmax
	if health ~= healthmax then
		return "-" .. SepThousands(healthmax - health)
	end
end
-- Total and Percent
local function HealthFunctionTotal(unit)
	local health, healthmax = unit.health, unit.healthmax
	return ShortenNumber(health) ..
		" / " .. ShortenNumber(healthmax) .. " (" .. ceil(100 * (health / healthmax)) .. "%)"
end
-- TargetOf
local function HealthFunctionTargetOf(unit)
	if unit.isTarget then
		return UnitName("targettarget")
	elseif unit.isMouseover then
		return UnitName("mouseovertarget")
	else
		return ""
	end
end

local HealthTextModeFunctions = {
	HealthFunctionNone,
	HealthFunctionPercent,
	HealthFunctionExact,
	HealthFunctionDeficit,
	HealthFunctionTotal,
	HealthFunctionTargetOf,
	HealthFunctionApprox
}

local function HealthTextDelegate(unit)
	return HealthTextModeFunctions[LocalVars.TextHealthTextMode](unit)
end

---------------------------------------
-- Scale
---------------------------------------

-- By Elite
local function ScaleFunctionByElite(unit)
	if unit.isElite then
		return LocalVars.ScaleSpotlight
	end
end

-- By Target
local function ScaleFunctionByTarget(unit)
	if unit.isTarget then
		return LocalVars.ScaleSpotlight
	end
end

-- By Threat (High) DPS Mode
local function ScaleFunctionByThreatHigh(unit)
	if InCombatLockdown() and unit.reaction == "HOSTILE" then
		if unit.type == "NPC" and unit.threatValue > 1 and unit.health > 2 then
			return LocalVars.ScaleSpotlight
		end
	end
end

-- By Threat (Low) Tank Mode
local function ScaleFunctionByThreatLow(unit)
	if InCombatLockdown() and unit.reaction == "HOSTILE" then
		if IsTankedByAnotherTank(unit) then
			return
		end
		if unit.type == "NPC" and unit.health > 2 and unit.threatValue < 2 then
			return LocalVars.ScaleSpotlight
		end
	end
end

-- By Debuff Widget
local function ScaleFunctionByActiveDebuffs(unit, frame)
	local widget = unit.frame.widgets.DebuffWidget
	--local widget = TidyPlatesWidgets.GetAuraWidgetByGUID(unit.guid)
	if IsAuraShown(widget) then
		return LocalVars.ScaleSpotlight
	end
end

-- By Enemy
local function ScaleFunctionByEnemy(unit)
	if unit.reaction ~= "FRIENDLY" then
		return LocalVars.ScaleSpotlight
	end
end

-- By NPC
local function ScaleFunctionByNPC(unit)
	if unit.type == "NPC" then
		return LocalVars.ScaleSpotlight
	end
end

-- By Raid Icon
local function ScaleFunctionByRaidIcon(unit)
	if unit.isMarked then
		return LocalVars.ScaleSpotlight
	end
end

local ScaleFunctionsDamage = {
	DummyFunction,
	ScaleFunctionByElite,
	ScaleFunctionByTarget,
	ScaleFunctionByThreatHigh,
	ScaleFunctionByActiveDebuffs,
	ScaleFunctionByEnemy,
	ScaleFunctionByNPC,
	ScaleFunctionByRaidIcon
}
local ScaleFunctionsTank = {
	DummyFunction,
	ScaleFunctionByElite,
	ScaleFunctionByTarget,
	ScaleFunctionByThreatLow,
	ScaleFunctionByActiveDebuffs,
	ScaleFunctionByEnemy,
	ScaleFunctionByNPC,
	ScaleFunctionByRaidIcon
}

-- Scale Functions Listed by Role order: Damage, Tank, Heal
local ScaleFunctions = {ScaleFunctionsDamage, ScaleFunctionsTank}

local function ScaleDelegate(...)
	local unit = ...
	local scale

	if LocalVars.ScaleIgnoreNonEliteUnits and (not unit.isElite) then
	elseif LocalVars.ScaleIgnoreNeutralUnits and unit.reaction == "NEUTRAL" then
	elseif
		LocalVars.ScaleIgnoreInactive and
			not (unit.reaction == "FRIENDLY" and
				(unit.isInCombat or (unit.threatValue > 0) or (unit.health < unit.healthmax)))
	 then
	else
		scale = ScaleFunctions[LocalRole][LocalVars.ScaleSpotlightMode](...)
	end
	return scale or LocalVars.ScaleStandard
end

---------------------------------------
-- Opacity / Alpha
---------------------------------------

-- By Threat (High)
local function AlphaFunctionByThreatHigh(unit)
	if InCombatLockdown() and unit.reaction == "HOSTILE" then
		if unit.threatValue > 1 and unit.health > 0 then
			return LocalVars.OpacitySpotlight
		end
	end
end

-- Tank Mode
local function AlphaFunctionByThreatLow(unit)
	if InCombatLockdown() and unit.reaction == "HOSTILE" then
		if IsTankedByAnotherTank(unit) then
			return
		end
		if unit.threatValue < 2 and unit.health > 0 then
			return LocalVars.OpacitySpotlight
		end
	end
end

local function AlphaFunctionByMouseover(unit)
	if unit.isMouseover then
		return LocalVars.OpacitySpotlight
	end
end

local function AlphaFunctionByEnemy(unit)
	if unit.reaction ~= "FRIENDLY" then
		return LocalVars.OpacitySpotlight
	end
end

local function AlphaFunctionByNPC(unit)
	if unit.type == "NPC" then
		return LocalVars.OpacitySpotlight
	end
end

local function AlphaFunctionByRaidIcon(unit)
	if unit.isMarked then
		return LocalVars.OpacitySpotlight
	end
end

local function AlphaFunctionByActive(unit)
	if (unit.health < unit.healthmax) or (unit.threatValue > 1) or unit.isInCombat or unit.isMarked then
		return LocalVars.OpacitySpotlight
	end
end

local function AlphaFunctionByActiveDebuffs(unit)
	local widget = unit.frame.widgets.DebuffWidget
	--local widget = TidyPlatesWidgets.GetAuraWidgetByGUID(unit.guid)
	if IsAuraShown(widget) then
		return LocalVars.OpacitySpotlight
	end
end

local function AlphaFilter(unit)
	if LocalVars.OpacityFilterLookup[unit.name] then
		return true
	elseif LocalVars.OpacityFilterNeutralUnits and unit.reaction == "NEUTRAL" then
		return true
	elseif LocalVars.OpacityFilterNonElite and (not unit.isElite) then
		return true
	elseif LocalVars.OpacityFilterInactive then
		if unit.reaction ~= "FRIENDLY" and not (unit.isInCombat or unit.threatValue > 0 or unit.health < unit.healthmax) then
			return true
		end
	end
end

local AlphaFunctionsDamage = {
	DummyFunction,
	AlphaFunctionByThreatHigh,
	AlphaFunctionByMouseover,
	AlphaFunctionByActiveDebuffs,
	AlphaFunctionByEnemy,
	AlphaFunctionByNPC,
	AlphaFunctionByRaidIcon,
	AlphaFunctionByActive
}
local AlphaFunctionsTank = {
	DummyFunction,
	AlphaFunctionByThreatLow,
	AlphaFunctionByMouseover,
	AlphaFunctionByActiveDebuffs,
	AlphaFunctionByEnemy,
	AlphaFunctionByNPC,
	AlphaFunctionByRaidIcon,
	AlphaFunctionByActive
}

-- Alpha Functions Listed by Role order: Damage, Tank, Heal
local AlphaFunctions = {AlphaFunctionsDamage, AlphaFunctionsTank}

local function Diminish(num)
	if num == 1 then
		return 1
	elseif num < .3 then
		return num * .60
	elseif num < .6 then
		return num * .70
	else
		return num * .80
	end
end

local function AlphaDelegate(...)
	local unit = ...
	local alpha

	if unit.isTarget then
		return Diminish(LocalVars.OpacityTarget)
	elseif unit.isCasting and LocalVars.OpacityFullSpell then
		return Diminish(LocalVars.OpacityTarget)
	else
		-- Filter
		if AlphaFilter(unit) then
			-- Spotlight
			alpha = LocalVars.OpacityFiltered
		else
			alpha = AlphaFunctions[LocalRole][LocalVars.OpacitySpotlightMode](...)
		end
	end

	if alpha then
		return Diminish(alpha)
	else
		if (not UnitExists("target")) and LocalVars.OpacityFullNoTarget then
			return Diminish(LocalVars.OpacityTarget)
		else
			return Diminish(LocalVars.OpacityNonTarget)
		end
	end
end

---------------------------------------
-- Health Bar Color
---------------------------------------

--"By Class"
local function ColorFunctionByClass(unit)
	return nil
end

local function ColorFunctionBlack()
	return Black
end

local function ColorFunctionsDamage(unit)
	if unit.threatValue > 1 then
		return LocalVars.ColorAttackingMe
	elseif unit.threatValue == 1 then
		return LocalVars.ColorAggroTransition
	else
		return LocalVars.ColorAttackingOthers
	end
end

local function ColorFunctionsTank(unit)
	if unit.threatValue > 2 then
		return LocalVars.ColorAttackingMe
	elseif unit.threatValue == 2 then
		return LocalVars.ColorAggroTransition
	else
		if IsTankedByAnotherTank(unit) then
			return LocalVars.ColorAttackingOtherTank
		end
		return LocalVars.ColorAttackingOthers
	end
end

-- By Threat Color Functions Listed by Role order: Damage, Tank, Heal
local ByThreatColorRoleFunctions = {ColorFunctionsDamage, ColorFunctionsTank}

--"By Aggro"
local function ColorFunctionByThreat(unit)
	if InCombatLockdown() and unit.reaction ~= "FRIENDLY" and unit.type == "NPC" then
		return ByThreatColorRoleFunctions[LocalRole](unit)
	end
end

--"By Reaction"
local ReactionColors = {
	["FRIENDLY"] = {
		["PLAYER"] = {r = 0, g = 0, b = 1},
		["NPC"] = {r = 0, g = 1, b = 0}
	},
	["HOSTILE"] = {
		["PLAYER"] = {r = 1, g = 0, b = 0},
		["NPC"] = {r = 1, g = 0, b = 0}
	},
	["NEUTRAL"] = {
		["NPC"] = {r = 1, g = 1, b = 0}
	}
}

local function ColorFunctionByReaction(unit)
	return ReactionColors[unit.reaction][unit.type]
end

local ColorFunctions = {DummyFunction, ColorFunctionByClass, ColorFunctionByThreat, ColorFunctionByReaction}

local SkyBlue = {r = .4, g = 0, b = 1}

local function HealthColorDelegate(unit)
	local color, color2

	if LocalVars.ClassColorPartyMembers and unit.reaction == "FRIENDLY" and unit.type == "PLAYER" then
		local class = TidyPlatesUtility.GroupMembers.Class[unit.name]
		if class then
			color = RAID_CLASS_COLORS[class]
		end
	else
		color = ColorFunctions[LocalVars.ColorHealthBarMode](unit)
	end

	if color then
		return color.r, color.g, color.b
	else
		return unit.red, unit.green, unit.blue
	end
end

---------------------------------------
-- Warning Border Color
---------------------------------------

-- "By Threat (High) Damage"
local function WarningBorderFunctionByThreatDamage(unit)
	if InCombatLockdown and unit.reaction ~= "FRIENDLY" and unit.type == "NPC" then
		if unit.threatValue > 0 then
			return ColorFunctionsDamage(unit)
		end
	end
end

-- "By Threat (Low) Tank"
local function WarningBorderFunctionByThreatTank(unit)
	if unit.InCombatLockdown and unit.reaction ~= "FRIENDLY" and unit.type == "NPC" then
		if unit.threatValue < 3 and not IsTankedByAnotherTank(unit) then
			return ColorFunctionsTank(unit)
		end
	end
end

local WarningBorderFunctionsDamage = {DummyFunction, WarningBorderFunctionByThreatDamage}
local WarningBorderFunctionsTank = {DummyFunction, WarningBorderFunctionByThreatTank}
local WarningBorderFunctions = {WarningBorderFunctionsDamage, WarningBorderFunctionsTank}

local function ThreatColorDelegate(unit)
	local color

	if LocalVars.ColorDangerGlowOnParty and unit.reaction == "FRIENDLY" then
		if GetThreatCondition(unit.name) then
			return 1, 0, 0, 1
		end
	end

	color = WarningBorderFunctions[LocalRole][LocalVars.ColorDangerGlowMode](unit)
	if color then
		return color.r, color.g, color.b, 1
	else
		return 0, 0, 0, 0
	end
end

---------------------------------------
-- Cast Bar Color
---------------------------------------
local function CastBarDelegate(unit)
	local color
	if unit.spellInterruptible then
		color = GoldColor
	else
		color = WhiteColor
	end
	return color.r, color.g, color.b, 1
end

---------------------------------------
-- Name Text Color
---------------------------------------
local NameReactionColors = {
	["FRIENDLY"] = {
		["PLAYER"] = {r = 60 / 255, g = 168 / 255, b = 255 / 255},
		["NPC"] = {r = 96 / 255, g = 224 / 255, b = 37 / 255}
	},
	["HOSTILE"] = {
		["PLAYER"] = {r = 255 / 255, g = 51 / 255, b = 32 / 255},
		["NPC"] = {r = 255 / 255, g = 51 / 255, b = 32 / 255}
	},
	["NEUTRAL"] = {
		["NPC"] = {r = 252 / 255, g = 180 / 255, b = 27 / 255}
	}
}

local NameColorFunctions = {
	-- Default
	function(unit)
		return White
	end,
	-- By Class
	function(unit)
		-- Friendly Units; Enemy units are taken care of via SetNameColorDelegate
		if unit.reaction == "FRIENDLY" and unit.type == "PLAYER" then
			local class = TidyPlatesUtility.GroupMembers.Class[unit.name] or TidyPlatesData.UnitClass[unit.name]

			if class then
				return RAID_CLASS_COLORS[class]
			else
				return NameReactionColors[unit.reaction][unit.type]
			end
		end
	end,
	-- By Threat
	function(unit)
		if InCombatLockdown() then
			return ColorFunctionByThreat(unit)
		else
			return NameReactionColors[unit.reaction][unit.type]
		end
	end,
	-- By Reaction
	function(unit)
		return NameReactionColors[unit.reaction][unit.type]
	end
}

local function SetNameColorDelegate(unit)
	local color = NameColorFunctions[LocalVars.TextNameColorMode](unit)
	if color then
		return color.r, color.g, color.b
	else
		return unit.red, unit.green, unit.blue
	end
end

---------------------------------------
-- Style
---------------------------------------

local StyleModeFunctions = {
	--	Full Bars and Widgets
	function(unit)
		return 1
	end,
	-- NameOnly
	function(unit)
		return 2
	end,
	-- Bars during combat
	function(unit)
		if InCombatLockdown() then
			return 1
		else
			return 2
		end
	end,
	-- Bars when unit is active or damaged
	function(unit)
		if (unit.health < unit.healthmax) or (unit.threatValue > 1) or unit.isInCombat or unit.isMarked then
			return 1
		end
		return 2
	end,
	-- elite units
	function(unit)
		if unit.isElite then
			return 1
		else
			return 2
		end
	end,
	-- marked
	function(unit)
		if unit.isMarked then
			return 1
		else
			return 2
		end
	end,
	-- player chars
	function(unit)
		if unit.type == "PLAYER" then
			return 1
		else
			return 2
		end
	end
}

local function StyleDelegate(unit)
	if unit.reaction == "FRIENDLY" then
		return StyleModeFunctions[LocalVars.StyleFriendlyMode](unit)
	else
		return StyleModeFunctions[LocalVars.StyleEnemyMode](unit)
	end
end

---------------------------------------
-- Widgets
---------------------------------------

local function GetPrefixPriority(debuff)
	local spellid = tostring(debuff.spellid)
	local name = debuff.name
	local prefix = LocalVars.WidgetsDebuffLookup[spellid] or LocalVars.WidgetsDebuffLookup[name]
	local priority = LocalVars.WidgetsDebuffPriority[spellid] or LocalVars.WidgetsDebuffPriority[name]
	return prefix, priority
end

local DebuffPrefixModes = {
	-- All
	function(debuff) return true end,
	-- My
	function(debuff) return (debuff.caster == UnitGUID("player")) or nil end,
	-- No
	function(debuff) return nil end,
	-- CC
	function(debuff) return true end,
	-- Other
	function(debuff) return (debuff.caster ~= UnitGUID("player")) end
}

local DebuffFilterModes = {
	-- All
	function(debuff)
		return true
	end,
	-- Specific
	function(debuff)
		local prefix, priority = GetPrefixPriority(debuff)
		if prefix then
			return true, priority
		end
	end,
	-- All mine
	function(debuff)
		if debuff.caster == UnitGUID("player") then
			return true
		end
	end,
	-- My specific
	function(debuff)
		local prefix, priority = GetPrefixPriority(debuff)
		if prefix and debuff.caster == UnitGUID("player") then
			return true, priority
		end
	end,
	-- By Prefix
	function(debuff)
		local prefix, priority = GetPrefixPriority(debuff)
		if prefix then
			return DebuffPrefixModes[prefix](debuff), priority
		end
	end
}

local AURA_TYPE_DEBUFF = 6
local AURA_TYPE_BUFF = 1
local AURA_TARGET_HOSTILE = 1
local AURA_TARGET_FRIENDLY = 2

local AURA_TYPE = {
	"Buff",
	"Curse",
	"Disease",
	"Magic",
	"Poison",
	"Debuff"
}

local function DebuffFilter(aura)
	-- Buffs/Hots on Friendly Units
	if aura.type == AURA_TYPE_BUFF then
		return true -- false
	end

	-- Debuffs on Friendly Units
	if aura.target == AURA_TARGET_FRIENDLY then
		return false
	end

	-- Debuffs on Hostile Units
	return DebuffFilterModes[LocalVars.WidgetsDebuffMode](aura)
end

local function AddClassIcon(plate, enable, config)
	if enable then
		if not plate.widgets.ClassIcon then
			local widget
			widget = CreateClassWidget(plate)
			widget:SetPoint(config.anchor or "TOP", plate, config.x or 0, config.y or 0) -- 0, 3)
			plate.widgets.ClassIcon = widget
		end
	elseif plate.widgets.ClassIcon then
		plate.widgets.ClassIcon:Hide()
		plate.widgets.ClassIcon = nil
	end
end

local function AddTotemIcon(plate, enable, config)
	if enable then
		if not plate.widgets.TotemIcon then
			local widget
			widget = CreateTotemIconWidget(plate)
			widget:SetPoint(config.anchor or "TOP", plate, config.x or 0, config.y or 0) --0, 3)
			plate.widgets.TotemIcon = widget
		end
	elseif plate.widgets.TotemIcon then
		plate.widgets.TotemIcon:Hide()
		plate.widgets.TotemIcon = nil
	end
end

local function AddComboPoints(plate, enable, config)
	if enable then
		if not plate.widgets.ComboWidget then
			local widget
			widget = CreateComboPointWidget(plate)
			widget:SetPoint(config.anchor or "TOP", plate, config.x or 0, config.y or 0) --0, 10)
			widget:SetFrameLevel(plate:GetFrameLevel() + 2)
			plate.widgets.ComboWidget = widget
		end
	elseif plate.widgets.ComboWidget then
		plate.widgets.ComboWidget:Hide()
		plate.widgets.ComboWidget = nil
	end
end

local function AddThreatLineWidget(plate, enable, config)
	if enable then
		if not plate.widgets.ThreatLineWidget then
			local widget
			widget = CreateThreatLineWidget(plate)
			widget:SetPoint(config.anchor or "TOP", plate, config.x or 0, config.y or 0)
			widget:SetFrameLevel(plate:GetFrameLevel() + 3)
			plate.widgets.ThreatLineWidget = widget
		end
	elseif plate.widgets.ThreatLineWidget then
		plate.widgets.ThreatLineWidget:Hide()
		plate.widgets.ThreatLineWidget = nil
	end
end

local function AddThreatWheelWidget(plate, enable, config)
	if enable then
		if not plate.widgets.ThreatWheelWidget then
			local widget
			widget = WidgetLib.CreateThreatWheelWidget(plate)
			widget:SetPoint(config.anchor or "TOP", plate, config.x or 0, config.y or 0)
			widget:SetFrameLevel(plate:GetFrameLevel() + 3)
			plate.widgets.ThreatWheelWidget = widget
		end
	elseif plate.widgets.ThreatWheelWidget then
		plate.widgets.ThreatWheelWidget:Hide()
		plate.widgets.ThreatWheelWidget = nil
	end
end

local RangeModeRef = {9, 15, 28, 40}
local function AddRangeWidget(plate, enable, config)
	if enable then
		if not plate.widgets.RangeWidget then
			local widget
			widget = CreateRangeWidget(plate)
			widget:SetPoint(config.anchor or "CENTER", config.x or 0, config.y or 0)
			plate.widgets.RangeWidget = widget
		end
	elseif plate.widgets.RangeWidget then
		plate.widgets.RangeWidget:Hide()
		plate.widgets.RangeWidget = nil
	end
end

local function AddDebuffWidget(plate, enable, config)
	if enable then
		if not plate.widgets.DebuffWidget then
			local widget
			widget = CreateAuraWidget(plate)
			widget:SetPoint(config.anchor or "TOP", plate, config.x or 0, config.y or 0)
			widget:SetFrameLevel(plate:GetFrameLevel() + 1)
			widget.Filter = DebuffFilter
			plate.widgets.DebuffWidget = widget
		end
	elseif plate.widgets.DebuffWidget then
		plate.widgets.DebuffWidget:Hide()
		plate.widgets.DebuffWidget = nil
	end
end

---------------------------------------
-- Widget Activation
---------------------------------------

local function OnInitializeWidgets(plate, configTable)
	AddClassIcon(plate, (LocalVars.ClassEnemyIcon or LocalVars.ClassPartyIcon), configTable.ClassIcon)
	AddTotemIcon(plate, LocalVars.WidgetsTotemIcon, configTable.TotemIcon)
	AddThreatWheelWidget(
		plate,
		LocalVars.WidgetsThreatIndicator and (LocalVars.WidgetsThreatIndicatorMode == 2),
		configTable.ThreatWheelWidget
	)
	AddThreatLineWidget(
		plate,
		LocalVars.WidgetsThreatIndicator and (LocalVars.WidgetsThreatIndicatorMode == 1),
		configTable.ThreatLineWidget
	)
	AddComboPoints(plate, LocalVars.WidgetsComboPoints, configTable.ComboWidget)
	AddRangeWidget(plate, LocalVars.WidgetsRangeIndicator, configTable.RangeWidget)
	AddDebuffWidget(plate, LocalVars.WidgetsDebuff, configTable.DebuffWidget)
end

local function OnContextUpdateDelegate(plate, unit)
	local Widgets = plate.widgets
	if LocalVars.WidgetsComboPoints then
		Widgets.ComboWidget:UpdateContext(unit)
	end
	if (LocalVars.WidgetsThreatIndicatorMode == 1) and LocalVars.WidgetsThreatIndicator then
		Widgets.ThreatLineWidget:UpdateContext(unit)
	end -- Tug-O-Threat
	if LocalVars.WidgetsDebuff then
		Widgets.DebuffWidget:UpdateContext(unit)
	end
end

local function OnUpdateDelegate(plate, unit)
	local Widgets = plate.widgets
	if LocalVars.WidgetsRangeIndicator then
		Widgets.RangeWidget:Update(unit, RangeModeRef[LocalVars.RangeMode])
	end
	if LocalVars.ClassEnemyIcon or LocalVars.ClassPartyIcon then
		Widgets.ClassIcon:Update(unit, LocalVars.ClassPartyIcon)
	end
	if LocalVars.WidgetsTotemIcon then
		Widgets.TotemIcon:Update(unit)
	end
	if (LocalVars.WidgetsThreatIndicatorMode == 2) and LocalVars.WidgetsThreatIndicator then
		plate.widgets.ThreatWheelWidget:Update(unit)
	end -- Threat Wheel
end

local function EnableWatchers()
	TidyPlatesUtility:EnableGroupWatcher()
	TidyPlatesUtility:EnableUnitCache()
	if LocalVars.WidgetsDebuff then
		TidyPlatesWidgets:EnableAuraWatcher()
	else
		TidyPlatesWidgets:DisableAuraWatcher()
	end
	TidyPlatesWidgets:EnableTankWatch()
end

local function UseDamageVariables()
	LocalVars = TidyPlatesHubDamageVariables
	LocalRole = 1
	EnableWatchers()
	return TidyPlatesHubDamageVariables
end

local function UseTankVariables()
	LocalVars = TidyPlatesHubTankVariables
	LocalRole = 2
	EnableWatchers()
	return TidyPlatesHubTankVariables
end

---------------
-- Function List
---------------
TidyPlatesHubFunctions.SetMultistyle = StyleDelegate
TidyPlatesHubFunctions.SetScale = ScaleDelegate
TidyPlatesHubFunctions.SetNameColor = SetNameColorDelegate
TidyPlatesHubFunctions.SetAlpha = AlphaDelegate
TidyPlatesHubFunctions.SetCustomText = HealthTextDelegate
TidyPlatesHubFunctions.OnUpdate = OnUpdateDelegate
TidyPlatesHubFunctions.OnInitializeWidgets = OnInitializeWidgets
TidyPlatesHubFunctions.SetHealthbarColor = HealthColorDelegate
TidyPlatesHubFunctions.SetThreatColor = ThreatColorDelegate
TidyPlatesHubFunctions.OnContextUpdate = OnContextUpdateDelegate
TidyPlatesHubFunctions.SetCastbarColor = CastBarDelegate
TidyPlatesHubFunctions.UseDamageVariables = UseDamageVariables
TidyPlatesHubFunctions.UseTankVariables = UseTankVariables
TidyPlatesHubFunctions._WidgetDebuffFilter = DebuffFilter