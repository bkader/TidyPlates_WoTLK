local L = LibStub("AceLocale-3.0"):NewLocale("TidyPlatesThreat", "enGB", false)
if not L then return end

----------------------
--[[ commands.lua ]]--
----------------------

L["-->>|cffff0000DPS Plates Enabled|r<<--"] = "-->>|cffff0000DPS Plates Enabled|r<<--"
L["|cff89F559Threat Plates|r: DPS switch detected, you are now in your |cff89F559"] = "|cff89F559Threat Plates|r: DPS switch detected, you are now in your |cff89F559"
L["|r spec and are now in your |cffff0000dpsing / healing|r role."] = "|r spec and are now in your |cffff0000dpsing / healing|r role."

L["-->>|cff00ff00Tank Plates Enabled|r<<--"] = "-->>|cff00ff00Tank Plates Enabled|r<<--"
L["|cff89F559Threat Plates|r: Tank switch detected, you are now in your |cff89F559"] = "|cff89F559Threat Plates|r: Tank switch detected, you are now in your |cff89F559"
L["|r spec and are now in your |cff00ff00tanking|r role."] = "|r spec and are now in your |cff00ff00tanking|r role."

L["-->>Nameplate Overlapping is now |cff00ff00ON!|r<<--"] = "-->>Nameplate Overlapping is now |cff00ff00ON!|r<<--"
L["-->>Nameplate Overlapping is now |cffff0000OFF!|r<<--"] = "-->>Nameplate Overlapping is now |cffff0000OFF!|r<<--"

L["-->>Threat Plates verbose is now |cff00ff00ON!|r<<--"] = "-->>Threat Plates verbose is now |cff00ff00ON!|r<<--"
L["-->>Threat Plates verbose is now |cffff0000OFF!|r<<-- shhh!!"] = "-->>Threat Plates verbose is now |cffff0000OFF!|r<<-- shhh!!"

------------------------------
--[[ TidyPlatesThreat.lua ]]--
------------------------------

L["|cff00ff00tanking|r"] = "|cff00ff00tanking|r"
L["|cffff0000dpsing / healing|r"] = "|cffff0000dpsing / healing|r"

L["primary"] = "primary"
L["secondary"] = "secondary"
L["unknown"] = "unknown"
L["Undetermined"] = "Undetermined"

L["|cff89f559Welcome to |rTidy Plates: |cff89f559Threat Plates!\nThis is your first time using Threat Plates and you are a(n):\n|r|cff"] = "|cff89f559Welcome to |rTidy Plates: |cff89f559Threat Plates!\nThis is your first time using Threat Plates and you are a(n):\n|r|cff"

L["|cff89f559Your dual spec's have been set to |r"] = "|cff89f559Your dual spec's have been set to |r"
L["|cff89f559You are currently in your "] = "|cff89f559You are currently in your "
L["|cff89f559 role.|r"] = "|cff89f559 role.|r"
L["|cff89f559Your role can not be determined.\nPlease set your dual spec preferences in the |rThreat Plates|cff89f559 options.|r"] = "|cff89f559Your role can not be determined.\nPlease set your dual spec preferences in the |rThreat Plates|cff89f559 options.|r"
L["|cff89f559Additional options can be found by typing |r'/tptp'|cff89F559.|r"] = "|cff89f559Additional options can be found by typing |r'/tptp'|cff89F559.|r"
L[":\n----------\nWould you like to \nset your theme to |cff89F559Threat Plates|r?\n\nClicking '|cff00ff00Yes|r' will set you to Threat Plates & reload UI. \n Clicking '|cffff0000No|r' will open the Tidy Plates options."] = ":\n----------\nWould you like to \nset your theme to |cff89F559Threat Plates|r?\n\nClicking '|cff00ff00Yes|r' will set you to Threat Plates & reload UI. \n Clicking '|cffff0000No|r' will open the Tidy Plates options."

L["Yes"] = "Yes"
L["Cancel"] = "Cancel"
L["No"] = "No"

L["-->>|cffff0000Activate Threat Plates from the Tidy Plates options!|r<<--"] = "-->>|cffff0000Activate Threat Plates from the Tidy Plates options!|r<<--"
L["|cff89f559Threat Plates:|r Welcome back |cff"] = "|cff89f559Threat Plates:|r Welcome back |cff"

