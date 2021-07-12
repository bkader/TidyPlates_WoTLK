-- Tidy Plates - Dedicated to the loves-of-my-life..
--------------------------------------------------------------------------------------------------------------
-- I. Variables and Functions
--------------------------------------------------------------------------------------------------------------
local addonName, TidyPlates = ...
_G.TidyPlates = TidyPlates

local _
local numChildren = -1
local activetheme = {}
local massQueue, targetQueue, functionQueue = {}, {}, {}
local ForEachPlate
local EMPTY_TEXTURE = "Interface\\Addons\\TidyPlates\\Media\\Empty"
local select, pairs, tostring = select, pairs, tostring
local CreateTidyPlatesStatusbar = CreateTidyPlatesStatusbar
local Plates, PlatesVisible, PlatesFading, GUID = {}, {}, {}, {}
local nameplate, extended, bars, regions, visual
local unit, unitcache, style, stylename, unitchanged
local currentTarget
local extendedSetAlpha, HighlightIsShown, HighlightSetAlpha
local PlateSetAlpha, PlateGetAlpha
local InCombat, HasTarget = false, false
TidyPlates.InCombat = InCombat

----------------------------
-- Internal Functions
----------------------------
-- Simple Functions
local function ClearIndices(t)
	if t then
		for i, v in pairs(t) do
			t[i] = nil
		end
		return t
	end
end
local function IsPlateShown(plate)
	return plate and plate:IsShown()
end
local function SetTargetQueue(plate, func)
	if func then
		targetQueue[plate] = func
	end
end
local function SetMassQueue(func)
	if func then
		massQueue[func] = true
	end
end
local function SetFunctionQueue(func)
	if func then
		functionQueue[func] = true
	end
end

-- Indicator Functions
local UpdateIndicator_CustomScaleText, UpdateIndicator_Standard, UpdateIndicator_CustomAlpha
local UpdateIndicator_Level, UpdateIndicator_ThreatGlow, UpdateIndicator_RaidIcon, UpdateIndicator_EliteIcon, UpdateIndicator_UnitColor, UpdateIndicator_Name
local UpdateIndicator_HealthBar, UpdateHitboxShape

-- Data and Condition Functions
local OnNewNameplate, OnShowNameplate, OnHideNameplate, OnUpdateNameplate, OnResetNameplate, OnEchoNewNameplate
local OnUpdateHealth, OnUpdateLevel, OnUpdateThreatSituation, OnUpdateRaidIcon, OnUpdateHealthRange
local OnMouseoverNameplate, OnRequestWidgetUpdate, OnRequestDelegateUpdate

-- Spell Casting
local UpdateCastAnimation, UpdateChannelAnimation, StartCastAnimation, StopCastAnimation, OnUpdateTargetCastbar

-- Main Loop
local OnUpdate
local ApplyPlateExtension

--------------------------------------------------------------------------------------------------------------
-- II. Frame/Layer Appearance Functions:  These functions set the appearance of specific object types
--------------------------------------------------------------------------------------------------------------

local function SetObjectShape(object, width, height)
	object:SetWidth(width)
	object:SetHeight(height)
end
local function SetObjectFont(object, font, size, flags)
	object:SetFont(font, size, flags)
end
local function SetObjectJustify(object, horz, vert)
	object:SetJustifyH(horz)
	object:SetJustifyV(vert)
end
local function SetObjectShadow(object, shadow)
	if shadow then
		object:SetShadowColor(0, 0, 0, tonumber(shadow) or 1)
		object:SetShadowOffset(.5, -.5)
	else
		object:SetShadowColor(0, 0, 0, 0)
	end
end
local function SetObjectAnchor(object, anchor, anchorTo, x, y)
	object:ClearAllPoints()
	object:SetPoint(anchor, anchorTo, anchor, x, y)
end
local function SetObjectTexture(object, texture)
	object:SetTexture(texture)
	object:SetTexCoord(0, 1, 0, 1)
end
local function SetObjectBartexture(obj, tex, ori, crop)
	obj:SetStatusBarTexture(tex)
	obj:SetOrientation(ori)
end

-- SetFontGroupObject
local function SetFontGroupObject(object, objectstyle)
	SetObjectFont(object, objectstyle.typeface, objectstyle.size, objectstyle.flags)
	SetObjectJustify(object, objectstyle.align, objectstyle.vertical)
	SetObjectShadow(object, objectstyle.shadow)
end

-- SetAnchorGroupObject
local function SetAnchorGroupObject(object, objectstyle, anchorTo)
	SetObjectShape(object, objectstyle.width, objectstyle.height) --end
	SetObjectAnchor(object, objectstyle.anchor, anchorTo, objectstyle.x, objectstyle.y)
end

-- SetBarGroupObject
local backdropTable = {}
local function SetBarGroupObject(object, objectstyle, anchorTo)
	SetObjectShape(object, objectstyle.width, objectstyle.height)
	SetObjectAnchor(object, objectstyle.anchor, anchorTo, objectstyle.x, objectstyle.y)
	SetObjectBartexture(object, objectstyle.texture, objectstyle.orientation, objectstyle.texcoord)
	backdropTable.bgFile = objectstyle.backdrop
	object:SetBackdrop(backdropTable)
	if objectstyle.backdropcolor then
		object:SetBackdropColor(unpack(objectstyle.backdropcolor))
	end
end
local function MatchTextWidth()
	local stringwidth = visual.name:GetStringWidth() or 100
	bars.healthbar:SetWidth(stringwidth + style.healthbar.width)
	visual.healthborder:SetWidth(stringwidth + style.healthborder.width)
	visual.target:SetWidth(stringwidth + style.target.width)
	extended:SetWidth(stringwidth + style.frame.width)
end

