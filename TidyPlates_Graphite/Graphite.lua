-----------------------------------------------------
-- Theme Definition
-----------------------------------------------------
local Theme = {}
local ThemeName = "Graphite"
local CopyTable = TidyPlatesUtility.copyTable
local EmptyTexture = "Interface\\Addons\\TidyPlates\\media\\Empty"
local path = "Interface\\Addons\\TidyPlates_Graphite\\Media\\"
local font = "Interface\\Addons\\TidyPlates\\media\\AccidentalPresidency.ttf"

-- Non-Latin Font Bypass
local NonLatinLocales = {ruRU = true, koKR = true, zhCN = true, zhTW = true}
if NonLatinLocales[GetLocale()] then
	font = NAMEPLATE_FONT
end

local castoffset = 1
local artwidth = 90
local barwidth = 90
local borderheight = 16
local barheight = 16
local widthfactor = .85
local heightfactor = 1.2

local StyleDefault = {}

Theme.SetStatusbarWidthMatching = true

StyleDefault.hitbox = {width = 100, height = 35}

StyleDefault.frame = {x = 0, y = 0, anchor = "CENTER"}

StyleDefault.healthbar = {
	texture = path .. "StatusBar",
	width = barwidth * widthfactor,
	height = barheight * heightfactor,
	x = 0,
	y = 0
}

StyleDefault.healthborder = {
	texture = path .. "HealthBorder",
	width = artwidth * widthfactor,
	height = borderheight * heightfactor,
	x = 0,
	y = 0
}

StyleDefault.target = {
	texture = path .. "Target",
	width = 128,
	height = 36,
	x = 0,
	y = -4,
	anchor = "CENTER",
	show = true
}

StyleDefault.highlight = {texture = path .. "Mouseover"}

StyleDefault.threatborder = {
	texture = EmptyTexture,
	width = artwidth * widthfactor * 1.2,
	height = borderheight * heightfactor,
	x = 0,
	y = 0,
	anchor = "CENTER"
}

StyleDefault.castbar = {
	texture = path .. "StatusBar",
	width = barwidth * widthfactor,
	height = barheight * heightfactor,
	anchor = "CENTER",
	x = 0,
	y = -6 + castoffset
}

StyleDefault.castborder = {
	texture = path .. "HealthBorder",
	width = artwidth * widthfactor,
	height = borderheight * heightfactor,
	anchor = "CENTER",
	x = 0,
	y = -6 + castoffset
}

StyleDefault.castnostop = {
	texture = path .. "HealthBorder",
	width = artwidth * widthfactor,
	height = borderheight * heightfactor,
	anchor = "CENTER",
	x = 0,
	y = -6 + castoffset
}

StyleDefault.name = {
	typeface = font,
	size = 10,
	width = 175,
	height = 14,
	x = 0,
	y = 7,
	align = "CENTER",
	anchor = "CENTER",
	vertical = "CENTER",
	shadow = true,
	show = true
}

StyleDefault.level = {
	typeface = font,
	show = false
}

StyleDefault.customtext = {
	typeface = font,
	size = 10,
	width = 175,
	height = 14,
	x = 0,
	y = -1,
	align = "CENTER",
	anchor = "CENTER",
	vertical = "CENTER",
	shadow = true,
	show = true
}

StyleDefault.spelltext = {
	typeface = font,
	size = 10,
	width = 175,
	height = 14,
	x = 0,
	y = -16 + castoffset,
	align = "CENTER",
	anchor = "CENTER",
	vertical = "CENTER",
	shadow = false,
	show = true
}

StyleDefault.spellicon = {
	height = 12,
	width = 12,
	x = -38,
	y = -4,
	show = false
}

StyleDefault.eliteicon = {
	show = false
}

StyleDefault.raidicon = {
	width = 12,
	height = 12,
	x = 0,
	y = 12,
	anchor = "CENTER"
}

StyleDefault.skullicon = {
	show = false
}

StyleDefault.threatcolor = {
	LOW = {r = .6, g = 1, b = 0, a = 0},
	MEDIUM = {r = .6, g = 1, b = 0, a = 1},
	HIGH = {r = 1, g = 0, b = 0, a = 1}
}

local StyleTextOnly = CopyTable(StyleDefault)
StyleTextOnly.threatborder.texture = EmptyTexture
StyleTextOnly.healthborder.texture = EmptyTexture
StyleTextOnly.healthbar.texture = EmptyTexture
StyleTextOnly.healthbar.backdrop = EmptyTexture
StyleTextOnly.eliteicon.texture = EmptyTexture
StyleTextOnly.customtext.align = "CENTER"
StyleTextOnly.customtext.size = 9
StyleTextOnly.customtext.y = -2
StyleTextOnly.level.show = false
StyleTextOnly.skullicon.show = false
StyleTextOnly.eliteicon.show = false
StyleTextOnly.highlight.texture = "Interface\\Addons\\TidyPlates\\media\\Highlight"
StyleTextOnly.target.texture = "Interface\\Addons\\TidyPlates\\media\\Target"
StyleTextOnly.target.y = -3
StyleTextOnly.target.width = 128
StyleTextOnly.target.height = 36

local WidgetConfig = {}
WidgetConfig.ClassIcon = {anchor = "TOP", x = 0, y = 26}
WidgetConfig.TotemIcon = {anchor = "TOP", x = 0, y = 26}
WidgetConfig.ThreatLineWidget = {anchor = "TOP", x = 0, y = 0}
WidgetConfig.ThreatWheelWidget = {anchor = "CENTER", x = 0, y = 16}
WidgetConfig.ComboWidget = {anchor = "CENTER", x = 0, y = 16}
WidgetConfig.RangeWidget = {anchor = "CENTER", x = 0, y = 12}
WidgetConfig.DebuffWidget = {anchor = "TOP", x = 15, y = 15}