L["|cff89F559Threat Plates|r: Player spec change detected: |cff"] = "|cff89F559Threat Plates|r: Player spec change detected: |cff"
L[")|r, you are now in your |cff89F559"] = ")|r, you are now in your |cff89F559"
L["|r spec and are now in your "] = "|r spec and are now in your "
L[" role."] = " role."

-- Custom Nameplates
L["Shadow Fiend"] = "Shadow Fiend"
L["Spirit Wolf"] = "Spirit Wolf"
L["Ebon Gargoyle"] = "Ebon Gargoyle"
L["Water Elemental"] = "Water Elemental"
L["Treant"] = "Treant"
L["Viper"] = "Viper"
L["Venomous Snake"] = "Venomous Snake"
L["Army of the Dead Ghoul"] = "Army of the Dead Ghoul"
L["Shadowy Apparition"] = "Shadowy Apparition"
L["Shambling Horror"] = "Shambling Horror"
L["Web Wrap"] = "Web Wrap"
L["Immortal Guardian"] = "Immortal Guardian"
L["Marked Immortal Guardian"] = "Marked Immortal Guardian"
L["Empowered Adherent"] = "Empowered Adherent"
L["Deformed Fanatic"] = "Deformed Fanatic"
L["Reanimated Adherent"] = "Reanimated Adherent"
L["Reanimated Fanatic"] = "Reanimated Fanatic"
L["Bone Spike"] = "Bone Spike"
L["Onyxian Whelp"] = "Onyxian Whelp"
L["Gas Cloud"] = "Gas Cloud"
L["Volatile Ooze"] = "Volatile Ooze"
L["Darnavan"] = "Darnavan"
L["Val'kyr Shadowguard"] = "Val'kyr Shadowguard"
L["Kinetic Bomb"] = "Kinetic Bomb"
L["Lich King"] = "Lich King"
L["Raging Spirit"] = "Raging Spirit"
L["Drudge Ghoul"] = "Drudge Ghoul"
L["Living Inferno"] = "Living Inferno"
L["Living Ember"] = "Living Ember"
L["Fanged Pit Viper"] = "Fanged Pit Viper"
L["Canal Crab"] = "Canal Crab"
L["Muddy Crawfish"] = "Muddy Crawfish"

---------------------
--[[ options.lua ]]--
---------------------

L["None"] = "None"
L["Outline"] = "Outline"
L["Thick Outline"] = "Thick Outline"
L["No Outline, Monochrome"] = "No Outline, Monochrome"
L["Outline, Monochrome"] = "Outline, Monochrome"
L["Thick Outline, Monochrome"] = "Thick Outline, Monochrome"

L["White List"] = "White List"
L["Black List"] = "Black List"
L["White List (Mine)"] = "White List (Mine)"
L["Black List (Mine)"] = "Black List (Mine)"
L["All Debuffs"] = "All Debuffs"
L["All Debuffs (Mine)"] = "All Debuffs (Mine)"

-- Tab Titles
L["Nameplate Settings"] = "Nameplate Settings"
L["Threat System"] = "Threat System"
L["Widgets"] = "Widgets"
L["Totem Nameplates"] = "Totem Nameplates"
L["Custom Nameplates"] = "Custom Nameplates"
L["About"] = "About"

------------------------
-- Nameplate Settings --
------------------------
L["General Settings"] = "General Settings"
L["Hiding"] = "Hiding"
L["Show Neutral"] = "Show Neutral"
L["Show Normal"] = "Show Normal"
L["Show Elite"] = "Show Elite"
L["Show Boss"] = "Show Boss"

L["Blizzard Settings"] = "Blizzard Settings"
L["Open Blizzard Settings"] = "Open Blizzard Settings"

L["Friendly"] = "Friendly"
L["Show Friends"] = "Show Friends"
L["Show Friendly Totems"] = "Show Friendly Totems"
L["Show Friendly Pets"] = "Show Friendly Pets"
L["Show Friendly Guardians"] = "Show Friendly Guardians"

L["Enemy"] = "Enemy"
L["Show Enemies"] = "Show Enemies"
L["Show Enemy Totems"] = "Show Enemy Totems"
L["Show Enemy Pets"] = "Show Enemy Pets"
L["Show Enemy Guardians"] = "Show Enemy Guardians"