--------------------------------------------------------------------------------------------------------------
-- III. Nameplate Style: These functions request updates for the appearance of the various graphical objects
--------------------------------------------------------------------------------------------------------------
local UpdateStyle
do
	-- Style Property Groups
	local fontgroup = {"name", "level", "spelltext", "customtext"}
	local anchorgroup = {"healthborder", "threatborder", "castborder", "castnostop", "name", "spelltext", "customtext", "level", "customart", "spellicon", "raidicon", "skullicon", "eliteicon", "target"}
	local bargroup = {"castbar", "healthbar"}
	local texturegroup = {"castborder", "castnostop", "healthborder", "threatborder", "eliteicon", "skullicon", "highlight", "target"}
	-- UpdateStyle:
	function UpdateStyle()
		-- Frame
		SetAnchorGroupObject(extended, style.frame, nameplate)
		-- Anchorgroup
		for index = 1, #anchorgroup do
			local objectname = anchorgroup[index]
			SetAnchorGroupObject(visual[objectname], style[objectname], extended)
			if style[objectname].show then
				visual[objectname]:Show()
			else
				visual[objectname]:Hide()
			end
		end
		-- Bars
		for index = 1, #bargroup do
			local objectname = bargroup[index]
			SetBarGroupObject(bars[objectname], style[objectname], extended)
		end
		-- Texture
		for index = 1, #texturegroup do
			local objectname = texturegroup[index]
			SetObjectTexture(visual[objectname], style[objectname].texture)
		end
		-- Font Group
		for index = 1, #fontgroup do
			local objectname = fontgroup[index]
			SetFontGroupObject(visual[objectname], style[objectname])
		end
		-- Hide Stuff
		if unit.isElite then
			visual.eliteicon:Hide()
		else
			visual.eliteicon:Hide()
		end
		if unit.isBoss then
			visual.level:Hide()
		else
			visual.skullicon:Hide()
		end
		if not unit.isTarget then
			visual.target:Hide()
		end
		if not unit.isMarked then
			visual.raidicon:Hide()
		end
		if activetheme.SetStatusbarWidthMatching then
			MatchTextWidth()
		end
	end
end
--------------------------------------------------------------------------------------------------------------
-- IV. Indicators: These functions update the actual data shown on the graphical objects
--------------------------------------------------------------------------------------------------------------

do
	local color = {}
	local threatborder, alpha, forcealpha, scale
	-- UpdateIndicator_HealthBar: Updates the value on the health bar
	function UpdateIndicator_HealthBar()
		bars.healthbar:SetMinMaxValues(bars.health:GetMinMaxValues())
		bars.healthbar:SetValue(bars.health:GetValue())
	end
	-- UpdateIndicator_Name:
	function UpdateIndicator_Name()
		visual.name:SetText(unit.name)
		-- Name Color
		if activetheme.SetNameColor then
			visual.name:SetTextColor(activetheme.SetNameColor(unit))
		else
			visual.name:SetTextColor(1, 1, 1, 1)
		end
		if activetheme.SetStatusbarWidthMatching then
			MatchTextWidth()
		end
	end
	-- UpdateIndicator_Level:
	function UpdateIndicator_Level()
		visual.level:SetText(unit.level)
		local tr, tg, tb = regions.level:GetTextColor()
		visual.level:SetTextColor(tr, tg, tb)
	end
	-- UpdateIndicator_ThreatGlow: Updates the aggro glow
	function UpdateIndicator_ThreatGlow()
		if not style.threatborder.show then
			return
		end
		threatborder = visual.threatborder
		if activetheme.SetThreatColor then
			threatborder:SetVertexColor(activetheme.SetThreatColor(unit))
		else
			if InCombat and unit.reaction ~= "FRIENDLY" and unit.type == "NPC" then
				local color = style.threatcolor[unit.threatSituation]
				threatborder:Show()
				threatborder:SetVertexColor(color.r, color.g, color.b, (color.a or 1))
			else
				threatborder:Hide()
			end
		end
	end
	-- UpdateIndicator_Target
	function UpdateIndicator_Target()
		if unit.isTarget and style.target.show then
			visual.target:Show()
		else
			visual.target:Hide()
		end
	end
	-- UpdateIndicator_RaidIcon
	function UpdateIndicator_RaidIcon()
		if unit.isMarked and style.raidicon.show then
			visual.raidicon:Show()
			visual.raidicon:SetTexCoord(regions.raidicon:GetTexCoord())
		else
			visual.raidicon:Hide()
		end
	end
	-- UpdateIndicator_EliteIcon: Updates the border overlay art and threat glow to Elite or Non-Elite art
	function UpdateIndicator_EliteIcon()
		threatborder = visual.threatborder
		if unit.isElite and style.eliteicon.show then
			visual.eliteicon:Show()
		else
			visual.eliteicon:Hide()
		end
	end
	-- UpdateIndicator_UnitColor: Update the health bar coloring, if needed
	function UpdateIndicator_UnitColor()
		-- Set Health Bar
		if activetheme.SetHealthbarColor then
			--bars.healthbar:SetStatusBarColor(activetheme.SetHealthbarColor(unit))
			bars.healthbar:SetStatusBarSmartGradient(activetheme.SetHealthbarColor(unit)) -- Testing Gradient
		else
			bars.healthbar:SetStatusBarColor(bars.health:GetStatusBarColor())
		end
		-- Name Color
		if activetheme.SetNameColor then
			visual.name:SetTextColor(activetheme.SetNameColor(unit))
		else
			visual.name:SetTextColor(1, 1, 1, 1)
		end
	end
	-- UpdateIndicator_Standard: Updates Non-Delegate Indicators
	function UpdateIndicator_Standard()
		if IsPlateShown(nameplate) then
			if unitcache.name ~= unit.name then
				UpdateIndicator_Name()
			end
			if unitcache.level ~= unit.level then
				UpdateIndicator_Level()
			end
			UpdateIndicator_RaidIcon()
			if unitcache.isElite ~= unit.isElite then
				UpdateIndicator_EliteIcon()
			end
		end
	end
	-- UpdateIndicator_CustomAlpha: Calls the alpha delegate to get the requested alpha
	function UpdateIndicator_CustomAlpha()
		if activetheme.SetAlpha then
			local previousAlpha = extended.requestedAlpha
			extended.requestedAlpha = activetheme.SetAlpha(unit) or previousAlpha or unit.alpha or 1
		else
			extended.requestedAlpha = unit.alpha or 1
		end

		if not PlatesFading[nameplate] then
			extended:SetAlpha(extended.requestedAlpha)
		end
	end
	-- UpdateIndicator_CustomScaleText: Updates the custom indicators (text, image, alpha, scale)
	function UpdateIndicator_CustomScaleText()
		threatborder = visual.threatborder

		if unit.health and (extended.requestedAlpha > 0) then
			-- Scale
			if activetheme.SetScale then
				scale = activetheme.SetScale(unit)
				if scale then
					extended:SetScale(scale)
				end
			end

			-- Set Special-Case Regions
			if style.customtext.show then
				if activetheme.SetCustomText then
					local text, r, g, b, a = activetheme.SetCustomText(unit)
					visual.customtext:SetText(text or "")
					visual.customtext:SetTextColor(r or 1, g or 1, b or 1, a or 1)
				else
					visual.customtext:SetText("")
				end
			end
			if style.customart.show then
				if activetheme.SetCustomArt then
					visual.customart:SetTexture(activetheme.SetCustomArt(unit))
				else
					visual.customart:SetTexture(EMPTY_TEXTURE)
				end
			end
			UpdateIndicator_UnitColor()
		end
	end
	-- UpdateHitboxShape:  Updates the nameplate's hitbox, but only out of combat
	function UpdateHitboxShape()
		if not InCombat then
			SetObjectShape(nameplate, style.hitbox.width, style.hitbox.height)
		end
	end
