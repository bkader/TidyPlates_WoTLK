if GetLocale() ~= "koKR" then return end
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

L["Fire Resistance Totem I"] = "화염 저항 토템 I"
L["Fire Resistance Totem II"] = "화염 저항 토템 II"
L["Fire Resistance Totem III"] = "화염 저항 토템 III"
L["Fire Resistance Totem IV"] = "화염 저항 토템 IV"
L["Fire Resistance Totem V"] = "화염 저항 토템 V"
L["Fire Resistance Totem VI"] = "화염 저항 토템 VI"
L["Flametongue Totem I"] = "불꽃의 토템 I"
L["Flametongue Totem II"] = "불꽃의 토템 II"
L["Flametongue Totem III"] = "불꽃의 토템 III"
L["Flametongue Totem IV"] = "불꽃의 토템 IV"
L["Flametongue Totem V"] = "불꽃의 토템 V"
L["Flametongue Totem VI"] = "불꽃의 토템 VI"
L["Flametongue Totem VII"] = "불꽃의 토템 VII"
L["Flametongue Totem VIII"] = "불꽃의 토템 VIII"
L["Frost Resistance Totem I"] = "냉기 저항 토템 I"
L["Frost Resistance Totem II"] = "냉기 저항 토템 II"
L["Frost Resistance Totem III"] = "냉기 저항 토템 III"
L["Frost Resistance Totem IV"] = "냉기 저항 토템 IV"
L["Frost Resistance Totem V"] = "냉기 저항 토템 V"
L["Frost Resistance Totem VI"] = "냉기 저항 토템 VI"
L["Healing Stream Totem I"] = "치유의 토템 I"
L["Healing Stream Totem II"] = "치유의 토템 II"
L["Healing Stream Totem III"] = "치유의 토템 III"
L["Healing Stream Totem IV"] = "치유의 토템 IV"
L["Healing Stream Totem IX"] = "치유의 토템 IX"
L["Healing Stream Totem V"] = "치유의 토템 V"
L["Healing Stream Totem VI"] = "치유의 토템 VI"
L["Healing Stream Totem VII"] = "치유의 토템 VII"
L["Healing Stream Totem VIII"] = "치유의 토템 VIII"
L["Magma Totem I"] = "용암 토템 I"
L["Magma Totem II"] = "용암 토템 II"
L["Magma Totem III"] = "용암 토템 III"
L["Magma Totem IV"] = "용암 토템 IV"
L["Magma Totem V"] = "용암 토템 V"
L["Magma Totem VI"] = "용암 토템 VI"
L["Magma Totem VII"] = "용암 토템 VII"
L["Mana Spring Totem I"] = "마나샘 토템 I"
L["Mana Spring Totem II"] = "마나샘 토템 II"
L["Mana Spring Totem III"] = "마나샘 토템 III"
L["Mana Spring Totem IV"] = "마나샘 토템 IV"
L["Mana Spring Totem V"] = "마나샘 토템 V"
L["Mana Spring Totem VI"] = "마나샘 토템 VI"
L["Mana Spring Totem VII"] = "마나샘 토템 VII"
L["Mana Spring Totem VIII"] = "마나샘 토템 VIII"
L["Nature Resistance Totem I"] = "자연 저항 토템 I"
L["Nature Resistance Totem II"] = "자연 저항 토템 II"
L["Nature Resistance Totem III"] = "자연 저항 토템 III"
L["Nature Resistance Totem IV"] = "자연 저항 토템 IV"
L["Nature Resistance Totem V"] = "자연 저항 토템 V"
L["Nature Resistance Totem VI"] = "자연 저항 토템 VI"
L["Searing Totem I"] = "불타는 토템 I"
L["Searing Totem II"] = "불타는 토템 II"
L["Searing Totem III"] = "불타는 토템 III"
L["Searing Totem IV"] = "불타는 토템 IV"
L["Searing Totem IX"] = "불타는 토템 IX"
L["Searing Totem V"] = "불타는 토템 V"
L["Searing Totem VI"] = "불타는 토템 VI"
L["Searing Totem VII"] = "불타는 토템 VII"
L["Searing Totem VIII"] = "불타는 토템 VIII"
L["Searing Totem X"] = "불타는 토템 X"
L["Stoneclaw Totem I"] = "돌발톱 토템 I"
L["Stoneclaw Totem II"] = "돌발톱 토템 II"
L["Stoneclaw Totem III"] = "돌발톱 토템 III"
L["Stoneclaw Totem IV"] = "돌발톱 토템 IV"
L["Stoneclaw Totem IX"] = "돌발톱 토템 IX"
L["Stoneclaw Totem V"] = "돌발톱 토템 V"
L["Stoneclaw Totem VI"] = "돌발톱 토템 VI"
L["Stoneclaw Totem VII"] = "돌발톱 토템 VII"
L["Stoneclaw Totem VIII"] = "돌발톱 토템 VIII"
L["Stoneclaw Totem X"] = "돌발톱 토템 X"
L["Stoneskin Totem I"] = "돌가죽 토템 I"
L["Stoneskin Totem II"] = "돌가죽 토템 II"
L["Stoneskin Totem III"] = "돌가죽 토템 III"
L["Stoneskin Totem IV"] = "돌가죽 토템 IV"
L["Stoneskin Totem IX"] = "돌가죽 토템 IX"
L["Stoneskin Totem V"] = "돌가죽 토템 V"
L["Stoneskin Totem VI"] = "돌가죽 토템 VI"
L["Stoneskin Totem VII"] = "돌가죽 토템 VII"
L["Stoneskin Totem VIII"] = "돌가죽 토템 VIII"
L["Stoneskin Totem X"] = "돌가죽 토템 X"
L["Strength of Earth Totem I"] = "대지력 토템 I"
L["Strength of Earth Totem II"] = "대지력 토템 II"
L["Strength of Earth Totem III"] = "대지력 토템 III"
L["Strength of Earth Totem IV"] = "대지력 토템 IV"
L["Strength of Earth Totem V"] = "대지력 토템 V"
L["Strength of Earth Totem VI"] = "대지력 토템 VI"
L["Strength of Earth Totem VII"] = "대지력 토템 VII"
L["Strength of Earth Totem VIII"] = "대지력 토템 VIII"
L["Totem of Wrath I"] = "격노의 토템 I"
L["Totem of Wrath II"] = "격노의 토템 II"
L["Totem of Wrath III"] = "격노의 토템 III"
L["Totem of Wrath IV"] = "격노의 토템 IV"