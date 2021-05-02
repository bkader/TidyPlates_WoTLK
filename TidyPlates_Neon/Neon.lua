---------------------------------------------
-- Style Definition
---------------------------------------------
local ArtworkPath = "Interface\\Addons\\TidyPlates_Neon\\Media\\"
local font = "Interface\\Addons\\TidyPlates\\media\\AccidentalPresidency.ttf"
local fontsize = 12
local blizzfont = NAMEPLATE_FONT
local NameTextVerticalAdjustment = -10
local EmptyTexture = ArtworkPath .. "Neon_Empty"
local CastBarVerticalAdjustment = -24

-- Non-Latin Font Bypass
local NonLatinLocales = {ruRU = true, koKR = true, zhCN = true, zhTW = true}
if NonLatinLocales[GetLocale()] then
	font = NAMEPLATE_FONT
end

---------------------------------------------
-- Default Style
---------------------------------------------
local Theme = {}
local DefaultStyle = {}

DefaultStyle.highlight = {
	texture = ArtworkPath .. "Neon_Highlight"
}

DefaultStyle.healthborder = {
	texture = ArtworkPath .. "Neon_HealthOverlay",
	width = 128,
	height = 32,
	y = 0,
	show = true
}

DefaultStyle.healthbar = {
	texture = ArtworkPath .. "Neon_Bar",
	backdrop = ArtworkPath .. "Neon_Bar_Backdrop",
	width = 102,
	height = 32,
	x = 0,
	y = 0
}

DefaultStyle.castborder = {
	texture = ArtworkPath .. "Cast_Normal",
	width = 128,
	height = 32,
	x = 0,
	y = CastBarVerticalAdjustment,
	show = true
}

DefaultStyle.castnostop = {
	texture = ArtworkPath .. "Cast_Shield",
	width = 128,
	height = 32,
	x = 0,
	y = CastBarVerticalAdjustment,
	show = true
}

DefaultStyle.castbar = {
	texture = ArtworkPath .. "Neon_Bar",
	width = 100,
	height = 32,
	x = 0,
	y = CastBarVerticalAdjustment,
	anchor = "CENTER",
	orientation = "HORIZONTAL"
}

DefaultStyle.spellicon = {
	width = 15,
	height = 15,
	x = 24,
	y = CastBarVerticalAdjustment,
	anchor = "CENTER",
	show = true
}

DefaultStyle.spelltext = {
	typeface = font,
	size = 12,
	width = 150,
	height = 11,
	x = 26,
	y = -16 + CastBarVerticalAdjustment,
	align = "CENTER",
	anchor = "CENTER",
	vertical = "CENTER",
	shadow = true,
	show = true
}

DefaultStyle.threatborder = {
	-- [[
	texture = ArtworkPath .. "Neon_AggroOverlayWhite",
	width = 256,
	height = 64,
	y = 1,
	-- ]]
	x = 0,
	show = true
}

DefaultStyle.target = {
	texture = "Interface\\Addons\\TidyPlates_Neon\\Media\\Neon_Select",
	width = 128,
	height = 32,
	x = 0,
	y = 0,
	anchor = "CENTER",
	show = true
}

DefaultStyle.raidicon = {
	width = 32,
	height = 32,
	x = -48,
	y = 3,
	anchor = "CENTER",
	show = true
}

DefaultStyle.eliteicon = {
	texture = ArtworkPath .. "Neon_EliteIcon",
	width = 14,
	height = 14,
	x = -44,
	y = 5,
	anchor = "CENTER",
	show = true
}

DefaultStyle.name = {
	typeface = font,
	size = fontsize,
	width = 200,
	height = 11,
	x = 0,
	y = NameTextVerticalAdjustment,
	align = "CENTER",
	anchor = "CENTER",
	vertical = "CENTER",
	shadow = true,
	flags = "NONE"
}

DefaultStyle.level = {
	typeface = font,
	size = 9,
	width = 22,
	height = 11,
	x = 5,
	y = 5,
	align = "LEFT",
	anchor = "LEFT",
	vertical = "CENTER",
	flags = "OUTLINE",
	shadow = false,
	show = false
}

DefaultStyle.skullicon = {
	--texture = "",
	width = 14,
	height = 14,
	x = 5,
	y = 5,
	anchor = "LEFT",
	show = false
}

DefaultStyle.customtext = {
	typeface = font,
	size = 11,
	width = 150,
	height = 11,
	x = 0,
	y = 1,
	align = "CENTER",
	anchor = "CENTER",
	vertical = "CENTER",
	shadow = false,
	flags = "OUTLINE",
	show = true
}

DefaultStyle.frame = {
	y = 12
}

local CopyTable = TidyPlatesUtility.copyTable