end

--------------------------------------------------------------------------------------------------------------
-- V. Data Gather: Gathers Information about the unit and requests updates, if needed
--------------------------------------------------------------------------------------------------------------
do
	--------------------------------
	-- References and Cache
	--------------------------------
	-- UpdateUnitCache
	local function UpdateUnitCache()
		for key, value in pairs(unit) do
			unitcache[key] = value
		end
	end
	-- UpdateReferences
	function UpdateReferences(plate)
		nameplate = plate
		extended = plate.extended
		bars = extended.bars
		regions = extended.regions
		unit = extended.unit
		unitcache = extended.unitcache
		visual = extended.visual
		style = extended.style
	end
	--------------------------------
	-- Data Conversion Functions
	local ClassReference = {}
	-- ColorToString: Converts a color to a string with a C- prefix
	local function ColorToString(r, g, b)
		return "C" .. math.floor((100 * r) + 0.5) .. math.floor((100 * g) + 0.5) .. math.floor((100 * b) + 0.5)
	end
	-- GetUnitCombatStatus: Determines if a unit is in combat by checking the name text color
	local function GetUnitCombatStatus(r, g, b)
		return (r > .5 and g < .5)
	end
	-- GetUnitAggroStatus: Determines if a unit is attacking, by looking at aggro glow region
	local GetUnitAggroStatus
	do
		local shown
		local red, green, blue
		function GetUnitAggroStatus(region)
			-- High = 1, 0, 0	-- Medium High = 1, .6, 0  -- Medium Low = 1, 1, .47
			shown = region:IsShown()
			if not shown then
				return "LOW", 0
			end
			red, green, blue = region:GetVertexColor()
			if red > 0 then
				if green > 0 then
					if blue > 0 then
						return "MEDIUM", 1
					end
					return "MEDIUM", 2
				end
				return "HIGH", 3
			end
		end
	end
	-- GetUnitReaction: Determines the reaction, and type of unit from the health bar color
	local function GetUnitReaction(red, green, blue)
		if red < .01 and blue < .01 and green > .99 then
			return "FRIENDLY", "NPC"
		elseif red < .01 and blue > .99 and green < .01 then
			return "FRIENDLY", "PLAYER"
		elseif red > .99 and blue < .01 and green > .99 then
			return "NEUTRAL", "NPC"
		elseif red > .99 and blue < .01 and green < .01 then
			return "HOSTILE", "NPC"
		else
			return "HOSTILE", "PLAYER"
		end
	end
	-- Raid Icon Lookup table
	local ux, uy
	local RaidIconCoordinate = {
		--from GetTexCoord. input is ULx and ULy (first 2 values).
		[0] = {[0] = "STAR", [0.25] = "MOON"},
		[0.25] = {[0] = "CIRCLE", [0.25] = "SQUARE"},
		[0.5] = {[0] = "DIAMOND", [0.25] = "CROSS"},
		[0.75] = {[0] = "TRIANGLE", [0.25] = "SKULL"}
	}

	-- Populates the class color lookup table
	for classname, color in pairs(RAID_CLASS_COLORS) do
		ClassReference[ColorToString(color.r, color.g, color.b)] = classname
	end
	--------------------------------
	-- Mass Gather Functions
	--------------------------------
	local function GatherData_Alpha(plate)
		if HasTarget then
			unit.alpha = plate.alpha
		else
			unit.alpha = 1
		end -- Active Alpha

		unit.isTarget = HasTarget and unit.alpha == 1
		unit.isMouseover = regions.highlight:IsShown()
		-- GUID
		if unit.isTarget then
			currentTarget = plate
			OnUpdateTargetCastbar(plate)
			if not unit.guid then
				-- UpdateCurrentGUID
				unit.guid = UnitGUID("target")
				if unit.guid then
					GUID[unit.guid] = plate
				end
			end
			extended:SetFrameLevel(127)
		else
			extended:SetFrameLevel(extended.frameLevel)
		end

		UpdateIndicator_Target()
		if activetheme.OnContextUpdate then
			activetheme.OnContextUpdate(extended, unit)
		end
	end

	-- GatherData_BasicInfo: Updates Unit Variables
	local function GatherData_BasicInfo()
		unit.name = regions.name:GetText()
		unit.isBoss = regions.skullicon:IsShown()
		unit.isDangerous = unit.isBoss
		unit.isElite = (regions.eliteicon:IsShown() or 0) == 1

		if unit.isBoss then
			unit.level = "??"
		else
			unit.level = regions.level:GetText()
		end
		unit.health = bars.health:GetValue() or 0
		_, unit.healthmax = bars.health:GetMinMaxValues()

		if InCombat then
			unit.threatSituation, unit.threatValue = GetUnitAggroStatus(regions.threatglow)
		else
			unit.threatSituation = "LOW"
			unit.threatValue = 0
		end

		unit.isMarked = regions.raidicon:IsShown() or false

		unit.isInCombat = GetUnitCombatStatus(regions.name:GetTextColor())
		unit.red, unit.green, unit.blue = bars.health:GetStatusBarColor()
		unit.levelcolorRed, unit.levelcolorGreen, unit.levelcolorBlue = regions.level:GetTextColor()
		unit.reaction, unit.type = GetUnitReaction(unit.red, unit.green, unit.blue)
		unit.class = ClassReference[ColorToString(unit.red, unit.green, unit.blue)] or "UNKNOWN"
		unit.InCombatLockdown = InCombat

		if unit.isMarked then
			ux, uy = regions.raidicon:GetTexCoord()
			unit.raidIcon = RaidIconCoordinate[ux][uy]
		else
			unit.raidIcon = nil
		end
	end

	--------------------------------
	-- Graphical Updates
	--------------------------------
	-- CheckNameplateStyle
	local function CheckNameplateStyle()
		if activetheme.SetStyle then
			stylename = activetheme.SetStyle(unit)
			extended.style = activetheme[stylename]
		else
			extended.style = activetheme
			stylename = tostring(activetheme)
		end
		style = extended.style
		if extended.stylename ~= stylename then
			UpdateStyle()
			extended.stylename = stylename
			unit.style = stylename
		end
		UpdateHitboxShape()
	end

	-- ProcessUnitChanges
	local function ProcessUnitChanges()
		-- Unit Cache
		unitchanged = false
		for key, value in pairs(unit) do
			if unitcache[key] ~= value then
				unitchanged = true
			end
		end

		-- Update Style/Indicators
		if unitchanged then
			CheckNameplateStyle()
			UpdateIndicator_Standard()
			UpdateIndicator_HealthBar()
		end

		-- Update Widgets
		if activetheme.OnUpdate then
			activetheme.OnUpdate(extended, unit)
		end

		-- Update Delegates
		UpdateIndicator_Target()
		UpdateIndicator_ThreatGlow()
		UpdateIndicator_CustomAlpha()
		UpdateIndicator_CustomScaleText()

		-- Cache the old unit information
		UpdateUnitCache()
	end

	--------------------------------
	-- Setup
	--------------------------------
	local function PrepareNameplate(plate)
		GatherData_BasicInfo()
		unit.frame = extended
		unit.alpha = 1
		unit.isTarget = false
		unit.isMouseover = false
		extended.unitcache = ClearIndices(extended.unitcache)
		extended.stylename = ""

		-- For Fading In
		PlatesFading[plate] = true
		extended.requestedAlpha = 0
		extended.visibleAlpha = 0
		extended:SetAlpha(0)

		-- Graphics
		unit.isCasting = false
		bars.castbar:Hide()
		visual.highlight:Hide()
		regions.highlight:Hide()

		-- Widgets/Extensions
		if activetheme.OnInitialize then
			activetheme.OnInitialize(extended)
		end
	end

	--------------------------------
	-- Individual Gather/Entry-Point Functions
	--------------------------------
	-- OnHideNameplate
	function OnHideNameplate(source)
		local plate = source.parentPlate
		UpdateReferences(plate)
		if unit.guid then
			GUID[unit.guid] = nil
		end

		bars.castbar:Hide()
		bars.castbar:SetScript("OnUpdate", nil)
		unit.isCasting = false

		PlatesVisible[plate] = nil
		extended.unit = ClearIndices(extended.unit)
		extended.unitcache = ClearIndices(extended.unitcache)
		for widgetname, widget in pairs(extended.widgets) do
			widget:Hide()
		end
		if plate == currentTarget then
			currentTarget = nil
		end
	end

	-- OnEchoNewNameplate: Intended to reduce CPU by bypassing the full update, and only checking the alpha value
	function OnEchoNewNameplate(plate)
		if not plate:IsShown() then
			return
		end
		-- Gather Information
		UpdateReferences(plate)
		GatherData_Alpha(plate)
		ProcessUnitChanges()
	end
	-- OnNewNameplate: When a new nameplate is generated, this function hooks the appropriate functions
	function OnNewNameplate(plate)
		local health, cast = plate:GetChildren()
		UpdateReferences(plate)
		PrepareNameplate(plate)
		GatherData_BasicInfo()

		-- Alternative to reduce initial CPU load
		CheckNameplateStyle()
		UpdateIndicator_CustomAlpha()

		-- Hook for Updates
		health:HookScript("OnShow", OnShowNameplate)
		health:HookScript("OnHide", OnHideNameplate)
		health:HookScript("OnValueChanged", OnUpdateHealth)
		health:HookScript("OnMinMaxChanged", OnUpdateHealthRange)

		-- Activates nameplate visibility
		PlatesVisible[plate] = true
		SetTargetQueue(plate, OnEchoNewNameplate) -- Echo for a partial update (alpha only)
	end

	-- OnShowNameplate
	function OnShowNameplate(source)
		local plate = source.parentPlate
		-- Activate Plate
		PlatesVisible[plate] = true
		UpdateReferences(plate)
		PrepareNameplate(plate)
		GatherData_BasicInfo()

		CheckNameplateStyle()
		UpdateIndicator_CustomAlpha()
		UpdateHitboxShape()

		SetTargetQueue(plate, OnUpdateNameplate) -- Echo for a full update
	end

	-- OnUpdateNameplate
	function OnUpdateNameplate(plate)
		if not plate:IsShown() then
			return
		end
		-- Gather Information
		UpdateReferences(plate)
		GatherData_Alpha(plate)
		GatherData_BasicInfo()
		ProcessUnitChanges()
	end
	-- OnUpdateLevel
	function OnUpdateLevel(plate)
		if not IsPlateShown(plate) then
			return
		end
		UpdateReferences(plate)
		if unit.isBoss then
			unit.level = "??"
		else
			unit.level = regions.level:GetText()
		end
		UpdateIndicator_Level()
	end

	-- OnUpdateThreatSituation
	function OnUpdateThreatSituation(plate)
		if not IsPlateShown(plate) then
			return
		end
		UpdateReferences(plate)

		if InCombat then
			unit.threatSituation, unit.threatValue = GetUnitAggroStatus(regions.threatglow)
		else
			unit.threatSituation = "LOW"
			unit.threatValue = 0
		end
		unit.isInCombat = GetUnitCombatStatus(regions.name:GetTextColor())

		CheckNameplateStyle()
		UpdateIndicator_ThreatGlow()
		UpdateIndicator_CustomAlpha()
		UpdateIndicator_CustomScaleText()
	end

	-- OnUpdateRaidIcon
	function OnUpdateRaidIcon(plate)
		if not IsPlateShown(plate) then
			return
		end
		UpdateReferences(plate)
		unit.isMarked = regions.raidicon:IsShown() or false
		if unit.isMarked then
			ux, uy = regions.raidicon:GetTexCoord()
			unit.raidIcon = RaidIconCoordinate[ux][uy]
		else
			unit.raidIcon = nil
		end
		UpdateIndicator_RaidIcon()
		UpdateIndicator_UnitColor()
	end

	-- OnUpdateReaction
	function OnUpdateReaction(plate)
		if not IsPlateShown(plate) then
			return
		end
		UpdateReferences(plate)
		unit.red, unit.green, unit.blue = bars.health:GetStatusBarColor()
		unit.reaction, unit.type = GetUnitReaction(unit.red, unit.green, unit.blue)
		unit.class = ClassReference[ColorToString(unit.red, unit.green, unit.blue)] or "UNKNOWN"
		UpdateIndicator_CustomScaleText()
	end

	-- OnMouseoverNameplate
	function OnMouseoverNameplate(plate)
		if not IsPlateShown(plate) then
			return
		end
		UpdateReferences(plate)
		unit.isMouseover = regions.highlight:IsShown()

		if unit.isMouseover then
			visual.highlight:Show()
			if (not unit.guid) then
				unit.guid = UnitGUID("mouseover")
				if unit.guid then
					GUID[unit.guid] = plate
				end
			end
		else
			visual.highlight:Hide()
		end

		OnUpdateThreatSituation(plate) -- This updates a bunch of properties
		if activetheme.OnContextUpdate then
			activetheme.OnContextUpdate(extended, unit)
		end
		if activetheme.OnUpdate then
			activetheme.OnUpdate(extended, unit)
		end
	end

	-- OnRequestWidgetUpdate: Updates just the widgets
	function OnRequestWidgetUpdate(plate)
		if not IsPlateShown(plate) then
			return
		end
		UpdateReferences(plate)
		if activetheme.OnContextUpdate then
			activetheme.OnContextUpdate(extended, unit)
		end
		if activetheme.OnUpdate then
			activetheme.OnUpdate(extended, unit)
		end
	end

	-- OnRequestDelegateUpdate: Updates just the delegate function indicators (excluding Style?)
	function OnRequestDelegateUpdate(plate)
		if not IsPlateShown(plate) then
			return
		end
		UpdateReferences(plate)
		UpdateIndicator_ThreatGlow()
		UpdateIndicator_CustomAlpha()
		UpdateIndicator_CustomScaleText()
	end

	-- OnUpdateHealth
	function OnUpdateHealth(source)
		local plate = source.parentPlate
		if not IsPlateShown(plate) then
			return
		end
		UpdateReferences(plate)
		unit.health = bars.health:GetValue() or 0
		_, unit.healthmax = bars.health:GetMinMaxValues()
		UpdateIndicator_HealthBar()
		UpdateIndicator_CustomAlpha()
		UpdateIndicator_CustomScaleText()
	end

	-- OnUpdateHealthRange
	function OnUpdateHealthRange(source)
		local plate = source.parentPlate
		OnUpdateNameplate(plate)
	end

	-- Update the Animation
	function UpdateCastAnimation(castbar)
		local currentTime = GetTime()
		if currentTime > (castbar.endTime or 0) then
			StopCastAnimation(castbar.parentPlate)
		else
			castbar:SetValue(currentTime)
		end
	end

	function UpdateChannelAnimation(castbar)
		local currentTime = GetTime()
		if currentTime > (castbar.endTime or 0) then
			StopCastAnimation(castbar.parentPlate)
		else
			castbar:SetValue(castbar.startTime + (castbar.endTime - currentTime))
		end
	end

	-- Shows the Cast Animation (requires references)
	function StartCastAnimation(plate, spell, spellid, icon, startTime, endTime, notInterruptible, channel)
		UpdateReferences(plate)
		if (tonumber(GetCVar("showVKeyCastbar")) == 1) and spell then
			local castbar = bars.castbar
			local r, g, b, a = 1, .8, 0, 1
			unit.isCasting = true
			unit.spellName = spell
			unit.spellID = spellid
			unit.spellIsShielded = notInterruptible
			unit.spellInterruptible = not notInterruptible

			if activetheme.SetCastbarColor then
				r, g, b, a = activetheme.SetCastbarColor(unit)
				if not (r and g and b) then
					return
				end
			end

			castbar.endTime = endTime
			castbar.startTime = startTime
			castbar:SetStatusBarColor(r, g, b, a or 1)
			castbar:SetMinMaxValues(startTime, endTime)
			visual.spelltext:SetText(spell)

			visual.spellicon:SetTexture(icon)
			if notInterruptible then
				visual.castnostop:Show()
				visual.castborder:Hide()
			else
				visual.castnostop:Hide()
				visual.castborder:Show()
			end

			castbar:Show()
			if channel then
				castbar:SetValue(endTime - GetTime())
				castbar:SetScript("OnUpdate", UpdateChannelAnimation)
			else
				castbar:SetValue(GetTime())
				castbar:SetScript("OnUpdate", UpdateCastAnimation)
			end

			UpdateIndicator_CustomScaleText()
			UpdateIndicator_CustomAlpha()
		end
	end

	-- Hides the Cast Animation (requires references)
	function StopCastAnimation(plate)
		UpdateReferences(plate)
		bars.castbar:Hide()
		bars.castbar:SetScript("OnUpdate", nil)
		unit.isCasting = false
		UpdateIndicator_CustomScaleText()
		UpdateIndicator_CustomAlpha()
	end

	-- OnUpdateTargetCastbar: Called from hooking into the original nameplate castbar's "OnValueChanged"
	function OnUpdateTargetCastbar(source)
		if not source then
			return
		end
		local plate
		if PlatesVisible[source] then
			plate = source
		else
			plate = source.parentPlate
		end

		if plate and plate.extended.unit.isTarget then
			-- Grabs the target's casting information
			local spell, _, icon, start, finish, nonInt, channel, spellid, _

			spell, _, _, icon, start, finish, _, spellid, nonInt = UnitCastingInfo("target")

			if not spell then
				spell, _, _, icon, start, finish, spellid, nonInt = UnitChannelInfo("target")
				channel = true
			end

			if spell then
				StartCastAnimation(plate, spell, spellid, icon, start / 1000, finish / 1000, nonInt, channel)
			else
				StopCastAnimation(plate)
			end
		end
	end

	-- OnResetNameplate
	function OnResetNameplate(plate)
		local extended = plate.extended
		extended.unitcache = ClearIndices(extended.unitcache)
		extended.stylename = ""
		OnShowNameplate(extended)
	end
