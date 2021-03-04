local TidyPlates = _G.TidyPlates
local TidyPlatesHubDefaults = _G.TidyPlatesHubDefaults
local TidyPlatesHubRapidPanel = _G.TidyPlatesHubRapidPanel
local TidyPlatesHubSettings = _G.TidyPlatesHubSettings
local TidyPlatesOptions = _G.TidyPlatesOptions
local TidyPlatesThemeList = _G.TidyPlatesThemeList
local TidyPlatesUtility = _G.TidyPlatesUtility
local TidyPlatesWidgets = _G.TidyPlatesWidgets
------------------------------------------------------------------------------------
-- Tidy Plates Hub
------------------------------------------------------------------------------------

TidyPlatesHubFunctions = {}
local LocalVars = TidyPlatesHubDefaults

local WidgetLib = TidyPlatesWidgets
local valueToString = TidyPlatesUtility.abbrevNumber
local EnableTankWatch = TidyPlatesWidgets.EnableTankWatch
local DisableTankWatch = TidyPlatesWidgets.DisableTankWatch
local EnableAggroWatch = TidyPlatesWidgets.EnableAggroWatch
local DisableAggroWatch = TidyPlatesWidgets.DisableAggroWatch
local IsTankedByAnotherTank = TidyPlatesWidgets.IsTankedByAnotherTank
local GetAggroCondition = TidyPlatesWidgets.GetThreatCondition
local IsTotem = TidyPlatesUtility.IsTotem
local IsAuraShown = TidyPlatesWidgets.IsAuraShown
local IsHealer = TidyPlatesUtility.IsHealer
local InstanceStatus = TidyPlatesUtility.InstanceStatus

local CachedUnitDescription = TidyPlatesUtility.CachedUnitDescription
local CachedUnitGuild = TidyPlatesUtility.CachedUnitGuild
local CachedUnitClass = TidyPlatesUtility.CachedUnitClass
local IsFriend = TidyPlatesUtility.IsFriend
local IsGuildmate = TidyPlatesUtility.IsGuildmate

local CreateThreatLineWidget = WidgetLib.CreateThreatLineWidget
local CreateAuraWidget = WidgetLib.CreateAuraWidget
local CreateClassWidget = WidgetLib.CreateClassWidget
local CreateRangeWidget = WidgetLib.CreateRangeWidget
local CreateComboPointWidget = WidgetLib.CreateComboPointWidget
local CreateTotemIconWidget = WidgetLib.CreateTotemIconWidget

local function DummyFunction()
end

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

local NormalGrey = {r = .65, g = .65, b = .65, a = .4}
local EliteGrey = {r = .9, g = .7, b = .3, a = .5}
local BossGrey = {r = 1, g = .85, b = .1, a = .8}

-- Colors
local BlueColor = {r = 60 / 255, g = 168 / 255, b = 255 / 255}
local GreenColor = {r = 96 / 255, g = 224 / 255, b = 37 / 255}
local RedColor = {r = 255 / 255, g = 51 / 255, b = 32 / 255}
local YellowColor = {r = 252 / 255, g = 220 / 255, b = 27 / 255}
local GoldColor = {r = 252 / 255, g = 140 / 255, b = 0}
local OrangeColor = {r = 255 / 255, g = 64 / 255, b = 0}
local WhiteColor = {r = 250 / 255, g = 250 / 255, b = 250 / 255}

local White = {r = 1, g = 1, b = 1}
local Black = {r = 0, g = 0, b = 0}

local RaidIconColors = {
    ["STAR"] = {r = 251 / 255, g = 240 / 255, b = 85 / 255},
    ["MOON"] = {r = 100 / 255, g = 180 / 255, b = 255 / 255},
    ["CIRCLE"] = {r = 230 / 255, g = 116 / 255, b = 11 / 255},
    ["SQUARE"] = {r = 0, g = 174 / 255, b = 1},
    ["DIAMOND"] = {r = 207 / 255, g = 49 / 255, b = 225 / 255},
    ["CROSS"] = {r = 255 / 255, g = 130 / 255, b = 100 / 255},
    ["TRIANGLE"] = {r = 31 / 255, g = 194 / 255, b = 27 / 255},
    ["SKULL"] = {r = 244 / 255, g = 242 / 255, b = 240 / 255}
}

--"By Reaction"
local BrightBlue = {r = 0, g = 70 / 255, b = 240 / 255} -- {r = 0, g = 75/255, b = 240/255,}
local BrightBlueText = {r = 112 / 255, g = 219 / 255, b = 255 / 255}
local PaleBlue = {r = 0, g = 130 / 255, b = 225 / 255}
local PaleBlueText = {r = 194 / 255, g = 253 / 255, b = 1}
local DarkRed = {r = .9, g = 0.08, b = .08}

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

local RaidClassColors = RAID_CLASS_COLORS

------------------------------------------------------------------------------------
-- Helper Functions
------------------------------------------------------------------------------------
local function GetCurrentSpec()
    if TidyPlatesUtility.GetSpec(false, false) == 2 then
        return "secondary"
    else
        return "primary"
    end
end

