local _, TidyPlates = ...

local setmetatable = setmetatable
local tostring, format = tostring, string.format
local rawset, rawget = rawset, rawget

local L = setmetatable({}, {
    __newindex = function(self, key, value)
        rawset(self, key, value == true and key or value)
    end,
    __index = function(self, key)
        return key
    end
})

-- Quick usage of string.format
-- @param line the line to print
-- @param ...
-- @return returns the formatted
function L:F(line, ...)
    line = L[line]
    return format(line, ...)
end

TidyPlates.L = L

----------------------
--[[ TidyPlatesPanel.lua ]]--
----------------------

L["No Automation"] = true
L["Show during Combat, Hide when Combat ends"] = true
L["Hide when Combat starts, Show when Combat ends"] = true
L["Primary Theme:"] = true
L["Secondary Theme:"] = true
L["Please choose a theme for your Primary and Secondary Specializations. The appropriate theme will be automatically activated when you switch specs."] = true
L["Enemy Nameplates:"] = true
L["Friendly Nameplates:"] = true
L["Automation can automatically turn on or off Friendly and Enemy nameplates."] = true
L["Blizzard Nameplate Motion & Visibility"] = true
L["Show Non-Target Casting Bars (When Possible)"] = true
L["Enable Minimap Icon"] = true
L["Reset Configuration"] = true
L["|cFFFF6600Tidy Plates: |cFFFFFFFFWidget file versions do not match. This may be caused by an issue with auto-updater software."] = true
L["Please uninstall Tidy Plates, and then re-install. You do NOT need to clear your variables."] = true
L["|cFFFF6600Tidy Plates: |cFFFF9900No Theme is Selected. |cFF77FF00Use |cFFFFFF00/tidyplates|cFF77FF00 to bring up the Theme Selection Window."] = true

L.resetTidyPlanel = "%sResetting %sTidy Plates %sTheme Selection to Default"
L.commonResetPanel = "%sResetting %sTidy Plates Hub: %s%s %sConfiguration to Default"
L.resetTidyPlanelShift = "%sHolding down %sShift %swhile clicking %sReset Configuration %swill clear your saved settings, AND reload the user interface."
L.commonCopyPanel = "%sCopied %sTidy Plates Hub: %s%s %sTheme Values to Cache."
L.commonPastePanel = "%sPasted %sTidy Plates Hub: %s%s %sTheme Values from Cache."

----------------------
--[[ TankPanel.lua ]]--
----------------------

L["Default"] = true
L["Text Only"] = true
L["Bars during Combat"] = true
L["Bars on Active/Damaged Units"] = true
L["Bars on Elite Units"] = true
L["Bars on Marked Units"] = true
L["Bars on Players"] = true
L["None"] = true
L["Percent Health"] = true
L["Exact health"] = true
L["Health Deficit"] = true
L["Health Total & Percent"] = true
L["Target Of"] = true
L["Approximate Health"] = true
L["9 yards"] = true
L["15 yards"] = true
L["28 yards"] = true
L["40 yards"] = true
L["Show All"] = true
L["Show These... "] = true
L["Show All Mine "] = true
L["Show My... "] = true
L["By Prefix..."] = true
L["By Low Threat"] = true
L["By Mouseover"] = true
L["By Debuff Widget"] = true
L["By Enemy"] = true
L["By NPC"] = true
L["By Raid Icon"] = true
L["By Active/Damaged"] = true
L["By Elite"] = true
L["By Target"] = true
L["By Class"] = true
L["By Threat"] = true
L["By Reaction"] = true
L["Tug-o-Threat"] = true
L["Threat Wheel"] = true
L["Style"] = true
L["Opacity"] = true
L["Current Target Opacity:"] = true
L["Non-Target Opacity:"] = true
L["Opacity Spotlight Mode:"] = true
L["Spotlight Opacity:"] = true
L["Bring Casting Units to Target Opacity"] = true
L["Use Target Opacity When No Target Exists"] = true
L["Filtered Unit Opacity:"] = true
L["Filter Neutral Units"] = true
L["Filter Non-Elite"] = true
L["Filter Inactive"] = true
L["Filter By Unit Name:"] = true
L["Scale"] = true
L["Normal Scale:"] = true
L["Scale Spotlight Mode:"] = true
L["Spotlight Scale:"] = true
L["Ignore Neutral Units"] = true
L["Ignore Non-Elite Units"] = true
L["Ignore Inactive Units"] = true
L["Text"] = true
L["Name Text Color Mode:"] = true
L["Health Text:"] = true
L["Show Level Text"] = true
L["Use Default Blizzard Font"] = true
L["Color"] = true
L["Health Bar Color Mode:"] = true
L["Warning Glow/Border Mode:"] = true
L["Threat Colors:"] = true
L["Attacking Me"] = true
L["Losing Aggro"] = true
L["Attacking Others"] = true
L["Attacking Another Tank"] = true
L["Show Warning around Group Members with Aggro"] = true
L["Show Class Color for Party and Raid Members"] = true
L["Widgets"] = true
L["Show Highlight on Current Target"] = true
L["Show Elite Indicator"] = true
L["Show Enemy Class Icons"] = true
L["Show Party Member Class Icons"] = true
L["Show Totem Icons"] = true
L["Show Combo Points"] = true
L["Show Threat Indicator"] = true
L["Threat Indicator:"] = true
L["Show Party Range Warning"] = true
L["Range:"] = true
L["Show My Debuff Timers"] = true
L["Debuff Filter:"] = true
L["Debuff Names:"] = true
L["WidgetsDebuffTrackList_Description"] = [[
Tip: |cffCCCCCCDebuffs should be listed with the exact name, or a spell ID number.
You can use the prefixes, "My" or "All", to distinguish personal damage spells from global crowd control spells.
Auras at the top of the list will get displayed before lower ones.|r
]]
L["Frame"] = true
L["Vertical Position of Artwork:"] = true
L["Paste"] = true
L["Copy"] = true
L["Reset"] = true