----
L["Healthbar"] = "Healthbar"
L["Textures"] = "Textures"
L["Show Border"] = "Show Border"
L["Normal Border"] = "Normal Border"
L["Show Elite Border"] = "Show Elite Border"
L["Elite Border"] = "Elite Border"
L["Mouseover"] = "Mouseover"
L["Width"] = "Width"
L["Height"] = "Height"
----
L["Placement"] = "Placement"
L["Changing these settings will alter the placement of the nameplates, however the mouseover area does not follow. |cffff0000Use with caution!|r"] = "Changing these settings will alter the placement of the nameplates, however the mouseover area does not follow. |cffff0000Use with caution!|r"
L["Offset X"] = "Offset X"
L["Offset Y"] = "Offset Y"
L["X"] = "X"
L["Y"] = "Y"
L["Anchor"] = "Anchor"
----
L["Coloring"] = "Coloring"
L["Enable Coloring"] = "Enable Coloring"
L["Color HP by amount"] = "Color HP by amount"
L["Changes the HP color depending on the amount of HP the nameplate shows."] = "Changes the HP color depending on the amount of HP the nameplate shows."
----
L["Class Coloring"] = "Class Coloring"
L["Enemy Class Colors"] = "Enemy Class Colors"
L["Enable Enemy Class colors"] = "Enable Enemy Class colors"
L["Friendly Class Colors"] = "Friendly Class Colors"
L["Enable Friendly Class Colors"] = "Enable Friendly Class Colors"
L["Enable the showing of friendly player class color on hp bars."] = "Enable the showing of friendly player class color on hp bars."
L["Friendly Caching"] = "Friendly Caching"
L["This allows you to save friendly player class information between play sessions or nameplates going off the screen.|cffff0000(Uses more memory)"] = "This allows you to save friendly player class information between play sessions or nameplates going off the screen.|cffff0000(Uses more memory)"
L["Name Only"] = "Name Only"
L["Show only names above friendly units."] = "Show only names above friendly units."
----
L["Custom HP Color"] = "Custom HP Color"
L["Enable Custom HP colors"] = "Enable Custom HP colors"
L["Friendly Color"] = "Friendly Color"
L["Neutral Color"] = "Neutral Color"
L["Enemy Color"] = "Enemy Color"
----
L["Raid Mark HP Color"] = "Raid Mark HP Color"
L["Enable Raid Marked HP colors"] = "Enable Raid Marked HP colors"
L["Colors"] = "Colors"
----
L["Threat Colors"] = "Threat Colors"
L["Show Threat Glow"] = "Show Threat Glow"
L["|cff00ff00Low threat|r"] = "|cff00ff00Low threat|r"
L["|cffffff00Medium threat|r"] = "|cffffff00Medium threat|r"
L["|cffff0000High threat|r"] = "|cffff0000High threat|r"
L["|cffff0000Low threat|r"] = "|cffff0000Low threat|r"
L["|cff00ff00High threat|r"] = "|cff00ff00High threat|r"
L["Low Threat"] = "Low Threat"
L["Medium Threat"] = "Medium Threat"
L["High Threat"] = "High Threat"

----
L["Castbar"] = "Castbar"
L["Enable"] = "Enable"
L["Non-Target Castbars"] = "Non-Target Castbars"
L["This allows the castbar to attempt to create a castbar on nameplates of players or creatures you have recently moused over."] = "This allows the castbar to attempt to create a castbar on nameplates of players or creatures you have recently moused over."
L["Interruptable Casts"] = "Interruptable Casts"
L["Shielded Coloring"] = "Shielded Coloring"
L["Uninterruptable Casts"] = "Uninterruptable Casts"

----
L["Alpha"] = "Alpha"
L["Blizzard Target Fading"] = "Blizzard Target Fading"
L["Enable Blizzard 'On-Target' Fading"] = "Enable Blizzard 'On-Target' Fading"
L["Enabling this will allow you to set the alpha adjustment for non-target nameplates."] = "Enabling this will allow you to set the alpha adjustment for non-target nameplates."
L["Non-Target Alpha"] = "Non-Target Alpha"
L["Alpha Settings"] = "Alpha Settings"