local function ShortenNumber(number)
    if number > 1000000 then
        return (ceil((number / 10000)) / 100) .. " M"
    elseif number > 1000 then
        return (ceil((number / 10)) / 100) .. " k"
    else
        return number
    end
end

local function GetLevelDescription(unit)
    local description = ""
    description = "Level " .. unit.level
    if unit.isElite then
        description = description .. " (Elite)"
    end
    return description
end

local function SepThousands(n)
    local left, num, right = string.match(n, "^([^%d]*%d)(%d*)(.-)")
    return left .. (num:reverse():gsub("(%d%d%d)", "%1,"):reverse()) .. right
end

local function GetFriendlyClass(name)
    local class = TidyPlatesUtility.GroupMembers.Class[name]
    if (not class) and LocalVars.AdvancedEnableUnitCache then
        class = CachedUnitClass(name)
    end
    return class
end

local function GetEnemyClass(name)
    if LocalVars.AdvancedEnableUnitCache then
        return CachedUnitClass(name)
    end
end

------------------------------------------------------------------------------------
-- Style
------------------------------------------------------------------------------------

local BARMODE, HEADLINEMODE = 1, 2

local StyleModeFunctions = {
    --  Full Bars and Widgets
    function(unit)
        return BARMODE
    end,
    -- NameOnly
    function(unit)
        return HEADLINEMODE
    end,
    -- Bars during combat
    function(unit)
        if InCombatLockdown() then
            return BARMODE
        else
            return HEADLINEMODE
        end
    end,
    -- Bars when unit is active or damaged
    function(unit)
        if (unit.health < unit.healthmax) or (unit.threatValue > 1) or unit.isInCombat or unit.isMarked then
            return BARMODE
        end
        return HEADLINEMODE
    end,
    -- elite units
    function(unit)
        if unit.isElite then
            return BARMODE
        else
            return HEADLINEMODE
        end
    end,
    -- marked
    function(unit)
        if unit.isMarked then
            return BARMODE
        else
            return HEADLINEMODE
        end
    end,
    -- player chars
    function(unit)
        if unit.type == "PLAYER" then
            return BARMODE
        else
            return HEADLINEMODE
        end
    end,
    -- Current Target
    function(unit)
        if unit.isTarget == true then
            return BARMODE
        else
            return HEADLINEMODE
        end
    end,
    -- low threat
    function(unit)
        if InCombatLockdown() and unit.reaction == "HOSTILE" then
            if IsTankedByAnotherTank(unit) then
                return HEADLINEMODE
            end
            if unit.threatValue < 2 and unit.health > 0 then
                return BARMODE
            end
        elseif LocalVars.ColorShowPartyAggro and unit.reaction == "FRIENDLY" then
            if GetAggroCondition(unit.name) == true then
                return BARMODE
            end
        end
        return HEADLINEMODE
    end
}

local function StyleDelegate(unit)
    if unit.reaction == "FRIENDLY" then
        return StyleModeFunctions[LocalVars.StyleFriendlyMode](unit)
    else
        return StyleModeFunctions[LocalVars.StyleEnemyMode](unit)
    end
end

------------------------------------------------------------------------------------
-- Binary Plate Styles
------------------------------------------------------------------------------------

local function SetStyleBinaryDelegate(unit)
    if StyleDelegate(unit) == 2 then
        return "NameOnly"
    else
        return "Default"
    end
end

------------------------------------------------------------------------------
-- Health Bar Color
------------------------------------------------------------------------------
local tempColor = {}

-- By Low Health
local function ColorFunctionByHealth(unit)
    local health = unit.health / unit.healthmax
    if health > LocalVars.HighHealthThreshold then
        return LocalVars.ColorHighHealth
    elseif health > LocalVars.LowHealthThreshold then
        return LocalVars.ColorMediumHealth
    else
        return LocalVars.ColorLowHealth
    end
end

--"By Class"
local function ColorFunctionByClassEnemy(unit)
    local class

    if unit.type == "PLAYER" then
        -- Determine Unit Class
        if unit.reaction ~= "FRIENDLY" then
            class = unit.class or GetEnemyClass(unit.name)
        end

        -- Return Color
        if class and RaidClassColors[class] then
            return RaidClassColors[class]
        end
    end

    -- For unit types with no Class info available, the function returns nil (meaning, default reaction color)
end

local function ColorFunctionByClassFriendly(unit)
    local class

    if unit.type == "PLAYER" then
        -- Determine Unit Class
        if unit.reaction == "FRIENDLY" then
            class = GetFriendlyClass(unit.name)
        end

        -- Return Color
        if class and RaidClassColors[class] then
            return RaidClassColors[class]
        end
    end

    -- For unit types with no Class info available, the function returns nil (meaning, default reaction color)
end

local function ColorFunctionBlack()
    return Black
end

local function ColorFunctionDamage(unit)
    if unit.threatValue > 1 then
        return LocalVars.ColorAttackingMe -- When player is unit's target   -- Warning
    elseif unit.threatValue == 1 then
        return LocalVars.ColorAggroTransition -- Transition
    else
        return LocalVars.ColorAttackingOthers
    end -- Safe
end

