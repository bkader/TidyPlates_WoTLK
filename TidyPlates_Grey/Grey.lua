-----------------------------------------------------
-- Tidy Plates Grey
-----------------------------------------------------
local Theme = {}
local CopyTable = TidyPlatesUtility.copyTable

local EmptyTexture = "Interface\\Addons\\TidyPlates\\media\\Empty"
local defaultArtPath = "Interface\\Addons\\TidyPlates_Grey\\Media\\"
local font = defaultArtPath .. "LiberationSans-Regular.ttf"
local blizzfont = NAMEPLATE_FONT
local nameplate_verticalOffset = -5
local castBar_verticalOffset = -6

-- Non-Latin Font Bypass
local NonLatinLocales = {ruRU = true, koKR = true, zhCN = true, zhTW = true}
if NonLatinLocales[GetLocale()] then
	font = NAMEPLATE_FONT
end

local StyleDefault = {}

StyleDefault.hitbox = {width = 140, height = 35}

StyleDefault.highlight = {
	texture = defaultArtPath .. "Highlight"
}

StyleDefault.healthborder = {
	texture = defaultArtPath .. "RegularBorder",
	glowtexture = defaultArtPath .. "Highlight",
	width = 128,
	height = 64,
	x = 0,
	y = nameplate_verticalOffset,
	anchor = "CENTER"
}

StyleDefault.eliteicon = {
	texture = defaultArtPath .. "EliteIcon",
	width = 14,
	height = 14,
	x = -51,
	y = 17,
	anchor = "CENTER",
	show = true
}

StyleDefault.target = {
	texture = defaultArtPath .. "TargetBox",
	width = 128,
	height = 64,
	x = 0,
	y = nameplate_verticalOffset,
	anchor = "CENTER",
	show = true
}

StyleDefault.threatborder = {
	texture = defaultArtPath .. "RegularThreat",
	elitetexture = defaultArtPath .. "EliteThreat",
	width = 128,
	height = 64,
	x = 0,
	y = nameplate_verticalOffset,
	anchor = "CENTER"
}

StyleDefault.castborder = {
	texture = defaultArtPath .. "CastStoppable",
	width = 128,
	height = 64,
	x = 0,
	y = 0 + castBar_verticalOffset + nameplate_verticalOffset,
	anchor = "CENTER"
}

StyleDefault.castnostop = {
	texture = defaultArtPath .. "CastNotStoppable",
	width = 128,
	height = 64,
	x = 0,
	y = 0 + castBar_verticalOffset + nameplate_verticalOffset,
	anchor = "CENTER"
}

StyleDefault.name = {
	typeface = font,
	size = 9,
	width = 100,
	height = 10,
	x = 0,
	y = 6 + nameplate_verticalOffset,
	align = "LEFT",
	anchor = "LEFT",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE"
}

StyleDefault.level = {
	typeface = font,
	size = 9,
	width = 25,
	height = 10,
	x = 36,
	y = 6 + nameplate_verticalOffset,
	align = "RIGHT",
	anchor = "CENTER",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE"
}

StyleDefault.healthbar = {
	texture = defaultArtPath .. "Statusbar",
	backdrop = defaultArtPath .. "Empty",
	height = 12,
	width = 101,
	x = 0,
	y = 15 + nameplate_verticalOffset,
	anchor = "CENTER",
	orientation = "HORIZONTAL"
}

StyleDefault.castbar = {
	texture = defaultArtPath .. "Statusbar",
	backdrop = defaultArtPath .. "Empty",
	height = 12,
	width = 99,
	x = 0,
	y = -8 + castBar_verticalOffset + nameplate_verticalOffset,
	anchor = "CENTER",
	orientation = "HORIZONTAL"
}

StyleDefault.customtext = {
	typeface = font,
	size = 9,
	width = 93,
	height = 10,
	x = 0,
	y = 16 + nameplate_verticalOffset,
	align = "RIGHT",
	anchor = "CENTER",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
	show = true
}

StyleDefault.spelltext = {
	typeface = font,
	size = 8,
	width = 100,
	height = 10,
	x = 1,
	y = castBar_verticalOffset - 8 + nameplate_verticalOffset,
	align = "LEFT",
	anchor = "CENTER",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
	show = true
}

StyleDefault.spellicon = {
	width = 18,
	height = 18,
	x = 62,
	y = -8 + castBar_verticalOffset + nameplate_verticalOffset,
	anchor = "CENTER"
}

