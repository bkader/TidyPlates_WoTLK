-----------------------------------------------------
-- Theme Definition
-----------------------------------------------------
local Theme = {}
local CopyTable = TidyPlatesUtility.copyTable
local path = "Interface\\Addons\\TidyPlates_Quatre\\Media\\"
local font = "Interface\\Addons\\TidyPlates\\media\\AccidentalPresidency.ttf"
local EmptyTexture = "Interface\\Addons\\TidyPlates\\media\\Empty"

-- Non-Latin Font Bypass
local NonLatinLocales = {["ruRU"] = true, ["koKR"] = true, ["zhCN"] = true, ["zhTW"] = true}
if NonLatinLocales[GetLocale()] == true then
	font = NAMEPLATE_FONT
end

local VerticalAdjustment = -12
local castbarVertical = VerticalAdjustment - 15

local StyleDefault = {}

StyleDefault.frame = {
	width = 100,
	height = 45,
	x = 0,
	y = 0,
	anchor = "CENTER"
}

StyleDefault.healthborder = {
	texture = path .. "RegularBorder",
	width = 128,
	height = 64,
	x = 0,
	y = VerticalAdjustment,
	anchor = "CENTER"
}

StyleDefault.target = {
	texture = path .. "TargetBox",
	width = 128,
	height = 64,
	x = 0,
	y = VerticalAdjustment,
	anchor = "CENTER",
	show = true
}

StyleDefault.highlight = {texture = path .. "RegularBorder"}

StyleDefault.threatborder = {
	texture = path .. "Warning",
	width = 128,
	height = 64,
	x = 0,
	y = VerticalAdjustment,
	anchor = "CENTER"
}

StyleDefault.castbar = {
	texture = path .. "Statusbar",
	backdrop = EmptyTexture,
	height = 8,
	width = 99,
	x = 0,
	y = 15 + castbarVertical,
	anchor = "CENTER",
	orientation = "HORIZONTAL"
}

StyleDefault.castborder = {
	texture = path .. "RegularBorder",
	width = 128,
	height = 64,
	x = 0,
	y = castbarVertical,
	anchor = "CENTER"
}

StyleDefault.castnostop = {
	texture = path .. "RegularBorder",
	width = 128,
	height = 64,
	x = 0,
	y = castbarVertical,
	anchor = "CENTER"
}

StyleDefault.name = {
	typeface = font,
	size = 12,
	height = 12,
	width = 180,
	x = 0,
	y = VerticalAdjustment + 9,
	align = "CENTER",
	anchor = "TOP",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE"
}

StyleDefault.level = {
	typeface = font,
	size = 10,
	width = 93,
	height = 10,
	x = -2,
	y = VerticalAdjustment + 15.5,
	align = "LEFT",
	anchor = "CENTER",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
	show = false
}

StyleDefault.healthbar = {
	texture = path .. "Statusbar",
	backdrop = path .. "StatusbarBackground",
	height = 8.5,
	width = 98.5,
	x = 0,
	y = VerticalAdjustment + 15,
	anchor = "CENTER",
	orientation = "HORIZONTAL"
}

StyleDefault.customtext = {
	typeface = font,
	size = 9,
	width = 93,
	height = 10,
	x = 0,
	y = VerticalAdjustment + 16,
	align = "RIGHT",
	anchor = "CENTER",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
	show = true
}

StyleDefault.spelltext = {
	typeface = font,
	size = 12,
	height = 12,
	width = 180,
	x = 0,
	y = -11 + castbarVertical,
	align = "CENTER",
	anchor = "TOP",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
	show = true
}

StyleDefault.spellicon = {
	width = 25,
	height = 25,
	x = -67,
	y = 22 + castbarVertical,
	anchor = "CENTER"
}

StyleDefault.eliteicon = {
	texture = path .. "EliteBorder",
	width = 128,
	height = 64,
	x = 0,
	y = VerticalAdjustment,
	anchor = "CENTER",
	show = true
}

StyleDefault.raidicon = {
	width = 25,
	height = 25,
	x = -55,
	y = VerticalAdjustment + 21,
	anchor = "CENTER"
}

StyleDefault.skullicon = {
	width = 8,
	height = 8,
	x = 2,
	y = VerticalAdjustment + 15,
	anchor = "LEFT"
}

StyleDefault.threatcolor = {
	LOW = {r = .6, g = 1, b = 0, a = 0},
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
StyleTextOnly.customtext.align = "CENTER"
StyleTextOnly.customtext.size = 10
StyleTextOnly.customtext.y = VerticalAdjustment + 16
StyleTextOnly.level.show = false
StyleTextOnly.skullicon.show = false
StyleTextOnly.eliteicon.show = false
StyleTextOnly.highlight.texture = "Interface\\Addons\\TidyPlates\\media\\Highlight"
StyleTextOnly.target.texture = "Interface\\Addons\\TidyPlates\\media\\Target"

local WidgetConfig = {}
WidgetConfig.ClassIcon = {anchor = "TOP", x = 0, y = VerticalAdjustment + 26} -- Above Name
WidgetConfig.TotemIcon = {anchor = "TOP", x = 0, y = VerticalAdjustment + 26}
WidgetConfig.ThreatLineWidget = {anchor = "TOP", x = 0, y = VerticalAdjustment + 20} -- y = 20
WidgetConfig.ThreatWheelWidget = {anchor = "CENTER", x = 33, y = VerticalAdjustment + 27} -- "CENTER", plate, 30, 18
WidgetConfig.ComboWidget = {anchor = "TOP", x = 0, y = VerticalAdjustment + 0}
WidgetConfig.RangeWidget = {anchor = "CENTER", x = 0, y = VerticalAdjustment + 12}
WidgetConfig.DebuffWidget = {anchor = "TOP", x = 15, y = VerticalAdjustment + 33}

local DamageThemeName = "Quatre/|cFFFF4400Damage"
local TankThemeName = "Quatre/|cFF3782D1Tank"

SLASH_QUATRETANK1 = "/quatretank"
SlashCmdList["QUATRETANK"] = ShowTidyPlatesHubTankPanel

SLASH_QUATREDAMAGE = "/quatredamage"
SlashCmdList["QUATREDAMAGE"] = ShowTidyPlatesHubDamagePanel

---------------------------------------------
-- Tidy Plates Hub Integration
---------------------------------------------
Theme["Default"] = StyleDefault
Theme["NameOnly"] = StyleTextOnly

TidyPlatesThemeList[DamageThemeName] = Theme
local LocalVars = TidyPlatesHubDamageVariables

local function ApplyFontCustomization(style)
	local currentFont = font
	if LocalVars.TextUseBlizzardFont then
		currentFont = GameFontNormal
	end
	style.name.typeface = currentFont
	style.level.typeface = currentFont
	style.customtext.typeface = currentFont
	style.spelltext.typeface = currentFont

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

-- [[ (6.2)
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

Theme.SetStyle = SetStyleDelegate

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