if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local _, TidyPlates = ...
local L = TidyPlates.L

----------------------
--[[ TidyPlatesPanel.lua ]]--
----------------------

-- L["No Automation"] = true
-- L["Show during Combat, Hide when Combat ends"] = true
-- L["Hide when Combat starts, Show when Combat ends"] = true
-- L["Primary Theme:"] = true
-- L["Secondary Theme:"] = true
-- L["Please choose a theme for your Primary and Secondary Specializations. The appropriate theme will be automatically activated when you switch specs."] = true
-- L["Enemy Nameplates:"] = true
-- L["Friendly Nameplates:"] = true
-- L["Automation can automatically turn on or off Friendly and Enemy nameplates."] = true
-- L["Blizzard Nameplate Motion & Visibility"] = true
-- L["Show Non-Target Casting Bars (When Possible)"] = true
-- L["Enable Minimap Icon"] = true
-- L["Reset Configuration"] = true
-- L["|cFFFF6600Tidy Plates: |cFFFFFFFFWidget file versions do not match. This may be caused by an issue with auto-updater software."] = true
-- L["Please uninstall Tidy Plates, and then re-install. You do NOT need to clear your variables."] = true
-- L["|cFFFF6600Tidy Plates: |cFFFF9900No Theme is Selected. |cFF77FF00Use |cFFFFFF00/tidyplates|cFF77FF00 to bring up the Theme Selection Window."] = true

-- L.resetTidyPlanel = "%sResetting %sTidy Plates %sTheme Selection to Default"
-- L.commonResetPanel = "%sResetting %sTidy Plates Hub: %s%s %sConfiguration to Default"
-- L.resetTidyPlanelShift = "%sHolding down %sShift %swhile clicking %sReset Configuration %swill clear your saved settings, AND reload the user interface."
-- L.commonCopyPanel = "%sCopied %sTidy Plates Hub: %s%s %sTheme Values to Cache."
-- L.commonPastePanel = "%sPasted %sTidy Plates Hub: %s%s %sTheme Values from Cache."

----------------------
--[[ TankPanel.lua ]]--
----------------------

-- L["Default"] = true
-- L["Text Only"] = true
-- L["Bars during Combat"] = true
-- L["Bars on Active/Damaged Units"] = true
-- L["Bars on Elite Units"] = true
-- L["Bars on Marked Units"] = true
-- L["Bars on Players"] = true
-- L["None"] = true
-- L["Percent Health"] = true
-- L["Exact health"] = true
-- L["Health Deficit"] = true
-- L["Health Total & Percent"] = true
-- L["Target Of"] = true
-- L["Approximate Health"] = true
-- L["9 yards"] = true
-- L["15 yards"] = true
-- L["28 yards"] = true
-- L["40 yards"] = true
-- L["Show All"] = true
-- L["Show These... "] = true
-- L["Show All Mine "] = true
-- L["Show My... "] = true
-- L["By Prefix..."] = true
-- L["By Low Threat"] = true
-- L["By Mouseover"] = true
-- L["By Debuff Widget"] = true
-- L["By Enemy"] = true
-- L["By NPC"] = true
-- L["By Raid Icon"] = true
-- L["By Active/Damaged"] = true
-- L["By Elite"] = true
-- L["By Target"] = true
-- L["By Class"] = true
-- L["By Threat"] = true
-- L["By Reaction"] = true
-- L["Tug-o-Threat"] = true
-- L["Threat Wheel"] = true
-- L["Style"] = true
-- L["Opacity"] = true
-- L["Current Target Opacity:"] = true
-- L["Non-Target Opacity:"] = true
-- L["Opacity Spotlight Mode:"] = true
-- L["Spotlight Opacity:"] = true
-- L["Bring Casting Units to Target Opacity"] = true
-- L["Use Target Opacity When No Target Exists"] = true
-- L["Filtered Unit Opacity:"] = true
-- L["Filter Neutral Units"] = true
-- L["Filter Non-Elite"] = true
-- L["Filter Inactive"] = true
-- L["Filter By Unit Name:"] = true
-- L["Scale"] = true
-- L["Normal Scale:"] = true
-- L["Scale Spotlight Mode:"] = true
-- L["Spotlight Scale:"] = true
-- L["Ignore Neutral Units"] = true
-- L["Ignore Non-Elite Units"] = true
-- L["Ignore Inactive Units"] = true
-- L["Text"] = true
-- L["Name Text Color Mode:"] = true
-- L["Health Text:"] = true
-- L["Show Level Text"] = true
-- L["Use Default Blizzard Font"] = true
-- L["Color"] = true
-- L["Health Bar Color Mode:"] = true
-- L["Warning Glow/Border Mode:"] = true
-- L["Threat Colors:"] = true
-- L["Attacking Me"] = true
-- L["Losing Aggro"] = true
-- L["Attacking Others"] = true
-- L["Attacking Another Tank"] = true
-- L["Show Warning around Group Members with Aggro"] = true
-- L["Show Class Color for Party and Raid Members"] = true
-- L["Widgets"] = true
-- L["Show Highlight on Current Target"] = true
-- L["Show Elite Indicator"] = true
-- L["Show Enemy Class Icons"] = true
-- L["Show Party Member Class Icons"] = true
-- L["Show Totem Icons"] = true
-- L["Show Combo Points"] = true
-- L["Show Threat Indicator"] = true
-- L["Threat Indicator:"] = true
-- L["Show Party Range Warning"] = true
-- L["Range:"] = true
-- L["Show My Debuff Timers"] = true
-- L["Debuff Filter:"] = true
-- L["Debuff Names:"] = true
-- L["WidgetsDebuffTrackList_Description"] = [[
-- Tip: |cffCCCCCCDebuffs should be listed with the exact name, or a spell ID number.
-- You can use the prefixes, "My" or "All", to distinguish personal damage spells from global crowd control spells.
-- Auras at the top of the list will get displayed before lower ones.|r
-- ]]
-- L["Frame"] = true
-- L["Vertical Position of Artwork:"] = true
-- L["Paste"] = true
-- L["Copy"] = true
-- L["Reset"] = true