local function ColorFunctionTank(unit)
    if IsTankedByAnotherTank(unit) then
        return LocalVars.ColorAttackingOtherTank -- When unit is tanked by another
    elseif unit.threatValue > 2 then
        return LocalVars.ColorAttackingMe -- When player is solid target    -- Safe
    elseif unit.threatValue == 2 then
        return LocalVars.ColorAggroTransition -- Transition
    else
        return LocalVars.ColorAttackingOthers
    end -- Warning
end

local function ColorFunctionTankSwapColors(unit)
    if IsTankedByAnotherTank(unit) then
        return LocalVars.ColorAttackingOtherTank -- When unit is tanked by another
    elseif unit.threatValue > 2 then
        return LocalVars.ColorAttackingOthers -- When player is solid target    -- Safe
    elseif unit.threatValue == 2 then
        return LocalVars.ColorAggroTransition -- Transition
    else
        return LocalVars.ColorAttackingMe
    end -- Warning
end

local function ColorFunctionByThreatAutoDetect(unit)
    if InCombatLockdown() and unit.reaction ~= "FRIENDLY" and unit.type == "NPC" then
        if TidyPlatesWidgets.IsTankingAuraActive then
            return ColorFunctionTankSwapColors(unit)
        else
            return ColorFunctionDamage(unit)
        end
    end
end

local function ColorFunctionByThreat(unit)
    if InCombatLockdown() and unit.reaction ~= "FRIENDLY" and unit.type == "NPC" then
        if TidyPlatesWidgets.IsTankingAuraActive then
            return ColorFunctionTank(unit)
        else
            return ColorFunctionDamage(unit)
        end
    end
end

-- By Raid Icon
local function ColorFunctionByRaidIcon(unit)
    return RaidIconColors[unit.raidIcon]
end

local function ColorFunctionByReaction(unit)
    if unit.reaction == "FRIENDLY" and unit.type == "PLAYER" then
        if IsGuildmate(unit.name) then
            return PaleBlue
        elseif IsFriend(unit.name) then
            return BrightBlue
        end
    end

    return ReactionColors[unit.reaction][unit.type]
end

local function ColorFunctionByLevelColor(unit)
    tempColor.r, tempColor.g, tempColor.b = unit.levelcolorRed, unit.levelcolorGreen, unit.levelcolorBlue
    return tempColor
end

local ColorFunctions = {
    DummyFunction,
    ColorFunctionByClassEnemy,
    ColorFunctionByThreatAutoDetect,
    ColorFunctionByReaction,
    ColorFunctionByLevelColor,
    ColorFunctionByRaidIcon,
    ColorFunctionByHealth,
    ColorFunctionByThreat,
    ColorFunctionByClassFriendly
}

local function HealthColorDelegate(unit)
    local color, class

    -- Aggro Coloring
    if unit.reaction == "FRIENDLY" then
        if LocalVars.ColorShowPartyAggro and LocalVars.ColorPartyAggroBar then
            if GetAggroCondition(unit.name) then
                color = LocalVars.ColorPartyAggro
            end
        end
    end

    if not color then
        color = ColorFunctions[LocalVars.ColorHealthBarMode](unit)
    end

    if color then
        return color.r, color.g, color.b
    else
        return unit.red, unit.green, unit.blue
    end
end

------------------------------------------------------------------------------
-- Warning Border Color
------------------------------------------------------------------------------
local WarningColor = {}

-- Player Health (na)
local function WarningBorderFunctionByPlayerHealth(unit)
    local healthPct = UnitHealth("player") / UnitHealthMax("player")
    if healthPct < .3 then
        return DarkRed
    end
end

-- "By Threat (High) Damage"
local function WarningBorderFunctionByThreatDamage(unit)
    if InCombatLockdown and unit.reaction ~= "FRIENDLY" and unit.type == "NPC" then
        if unit.threatValue > 0 then
            return ColorFunctionDamage(unit)
        end
    end
end

-- "By Threat (Low) Tank"
local function WarningBorderFunctionByThreatTank(unit)
    if unit.InCombatLockdown and unit.reaction ~= "FRIENDLY" and unit.type == "NPC" then
        if unit.threatValue < 3 and not IsTankedByAnotherTank(unit) then
            return ColorFunctionTank(unit)
        end
    end
end

-- Warning Glow (Auto Detect)
local function WarningBorderFunctionByThreatAutoDetect(unit)
    if unit.InCombatLockdown and unit.reaction ~= "FRIENDLY" and unit.type == "NPC" then
        if TidyPlatesWidgets.IsTankingAuraActive and (not IsTankedByAnotherTank(unit)) then
            if unit.threatValue == 2 then
                return LocalVars.ColorAggroTransition
            elseif unit.threatValue < 2 then
                return LocalVars.ColorAttackingMe
            end
        elseif unit.threatValue > 0 then
            return ColorFunctionDamage(unit)
        end
    end
end

-- By Enemy Healer
local function WarningBorderFunctionByEnemyHealer(unit)
    if unit.reaction == "HOSTILE" and unit.type == "PLAYER" then
        if IsHealer(unit.name) then
            WarningColor.r = unit.red
            WarningColor.g = unit.green
            WarningColor.b = unit.blue
            return WarningColor
        end
    end
end