----
L["Scale"] = "Scale"
L["Scale Settings"] = "Scale Settings"

----
L["Name Text"] = "Name Text"
L["Enable Name Text"] = "Enable Name Text"
L["Enables the showing of text on nameplates."] = "Enables the showing of text on nameplates."
L["Options"] = "Options"
L["Font"] = "Font"
L["Font Style"] = "Font Style"
L["Set the outlining style of the text."] = "Set the outlining style of the text."
L["Enable Shadow"] = "Enable Shadow"
L["Color"] = "Color"
L["Text Bounds and Sizing"] = "Text Bounds and Sizing"
L["Font Size"] = "Font Size"
L["Text Boundaries"] = "Text Boundaries"
L["These settings will define the space that text can be placed on the nameplate.\nHaving too large a font and not enough height will cause the text to be not visible."] = "These settings will define the space that text can be placed on the nameplate.\nHaving too large a font and not enough height will cause the text to be not visible."
L["Text Width"] = "Text Width"
L["Text Height"] = "Text Height"
L["Horizontal Align"] = "Horizontal Align"
L["Vertical Align"] = "Vertical Align"

----
L["Health Text"] = "Health Text"
L["Enable Health Text"] = "Enable Health Text"
L["Display Settings"] = "Display Settings"
L["Text at Full HP"] = "Text at Full HP"
L["Display health text on targets with full HP."] = "Display health text on targets with full HP."
L["Percent Text"] = "Percent Text"
L["Display health percentage text."] = "Display health percentage text."
L["Amount Text"] = "Amount Text"
L["Display health amount text."] = "Display health amount text."
L["Amount Text Formatting"] = "Amount Text Formatting"
L["Truncate Text"] = "Truncate Text"
L["This will format text to a simpler format using M or K for millions and thousands. Disabling this will show exact HP amounts."] = "This will format text to a simpler format using M or K for millions and thousands. Disabling this will show exact HP amounts."
L["Max HP Text"] = "Max HP Text"
L["This will format text to show both the maximum hp and current hp."] = "This will format text to show both the maximum hp and current hp."
L["Deficit Text"] = "Deficit Text"
L["This will format text to show hp as a value the target is missing."] = "This will format text to show hp as a value the target is missing."

----
L["Spell Text"] = "Spell Text"
L["Enable Spell Text"] = "Enable Spell Text"

----
L["Level Text"] = "Level Text"
L["Enable Level Text"] = "Enable Level Text"

----
L["Elite Icon"] = "Elite Icon"
L["Enable Elite Icon"] = "Enable Elite Icon"
L["Enables the showing of the elite icon on nameplates."] = "Enables the showing of the elite icon on nameplates."
L["Texture"] = "Texture"
L["Preview"] = "Preview"
L["Elite Icon Style"] = "Elite Icon Style"
L["Size"] = "Size"

----
L["Skull Icon"] = "Skull Icon"
L["Enable Skull Icon"] = "Enable Skull Icon"
L["Enables the showing of the skull icon on nameplates."] = "Enables the showing of the skull icon on nameplates."

----
L["Spell Icon"] = "Spell Icon"
L["Enable Spell Icon"] = "Enable Spell Icon"
L["Enables the showing of the spell icon on nameplates."] = "Enables the showing of the spell icon on nameplates."

----
L["Raid Marks"] = "Raid Marks"
L["Enable Raid Mark Icon"] = "Enable Raid Mark Icon"
L["Enables the showing of the raid mark icon on nameplates."] = "Enables the showing of the raid mark icon on nameplates."

-------------------
-- Threat System --
-------------------

L["Enable Threat System"] = "Enable Threat System"

----
L["Additional Toggles"] = "Additional Toggles"
L["Ignore Non-Combat Threat"] = "Ignore Non-Combat Threat"
L["Disables threat feedback from mobs you're currently not in combat with."] = "Disables threat feedback from mobs you're currently not in combat with."
L["Show Neutral Threat"] = "Show Neutral Threat"
L["Disables threat feedback from neutral mobs regardless of boss or elite levels."] = "Disables threat feedback from neutral mobs regardless of boss or elite levels."
L["Show Normal Threat"] = "Show Normal Threat"
L["Disables threat feedback from normal mobs."] = "Disables threat feedback from normal mobs."
L["Show Elite Threat"] = "Show Elite Threat"
L["Disables threat feedback from elite mobs."] = "Disables threat feedback from elite mobs."
L["Show Boss Threat"] = "Show Boss Threat"
L["Disables threat feedback from boss level mobs."] = "Disables threat feedback from boss level mobs."