----------------------
--[[ DamagePanel.lua ]]--
----------------------

-- L["Show All Debuffs"] = true
-- L["Show Specific Debuffs... "] = true
-- L["Show All My Debuffs "] = true
-- L["Show My Specific Debuffs... "] = true
-- L["By High Threat"] = true
-- L["Gaining Aggro"] = true
-- L["Show Warning on Group Members with Aggro"] = true

---------------------
--[[ Totem Names ]]--
---------------------

L["Fire Resistance Totem I"] = "Tótem de resistencia al fuego I"
L["Fire Resistance Totem II"] = "Tótem de resistencia al fuego II"
L["Fire Resistance Totem III"] = "Tótem de resistencia al fuego III"
L["Fire Resistance Totem IV"] = "Tótem de resistencia al fuego IV"
L["Fire Resistance Totem V"] = "Tótem de resistencia al fuego V"
L["Fire Resistance Totem VI"] = "Tótem de resistencia al fuego VI"
L["Flametongue Totem I"] = "Tótem Lengua de Fuego I"
L["Flametongue Totem II"] = "Tótem Lengua de Fuego II"
L["Flametongue Totem III"] = "Tótem Lengua de Fuego III"
L["Flametongue Totem IV"] = "Tótem Lengua de Fuego IV"
L["Flametongue Totem V"] = "Tótem Lengua de Fuego V"
L["Flametongue Totem VI"] = "Tótem Lengua de Fuego VI"
L["Flametongue Totem VII"] = "Tótem Lengua de Fuego VII"
L["Flametongue Totem VIII"] = "Tótem Lengua de Fuego VIII"
L["Frost Resistance Totem I"] = "Tótem de resistencia a la escarcha I"
L["Frost Resistance Totem II"] = "Tótem de resistencia a la escarcha II"
L["Frost Resistance Totem III"] = "Tótem de resistencia a la escarcha III"
L["Frost Resistance Totem IV"] = "Tótem de resistencia a la escarcha IV"
L["Frost Resistance Totem V"] = "Tótem de resistencia a la escarcha V"
L["Frost Resistance Totem VI"] = "Tótem de resistencia a la escarcha VI"
L["Healing Stream Totem I"] = "Tótem Corriente de sanación I"
L["Healing Stream Totem II"] = "Tótem Corriente de sanación II"
L["Healing Stream Totem III"] = "Tótem Corriente de sanación III"
L["Healing Stream Totem IV"] = "Tótem Corriente de sanación IV"
L["Healing Stream Totem IX"] = "Tótem Corriente de sanación IX"
L["Healing Stream Totem V"] = "Tótem Corriente de sanación V"
L["Healing Stream Totem VI"] = "Tótem Corriente de sanación VI"
L["Healing Stream Totem VII"] = "Tótem Corriente de sanación VII"
L["Healing Stream Totem VIII"] = "Tótem Corriente de sanación VIII"
L["Magma Totem I"] = "Tótem de magma I"
L["Magma Totem II"] = "Tótem de magma II"
L["Magma Totem III"] = "Tótem de magma III"
L["Magma Totem IV"] = "Tótem de magma IV"
L["Magma Totem V"] = "Tótem de magma V"
L["Magma Totem VI"] = "Tótem de magma VI"
L["Magma Totem VII"] = "Tótem de magma VII"
L["Mana Spring Totem I"] = "Tótem Fuente de maná I"
L["Mana Spring Totem II"] = "Tótem Fuente de maná II"
L["Mana Spring Totem III"] = "Tótem Fuente de maná III"
L["Mana Spring Totem IV"] = "Tótem Fuente de maná IV"
L["Mana Spring Totem V"] = "Tótem Fuente de maná V"
L["Mana Spring Totem VI"] = "Tótem Fuente de maná VI"
L["Mana Spring Totem VII"] = "Tótem Fuente de maná VII"
L["Mana Spring Totem VIII"] = "Tótem Fuente de maná VIII"
L["Nature Resistance Totem I"] = "Tótem de resistencia a la Naturaleza I"
L["Nature Resistance Totem II"] = "Tótem de resistencia a la Naturaleza II"
L["Nature Resistance Totem III"] = "Tótem de resistencia a la Naturaleza III"
L["Nature Resistance Totem IV"] = "Tótem de resistencia a la Naturaleza IV"
L["Nature Resistance Totem V"] = "Tótem de resistencia a la Naturaleza V"
L["Nature Resistance Totem VI"] = "Tótem de resistencia a la Naturaleza VI"
L["Searing Totem I"] = "Tótem abrasador I"
L["Searing Totem II"] = "Tótem abrasador II"
L["Searing Totem III"] = "Tótem abrasador III"
L["Searing Totem IV"] = "Tótem abrasador IV"
L["Searing Totem IX"] = "Tótem abrasador IX"
L["Searing Totem V"] = "Tótem abrasador V"
L["Searing Totem VI"] = "Tótem abrasador VI"
L["Searing Totem VII"] = "Tótem abrasador VII"
L["Searing Totem VIII"] = "Tótem abrasador VIII"
L["Searing Totem X"] = "Tótem abrasador X"
L["Stoneclaw Totem I"] = "Tótem Garra de piedra I"
L["Stoneclaw Totem II"] = "Tótem Garra de piedra II"
L["Stoneclaw Totem III"] = "Tótem Garra de piedra III"
L["Stoneclaw Totem IV"] = "Tótem Garra de piedra IV"
L["Stoneclaw Totem IX"] = "Tótem Garra de piedra IX"
L["Stoneclaw Totem V"] = "Tótem Garra de piedra V"
L["Stoneclaw Totem VI"] = "Tótem Garra de piedra VI"
L["Stoneclaw Totem VII"] = "Tótem Garra de piedra VII"
L["Stoneclaw Totem VIII"] = "Tótem Garra de piedra VIII"
L["Stoneclaw Totem X"] = "Tótem Garra de piedra X"
L["Stoneskin Totem I"] = "Tótem Piel de piedra I"
L["Stoneskin Totem II"] = "Tótem Piel de piedra II"
L["Stoneskin Totem III"] = "Tótem Piel de piedra III"
L["Stoneskin Totem IV"] = "Tótem Piel de piedra IV"
L["Stoneskin Totem IX"] = "Tótem Piel de piedra IX"
L["Stoneskin Totem V"] = "Tótem Piel de piedra V"
L["Stoneskin Totem VI"] = "Tótem Piel de piedra VI"
L["Stoneskin Totem VII"] = "Tótem Piel de piedra VII"
L["Stoneskin Totem VIII"] = "Tótem Piel de piedra VIII"
L["Stoneskin Totem X"] = "Tótem Piel de piedra X"
L["Strength of Earth Totem I"] = "Tótem Fuerza de la tierra I"
L["Strength of Earth Totem II"] = "Tótem Fuerza de la tierra II"
L["Strength of Earth Totem III"] = "Tótem Fuerza de la tierra III"
L["Strength of Earth Totem IV"] = "Tótem Fuerza de la tierra IV"
L["Strength of Earth Totem V"] = "Tótem Fuerza de la tierra V"
L["Strength of Earth Totem VI"] = "Tótem Fuerza de la tierra VI"
L["Strength of Earth Totem VII"] = "Tótem Fuerza de la tierra VII"
L["Strength of Earth Totem VIII"] = "Tótem Fuerza de la tierra VIII"
L["Totem of Wrath I"] = "Tótem de cólera I"
L["Totem of Wrath II"] = "Tótem de cólera II"
L["Totem of Wrath III"] = "Tótem de cólera III"
L["Totem of Wrath IV"] = "Tótem de cólera IV"