local WarningBorderFunctionsUniversal = {
    DummyFunction,
    WarningBorderFunctionByThreatAutoDetect,
    WarningBorderFunctionByThreatDamage,
    WarningBorderFunctionByThreatTank,
    WarningBorderFunctionByEnemyHealer
}

local function ThreatColorDelegate(unit)
    local color

    if LocalVars.ColorShowPartyAggro and LocalVars.ColorPartyAggroGlow and unit.reaction == "FRIENDLY" then
        if GetAggroCondition(unit.name) then
            color = LocalVars.ColorPartyAggro
        end
    else
        color = WarningBorderFunctionsUniversal[LocalVars.ColorDangerGlowMode](unit)
    end

    if color then
        return color.r, color.g, color.b, 1
    else
        return 0, 0, 0, 0
    end
end

------------------------------------------------------------------------------
-- Cast Bar Color
------------------------------------------------------------------------------
local function CastBarDelegate(unit)
    local color
    if unit.spellInterruptible then
        color = GoldColor
    else
        color = WhiteColor
    end
    return color.r, color.g, color.b, 1
end

------------------------------------------------------------------------------
-- Name Text Color
------------------------------------------------------------------------------

-- By Reaction
local function NameColorByReaction(unit)
    if IsGuildmate(unit.name) then
        return PaleBlueText
    elseif IsFriend(unit.name) then
        return BrightBlueText
    end

    return NameReactionColors[unit.reaction][unit.type]
end

-- By Significance
local function NameColorBySignificance(unit)
    if unit.reaction ~= "FRIENDLY" then
        if unit.isTarget then
            return White
        elseif unit.isBoss or unit.isMarked then
            return BossGrey
        elseif unit.isElite or (unit.levelcolorRed > .9 and unit.levelcolorGreen < .9) then
            return EliteGrey
        else
            return NormalGrey
        end
    else
        return NameColorByReaction(unit)
    end
end

local function NameColorByClass(unit)
    local class, color

    if unit.type == "PLAYER" then
        -- Determine Unit Class
        if unit.reaction == "FRIENDLY" then
            class = GetFriendlyClass(unit.name)
        else
            class = unit.class or GetEnemyClass(unit.name)
        end

        -- Return color
        if class and RaidClassColors[class] then
            return RaidClassColors[class]
        end
    end

    -- For unit types with no Class info available, return reaction color
    return NameReactionColors[unit.reaction][unit.type]
end

local function NameColorByFriendlyClass(unit)
    local class, color

    if unit.type == "PLAYER" and unit.reaction == "FRIENDLY" then
        -- Determine Unit Class
        class = GetFriendlyClass(unit.name)

        -- Return color
        if class and RaidClassColors[class] then
            return RaidClassColors[class]
        end
    end

    -- For unit types with no Class info available, return reaction color
    return NameReactionColors[unit.reaction][unit.type]
end

local function NameColorByEnemyClass(unit)
    local class, color

    if unit.type == "PLAYER" and unit.reaction == "HOSTILE" then
        class = unit.class or GetEnemyClass(unit.name)

        -- Return color
        if class and RaidClassColors[class] then
            return RaidClassColors[class]
        end
    end

    -- For unit types with no Class info available, return reaction color
    return NameReactionColors[unit.reaction][unit.type]
end

local function NameColorByThreat(unit)
    if InCombatLockdown() then
        return ColorFunctionByThreat(unit)
    else
        return NameReactionColors[unit.reaction][unit.type]
    end
end

local function NameColorByThreatAutoDetect(unit)
    local color
    if InCombatLockdown() then
        color = ColorFunctionByThreatAutoDetect(unit)
    end
    if not color then
        color = NameReactionColors[unit.reaction][unit.type]
    end
    return color
end

local NameColorFunctions = {
    -- Default
    function(unit)
        return White
    end,
    -- By Class
    NameColorByEnemyClass,
    --NameColorByClass,
    -- By Threat
    NameColorByThreatAutoDetect,
    -- By Reaction
    NameColorByReaction,
    -- By Level Color
    ColorFunctionByLevelColor,
    -- By Health
    ColorFunctionByHealth,
    -- By Significance
    NameColorBySignificance,
    -- By Threat (Legacy)
    NameColorByThreat,
    -- By Friendly Class
    NameColorByFriendlyClass
}

local function SetNameColorDelegate(unit)
    local color, colorMode

    if unit.reaction == "FRIENDLY" then
        -- Party Aggro Coloring
        if LocalVars.ColorShowPartyAggro and LocalVars.ColorPartyAggroText then
            if GetAggroCondition(unit.name) then
                color = LocalVars.ColorPartyAggro
            end
        end
    end

    if not color then
        if StyleDelegate(unit) == 2 then
            colorMode = tonumber(LocalVars.TextPlateNameColorMode)
        else
            colorMode = tonumber(LocalVars.TextNameColorMode)
        end

        color = NameColorFunctions[colorMode or 1](unit)
    end

    if color then
        return color.r, color.g, color.b, (color.a or 1)
    else
        return 1, 1, 1, 1
    end
end

------------------------------------------------------------------------------
-- Optional/Health Text
------------------------------------------------------------------------------