----------------------
--[[ DamagePanel.lua ]]--
----------------------

L["Show All Debuffs"] = true
L["Show Specific Debuffs... "] = true
L["Show All My Debuffs "] = true
L["Show My Specific Debuffs... "] = true
L["By High Threat"] = true
L["Gaining Aggro"] = true
L["Show Warning on Group Members with Aggro"] = true

---------------------
--[[ Totem Names ]]--
---------------------

L["Fire Resistance Totem I"] = true
L["Fire Resistance Totem II"] = true
L["Fire Resistance Totem III"] = true
L["Fire Resistance Totem IV"] = true
L["Fire Resistance Totem V"] = true
L["Fire Resistance Totem VI"] = true
L["Flametongue Totem I"] = true
L["Flametongue Totem II"] = true
L["Flametongue Totem III"] = true
L["Flametongue Totem IV"] = true
L["Flametongue Totem V"] = true
L["Flametongue Totem VI"] = true
L["Flametongue Totem VII"] = true
L["Flametongue Totem VIII"] = true
L["Frost Resistance Totem I"] = true
L["Frost Resistance Totem II"] = true
L["Frost Resistance Totem III"] = true
L["Frost Resistance Totem IV"] = true
L["Frost Resistance Totem V"] = true
L["Frost Resistance Totem VI"] = true
L["Healing Stream Totem I"] = true
L["Healing Stream Totem II"] = true
L["Healing Stream Totem III"] = true
L["Healing Stream Totem IV"] = true
L["Healing Stream Totem IX"] = true
L["Healing Stream Totem V"] = true
L["Healing Stream Totem VI"] = true
L["Healing Stream Totem VII"] = true
L["Healing Stream Totem VIII"] = true
L["Magma Totem I"] = true
L["Magma Totem II"] = true
L["Magma Totem III"] = true
L["Magma Totem IV"] = true
L["Magma Totem V"] = true
L["Magma Totem VI"] = true
L["Magma Totem VII"] = true
L["Mana Spring Totem I"] = true
L["Mana Spring Totem II"] = true
L["Mana Spring Totem III"] = true
L["Mana Spring Totem IV"] = true
L["Mana Spring Totem V"] = true
L["Mana Spring Totem VI"] = true
L["Mana Spring Totem VII"] = true
L["Mana Spring Totem VIII"] = true
L["Nature Resistance Totem I"] = true
L["Nature Resistance Totem II"] = true
L["Nature Resistance Totem III"] = true
L["Nature Resistance Totem IV"] = true
L["Nature Resistance Totem V"] = true
L["Nature Resistance Totem VI"] = true
L["Searing Totem I"] = true
L["Searing Totem II"] = true
L["Searing Totem III"] = true
L["Searing Totem IV"] = true
L["Searing Totem IX"] = true
L["Searing Totem V"] = true
L["Searing Totem VI"] = true
L["Searing Totem VII"] = true
L["Searing Totem VIII"] = true
L["Searing Totem X"] = true
L["Stoneclaw Totem I"] = true
L["Stoneclaw Totem II"] = true
L["Stoneclaw Totem III"] = true
L["Stoneclaw Totem IV"] = true
L["Stoneclaw Totem IX"] = true
L["Stoneclaw Totem V"] = true
L["Stoneclaw Totem VI"] = true
L["Stoneclaw Totem VII"] = true
L["Stoneclaw Totem VIII"] = true
L["Stoneclaw Totem X"] = true
L["Stoneskin Totem I"] = true
L["Stoneskin Totem II"] = true
L["Stoneskin Totem III"] = true
L["Stoneskin Totem IV"] = true
L["Stoneskin Totem IX"] = true
L["Stoneskin Totem V"] = true
L["Stoneskin Totem VI"] = true
L["Stoneskin Totem VII"] = true
L["Stoneskin Totem VIII"] = true
L["Stoneskin Totem X"] = true
L["Strength of Earth Totem I"] = true
L["Strength of Earth Totem II"] = true
L["Strength of Earth Totem III"] = true
L["Strength of Earth Totem IV"] = true
L["Strength of Earth Totem V"] = true
L["Strength of Earth Totem VI"] = true
L["Strength of Earth Totem VII"] = true
L["Strength of Earth Totem VIII"] = true
L["Totem of Wrath I"] = true
L["Totem of Wrath II"] = true
L["Totem of Wrath III"] = true
L["Totem of Wrath IV"] = true