end

--------------------------------------------------------------------------------------------------------------
-- VI. Nameplate Extension: Applies scripts, hooks, and adds additional frame variables and elements
--------------------------------------------------------------------------------------------------------------

do
	-- local bars, regions, health, castbar, healthbar, visual
	local castbar, healthbar, region
	local platelevels = 125

	local function GetNameplateRegions(plate, regions, cast)
		regions.threatglow, regions.healthborder, regions.castborder, regions.castnostop, regions.spellicon, regions.highlight, regions.name, regions.level, regions.skullicon, regions.raidicon, regions.eliteicon = plate:GetRegions()
	end

	function ApplyPlateExtension(plate)
		Plates[plate] = true
		plate.extended = CreateFrame("Frame", nil, plate)
		local extended = plate.extended
		platelevels = platelevels - 1
		if platelevels < 1 then
			platelevels = 1
		end
		extended.frameLevel = platelevels
		extended:SetFrameLevel(platelevels)

		extended.style, extended.unit, extended.unitcache, extended.stylecache, extended.widgets = {}, {}, {}, {}, {}

		extended.regions, extended.bars, extended.visual = {}, {}, {}
		regions = extended.regions
		bars = extended.bars
		bars.health, bars.cast = plate:GetChildren()
		extended.stylename = ""

		-- Set Frame Levels and Parent
		GetNameplateRegions(plate, regions, bars.cast)

		-- This block makes the Blizz nameplate invisible
		regions.threatglow:SetTexCoord(0, 0, 0, 0)
		regions.healthborder:SetTexCoord(0, 0, 0, 0)
		regions.castborder:SetTexCoord(0, 0, 0, 0)
		regions.castnostop:SetTexCoord(0, 0, 0, 0)
		regions.skullicon:SetTexCoord(0, 0, 0, 0)
		regions.eliteicon:SetTexCoord(0, 0, 0, 0)
		regions.name:SetWidth(000.1)
		regions.level:SetWidth(000.1)
		regions.spellicon:SetTexCoord(0, 0, 0, 0)
		regions.spellicon:SetWidth(.001)
		regions.raidicon:SetAlpha(0)
		regions.highlight:SetTexture(EMPTY_TEXTURE)
		bars.health:SetStatusBarTexture(EMPTY_TEXTURE)
		bars.cast:SetStatusBarTexture(EMPTY_TEXTURE)

		-- Create Statusbars
		bars.healthbar = CreateTidyPlatesStatusbar(extended)
		bars.castbar = CreateTidyPlatesStatusbar(extended)
		health, cast, healthbar, castbar = bars.health, bars.cast, bars.healthbar, bars.castbar
		extended.parentPlate = plate
		health.parentPlate = plate
		cast.parentPlate = plate
		castbar.parentPlate = plate

		-- Visible Bars
		healthbar:SetFrameLevel(platelevels - 1)
		castbar:Hide()
		castbar:SetFrameLevel(platelevels)
		castbar:SetStatusBarColor(1, .8, 0)

		-- Visual Regions
		visual = extended.visual
		visual.customart = extended:CreateTexture(nil, "OVERLAY")
		visual.target = extended:CreateTexture(nil, "ARTWORK")
		visual.raidicon = extended:CreateTexture(nil, "OVERLAY")
		visual.raidicon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
		visual.eliteicon = extended:CreateTexture(nil, "OVERLAY")
		visual.healthborder = healthbar:CreateTexture(nil, "ARTWORK")
		visual.threatborder = healthbar:CreateTexture(nil, "ARTWORK")
		visual.skullicon = healthbar:CreateTexture(nil, "OVERLAY")
		visual.highlight = healthbar:CreateTexture(nil, "OVERLAY")
		visual.highlight:SetAllPoints(visual.healthborder)
		visual.highlight:SetBlendMode("ADD")
		visual.castborder = castbar:CreateTexture(nil, "ARTWORK")
		visual.castnostop = castbar:CreateTexture(nil, "ARTWORK")
		visual.spellicon = castbar:CreateTexture(nil, "OVERLAY")

		for i, v in pairs(visual) do
			v:SetNonBlocking(true)
		end

		visual.customtext = extended:CreateFontString(nil, "OVERLAY")
		visual.name = extended:CreateFontString(nil, "OVERLAY")
		visual.level = extended:CreateFontString(nil, "OVERLAY")
		visual.spelltext = castbar:CreateFontString(nil, "OVERLAY")

		if not extendedSetAlpha then
			PlateSetAlpha = plate.SetAlpha
			PlateGetAlpha = plate.GetAlpha
			extendedSetAlpha = plate.extended.SetAlpha
			HighlightIsShown = plate.extended.visual.highlight.IsShown
		end

		OnNewNameplate(plate)
	end