local function HealthAndMana(unit)
    if unit.isTarget then
        local power = ceil((UnitPower("target") / UnitPowerMax("target")) * 100)
        local _, powername = UnitPowerType("target")
        if power and power > 0 then
            return power .. "% " .. powername
        end
    end
end

-- None
local function HealthFunctionNone()
    return ""
end
-- Percent
local function TextHealthPercentColored(unit)
    local color = ColorFunctionByHealth(unit)
    return ceil(100 * (unit.health / unit.healthmax)) .. "%", color.r, color.g, color.b, .7
end

local function HealthFunctionPercent(unit)
    if unit.health < unit.healthmax then
        return TextHealthPercentColored(unit)
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
-- Level
local function HealthFunctionLevel(unit)
    local level = unit.level
    if unit.isElite then
        level = level .. " (Elite)"
    end
    return level, unit.levelcolorRed, unit.levelcolorGreen, unit.levelcolorBlue, .70
end
-- Level and Health
local function HealthFunctionLevelHealth(unit)
    local level = unit.level
    if unit.isElite then
        level = level .. "E"
    end
    return level .. "  |cffffffff" .. HealthFunctionApprox(unit), unit.levelcolorRed, unit.levelcolorGreen, unit.levelcolorBlue, .70
end

local HealthTextModeFunctions = {
    HealthFunctionNone,
    HealthFunctionPercent,
    HealthFunctionExact,
    HealthFunctionDeficit,
    HealthFunctionTotal,
    HealthFunctionTargetOf,
    HealthFunctionApprox,
    HealthFunctionLevel,
    HealthFunctionLevelHealth,
    HealthAndMana
}

local function HealthTextDelegate(unit)
    return HealthTextModeFunctions[LocalVars.TextHealthTextMode](unit)
end

------------------------------------------------------------------------------------
-- Binary/Headline Text Styles
------------------------------------------------------------------------------------
local function RoleOrGuildText(unit)
    if unit.type == "NPC" then
        return (CachedUnitDescription(unit.name) or GetLevelDescription(unit) or ""), 1, 1, 1, .70
    end
end

-- Role, Guild or Level
local function TextRoleGuildLevel(unit)
    local description
    local r, g, b = 1, 1, 1

    if unit.type == "NPC" then
        description = CachedUnitDescription(unit.name)

        if not description and unit.reaction ~= "FRIENDLY" then
            description = GetLevelDescription(unit)
            r, g, b = unit.levelcolorRed, unit.levelcolorGreen, unit.levelcolorBlue
        end
    elseif unit.type == "PLAYER" then
        description = CachedUnitGuild(unit.name)
        r, g, b = .5, .5, .7
    end

    return description, r, g, b, .70
end

-- Role or Guild
local function TextRoleGuild(unit)
    local description
    local r, g, b = 1, 1, 1

    if unit.type == "NPC" then
        description = CachedUnitDescription(unit.name)
    elseif unit.type == "PLAYER" then
        description = CachedUnitGuild(unit.name)
        r, g, b = .5, .5, .7
    end

    return description, r, g, b, .70
end

-- NPC Role
local function TextNPCRole(unit)
    if unit.type == "NPC" then
        return CachedUnitDescription(unit.name)
    end
end

-- Level
local function TextLevelColored(unit)
    --return GetLevelDescription(unit) , 1, 1, 1, .70
    return GetLevelDescription(unit), unit.levelcolorRed, unit.levelcolorGreen, unit.levelcolorBlue, .70
end

-- Guild, Role, Level, Health
function TextAll(unit)
    local color = ColorFunctionByHealth(unit)
    if unit.health < unit.healthmax then
        return ceil(100 * (unit.health / unit.healthmax)) .. "%", color.r, color.g, color.b, .7
    else
        --return GetLevelDescription(unit) , unit.levelcolorRed, unit.levelcolorGreen, unit.levelcolorBlue, .7
        return TextRoleGuildLevel(unit)
    end
end

local TextPlateFieldFunctions = {
    -- None
    DummyFunction,
    -- Health Text
    TextHealthPercentColored,
    -- Role, Guild or Level
    TextRoleGuildLevel,
    -- Role or Guild
    TextRoleGuild,
    -- NPC Role
    TextNPCRole,
    -- Level
    TextLevelColored,
    -- Level or Health
    TextAll
}

local function CustomTextBinaryDelegate(unit)
    if StyleDelegate(unit) == 2 then
        return TextPlateFieldFunctions[LocalVars.TextPlateFieldMode](unit)
    end
    return HealthTextDelegate(unit)
end

------------------------------------------------------------------------------
-- Scale
------------------------------------------------------------------------------

-- By Low Health
local function ScaleFunctionByLowHealth(unit)
    if unit.health / unit.healthmax < LocalVars.LowHealthThreshold then
        return LocalVars.ScaleSpotlight
    end
end

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
    elseif LocalVars.ColorShowPartyAggro and unit.reaction == "FRIENDLY" then
        if GetAggroCondition(unit.name) then
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
    elseif LocalVars.ColorShowPartyAggro and unit.reaction == "FRIENDLY" then
        if GetAggroCondition(unit.name) then
            return LocalVars.ScaleSpotlight
        end
    end