local DamageThemeName = ThemeName .. "/|cFFFF4400Damage"
local TankThemeName = ThemeName .. "/|cFF3782D1Tank"

---------------------------------------------
-- Tidy Plates Hub Integration
---------------------------------------------
Theme["Default"] = StyleDefault
Theme["NameOnly"] = StyleTextOnly

TidyPlatesThemeList[DamageThemeName] = Theme
local LocalVars = TidyPlatesHubDamageVariables

local function ApplyFontCustomization(style)
	style.name.typeface = font
	style.level.typeface = font
	style.customtext.typeface = font
	style.spelltext.typeface = font

	style.frame.y = ((LocalVars.FrameVerticalPosition - .5) * 50) - 16
end

local function OnApplyStyleCustomization(style)
	style.level.show = (LocalVars.TextShowLevel == true)
	style.target.show = (LocalVars.WidgetTargetHighlight == true)
	style.eliteicon.show = (LocalVars.WidgetEliteIndicator == true)
	ApplyFontCustomization(style)
end

local function OnApplyThemeCustomization(theme)
	OnApplyStyleCustomization(theme["Default"])
	ApplyFontCustomization(theme["NameOnly"])
	TidyPlates:ForceUpdate()
end

local function OnApplyDamageCustomization()
	OnApplyThemeCustomization(Theme)
end

local function OnInitialize(plate)
	TidyPlatesHubFunctions.OnInitializeWidgets(plate, WidgetConfig)
	if plate.widgets.DebuffWidget then
		plate.widgets.DebuffWidget:SetScale(.75)
	end
	if plate.widgets.ThreatLineWidget then
		plate.widgets.ThreatLineWidget:SetScale(.75)
	end
	if plate.widgets.ThreatWheelWidget then
		plate.widgets.ThreatWheelWidget:SetScale(.70)
	end
	if plate.widgets.ComboWidget then
		plate.widgets.ComboWidget:SetScale(.70)
	end
end

local function OnActivateTheme(themeTable)
	if Theme == themeTable then
		LocalVars = TidyPlatesHubFunctions:UseDamageVariables()
		OnApplyDamageCustomization()
	end
end

local function StyleDelegate(unit)
	return "Default"
end

Theme.SetNameColor = TidyPlatesHubFunctions.SetNameColor
Theme.SetScale = TidyPlatesHubFunctions.SetScale
Theme.SetAlpha = TidyPlatesHubFunctions.SetAlpha
Theme.SetHealthbarColor = TidyPlatesHubFunctions.SetHealthbarColor
Theme.SetThreatColor = TidyPlatesHubFunctions.SetThreatColor
Theme.SetCastbarColor = TidyPlatesHubFunctions.SetCastbarColor
Theme.SetCustomText = TidyPlatesHubFunctions.SetCustomText
Theme.OnUpdate = TidyPlatesHubFunctions.OnUpdate
Theme.OnContextUpdate = TidyPlatesHubFunctions.OnContextUpdate
Theme.ShowConfigPanel = ShowTidyPlatesHubDamagePanel
Theme.SetStyle = StyleDelegate

local function GetLevelDescription(unit)
	local description
	if unit.reaction ~= "FRIENDLY" then
		description = "Level " .. unit.level
		if unit.isElite then
			description = description .. " (Elite)"
		end
		return description
	end
end

local HubCustomText = TidyPlatesHubFunctions.SetCustomText
local function CustomText(unit)
	if unit.style == "NameOnly" then
		local description, elite
		if TidyPlatesData.UnitDescriptions and unit.type == "NPC" then
			return (TidyPlatesData.UnitDescriptions[unit.name] or GetLevelDescription(unit) or ""), 1, 1, 1, .70
		end
	end
	return HubCustomText(unit)
end
Theme.SetCustomText = CustomText

local StyleIndex = {"Default", "NameOnly"}
local function SetStyleDelegate(unit)
	return StyleIndex[TidyPlatesHubFunctions.SetMultistyle(unit)] or "Default"
end

Theme.SetStyle = SetStyleDelegate -- (6.2)

local GreyColor = {r = 98 / 255, g = 98 / 255, b = 98 / 255}
local function NameColorDelegate(unit)
	local class = TidyPlatesData.UnitClass[unit.name]
	local color
	if class then
		color = RAID_CLASS_COLORS[class]
	end
	if color then
		return color.r, color.g, color.b
	end
	return TidyPlatesHubFunctions.SetNameColor(unit)
end

Theme.OnInitialize = OnInitialize
Theme.OnActivateTheme = OnActivateTheme
Theme.OnApplyThemeCustomization = OnApplyDamageCustomization

do
	local TankTheme = CopyTable(Theme)
	TidyPlatesThemeList[TankThemeName] = TankTheme

	local function OnApplyTankCustomization()
		OnApplyThemeCustomization(TankTheme)
	end

	local function OnActivateTankTheme(themeTable)
		if TankTheme == themeTable then
			LocalVars = TidyPlatesHubFunctions:UseTankVariables()
			OnApplyTankCustomization()
		end
	end

	TankTheme.OnActivateTheme = OnActivateTankTheme
	TankTheme.OnApplyThemeCustomization = OnApplyTankCustomization
	TankTheme.ShowConfigPanel = ShowTidyPlatesHubTankPanel
end