----
L["Set alpha settings for different threat reaction types."] = "Set alpha settings for different threat reaction types."
L["Enable Alpha Threat"] = "Enable Alpha Threat"
L["Enable nameplates to change alpha depending on the levels you set below."] = "Enable nameplates to change alpha depending on the levels you set below."
L["|cff00ff00Tank|r"] = "|cff00ff00Tank|r"
L["|cffff0000DPS/Healing|r"] = "|cffff0000DPS/Healing|r"
----
L["Marked Targets"] = "Marked Targets"
L["Ignore Marked Targets"] = "Ignore Marked Targets"
L["This will allow you to disabled threat alpha changes on marked targets."] = "This will allow you to disabled threat alpha changes on marked targets."
L["Ignored Alpha"] = "Ignored Alpha"

----
L["Set scale settings for different threat reaction types."] = "Set scale settings for different threat reaction types."
L["Enable Scale Threat"] = "Enable Scale Threat"
L["Enable nameplates to change scale depending on the levels you set below."] = "Enable nameplates to change scale depending on the levels you set below."
L["This will allow you to disabled threat scale changes on marked targets."] = "This will allow you to disabled threat scale changes on marked targets."
L["Ignored Scaling"] = "Ignored Scaling"
----
L["Additional Adjustments"] = "Additional Adjustments"
L["Enable Adjustments"] = "Enable Adjustments"
L["This will allow you to add additional scaling changes to specific mob types."] = "This will allow you to add additional scaling changes to specific mob types."

----
L["Toggles"] = "Toggles"
L["Color HP by Threat"] = "Color HP by Threat"
L["This allows HP color to be the same as the threat colors you set below."] = "This allows HP color to be the same as the threat colors you set below."

----
L["Dual Spec Roles"] = "Dual Spec Roles"
L["Set the role your primary and secondary spec represent."] = "Set the role your primary and secondary spec represent."
L["Primary Spec"] = "Primary Spec"
L["Sets your primary spec to tanking."] = "Sets your primary spec to tanking."
L["Sets your primary spec to DPS."] = "Sets your primary spec to DPS."
L["Secondary Spec"] = "Secondary Spec"
L["Sets your secondary spec to tanking."] = "Sets your secondary spec to tanking."
L["Sets your secondary spec to DPS."] = "Sets your secondary spec to DPS."

----
L["Set threat textures and their coloring options here."] = "Set threat textures and their coloring options here."
L["These options are for the textures shown on nameplates at various threat levels."] = "These options are for the textures shown on nameplates at various threat levels."
----
L["Art Options"] = "Art Options"
L["Style"] = "Style"
L["This will allow you to disabled threat art on marked targets."] = "This will allow you to disabled threat art on marked targets."

-------------
-- Widgets --
-------------

L["Class Icons"] = "Class Icons"
L["This widget will display class icons on nameplate with the settings you set below."] = "This widget will display class icons on nameplate with the settings you set below."
L["Enable Friendly Icons"] = "Enable Friendly Icons"
L["Enable the showing of friendly player class icons."] = "Enable the showing of friendly player class icons."

----
L["Combo Points"] = "Combo Points"
L["This widget will display combo points on your target nameplate."] = "This widget will display combo points on your target nameplate."

----
L["Debuffs"] = "Debuffs"
L["This widget will display debuffs that match your filtering on your target nameplate and others you recently moused over."] = "This widget will display debuffs that match your filtering on your target nameplate and others you recently moused over."
L["Sizing"] = "Sizing"
L["Filtering"] = "Filtering"
L["Mode"] = "Mode"
L["Filtered Debuffs"] = "Filtered Debuffs"

----
L["Social Widget"] = "Social Widget"
L["Enables the showing if indicator icons for friends, guildmates, and BNET Friends"] = "Enables the showing if indicator icons for friends, guildmates, and BNET Friends"