end

-- By Debuff Widget
local function ScaleFunctionByActiveDebuffs(unit, frame)
    local widget = unit.frame.widgets.DebuffWidget
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

-- By Enemy Healer
local function ScaleFunctionByEnemyHealer(unit)
    if unit.reaction == "HOSTILE" and unit.type == "PLAYER" then
        if IsHealer(unit.name) then
            return LocalVars.ScaleSpotlight
        end
    end
end

-- By Boss
local function ScaleFunctionByBoss(unit)
    if unit.isBoss and unit.isElite then
        return LocalVars.ScaleSpotlight
    end
end

-- By Threat (Auto Detect)
local function ScaleFunctionByThreatAutoDetect(unit)
    if TidyPlatesWidgets.IsTankingAuraActive then
        return ScaleFunctionByThreatLow(unit) -- tank mode
    else
        return ScaleFunctionByThreatHigh(unit)
    end -- dps mode
end

-- Function List
local ScaleFunctionsUniversal = {
    DummyFunction,
    ScaleFunctionByElite,
    ScaleFunctionByTarget,
    ScaleFunctionByThreatAutoDetect,
    ScaleFunctionByThreatHigh,
    ScaleFunctionByThreatLow,
    ScaleFunctionByActiveDebuffs,
    ScaleFunctionByEnemy,
    ScaleFunctionByNPC,
    ScaleFunctionByRaidIcon,
    ScaleFunctionByEnemyHealer,
    ScaleFunctionByLowHealth,
    ScaleFunctionByBoss
}

-- Scale Functions Listed by Role order: Damage, Tank, Heal
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
    elseif LocalVars.ScaleCastingSpotlight and unit.isCasting then
        scale = LocalVars.ScaleSpotlight
    else
        scale = ScaleFunctionsUniversal[LocalVars.ScaleSpotlightMode](...)
    end

    return scale or LocalVars.ScaleStandard
end

------------------------------------------------------------------------------
-- Opacity / Alpha
------------------------------------------------------------------------------

-- By Low Health
local function AlphaFunctionByLowHealth(unit)
    if unit.health / unit.healthmax < LocalVars.LowHealthThreshold then
        return LocalVars.OpacitySpotlight
    end
end

-- By Threat (High)
local function AlphaFunctionByThreatHigh(unit)
    if InCombatLockdown() and unit.reaction == "HOSTILE" then
        if unit.threatValue > 1 and unit.health > 0 then
            return LocalVars.OpacitySpotlight
        end
    elseif LocalVars.ColorShowPartyAggro and unit.reaction == "FRIENDLY" then
        if GetAggroCondition(unit.name) then
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
    elseif LocalVars.ColorShowPartyAggro and unit.reaction == "FRIENDLY" then
        if GetAggroCondition(unit.name) then
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
    if IsAuraShown(widget) then
        return LocalVars.OpacitySpotlight
    end
end

-- By Enemy Healer
local function AlphaFunctionByEnemyHealer(unit)
    if unit.reaction == "HOSTILE" and unit.type == "PLAYER" then
        if IsHealer(unit.name) then
            return LocalVars.OpacitySpotlight
        end
    end
end

-- By Threat (Auto Detect)
local function AlphaFunctionByThreatAutoDetect(unit)
    if TidyPlatesWidgets.IsTankingAuraActive then
        return AlphaFunctionByThreatLow(unit) -- tank mode
    else
        return AlphaFunctionByThreatHigh(unit)
    end -- dps mode
end

local function AlphaFilter(unit)
    if LocalVars.OpacityFilterLookup[unit.name] then
        return true
    elseif LocalVars.OpacityFilterNeutralUnits and unit.reaction == "NEUTRAL" then
        return true
    elseif LocalVars.OpacityFilterFriendlyNPC and unit.type == "NPC" and unit.reaction == "FRIENDLY" then
        return true
    elseif LocalVars.OpacityFilterNPC and unit.type == "NPC" then
        return true
    elseif LocalVars.OpacityFilterNonElite and (not unit.isElite) then
        return true
    elseif LocalVars.OpacityFilterInactive then
        if
            unit.reaction ~= "FRIENDLY" and
                not (unit.isMarked or unit.isInCombat or unit.threatValue > 0 or unit.health < unit.healthmax)
         then
            return true
        end
    end
end

local AlphaFunctionsUniversal = {
    DummyFunction,
    AlphaFunctionByThreatAutoDetect,
    AlphaFunctionByThreatHigh,
    AlphaFunctionByThreatLow,
    AlphaFunctionByActiveDebuffs,
    AlphaFunctionByEnemy,
    AlphaFunctionByNPC,
    AlphaFunctionByRaidIcon,
    AlphaFunctionByActive,
    AlphaFunctionByEnemyHealer,
    AlphaFunctionByLowHealth
}

-- Alpha Functions Listed by Role order: Damage, Tank, Heal
local AlphaFunctions = {_G.AlphaFunctionsDamage, _G.AlphaFunctionsTank}

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
    elseif unit.isMouseover and LocalVars.OpacityFullMouseover then
        return Diminish(LocalVars.OpacityTarget)
    else
        -- Filter
        if AlphaFilter(unit) then
            -- Spotlight
            alpha = LocalVars.OpacityFiltered
        else
            alpha = AlphaFunctionsUniversal[LocalVars.OpacitySpotlightMode](...)
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

