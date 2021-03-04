local TidyPlatesUtility = _G.TidyPlatesUtility
local TidyPlatesThemeList = _G.TidyPlatesThemeList
local TidyPlatesHubFunctions = _G.TidyPlatesHubFunctions
-----------------------------------------------------
-- Theme Definition
-----------------------------------------------------
local Theme = {}
local CopyTable = TidyPlatesUtility.copyTable
local path = "Interface\\Addons\\TidyPlates_Quatre\\"
local font = "Interface\\Addons\\TidyPlatesHub\\shared\\AccidentalPresidency.ttf"
local EmptyTexture = "Interface\\Addons\\TidyPlatesHub\\shared\\Empty"

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
StyleTextOnly.highlight.texture = "Interface\\Addons\\TidyPlatesHub\\shared\\Highlight"
StyleTextOnly.target.texture = "Interface\\Addons\\TidyPlatesHub\\shared\\Target"

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

---------------------------------------------
-- Tidy Plates Hub Integration
---------------------------------------------
Theme["Default"] = StyleDefault
Theme["NameOnly"] = StyleTextOnly -- (6.2)

TidyPlatesThemeList[DamageThemeName] = Theme

local ApplyThemeCustomization = TidyPlatesHubFunctions.ApplyThemeCustomization

local function ApplyDamageCustomization()
    ApplyThemeCustomization(Theme)
end

local function OnInitialize(plate)
    TidyPlatesHubFunctions.OnInitializeWidgets(plate, WidgetConfig)
end

local function OnActivateTheme(themeTable)
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
