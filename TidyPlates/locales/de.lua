if GetLocale() ~= "deDE" then return end
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

L["Fire Resistance Totem I"] = "Totem des Feuerwiderstands I"
L["Fire Resistance Totem II"] = "Totem des Feuerwiderstands II"
L["Fire Resistance Totem III"] = "Totem des Feuerwiderstands III"
L["Fire Resistance Totem IV"] = "Totem des Feuerwiderstands IV"
L["Fire Resistance Totem V"] = "Totem des Feuerwiderstands V"
L["Fire Resistance Totem VI"] = "Totem des Feuerwiderstands VI"
L["Flametongue Totem I"] = "Totem der Flammenzunge I"
L["Flametongue Totem II"] = "Totem der Flammenzunge II"
L["Flametongue Totem III"] = "Totem der Flammenzunge III"
L["Flametongue Totem IV"] = "Totem der Flammenzunge IV"
L["Flametongue Totem V"] = "Totem der Flammenzunge V"
L["Flametongue Totem VI"] = "Totem der Flammenzunge VI"
L["Flametongue Totem VII"] = "Totem der Flammenzunge VII"
L["Flametongue Totem VIII"] = "Totem der Flammenzunge VIII"
L["Frost Resistance Totem I"] = "Totem des Frostwiderstands I"
L["Frost Resistance Totem II"] = "Totem des Frostwiderstands II"
L["Frost Resistance Totem III"] = "Totem des Frostwiderstands III"
L["Frost Resistance Totem IV"] = "Totem des Frostwiderstands IV"
L["Frost Resistance Totem V"] = "Totem des Frostwiderstands V"
L["Frost Resistance Totem VI"] = "Totem des Frostwiderstands VI"
L["Healing Stream Totem I"] = "Totem des heilenden Flusses I"
L["Healing Stream Totem II"] = "Totem des heilenden Flusses II"
L["Healing Stream Totem III"] = "Totem des heilenden Flusses III"
L["Healing Stream Totem IV"] = "Totem des heilenden Flusses IV"
L["Healing Stream Totem IX"] = "Totem des heilenden Flusses IX"
L["Healing Stream Totem V"] = "Totem des heilenden Flusses V"
L["Healing Stream Totem VI"] = "Totem des heilenden Flusses VI"
L["Healing Stream Totem VII"] = "Totem des heilenden Flusses VII"
L["Healing Stream Totem VIII"] = "Totem des heilenden Flusses VIII"
L["Magma Totem I"] = "Totem des glühenden Magmas I"
L["Magma Totem II"] = "Totem des glühenden Magmas II"
L["Magma Totem III"] = "Totem des glühenden Magmas III"
L["Magma Totem IV"] = "Totem des glühenden Magmas IV"
L["Magma Totem V"] = "Totem des glühenden Magmas V"
L["Magma Totem VI"] = "Totem des glühenden Magmas VI"
L["Magma Totem VII"] = "Totem des glühenden Magmas VII"
L["Mana Spring Totem I"] = "Totem der Manaquelle I"
L["Mana Spring Totem II"] = "Totem der Manaquelle II"
L["Mana Spring Totem III"] = "Totem der Manaquelle III"
L["Mana Spring Totem IV"] = "Totem der Manaquelle IV"
L["Mana Spring Totem V"] = "Totem der Manaquelle V"
L["Mana Spring Totem VI"] = "Totem der Manaquelle VI"
L["Mana Spring Totem VII"] = "Totem der Manaquelle VII"
L["Mana Spring Totem VIII"] = "Totem der Manaquelle VIII"
L["Nature Resistance Totem I"] = "Totem des Naturwiderstands I"
L["Nature Resistance Totem II"] = "Totem des Naturwiderstands II"
L["Nature Resistance Totem III"] = "Totem des Naturwiderstands III"
L["Nature Resistance Totem IV"] = "Totem des Naturwiderstands IV"
L["Nature Resistance Totem V"] = "Totem des Naturwiderstands V"
L["Nature Resistance Totem VI"] = "Totem des Naturwiderstands VI"
L["Searing Totem I"] = "Totem der Verbrennung I"
L["Searing Totem II"] = "Totem der Verbrennung II"
L["Searing Totem III"] = "Totem der Verbrennung III"
L["Searing Totem IV"] = "Totem der Verbrennung IV"
L["Searing Totem IX"] = "Totem der Verbrennung IX"
L["Searing Totem V"] = "Totem der Verbrennung V"
L["Searing Totem VI"] = "Totem der Verbrennung VI"
L["Searing Totem VII"] = "Totem der Verbrennung VII"
L["Searing Totem VIII"] = "Totem der Verbrennung VIII"
L["Searing Totem X"] = "Totem der Verbrennung X"
L["Stoneclaw Totem I"] = "Totem der Steinklaue I"
L["Stoneclaw Totem II"] = "Totem der Steinklaue II"
L["Stoneclaw Totem III"] = "Totem der Steinklaue III"
L["Stoneclaw Totem IV"] = "Totem der Steinklaue IV"
L["Stoneclaw Totem IX"] = "Totem der Steinklaue IX"
L["Stoneclaw Totem V"] = "Totem der Steinklaue V"
L["Stoneclaw Totem VI"] = "Totem der Steinklaue VI"
L["Stoneclaw Totem VII"] = "Totem der Steinklaue VII"
L["Stoneclaw Totem VIII"] = "Totem der Steinklaue VIII"
L["Stoneclaw Totem X"] = "Totem der Steinklaue X"
L["Stoneskin Totem I"] = "Totem der Steinhaut I"
L["Stoneskin Totem II"] = "Totem der Steinhaut II"
L["Stoneskin Totem III"] = "Totem der Steinhaut III"
L["Stoneskin Totem IV"] = "Totem der Steinhaut IV"
L["Stoneskin Totem IX"] = "Totem der Steinhaut IX"
L["Stoneskin Totem V"] = "Totem der Steinhaut V"
L["Stoneskin Totem VI"] = "Totem der Steinhaut VI"
L["Stoneskin Totem VII"] = "Totem der Steinhaut VII"
L["Stoneskin Totem VIII"] = "Totem der Steinhaut VIII"
L["Stoneskin Totem X"] = "Totem der Steinhaut X"
L["Strength of Earth Totem I"] = "Totem der Erdstärke I"
L["Strength of Earth Totem II"] = "Totem der Erdstärke II"
L["Strength of Earth Totem III"] = "Totem der Erdstärke III"
L["Strength of Earth Totem IV"] = "Totem der Erdstärke IV"
L["Strength of Earth Totem V"] = "Totem der Erdstärke V"
L["Strength of Earth Totem VI"] = "Totem der Erdstärke VI"
L["Strength of Earth Totem VII"] = "Totem der Erdstärke VII"
L["Strength of Earth Totem VIII"] = "Totem der Erdstärke VIII"
L["Totem of Wrath I"] = "Totem des Ingrimms I"
L["Totem of Wrath II"] = "Totem des Ingrimms II"
L["Totem of Wrath III"] = "Totem des Ingrimms III"
L["Totem of Wrath IV"] = "Totem des Ingrimms IV"