------------------------------------------------------------------------------
-- Widgets
------------------------------------------------------------------------------

local function GetPrefixPriority(debuff)
    local spellid = tostring(debuff.spellid)
    local name = debuff.name
    local prefix = LocalVars.WidgetsDebuffLookup[spellid] or LocalVars.WidgetsDebuffLookup[name]
    local priority = LocalVars.WidgetsDebuffPriority[spellid] or LocalVars.WidgetsDebuffPriority[name]
    return prefix, priority
end

local DebuffPrefixModes = {
    -- All
    function(debuff)
        return true
    end,
    -- My
    function(debuff)
        if debuff.caster == UnitGUID("player") then
            return true
        else
            return nil
        end
    end,
    -- No
    function(debuff)
        return nil
    end,
    -- CC
    function(debuff)
        return true
    end,
    -- Other
    function(debuff)
        if debuff.caster ~= UnitGUID("player") then
            return true
        end
    end
}

local DebuffFilterModes = {
    -- My Debuffs
    function(aura)
        if aura.caster == UnitGUID("player") and aura.type > 1 then
            return true
        end
    end,
    -- My Buffs
    function(aura)
        if aura.caster == UnitGUID("player") and aura.type == 1 and aura.duration < 120 then
            return true
        end
    end,
    -- By Prefix
    function(aura)
        local prefix, priority = GetPrefixPriority(aura)
        if prefix then
            return DebuffPrefixModes[prefix](aura), priority
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
    -- Debuffs on Friendly Units
    if aura.target == AURA_TARGET_FRIENDLY then
        return false
    end

    -- Debuffs on Hostile Units
    return DebuffFilterModes[LocalVars.WidgetsAuraMode](aura)
end

local function Prefilter(spellid, spellname, auratype)
    return (LocalVars.WidgetsDebuffLookup[tostring(spellid)] or LocalVars.WidgetsDebuffLookup[spellname] ~= nil)
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
            widget:SetPoint(config.anchor or "CENTER", config.x or 0, config.y or 0) --0, 0)
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
            widget:SetPoint(config.anchor or "TOP", plate, config.x or 0, config.y or 0) --15, 20)
            widget:SetFrameLevel(plate:GetFrameLevel() + 1)
            widget.Filter = DebuffFilter
            plate.widgets.DebuffWidget = widget
        end
    elseif plate.widgets.DebuffWidget then
        plate.widgets.DebuffWidget:Hide()
        plate.widgets.DebuffWidget = nil
    end
end

------------------------------------------------------------------------------
-- Widget Activation
------------------------------------------------------------------------------

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
    if LocalVars.WidgetsComboPoints and configTable.DebuffWidgetPlus then -- If the combo widget is active, it often overlaps the debuff widget "DebuffWidgetPlus" will provide an alternative
        AddDebuffWidget(plate, LocalVars.WidgetsDebuff, configTable.DebuffWidgetPlus)
    else
        AddDebuffWidget(plate, LocalVars.WidgetsDebuff, configTable.DebuffWidget)
    end
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
    if
        (LocalVars.ClassEnemyIcon and unit.reaction ~= "FRIENDLY") or
            (LocalVars.ClassPartyIcon and unit.reaction == "FRIENDLY")
     then
        Widgets.ClassIcon:Update(unit, LocalVars.ClassPartyIcon)
    end
    if LocalVars.WidgetsTotemIcon then
        Widgets.TotemIcon:Update(unit)
    end
    if (LocalVars.WidgetsThreatIndicatorMode == 2) and LocalVars.WidgetsThreatIndicator then
        plate.widgets.ThreatWheelWidget:Update(unit)
    end -- Threat Wheel
end

-- Threat Functions List
local ThreatFunctionList = {
    [ScaleFunctionByThreatLow] = true,
    [ScaleFunctionByThreatHigh] = true,
    [ScaleFunctionByThreatAutoDetect] = true,
    [AlphaFunctionByThreatHigh] = true,
    [AlphaFunctionByThreatLow] = true,
    [AlphaFunctionByThreatAutoDetect] = true,
    [ColorFunctionByThreatAutoDetect] = true,
    [ColorFunctionByThreat] = true,
    [NameColorByThreat] = true,
    [NameColorByThreatAutoDetect] = true,
    [WarningBorderFunctionByThreatDamage] = true,
    [WarningBorderFunctionByThreatTank] = true,
    [WarningBorderFunctionByThreatAutoDetect] = true
}