StyleDefault.raidicon = {
	width = 20,
	height = 20,
	x = -35,
	y = 12 + nameplate_verticalOffset,
	anchor = "TOP"
}

StyleDefault.skullicon = {
	width = 14,
	height = 14,
	x = 44,
	y = 8 + nameplate_verticalOffset,
	anchor = "CENTER"
}

StyleDefault.frame = {
	width = 101,
	height = 45,
	x = 0,
	y = 0 + nameplate_verticalOffset,
	anchor = "CENTER"
}

StyleDefault.threatcolor = {
	LOW = {r = .6, g = 1, b = 0, a = 1},
	MEDIUM = {r = .6, g = 1, b = 0, a = 1},
	HIGH = {r = 1, g = 0, b = 0, a = 1}
}

-- No-Bar Style   (6.2)
local StyleTextOnly = CopyTable(StyleDefault)
StyleTextOnly.threatborder.texture = EmptyTexture
StyleTextOnly.healthborder.texture = EmptyTexture
StyleTextOnly.healthbar.texture = EmptyTexture
StyleTextOnly.healthbar.backdrop = EmptyTexture
StyleTextOnly.eliteicon.texture = EmptyTexture
StyleTextOnly.name.align = "CENTER"
StyleTextOnly.name.anchor = "CENTER"
StyleTextOnly.name.size = 12
StyleTextOnly.name.y = 12
StyleTextOnly.name.x = 0
StyleTextOnly.name.width = 200
StyleTextOnly.customtext.align = "CENTER"
StyleTextOnly.customtext.size = 8
StyleTextOnly.customtext.y = 3
StyleTextOnly.customtext.x = 0
StyleTextOnly.level.show = false
StyleTextOnly.skullicon.show = false
StyleTextOnly.eliteicon.show = false
StyleTextOnly.highlight.texture = defaultArtPath .. "TextPlate_Highlight"
StyleTextOnly.target.texture = defaultArtPath .. "TextPlate_Target"

local WidgetConfig = {}
WidgetConfig.ClassIcon = {anchor = "TOP", x = -32, y = 7}
WidgetConfig.TotemIcon = {anchor = "TOP", x = 0, y = 10}
WidgetConfig.ThreatLineWidget = {anchor = "CENTER", x = 0, y = 18}
WidgetConfig.ThreatWheelWidget = {anchor = "CENTER", x = 31, y = 23} -- "CENTER", plate, 30, 18
WidgetConfig.ComboWidget = {anchor = "CENTER", x = 0, y = 24}
WidgetConfig.RangeWidget = {anchor = "CENTER", x = 0, y = 12}
WidgetConfig.DebuffWidget = {anchor = "CENTER", x = 15, y = 35}

local DamageThemeName = "Grey/|cFFFF4400Damage"
local TankThemeName = "Grey/|cFF3782D1Tank"

SLASH_GREYTANK1 = "/greytank"
SlashCmdList["GREYTANK"] = ShowTidyPlatesHubTankPanel

SLASH_GREYDPS1 = "/greydps"
SlashCmdList["GREYDPS"] = ShowTidyPlatesHubDamagePanel

---------------------------------------------
-- Tidy Plates Hub Integration
---------------------------------------------
Theme["Default"] = StyleDefault
Theme["NameOnly"] = StyleTextOnly

local function StyleDelegate(unit)
	return "Default"
end

Theme.SetStyle = StyleDelegate

TidyPlatesThemeList[DamageThemeName] = Theme
local LocalVars = TidyPlatesHubDamageVariables

local function ApplyFontCustomization(style)
	local currentFont = font
	if LocalVars.TextUseBlizzardFont then
		currentFont = blizzfont
	end
	style.name.typeface = currentFont
	style.level.typeface = currentFont
	style.customtext.typeface = currentFont
	style.spelltext.typeface = currentFont

	style.frame.y = ((LocalVars.FrameVerticalPosition - .5) * 50) - 5
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
end

local function OnActivateTheme(themeTable)
	if Theme == themeTable then
		LocalVars = TidyPlatesHubFunctions:UseDamageVariables()
		OnApplyDamageCustomization()
	end
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

Theme.OnInitialize = OnInitialize
Theme.OnActivateTheme = OnActivateTheme
Theme.OnApplyThemeCustomization = OnApplyDamageCustomization

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
			return (TidyPlatesData.UnitDescriptions[unit.name] or GetLevelDescription(unit) or "")
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