----
L["Threat Line"] = "Threat Line"
L["This widget will display a small bar that will display your current threat relative to other players on your target nameplate or recently mousedover namplates."] = "This widget will display a small bar that will display your current threat relative to other players on your target nameplate or recently mousedover namplates."

----
L["Tanked Targets"] = "Tanked Targets"
L["This widget will display a small shield or dagger that will indicate if the nameplate is currently being tanked. |cffff00ffRequires tanking role.|r"] = "This widget will display a small shield or dagger that will indicate if the nameplate is currently being tanked.|cffff00ffRequires tanking role.|r"

----
L["Target Highlight"] = "Target Highlight"
L["Enables the showing of a texture on your target nameplate"] = "Enables the showing of a texture on your target nameplate"

----------------------
-- Totem Nameplates --
----------------------

L["|cffffffffTotem Settings|r"] = "|cffffffffTotem Settings|r"
L["Toggling"] = "Toggling"
L["Hide Healthbars"] = "Hide Healthbars"
----
L["Icon"] = "Icon"
L["Icon Size"] = "Icon Size"
L["Totem Alpha"] = "Totem Alpha"
L["Totem Scale"] = "Totem Scale"
----
L["Show Nameplate"] = "Show Nameplate"
----
L["Health Coloring"] = "Health Coloring"
L["Enable Custom Colors"] = "Enable Custom Colors"

-----------------------
-- Custom Nameplates --
-----------------------

L["|cffffffffGeneral Settings|r"] = "|cffffffffGeneral Settings|r"
L["Disabling this will turn off any all icons without harming custom settings per nameplate."] = "Disabling this will turn off any all icons without harming custom settings per nameplate."
----
L["Set Name"] = "Set Name"
L["Use Target's Name"] = "Use Target's Name"
L["No target found."] = "No target found."
L["Clear"] = "Clear"
L["Copy"] = "Copy"
L["Copied!"] = "Copied!"
L["Paste"] = "Paste"
L["Pasted!"] = "Pasted!"
L["Nothing to paste!"] = "Nothing to paste!"
L["Restore Defaults"] = "Restore Defaults"
----
L["Use Custom Settings"] = "Use Custom Settings"
L["Custom Settings"] = "Custom Settings"
----
L["Disable Custom Alpha"] = "Disable Custom Alpha"
L["Disables the custom alpha setting for this nameplate and instead uses your normal alpha settings."] = "Disables the custom alpha setting for this nameplate and instead uses your normal alpha settings."
L["Custom Alpha"] = "Custom Alpha"
----
L["Disable Custom Scale"] = "Disable Custom Scale"
L["Disables the custom scale setting for this nameplate and instead uses your normal scale settings."] = "Disables the custom scale setting for this nameplate and instead uses your normal scale settings."
L["Custom Scale"] = "Custom Scale"
----
L["Allow Marked HP Coloring"] = "Allow Marked HP Coloring"
L["Allow raid marked hp color settings instead of a custom hp setting if the nameplate has a raid mark."] = "Allow raid marked hp color settings instead of a custom hp setting if the nameplate has a raid mark."

----
L["Enable the showing of the custom nameplate icon for this nameplate."] = "Enable the showing of the custom nameplate icon for this nameplate."
L["Type direct icon texture path using '\\' to separate directory folders, or use a spellid."] = "Type direct icon texture path using '\\' to separate directory folders, or use a spellid."
L["Set Icon"] = "Set Icon"

-----------
-- About --
-----------

L["\n\nThank you for supporting my work!\n"] = "\n\nThank you for supporting my work!\n"
L["Click to Donate!"] = "Click to Donate!"
L["Clear and easy to use nameplate theme for use with TidyPlates.\n\nFeel free to email me at |cff00ff00bkader@mail.com|r"] = "Clear and easy to use nameplate theme for use with TidyPlates.\n\nFeel free to email me at |cff00ff00bkader@mail.com|r"

--------------------------------
-- Default Game Options Frame --
--------------------------------

L["You can access the "] = "You can access the "
L[" options by typing: /tptp"] = " options by typing: /tptp"
L["Open Config"] = "Open Config"

------------------------
-- Additional Stances --
------------------------
L["Presences"] = "Presences"
L["Shapeshifts"] = "Shapeshifts"
L["Auras"] = "Auras"
L["Stances"] = "Stances"