end

--------------------------------------------------------------------------------------------------------------
-- VII. World Update Functions: Refers new plates to 'ApplyPlateExtension()', and watches for Alpha/Transparency
-- and Highlight/Mouseover changes, and sends those changes to the appropriate handler.
-- Also processes the update queue (ie. echos)
--------------------------------------------------------------------------------------------------------------

do
	local plate, curChildren
	local WorldGetNumChildren, WorldGetChildren = WorldFrame.GetNumChildren, WorldFrame.GetChildren

	-- IsFrameNameplate: Checks to see if the frame is a Blizz nameplate
	local function IsFrameNameplate(frame)
		local threatRegion, borderRegion = frame:GetRegions()
		return borderRegion and borderRegion:GetObjectType() == "Texture" and
			borderRegion:GetTexture() == "Interface\\Tooltips\\Nameplate-Border"
	end

	-- OnWorldFrameChange: Checks for new Blizz Plates
	local function OnWorldFrameChange(...)
		for index = 1, select("#", ...) do
			plate = select(index, ...)
			if not Plates[plate] and IsFrameNameplate(plate) then
				ApplyPlateExtension(plate)
			end
		end
	end

	-- ForEachPlate
	function ForEachPlate(functionToRun, ...)
		for plate in pairs(PlatesVisible) do
			if plate.extended:IsShown() then -- Plate and extended frame both explicitly visible
				functionToRun(plate, ...)
			end
		end
	end

	-- Nameplate Fade-In
	local visibleAlpha, requestedAlpha
	local fadeInRate, fadeOutRate = .07, .2
	local function UpdateNameplateFade(plate)
		extended = plate.extended
		--if extended then
		visibleAlpha = extended.visibleAlpha
		requestedAlpha = extended.requestedAlpha
		if visibleAlpha < requestedAlpha then
			visibleAlpha = visibleAlpha + fadeInRate
			extended.visibleAlpha = visibleAlpha
			extendedSetAlpha(extended, visibleAlpha)
		else
			extended.visibleAlpha = requestedAlpha
			extendedSetAlpha(extended, visibleAlpha)
			PlatesFading[plate] = nil
		end
		--end
	end

	-- OnUpdate: This function is processed every frame!
	local queuedFunction
	local HasMouseover, LastMouseover, CurrentMouseover
	local PollTime, PollIndex = 0, 0

	function OnUpdate(self)
		HasMouseover = false

		-- Alpha - Highlight - Poll Loop
		for plate in pairs(PlatesVisible) do
			-- Alpha
			if (HasTarget) then
				plate.alpha = PlateGetAlpha(plate)
				PlateSetAlpha(plate, 1)
			end

			-- Highlight: CURSOR_UPDATE events are unreliable for GUID updates.  This provides a much better experience.
			highlightRegion = plate.extended.regions.highlight
			if HighlightIsShown(highlightRegion) then
				HasMouseover = true
				CurrentMouseover = plate
			end
		end

		-- Fade-In Loop
		for plate in pairs(PlatesFading) do
			UpdateNameplateFade(plate)
		end

		-- Process the Update Request Queues
		if massQueue[OnResetNameplate] then
			ForEachPlate(OnResetNameplate)
			for queuedFunction in pairs(massQueue) do
				massQueue[queuedFunction] = nil
			end
		else
			-- Function Queue: Runs the specified function
			for queuedFunction, run in pairs(functionQueue) do
				queuedFunction()
				functionQueue[queuedFunction] = nil
			end
			-- Mass Update Queue: Run the specified function on ALL visible plates
			if massQueue[OnUpdateNameplate] then
				for queuedFunction in pairs(massQueue) do
					massQueue[queuedFunction] = nil
				end
				ForEachPlate(OnUpdateNameplate)
			else
				for queuedFunction in pairs(massQueue) do
					massQueue[queuedFunction] = nil
					ForEachPlate(queuedFunction)
				end
			end
			-- Spefific Nameplate Function Queue: Runs the function on a specific plate
			for plate, queuedFunction in pairs(targetQueue) do
				targetQueue[plate] = nil
				queuedFunction(plate)
			end
		end

		-- Process Mouseover
		if HasMouseover then
			if LastMouseover ~= CurrentMouseover then
				if LastMouseover then
					OnMouseoverNameplate(LastMouseover)
				end
				OnMouseoverNameplate(CurrentMouseover)
				LastMouseover = CurrentMouseover
			end
		elseif LastMouseover then
			OnMouseoverNameplate(LastMouseover)
			LastMouseover = nil
		end

		-- Detect New Nameplates
		curChildren = WorldGetNumChildren(WorldFrame)
		if (curChildren ~= numChildren) then
			numChildren = curChildren
			OnWorldFrameChange(WorldGetChildren(WorldFrame))
		end
	end
