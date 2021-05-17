if GetLocale() ~= "ruRU" then return end
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

L["Fire Resistance Totem I"] = "Тотем сопротивления силам стихий I"
L["Fire Resistance Totem II"] = "Тотем сопротивления силам стихий II"
L["Fire Resistance Totem III"] = "Тотем сопротивления силам стихий III"
L["Fire Resistance Totem IV"] = "Тотем сопротивления силам стихий IV"
L["Fire Resistance Totem V"] = "Тотем сопротивления силам стихий V"
L["Fire Resistance Totem VI"] = "Тотем сопротивления силам стихий VI"
L["Flametongue Totem I"] = "Тотем языка пламени I"
L["Flametongue Totem II"] = "Тотем языка пламени II"
L["Flametongue Totem III"] = "Тотем языка пламени III"
L["Flametongue Totem IV"] = "Тотем языка пламени IV"
L["Flametongue Totem V"] = "Тотем языка пламени V"
L["Flametongue Totem VI"] = "Тотем языка пламени VI"
L["Flametongue Totem VII"] = "Тотем языка пламени VII"
L["Flametongue Totem VIII"] = "Тотем языка пламени VIII"
L["Frost Resistance Totem I"] = "Тотем сопротивления льду I"
L["Frost Resistance Totem II"] = "Тотем сопротивления льду II"
L["Frost Resistance Totem III"] = "Тотем сопротивления льду III"
L["Frost Resistance Totem IV"] = "Тотем сопротивления льду IV"
L["Frost Resistance Totem V"] = "Тотем сопротивления льду V"
L["Frost Resistance Totem VI"] = "Тотем сопротивления льду VI"
L["Healing Stream Totem I"] = "Тотем исцеляющего потока I"
L["Healing Stream Totem II"] = "Тотем исцеляющего потока II"
L["Healing Stream Totem III"] = "Тотем исцеляющего потока III"
L["Healing Stream Totem IV"] = "Тотем исцеляющего потока IV"
L["Healing Stream Totem IX"] = "Тотем исцеляющего потока IX"
L["Healing Stream Totem V"] = "Тотем исцеляющего потока V"
L["Healing Stream Totem VI"] = "Тотем исцеляющего потока VI"
L["Healing Stream Totem VII"] = "Тотем исцеляющего потока VII"
L["Healing Stream Totem VIII"] = "Тотем исцеляющего потока VIII"
L["Magma Totem I"] = "Тотем магмы I"
L["Magma Totem II"] = "Тотем магмы II"
L["Magma Totem III"] = "Тотем магмы III"
L["Magma Totem IV"] = "Тотем магмы IV"
L["Magma Totem V"] = "Тотем магмы V"
L["Magma Totem VI"] = "Тотем магмы VI"
L["Magma Totem VII"] = "Тотем магмы VII"
L["Mana Spring Totem I"] = "Тотем источника маны I"
L["Mana Spring Totem II"] = "Тотем источника маны II"
L["Mana Spring Totem III"] = "Тотем источника маны III"
L["Mana Spring Totem IV"] = "Тотем источника маны IV"
L["Mana Spring Totem V"] = "Тотем источника маны V"
L["Mana Spring Totem VI"] = "Тотем источника маны VI"
L["Mana Spring Totem VII"] = "Тотем источника маны VII"
L["Mana Spring Totem VIII"] = "Тотем источника маны VIII"
L["Nature Resistance Totem I"] = "Тотем сопротивления силам природы I"
L["Nature Resistance Totem II"] = "Тотем сопротивления силам природы II"
L["Nature Resistance Totem III"] = "Тотем сопротивления силам природы III"
L["Nature Resistance Totem IV"] = "Тотем сопротивления силам природы IV"
L["Nature Resistance Totem V"] = "Тотем сопротивления силам природы V"
L["Nature Resistance Totem VI"] = "Тотем сопротивления силам природы VI"
L["Searing Totem I"] = "Опаляющий тотем I"
L["Searing Totem II"] = "Опаляющий тотем II"
L["Searing Totem III"] = "Опаляющий тотем III"
L["Searing Totem IV"] = "Опаляющий тотем IV"
L["Searing Totem IX"] = "Опаляющий тотем IX"
L["Searing Totem V"] = "Опаляющий тотем V"
L["Searing Totem VI"] = "Опаляющий тотем VI"
L["Searing Totem VII"] = "Опаляющий тотем VII"
L["Searing Totem VIII"] = "Опаляющий тотем VIII"
L["Searing Totem X"] = "Опаляющий тотем X"
L["Stoneclaw Totem I"] = "Тотем каменного когтя I"
L["Stoneclaw Totem II"] = "Тотем каменного когтя II"
L["Stoneclaw Totem III"] = "Тотем каменного когтя III"
L["Stoneclaw Totem IV"] = "Тотем каменного когтя IV"
L["Stoneclaw Totem IX"] = "Тотем каменного когтя IX"
L["Stoneclaw Totem V"] = "Тотем каменного когтя V"
L["Stoneclaw Totem VI"] = "Тотем каменного когтя VI"
L["Stoneclaw Totem VII"] = "Тотем каменного когтя VII"
L["Stoneclaw Totem VIII"] = "Тотем каменного когтя VIII"
L["Stoneclaw Totem X"] = "Тотем каменного когтя X"
L["Stoneskin Totem I"] = "Тотем каменной кожи I"
L["Stoneskin Totem II"] = "Тотем каменной кожи II"
L["Stoneskin Totem III"] = "Тотем каменной кожи III"
L["Stoneskin Totem IV"] = "Тотем каменной кожи IV"
L["Stoneskin Totem IX"] = "Тотем каменной кожи IX"
L["Stoneskin Totem V"] = "Тотем каменной кожи V"
L["Stoneskin Totem VI"] = "Тотем каменной кожи VI"
L["Stoneskin Totem VII"] = "Тотем каменной кожи VII"
L["Stoneskin Totem VIII"] = "Тотем каменной кожи VIII"
L["Stoneskin Totem X"] = "Тотем каменной кожи X"
L["Strength of Earth Totem I"] = "Тотем силы земли I"
L["Strength of Earth Totem II"] = "Тотем силы земли II"
L["Strength of Earth Totem III"] = "Тотем силы земли III"
L["Strength of Earth Totem IV"] = "Тотем силы земли IV"
L["Strength of Earth Totem V"] = "Тотем силы земли V"
L["Strength of Earth Totem VI"] = "Тотем силы земли VI"
L["Strength of Earth Totem VII"] = "Тотем силы земли VII"
L["Strength of Earth Totem VIII"] = "Тотем силы земли VIII"
L["Totem of Wrath I"] = "Тотем гнева I"
L["Totem of Wrath II"] = "Тотем гнева II"
L["Totem of Wrath III"] = "Тотем гнева III"
L["Totem of Wrath IV"] = "Тотем гнева IV"