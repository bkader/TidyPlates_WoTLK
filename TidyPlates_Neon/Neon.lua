local TidyPlatesUtility = _G.TidyPlatesUtility
local TidyPlatesThemeList = _G.TidyPlatesThemeList
local TidyPlatesHubFunctions = _G.TidyPlatesHubFunctions
---------------------------------------------
-- Style Definition
---------------------------------------------
local ArtworkPath = "Interface\\Addons\\TidyPlates_Neon\\"
local font = "Interface\\Addons\\TidyPlatesHub\\shared\\AccidentalPresidency.ttf"
local fontsize = 12
local EmptyTexture = "Interface\\Addons\\TidyPlatesHub\\shared\\Empty"
local VerticalAdjustment = 12
local CastBarHorizontalAdjustment = 22
local CastBarVerticalAdjustment = VerticalAdjustment - 18
local NameTextVerticalAdjustment = VerticalAdjustment - 9

-- Non-Latin Font Bypass
local NonLatinLocales = {["ruRU"] = true, ["koKR"] = true, ["zhCN"] = true, ["zhTW"] = true}
if NonLatinLocales[GetLocale()] == true then
    font = NAMEPLATE_FONT
end

---------------------------------------------
-- Default Style
---------------------------------------------
local Theme = {}
local DefaultStyle = {}

DefaultStyle.highlight = {texture = ArtworkPath .. "Neon_Highlight"}

DefaultStyle.healthborder = {
    texture = ArtworkPath .. "Neon_HealthOverlay",
    width = 128,
    height = 32,
    y = VerticalAdjustment,
    show = true
}

DefaultStyle.healthbar = {
    texture = ArtworkPath .. "Neon_Bar",
    backdrop = ArtworkPath .. "Neon_Bar_Backdrop",
    width = 102,
    height = 32,
    x = 0,
    y = VerticalAdjustment
}

DefaultStyle.castborder = {
    texture = ArtworkPath .. "Neon_CastOverlay",
    width = 128,
    height = 32,
    x = CastBarHorizontalAdjustment,
    y = CastBarVerticalAdjustment,
    show = true
}

DefaultStyle.castnostop = {
    texture = ArtworkPath .. "Neon_CastOverlay",
    width = 128,
    height = 32,
    x = CastBarHorizontalAdjustment,
    y = CastBarVerticalAdjustment,
    show = true
}

DefaultStyle.castbar = {
    texture = ArtworkPath .. "Neon_Bar",
    width = 100,
    height = 32,
    x = CastBarHorizontalAdjustment - 10,
    y = CastBarVerticalAdjustment - 6,
    anchor = "CENTER",
    orientation = "HORIZONTAL"
}

DefaultStyle.spellicon = {
    width = 16,
    height = 18,
    x = CastBarHorizontalAdjustment + 48,
    y = CastBarVerticalAdjustment - .7,
    anchor = "CENTER",
    show = true,
    coords = {left = 0.15, right = .85, top = 0.15, bottom = .85} -- Does nothing, at the moment
}

DefaultStyle.spelltext = {
    typeface = font,
    size = 12,
    width = 150,
    height = 11,
    x = CastBarHorizontalAdjustment - 10,
    y = CastBarVerticalAdjustment - 16,
    align = "CENTER",
    anchor = "CENTER",
    vertical = "CENTER",
    shadow = true,
    show = true
}

DefaultStyle.threatborder = {
    texture = ArtworkPath .. "Neon_AggroOverlayWhite",
    width = 256,
    height = 64,
    y = VerticalAdjustment + 1,
    x = 0,
    show = true
}

DefaultStyle.target = {
    texture = "Interface\\Addons\\TidyPlates_Neon\\Neon_Select",
    width = 128,
    height = 32,
    x = 0,
    y = VerticalAdjustment,
    anchor = "CENTER",
    show = true
}

DefaultStyle.raidicon = {
    width = 22,
    height = 22,
    x = -64,
    y = VerticalAdjustment - 3,
    anchor = "CENTER",
    show = true
}