-- No Bar
local StyleTextOnly = CopyTable(DefaultStyle)
StyleTextOnly.threatborder.texture = EmptyTexture
StyleTextOnly.healthborder.texture = EmptyTexture
StyleTextOnly.healthbar.texture = EmptyTexture
StyleTextOnly.healthbar.backdrop = EmptyTexture
StyleTextOnly.eliteicon.texture = EmptyTexture
StyleTextOnly.customtext.size = 10
StyleTextOnly.customtext.flags = "NONE"
StyleTextOnly.customtext.y = -8
StyleTextOnly.name.size = 12
StyleTextOnly.name.y = 1
StyleTextOnly.level.show = false
StyleTextOnly.skullicon.show = false
StyleTextOnly.eliteicon.show = false
StyleTextOnly.highlight.texture = ArtworkPath .. "TextPlate_Highlight"
StyleTextOnly.target.texture = ArtworkPath .. "TextPlate_Target"
StyleTextOnly.target.y = -8

-- 58px wide bar
local CompactStyle = CopyTable(DefaultStyle)
CompactStyle.healthborder.texture = ArtworkPath .. "Neon_HealthOverlay_Stubby"
CompactStyle.healthbar.width = 58
CompactStyle.highlight.texture = ArtworkPath .. "Neon_Stubby_Highlight"
CompactStyle.target.texture = ArtworkPath .. "Neon_Stubby_Target"

-- 38px wide bar
local MiniStyle = CopyTable(DefaultStyle)
MiniStyle.healthborder.texture = ArtworkPath .. "Neon_HealthOverlay_Very_Stubby"
MiniStyle.healthbar.width = 38
MiniStyle.name.size = 10
MiniStyle.highlight.texture = ArtworkPath .. "Neon_Very_Stubby_Highlight"
MiniStyle.target.texture = ArtworkPath .. "Neon_Very_Stubby_Target"

-- Border Danger Glow
local DangerStyle = CopyTable(DefaultStyle)

DangerStyle.healthborder.show = false
DangerStyle.healthbar.texture = EmptyTexture
DangerStyle.target.texture = EmptyTexture
DangerStyle.healthbar.backdrop = EmptyTexture
DangerStyle.highlight.texture = EmptyTexture
DangerStyle.level.show = false
DangerStyle.customtext.show = false
DangerStyle.skullicon.show = false
DangerStyle.eliteicon.show = false
DangerStyle.raidicon.x = 0

DangerStyle.threatborder = {
	texture = ArtworkPath .. "Neon_Select",
	width = 128,
	height = 32,
	y = 0,
	x = 0,
	show = true
}

-- Styles
Theme["Default"] = DefaultStyle
Theme["Compact"] = CompactStyle
Theme["Mini"] = MiniStyle
Theme["NameOnly"] = StyleTextOnly
Theme["Friendly"] = DangerStyle

-----------------------------------------------------
-- Tidy Plates: Neon/DPS - Theme Definition
-----------------------------------------------------

local IsTotem = TidyPlatesUtility.IsTotem

local function StyleDelegate(unit)
	if IsTotem(unit.name) then
		return "Mini"
	else
		return "Default"
	end
end

Theme.SetStyle = StyleDelegate

------------------------------------------------------------------------------------------

local WidgetConfig = {}
WidgetConfig.ClassIcon = {anchor = "TOP", x = 30, y = -1}
WidgetConfig.TotemIcon = {anchor = "TOP", x = 0, y = 2}
WidgetConfig.ThreatLineWidget = {anchor = "CENTER", x = 0, y = 4}
WidgetConfig.ThreatWheelWidget = {anchor = "CENTER", x = 36, y = 12}
WidgetConfig.ComboWidget = {anchor = "CENTER", x = 0, y = 10}
WidgetConfig.RangeWidget = {anchor = "CENTER", x = 0, y = 0}
WidgetConfig.DebuffWidget = {anchor = "CENTER", x = 15, y = 20}

local DamageThemeName = "Neon/|cFFFF4400Damage"
local TankThemeName = "Neon/|cFF3782D1Tank"

SLASH_NEONTANK1 = "/neontank"
SlashCmdList["NEONTANK"] = ShowTidyPlatesHubTankPanel

SLASH_NEONDPS1 = "/neondps"
SlashCmdList["NEONDPS"] = ShowTidyPlatesHubDamagePanel

---------------------------------------------
-- Tidy Plates Hub Integration
---------------------------------------------

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

	style.frame.y = ((LocalVars.FrameVerticalPosition - .5) * 50)
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
			return (TidyPlatesData.UnitDescriptions[unit.name] or GetLevelDescription(unit) or ""), 1, 1, 1, .65
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