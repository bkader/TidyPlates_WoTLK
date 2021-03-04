local TidyPlatesUtility = _G.TidyPlatesUtility
local TidyPlatesThemeList = _G.TidyPlatesThemeList
local TidyPlatesHubFunctions = _G.TidyPlatesHubFunctions
-----------------------------------------------------
-- Theme Definition
-----------------------------------------------------
local Theme = {}
local ThemeName = "Graphite"
local CopyTable = TidyPlatesUtility.copyTable
local EmptyTexture = "Interface\\Addons\\TidyPlatesHub\\shared\\Empty"
local path = "Interface\\Addons\\TidyPlates_Graphite\\"
local font = "Interface\\Addons\\TidyPlatesHub\\shared\\AccidentalPresidency.ttf"

-- Non-Latin Font Bypass
local NonLatinLocales = {["ruRU"] = true, ["koKR"] = true, ["zhCN"] = true, ["zhTW"] = true}
if NonLatinLocales[GetLocale()] == true then
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

-- No-Bar Style   (6.2)
local StyleTextOnly = CopyTable(StyleDefault)
StyleTextOnly.threatborder.texture = EmptyTexture
StyleTextOnly.healthborder.texture = EmptyTexture
StyleTextOnly.healthborder.height = 64
StyleTextOnly.healthborder.y = -18
StyleTextOnly.healthbar.texture = EmptyTexture
StyleTextOnly.healthbar.backdrop = EmptyTexture
StyleTextOnly.eliteicon.texture = EmptyTexture
StyleTextOnly.customtext.align = "CENTER"
StyleTextOnly.customtext.size = 9
StyleTextOnly.customtext.y = -2
StyleTextOnly.level.show = false
StyleTextOnly.skullicon.show = false
StyleTextOnly.eliteicon.show = false
StyleTextOnly.highlight.texture = "Interface\\Addons\\TidyPlatesHub\\shared\\Highlight"

local WidgetConfig = {}
WidgetConfig.ClassIcon = {anchor = "TOP", x = 0, y = 26} -- Above Name
WidgetConfig.TotemIcon = {anchor = "TOP", x = 0, y = 26}
WidgetConfig.ThreatLineWidget = {anchor = "TOP", x = 0, y = 0} -- y = 20
WidgetConfig.ThreatWheelWidget = {anchor = "CENTER", x = 0, y = 16} -- "CENTER", plate, 30, 18
WidgetConfig.ComboWidget = {anchor = "CENTER", x = 0, y = 19}
WidgetConfig.RangeWidget = {anchor = "CENTER", x = 0, y = 12}
WidgetConfig.DebuffWidget = {anchor = "TOP", x = 15, y = 18}
if (UnitClassBase("player") == "Druid") or (UnitClassBase("player") == "Rogue") then
    WidgetConfig.DebuffWidgetPlus = {anchor = "TOP", x = 15, y = 26.5}
end

local DamageThemeName = ThemeName .. "/|cFFFF4400Damage"
local TankThemeName = ThemeName .. "/|cFF3782D1Tank"

Theme["Default"] = StyleDefault
Theme["NameOnly"] = StyleTextOnly

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