-- [[
DefaultStyle.eliteicon = {
    texture = ArtworkPath .. "Neon_EliteIcon",
    width = 14,
    height = 14,
    x = -44,
    y = VerticalAdjustment + 5,
    anchor = "CENTER",
    show = true
}

DefaultStyle.skullicon = {
    texture = ArtworkPath .. "Skull_Icon_White",
    width = 14,
    height = 14,
    x = -32,
    y = VerticalAdjustment + 5,
    anchor = "CENTER",
    show = false
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
    y = VerticalAdjustment + 5,
    align = "LEFT",
    anchor = "LEFT",
    vertical = "CENTER",
    flags = "OUTLINE",
    shadow = false,
    show = false
}

DefaultStyle.customtext = {
    typeface = font,
    size = 11,
    width = 150,
    height = 11,
    x = 0,
    y = VerticalAdjustment + 1,
    align = "CENTER",
    anchor = "CENTER",
    vertical = "CENTER",
    shadow = false,
    flags = "OUTLINE",
    show = true
}

DefaultStyle.frame = {
    y = 0
}

local CopyTable = TidyPlatesUtility.copyTable

-- No Bar
local StyleTextOnly = CopyTable(DefaultStyle)
StyleTextOnly.threatborder.texture = EmptyTexture

StyleTextOnly.healthborder.y = VerticalAdjustment - 24
StyleTextOnly.healthborder.height = 64
StyleTextOnly.healthborder.texture = EmptyTexture
StyleTextOnly.healthbar.texture = EmptyTexture
StyleTextOnly.healthbar.backdrop = EmptyTexture
StyleTextOnly.eliteicon.texture = EmptyTexture
StyleTextOnly.customtext.size = 10
StyleTextOnly.customtext.flags = "NONE"
StyleTextOnly.customtext.y = VerticalAdjustment - 8
StyleTextOnly.name.size = 12
StyleTextOnly.name.y = VerticalAdjustment + 1
StyleTextOnly.level.show = false
StyleTextOnly.skullicon.show = false
StyleTextOnly.eliteicon.show = false
StyleTextOnly.highlight.texture = "Interface\\Addons\\TidyPlatesHub\\shared\\Highlight"
StyleTextOnly.target.texture = "Interface\\Addons\\TidyPlatesHub\\shared\\Target"
StyleTextOnly.target.height = 64
StyleTextOnly.target.y = VerticalAdjustment - 8 - 16

-- Styles
Theme["Default"] = DefaultStyle
Theme["NameOnly"] = StyleTextOnly

-- Widget
local WidgetConfig = {}
WidgetConfig.ClassIcon = {anchor = "TOP", x = 30, y = VerticalAdjustment - 1}
WidgetConfig.TotemIcon = {anchor = "TOP", x = 0, y = VerticalAdjustment + 2}
WidgetConfig.ThreatLineWidget = {anchor = "CENTER", x = 0, y = VerticalAdjustment + 4}
WidgetConfig.ThreatWheelWidget = {anchor = "CENTER", x = 36, y = VerticalAdjustment + 12} -- "CENTER", plate, 30, 18
WidgetConfig.ComboWidget = {anchor = "CENTER", x = 0, y = VerticalAdjustment + 9.5}
WidgetConfig.RangeWidget = {anchor = "CENTER", x = 0, y = VerticalAdjustment + 0}
WidgetConfig.DebuffWidget = {anchor = "CENTER", x = 15, y = VerticalAdjustment + 17}
if (UnitClassBase("player") == "Druid") or (UnitClassBase("player") == "Rogue") then
    WidgetConfig.DebuffWidgetPlus = {anchor = "CENTER", x = 15, y = VerticalAdjustment + 24}
end

local DamageThemeName = "Neon/|cFFFF4400Damage"
local TankThemeName = "Neon/|cFF3782D1Tank"

_G.SLASH_NEONTANK1 = "/neontank"
SlashCmdList["NEONTANK"] = _G.ShowTidyPlatesHubTankPanel

_G.SLASH_NEONDPS1 = "/neondps"
SlashCmdList["NEONDPS"] = _G.ShowTidyPlatesHubDamagePanel

---------------------------------------------
-- Tidy Plates Hub Integration
---------------------------------------------

TidyPlatesThemeList[DamageThemeName] = Theme

local ApplyThemeCustomization = TidyPlatesHubFunctions.ApplyThemeCustomization

local function ApplyDamageCustomization()
    ApplyThemeCustomization(Theme)
end

local function OnInitialize(plate)
    TidyPlatesHubFunctions.OnInitializeWidgets(plate, WidgetConfig)
end

local function OnActivateTheme(themeTable, other)
    if Theme == themeTable then
        ApplyDamageCustomization()
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
Theme.ShowConfigPanel = _G.ShowTidyPlatesHubDamagePanel
Theme.SetStyle = TidyPlatesHubFunctions.SetStyleBinary
Theme.SetCustomText = TidyPlatesHubFunctions.SetCustomTextBinary
Theme.OnInitialize = OnInitialize -- Need to provide widget positions
Theme.OnActivateTheme = OnActivateTheme -- called by Tidy Plates Core, Theme Loader
Theme.OnApplyThemeCustomization = ApplyDamageCustomization -- Called By Hub Panel

do
    local TankTheme = CopyTable(Theme)
    TidyPlatesThemeList[TankThemeName] = TankTheme

    local function ApplyTankCustomization()
        ApplyThemeCustomization(TankTheme)
    end

    local function OnActivateTankTheme(themeTable)
        if TankTheme == themeTable then
            ApplyTankCustomization()
        end
    end

    TankTheme.OnActivateTheme = OnActivateTankTheme -- called by Tidy Plates Core, Theme Loader
    TankTheme.OnApplyThemeCustomization = ApplyTankCustomization -- Called By Hub Panel
    TankTheme.ShowConfigPanel = _G.ShowTidyPlatesHubTankPanel
end