end
--------------------------------------------------------------------------------------------------------------
-- VIII. Event Handlers: sends event-driven changes to  the appropriate gather/update handler.
--------------------------------------------------------------------------------------------------------------
do
	local events = {}
	local function EventHandler(self, event, ...)
		events[event](event, ...)
	end
	local PlateHandler = CreateFrame("Frame", nil, WorldFrame)
	PlateHandler:SetFrameStrata("TOOLTIP") -- When parented to WorldFrame, causes OnUpdate handler to run close to last
	PlateHandler:SetScript("OnEvent", EventHandler)

	-- Events
	function events:PLAYER_ENTERING_WORLD()
		PlateHandler:SetScript("OnUpdate", OnUpdate)
	end
	function events:PLAYER_REGEN_ENABLED()
		InCombat = false
		SetMassQueue(OnUpdateNameplate)
	end
	function events:PLAYER_REGEN_DISABLED()
		InCombat = true
		SetMassQueue(OnUpdateNameplate)
	end

	function events:PLAYER_TARGET_CHANGED()
		HasTarget = UnitExists("target") == 1 -- Must be bool, never nil!
		if (not HasTarget) then
			currentTarget = nil
		end
		SetMassQueue(OnUpdateNameplate) -- Could be "SetMassQueue(UpdateTarget), someday...  :-o
	end

	function events:RAID_TARGET_UPDATE()
		SetMassQueue(OnUpdateNameplate)
	end
	function events:UNIT_THREAT_SITUATION_UPDATE()
		SetMassQueue(OnUpdateThreatSituation)
	end -- Only fired when a target changes
	function events:UNIT_LEVEL()
		ForEachPlate(OnUpdateLevel)
	end
	function events:PLAYER_CONTROL_LOST()
		ForEachPlate(OnUpdateReaction)
	end
	events.PLAYER_CONTROL_GAINED = events.PLAYER_CONTROL_LOST
	events.UNIT_FACTION = events.PLAYER_CONTROL_LOST

	function events:UNIT_SPELLCAST_START(unitid, spell, ...)
		if unitid == "target" and currentTarget then
			OnUpdateTargetCastbar(currentTarget)
		end
	end
	events.UNIT_SPELLCAST_STOP = events.UNIT_SPELLCAST_START
	events.UNIT_SPELLCAST_INTERRUPTED = events.UNIT_SPELLCAST_START
	events.UNIT_SPELLCAST_FAILED = events.UNIT_SPELLCAST_START
	events.UNIT_SPELLCAST_DELAYED = events.UNIT_SPELLCAST_START
	events.UNIT_SPELLCAST_CHANNEL_START = events.UNIT_SPELLCAST_START
	events.UNIT_SPELLCAST_NOT_INTERRUPTIBLE = events.UNIT_SPELLCAST_START
	events.UNIT_SPELLCAST_INTERRUPTIBLE = events.UNIT_SPELLCAST_START
	events.UNIT_SPELLCAST_CHANNEL_STOP = events.UNIT_SPELLCAST_START
	events.UNIT_SPELLCAST_FAILED_QUIET = events.UNIT_SPELLCAST_START

	-- Registration of Blizzard Events
	for eventname in pairs(events) do
		PlateHandler:RegisterEvent(eventname)
	end