local function EnableWatchers()
    if LocalVars.WidgetsDebuffStyle == 2 then
        TidyPlatesWidgets.UseSquareDebuffIcon()
    else
        TidyPlatesWidgets.UseWideDebuffIcon()
    end
    TidyPlatesUtility:EnableGroupWatcher()
    if LocalVars.AdvancedEnableUnitCache then
        TidyPlatesUtility:EnableUnitCache()
    else
        TidyPlatesUtility:DisableUnitCache()
    end

    -- Healer Tracker
    if
        (ScaleFunctionsUniversal[LocalVars.ScaleSpotlightMode] == ScaleFunctionByEnemyHealer) or
            AlphaFunctionsUniversal[LocalVars.OpacitySpotlightMode] == AlphaFunctionByEnemyHealer or
            WarningBorderFunctionsUniversal[LocalVars.ColorDangerGlowMode] == WarningBorderFunctionByEnemyHealer
     then
        TidyPlatesUtility:EnableHealerTrack()
    else
        TidyPlatesUtility:DisableHealerTrack()
    end

    -- Aggro/Threat
    if
        ThreatFunctionList[AlphaFunctionsUniversal[LocalVars.OpacitySpotlightMode]] or
            ThreatFunctionList[ColorFunctions[LocalVars.ColorHealthBarMode]] or
            ThreatFunctionList[WarningBorderFunctionsUniversal[LocalVars.ColorDangerGlowMode]] or
            ThreatFunctionList[ScaleFunctionsUniversal[LocalVars.ScaleSpotlightMode]] or
            ThreatFunctionList[NameColorFunctions[LocalVars.TextPlateNameColorMode]] or
            ThreatFunctionList[NameColorFunctions[LocalVars.TextNameColorMode]]
     then
        SetCVar("threatWarning", 3)
    end

    if LocalVars.WidgetsAuraMode == 3 then
        TidyPlatesWidgets.SetDebuffPrefilter(Prefilter)
    else
        TidyPlatesWidgets.SetDebuffPrefilter(nil)
    end

    TidyPlatesWidgets:EnableTankWatch()
    TidyPlatesWidgets:EnableAggroWatch()
    if LocalVars.WidgetsDebuff then
        TidyPlatesWidgets:EnableAuraWatcher()
    else
        TidyPlatesWidgets:DisableAuraWatcher()
    end
end

local CreateVariableSet = TidyPlatesHubRapidPanel.CreateVariableSet

local function UseDamageVariables()
    local objectName = "HubPanelSettingsDamage"
    LocalVars = TidyPlatesHubSettings[objectName] or CreateVariableSet(objectName)
    return LocalVars
end

local function UseTankVariables()
    local objectName = "HubPanelSettingsTank"
    LocalVars = TidyPlatesHubSettings[objectName] or CreateVariableSet(objectName)
    return LocalVars
end
--]]

local function UseVariables(suffix)
    if suffix then
        local objectName = "HubPanelSettings" .. suffix
        LocalVars = TidyPlatesHubSettings[objectName] or CreateVariableSet(objectName)
        return LocalVars
    end
end

---------------
-- Apply customization
---------------
local blizzfont = NAMEPLATE_FONT

local function ApplyFontCustomization(style)
    if not style then
        return
    end
    if LocalVars.TextUseBlizzardFont then
        style.oldfont = style.name.typeface
        style.name.typeface = blizzfont
        style.level.typeface = blizzfont
        style.customtext.typeface = blizzfont
        style.spelltext.typeface = blizzfont
    else
        local typeface = style.oldfont or style.name.typeface
        style.name.typeface = typeface
        style.level.typeface = typeface
        style.customtext.typeface = typeface
        style.spelltext.typeface = typeface
    end
    style.frame.y = ((LocalVars.FrameVerticalPosition - .5) * 50) - 16
end

local function ApplyStyleCustomization(style)
    if not style then
        return
    end
    style.level.show = (LocalVars.TextShowLevel == true)
    style.target.show = (LocalVars.WidgetTargetHighlight == true)
    style.eliteicon.show = (LocalVars.WidgetEliteIndicator == true)
    ApplyFontCustomization(style)
end

local function ApplyThemeCustomization(theme)
    EnableWatchers()
    ApplyStyleCustomization(theme["Default"])
    ApplyFontCustomization(theme["NameOnly"])
    TidyPlates:ForceUpdate()
end

---------------------------------------------
-- Function List
---------------------------------------------
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
TidyPlatesHubFunctions.UseVariables = UseVariables
TidyPlatesHubFunctions.EnableWatchers = EnableWatchers
TidyPlatesHubFunctions._WidgetDebuffFilter = DebuffFilter
TidyPlatesHubFunctions.ApplyFontCustomization = ApplyFontCustomization
TidyPlatesHubFunctions.ApplyStyleCustomization = ApplyStyleCustomization
TidyPlatesHubFunctions.ApplyThemeCustomization = ApplyThemeCustomization
TidyPlatesHubFunctions.SetMultistyle = StyleDelegate
TidyPlatesHubFunctions.SetStyleBinary = SetStyleBinaryDelegate
TidyPlatesHubFunctions.SetCustomTextBinary = CustomTextBinaryDelegate

---------------------------------------------
-- Slash Commands
---------------------------------------------
local function ShowCurrentHubPanel()
    local theme = TidyPlatesThemeList[TidyPlatesOptions[GetCurrentSpec()]]
    if theme and theme.ShowConfigPanel and type(theme.ShowConfigPanel) == "function" then
        theme.ShowConfigPanel()
    end
end

_G.SLASH_HUB1 = "/hub"
SlashCmdList["HUB"] = ShowCurrentHubPanel