end

--------------------------------------------------------------------------------------------------------------
-- IX. External Commands: Allows widgets and themes to request updates to the plates.
-- Useful to make a theme respond to externally-captured data (such as the combat log)
--------------------------------------------------------------------------------------------------------------
function TidyPlates:ForceUpdate()
	SetMassQueue(OnResetNameplate)
end
function TidyPlates:Update()
	SetMassQueue(OnUpdateNameplate)
end
function TidyPlates:RequestWidgetUpdate()
	SetMassQueue(OnRequestWidgetUpdate)
end
function TidyPlates:RequestDelegateUpdate()
	SetMassQueue(OnRequestDelegateUpdate)
end
function TidyPlates:ActivateTheme(theme)
	if theme and type(theme) == "table" then
		TidyPlates.ActiveThemeTable, activetheme = theme, theme
		SetMassQueue(OnResetNameplate)
	end
end

TidyPlates.StartCastAnimationOnNameplate = StartCastAnimation
TidyPlates.StopCastAnimationOnNameplate = StopCastAnimation
TidyPlates.NameplatesByGUID, TidyPlates.NameplatesAll, TidyPlates.NameplatesByVisible = GUID, Plates, PlatesVisible
TidyPlates.OnNewNameplate = OnNewNameplate
TidyPlates.OnShowNameplate = OnShowNameplate
TidyPlates.OnHideNameplate = OnHideNameplate
TidyPlates.OnUpdateNameplate = OnUpdateNameplate
TidyPlates.OnResetNameplate = OnResetNameplate
TidyPlates.OnEchoNewNameplate = OnEchoNewNameplate
TidyPlates.OnUpdateHealth = OnUpdateHealth
TidyPlates.OnUpdateLevel = OnUpdateLevel
TidyPlates.OnUpdateThreatSituation = OnUpdateThreatSituation
TidyPlates.OnUpdateRaidIcon = OnUpdateRaidIcon
TidyPlates.OnUpdateHealthRange = OnUpdateHealthRange
TidyPlates.OnMouseoverNameplate = OnMouseoverNameplate
TidyPlates.OnRequestWidgetUpdate = OnRequestWidgetUpdate
TidyPlates.OnRequestDelegateUpdate = OnRequestDelegateUpdate